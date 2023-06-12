Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D778672B8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjFLHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjFLHep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 03:34:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993310F3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:30:12 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so3927758f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686554725; x=1689146725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntRYvz0tRb6HbKymHFNjRh0d14+I2NVOI7EThtiN4Yc=;
        b=SE8p/S0KQsx1I+RxtNnhR1No+H+/1ERh73gDDqx7Nq8x/bhrQ4JR0lPK8xynhsXXp3
         OaEqHrIH7j2dvbMiyLxwHVyNAXbHoNcpG8KBeUNxR34p/eZ4Dzzmtvor7PxtwUq2Zyit
         9tR5hLckHQ01xeyyUEhFicMZ2eodtRSqFLPv1vl0I1P4buWyQ3+mtM7Zgxdzd6yEB4yI
         ucCu4eJThBPx6fFOAVv6VmeSuq+yYTvb6tHIk4sAu749CE886JL4D5XxR+5UUAKmGoWb
         Crz/1DGujz9S+/UaZfKCm5tE7xCaLGUK8gPUz4wqRNuPpba9Th1Fv6RkRQlu8VF7gp7V
         UufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686554725; x=1689146725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntRYvz0tRb6HbKymHFNjRh0d14+I2NVOI7EThtiN4Yc=;
        b=LNPrYPHlGbImJORwkISwm88Zf04JZNgg//woEuTtSxReF/s0J2M+6rOEsPETkn+EM1
         psZW5vQW3mBMWCmCXb0A91Ew4b32LhTdVIbwhh+wbia1+XF34Tza7fdXJrUY/03o+6bI
         XCUHYaq4BeewrfFwMAEnsrH86D+89UMlPWelkUhLDik5wh0XTrzyEnvLc0oJmH1Y49mq
         9DuOeHlSFEBdzPd1R9lzv0Jo/xYe/G2sRpZZwwdkPgc+hk+NTIiOhW0y7I+vv0aobdf4
         bJj1RMQE6qaFo2oqcuNbGqmtYC3V1yFof4QIouhdd9hS+r7yS0odWaR/V3Hr+N9OYUIe
         dR4g==
X-Gm-Message-State: AC+VfDwi797SR7TbPd4yWQm3GiT95Ozy+weLGLoZmVxQ4Buyi3hXYXt8
        THMX1Otj50sQZtQOMfcpJDDPcA3eS4aHFz4AQMo=
X-Google-Smtp-Source: ACHHUZ7CNdlZ+cV8ahgX1g2P375Kp+4cIx9AN8l9KjZ490gLm+dmUsMvU9DvqOjd5o4cQC6f4IH9Dw==
X-Received: by 2002:a17:907:728d:b0:96f:afe9:25c4 with SMTP id dt13-20020a170907728d00b0096fafe925c4mr7636877ejc.50.1686554146850;
        Mon, 12 Jun 2023 00:15:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709060eea00b009745edfb7cbsm4772634eji.45.2023.06.12.00.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 00:15:46 -0700 (PDT)
Message-ID: <416a90ee-7501-1014-051d-e6a3eb03a0ff@linaro.org>
Date:   Mon, 12 Jun 2023 09:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC net 1/2] nfc: nxp-nci: Fix i2c read on ThinkPad
 hardware
To:     Marco Giorgi <giorgi.marco.96@disroot.org>
Cc:     netdev@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        davem@davemloft.net, michael@walle.cc, kuba@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230607170009.9458-1-giorgi.marco.96@disroot.org>
 <20230607170009.9458-2-giorgi.marco.96@disroot.org>
 <07b33c1e-895e-d7d7-a108-0ee5f2812ffa@linaro.org>
 <20230611181707.1227de20@T590-Marco>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230611181707.1227de20@T590-Marco>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2023 18:25, Marco Giorgi wrote:
> Hi Krzysztof,
> 
> On Wed, 7 Jun 2023 19:45:25 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 07/06/2023 19:00, Marco Giorgi wrote:
>>> Add the IRQ GPIO configuration.  
>>
>> Why? Please include reasons in commit msg. What you are doing is quite
>> easy to see.
> 
> This is my fault, I only put the patch reason in patch [0/2].
> 
> Basically, I found out that the mainline driver is not working on my
> machine (Lenovo ThinkPad T590).
> 
> I suspect that the I2C read IRQ is somehow misconfigured, and it
> triggers even when the NFC chip is not ready to be read, resulting in
> an error.

Isn't this then a problem of your I2C controller?

> 
> In this patch [1/2], I'm adding the "IRQ" GPIO to the driver so its
> value can be directly read from the IRQ thread.

What is IRQ GPIO? If this is interrupt line, you are not handling it
correctly. This is quite surprising code.

> 
> In patch [2/2], I'm safely returning from the IRQ thread when the IRQ
> GPIO is not active.
> 


Best regards,
Krzysztof

