Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4B76895B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjBCKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjBCKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:19:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFD51630A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:18:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so4150492wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=vZSwxd+i4gYdilxbkPyzz9u5M/wmJE6d5Ed+DcxQEkuCLGebQ2m4EgG17QKAT3QPqv
         k20Lhi0fmw24KDDunYGrQxKW+ByTCG9X8CfB1qi1qazX3jFg+VcCo+j7Mxua4Bleb7Vp
         aVMluIqoPCjZ3tkusKdiBM5hW3LJJMqG/0e57vTn5SSQX3KuOgQlzEQVSpqBC5eI6dbT
         fy6bOPpgVsHQHRqCWwF2WRDozVI2MsBK1YukbBXvePC7qIIYkNHzFqK22oGCi0yXTqfG
         KlVikTD7UtotnfrkV9UF3v76A8yAf1I8pGVPfMgmUi9MO5C8HQuhdYNQc2VxXsMbYwlv
         xXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odqpSFJ0f+PZ4TN9H2HUGPRDThnkRj1i7Ss7xOqwBxo=;
        b=qOGfWaMMOfOe6EeFBg1EZ3OKnirapeQ0hE7PPv1UjpBOrVshiZn7ZwMiPpgBSdBstA
         E8Zup4b7XloJXiD3mwzmPOrQKJHlTwcxtA2q5fjpGpO3TLBwAoChCo/rCIKLcGhFI8bh
         SN4TFDiRug3rSdnO2hYrMZDKGIfTTXOg4CJVWS1rBrSmNuZp2v8wMa76KC8F1C5oRMab
         Xop7v+/1nOmRlHUrM78qq2WhghJiA1Rz0cBKUqp9/Tq99BLfT/26KE2x0wezlQUd2rU3
         TjWyCJIZRopyixQKQHbF/eKsHds5EG64nRfwQyKpTTKwi0JMt5nkF75QgW6290ixxzpI
         eioA==
X-Gm-Message-State: AO0yUKVxYHG7d2hDday3SPEAEEgx+CpBjJUgLapHbBX2dY0dAMPeD4yL
        Y55SEpIsTPdt2BuKx1YkW5Zg1A==
X-Google-Smtp-Source: AK7set/A/7BpKhP+zyNlXDxtrR2vM9hyGoiLQbrQbwKXru552gKjPaug1Z3UaSVGQ6uTHJ0CplbhUQ==
X-Received: by 2002:a05:6000:104:b0:2bd:e547:943a with SMTP id o4-20020a056000010400b002bde547943amr9033416wrx.14.1675419523177;
        Fri, 03 Feb 2023 02:18:43 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.122])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b002c3b2afae00sm1615194wrq.41.2023.02.03.02.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 02:18:42 -0800 (PST)
Message-ID: <5040b424-23a9-5083-6de1-e457b8d5cbb5@linaro.org>
Date:   Fri, 3 Feb 2023 12:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: s/a SPI/an SPI
Content-Language: en-US
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203081119.69872-1-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230203081119.69872-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sent a tree wide patch instead, feel free to comment at:
https://lore.kernel.org/all/20230203101624.474611-1-tudor.ambarus@linaro.org/T/#u
