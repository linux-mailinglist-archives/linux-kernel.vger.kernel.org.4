Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59C6C1F45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCTSOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjCTSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:14:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFE53BC56;
        Mon, 20 Mar 2023 11:07:52 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id n2so14203870qtp.0;
        Mon, 20 Mar 2023 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679335664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L3ZgQ6hbDwLFA0+/6XyOTTwas24M548/DGldx8bD/B4=;
        b=LpTTMMaMAGr1wg0gxQpPPQJcst7GYq7vYAPtjRVIP8cmaf+ovoh4ciEsHhfsjI72S3
         LNmMof4lp289jUlBGm0qH75LQ0CEWWtVzCRDcHNa1zAYsdAXZmdAnNtD4MLAi+g54KPj
         4H227WE8o8Kf40sjsZo96JnijcrGtUCo6gOS5QHwi1TfT2ZtLLmtiFq3AQd4IpH/iGc/
         XRmMRfibPzro/QdkcU+II9zbngeGi2EO0U2WjN2eA/BXgZBHd0ODyvvxwIfX1g2OpXjH
         8qDJcZy+sq6X/Oa5xQqs6yjdd2aYZHxya+sjOqGm/5hthoBF+rPcqikSfMc0B9dW26dC
         xVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L3ZgQ6hbDwLFA0+/6XyOTTwas24M548/DGldx8bD/B4=;
        b=6Adb3HA/kfRoQl+7LSSLkvSVr6uMa2lxMQ6khfsbqmKRJwMA6iAcvtBbEcSNdVLa7g
         VsJxHWwwhRPk/TYIhXTZw6hT/whvNn6nf+1t/c0DLwPZNzCVI6sDtwxb+O4h/o73CXC0
         HofyHrng6Mhga1BuMqhSgqWwtFgN7FLbx2WeJ1I/OfcCbGYO9GlhiF1rV+y40b7gOkUg
         DROc7zm5SLvkEbsZRVt0LCCsCg0bp7zfxqO1yT12TDOS7Y894tPvgmkIQSXJY2oImVIU
         j4wH2szOIHuM1DOVPQXU5fYXt/QhCrAUl3lXR/E9lq8M/hPcKO+y8UxjAXEqkx1qVsDY
         rI6Q==
X-Gm-Message-State: AO0yUKUoefPPVg4Thpz2td0xyQGh8JS0tX3EQLv7E3joC24nU6Kh1zm7
        eTXpLmNiSEbJuFWsEwimSVA=
X-Google-Smtp-Source: AK7set8AD38+i11dYanB4qCBbmNUzfei9aCNLyXLYPG8CRg4osCls4SV6Aq39hM7qRY/j3bqRVDkuA==
X-Received: by 2002:a05:622a:180e:b0:3bf:bb1f:3c2b with SMTP id t14-20020a05622a180e00b003bfbb1f3c2bmr198499qtc.6.1679335664447;
        Mon, 20 Mar 2023 11:07:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n3-20020a37bd03000000b007456b2759efsm7789701qkf.28.2023.03.20.11.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 11:07:43 -0700 (PDT)
Message-ID: <b7057b51-540f-54a5-aba2-8f44da832289@gmail.com>
Date:   Mon, 20 Mar 2023 11:07:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: rtc: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230317233634.3968656-1-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230317233634.3968656-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/23 16:36, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/rtc/allwinner,sun4i-a10-rtc.yaml      | 2 +-
>   .../devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml      | 2 +-
>   .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml         | 2 +-
>   .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml        | 2 +-
>   .../devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml       | 2 +-

Acked-by: Florian Fainelli <f.fainelli@gmail.com> 
#brcm,brcmstb-waketimer.yaml
-- 
Florian

