Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297070E1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjEWQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEWQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:26:17 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAF1DD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:26:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f60dfc6028so432615e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684859169; x=1687451169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hWDKOTssM4FQyfGCYtsz+cR6mie3Z18WQlIfyIGgK4=;
        b=mYu0SEk+RZXENY1xtpNmWBrgNsZdpZ9O4tniZ/Wkwa+8dCOI8W1i2GmjzsBImvf2OQ
         /+0iD2cM8wt7vw7Z1a9jbaHadU1iIPqQ+lAaExnbAISEjZ6PCHUEpy3M+fVk3gzuUz0P
         j71SEkbgQu3MPnS5Cd7/uCdBfthCcWCXn3ZW2U37PSQAQQskcFiAL506vrhnYsinXa7S
         ZIwAKdhOixG1Yf0s3lGwng3Olx2HfN+e/WYGEDBAAQGd9SsnaVnw9c5a0YRZOpJ2SiqM
         gYFiTjkYtzop1yt1Lws4oD6AmMb4rB/5f/w7gz2OKk7yIDmOvByd3ZqDv7fNav2iirnd
         iISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859169; x=1687451169;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hWDKOTssM4FQyfGCYtsz+cR6mie3Z18WQlIfyIGgK4=;
        b=HQUGMjjp+7htuesq456pA9DFtAzEN9h6Pr46zWZPFxfMK02LGBmJmpsFCFfq6EDvw3
         yXVLHdm6h0QlCwqmrKe2/ijbWd9SVqer0Buo7m8JRUW7OjT9M1tf8eseCzRlgjGIuZp1
         eDuEU6YuxYfrr2cUUg4fCmT9tf+fCasP01/iv256c6xD+jZ34P+8TDLRXhNBFiNqdg5h
         fjJ6yA5ZrhcojZmXfBwRnch0QLL35aaJxxKUspRcLoghEaEKxXZeR+JA9iwfHDp7eg+1
         PLL2B/CJClGzY2mKdIr9YbW5gnMLjdI2Ff+h8nTOVY5DMzMoavHr0VlPHmFFluTFurtI
         RggA==
X-Gm-Message-State: AC+VfDz5Gxzewf8UfIZWhKZA0Zq1Xpj9TK3LX5SSNof8CWAypyXKm90+
        Qz7QliSN54M0AllazwvFbJZndA==
X-Google-Smtp-Source: ACHHUZ7wvkNksRRlhJ5pqhiWSVhwW+UQHRyyp9zUBWS/rshrEORKyWRTxRCw2le4JdEfLngvcdm3lg==
X-Received: by 2002:a7b:c4ce:0:b0:3f5:b4e:944b with SMTP id g14-20020a7bc4ce000000b003f50b4e944bmr9335119wmk.18.1684859169598;
        Tue, 23 May 2023 09:26:09 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id p24-20020a05600c205800b003f6041f5a6csm7729571wmg.12.2023.05.23.09.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:26:08 -0700 (PDT)
Message-ID: <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
Date:   Tue, 23 May 2023 18:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
 <20230523021933.3422-3-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230523021933.3422-3-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2023 04:19, Trevor Wu wrote:
> ADDA_BE is used to connect to mt6359. For machine mt8188-mt6359, codec
> for ADDA_BE must be mt6359 which are configured on the machine driver.
> Besides, ADDA_BE is divided into two dais, UL_SRC_BE and DL_SRC_BE.
> As a result, remove ADDA_BE from items of link-name.
> 
> Signed-off-by: Trevor Wu<trevor.wu@mediatek.com>

I don't understand how "DL_SRC_BE" and "UL_SRC_BE" links are done.
Why these dais don't replace "ADDA_BE" in this binding ?

Regards,
Alexandre

