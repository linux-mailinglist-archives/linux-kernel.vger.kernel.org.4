Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C386AB64C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCFG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCFG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:26:42 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DDCEC6E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:26:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so33936062edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 22:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678083999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2EVWs3pTg/fWY1PZtABlXR6f2sNu/d27mccEdhWh7U=;
        b=c2B/lU6CRWGnrc5QdLUOzoB5rfafH2gCgrW5YIvUTBtsNX+/RsnYuGL/hOKA/oONey
         xORE5C+oDdsUeHmt847wbHn51SnBdX0iOX6t3dGOSeZi9cjmGJMKKGMvKXKqFnnyLqgl
         w4/rygv7dmvuUfGaQZd84YvLI9zRQ7Mcp3gKJAPHa+441ISzHQAT2rVhS43PHwIqWDRK
         hFuXIhyGO8iBJxJUng8GxFFpqLJk3ZUE3FNLvHKYgbBSx1UokpPhzhKL4hl3Q1TjBtPs
         Z03ycgEiOVyEnxzlSjOgVDEnjcFYqRWxXfRsxUky5ESdJDfQJ8Gts1UxdV5eciZ94fdQ
         pBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678083999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2EVWs3pTg/fWY1PZtABlXR6f2sNu/d27mccEdhWh7U=;
        b=TB6G/jn4Sd1tSIjDuoygVZiOsbw2Um6okaGC3bWdrpER+AdjGXtyP6lxsmcEedpM6X
         cXgIdgbghfG6T5vzhD49VCrQvFjEsMv8QiHDeeryZ9HbSzw74iMZ6L805EV3wMPi4x09
         dSns3O+ZlGrNwDs1KU84S84n60Chjt0pVATVP7y5W1UZ0Ivg07txay/DLQ+dfaG65BOC
         RJL82UPSwlr5d/1+ijgWz6XZMnUIGtOVo6uX/9+AZFjY2/9L+sBAZokjdRnbtgcRYjE6
         Ni6SBrPrXJh6/tSpVfwcxzdQnhQAJ+yzjp8MXZrTHjY7UlVI/VgS8Ghw2aQJn9mG74bl
         /jaQ==
X-Gm-Message-State: AO0yUKWM2af3ubbPXZS0knP1Tf9u/fMhq0nCXWp6+a30O3Dn9qMMbxq3
        SFrdVzx+zAnXv/CTCIUKK9avvA==
X-Google-Smtp-Source: AK7set8n0rli9ksDBadVCoR2Qgpw1GH9WCld0Ejgjbj5d0mwffklxq/8uct/NXu8bhNw4ZCqxqvpUw==
X-Received: by 2002:a17:907:7da6:b0:888:b764:54e5 with SMTP id oz38-20020a1709077da600b00888b76454e5mr12048360ejc.71.1678083998999;
        Sun, 05 Mar 2023 22:26:38 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id t30-20020a50ab5e000000b004ad601533a3sm4629001edc.55.2023.03.05.22.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 22:26:38 -0800 (PST)
Message-ID: <422b00ec-1ef4-95e3-db49-672da29e6e24@linaro.org>
Date:   Mon, 6 Mar 2023 07:26:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] spi: s3c64xx: add no_cs description
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20230306015413epcas2p371356e4008af6978cdadb5b859d8be2a@epcas2p3.samsung.com>
 <20230306014239.80570-1-jaewon02.kim@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306014239.80570-1-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 02:42, Jaewon Kim wrote:
> This patch adds missing variable no_cs descriptions.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

