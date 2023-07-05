Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652E8748886
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGEPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjGEPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:54:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FF6173E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:54:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99342a599e9so505466666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688572449; x=1691164449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vh7Ahy6ORpQalqYiGXJ6P2PYQ7ck7O1uYvZEPdnfmvE=;
        b=Dy0WTC1XGDZlk8NOu+Am7t1fFifoT5sruMjvAFxYKg84I990vbNeEyN1JREJ4mPNEL
         53FmnZEia/O3KpwgEy30dFusX0Mky1TBMzPVTk8DYluD+npdINoroXxN6FaiA4ZtUdc6
         dkb26I6QVd8UR81LWzGZz9SEa0g27RA/pXVFwI2qO3qDBOeXQkq4jaM4AjHO6RKlxbPe
         KGe0XUkSqxSBL2R6nrrFj1NFFLPJDNQo0XSoYLIQ0R4zzrCf09LPca6mgw/zIUOvlwbp
         Iy6FP7huKkHG9/cQ5ILBX6TbgHPyB+g+46bW+00EPPJf7q9w6cmKuxCTMUY8y5cT9mjc
         P6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688572449; x=1691164449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh7Ahy6ORpQalqYiGXJ6P2PYQ7ck7O1uYvZEPdnfmvE=;
        b=TA5IbRD5s/qka99mmRurIAVeK8x3qEoAaV29IkhM/yzQLvhEmGWrmQX6zZT1avKeux
         sWx23vN52jlja86ku2KJ5zO2T+ft2a5DHOvkCEozrfJvQnB9wkrzbexOA2qzjdA3W0am
         qDEb3CnywVVRv5xtqPQg5plX9trnKZSONnPeeu+344CusWGyO9et/hfB8AtxWSUgvb6c
         X0208AlH0pL9wcrGjagn3MpUcbaV3uAo28orDfyrqW61C4xB4ynRz5J546CS40WqXCT3
         LERjpib/In2YeHGyD9AmvbYhj98ZusJWb/45Wu5bx3fvuP7v4omn6DwnDp3PBaghKumn
         Tavg==
X-Gm-Message-State: ABy/qLbtG1t9HZDAUbj4iGEguu5L4uJ5DWGv4Cxxrj5Q6EzSw5r+n1Hm
        3B46fOw7kC3hxCblzu4pjvBobw==
X-Google-Smtp-Source: APBJJlEz1prR8ooq74/QZIpUvVZQG3+zszMxccKMR2EU9mgjTG+aNd53wLSXMg8pc3kw0FhjJfbNiA==
X-Received: by 2002:a17:907:76ab:b0:96f:a891:36cb with SMTP id jw11-20020a17090776ab00b0096fa89136cbmr14178070ejc.0.1688572449094;
        Wed, 05 Jul 2023 08:54:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906dfd800b00982cfe1fe5dsm14671309ejc.65.2023.07.05.08.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 08:54:08 -0700 (PDT)
Message-ID: <9dc5738b-2170-a010-4685-ef8cc4bd3fa0@linaro.org>
Date:   Wed, 5 Jul 2023 17:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Nate Drude <Nate.D@variscite.com>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230704150240.2022020-1-hugo@hugovil.com>
 <20230704164140.824f6890dae5c87fc92531b4@hugovil.com>
 <CAOMZO5BNaQVMKbxU9rc5zOBwv9c+HayLnkjqrSgPKgMGzQ585A@mail.gmail.com>
 <20230704172801.f11422b3f947c625f53af871@hugovil.com>
 <CAOMZO5CWh0-5eMTBwjvNUrY-yOHE=daj6n-jAAfjWoV-H4rt0Q@mail.gmail.com>
 <CAOMZO5AZiuEAh6nJB8Oub83At6bsvLhzOhsT_yOniZSucrAUMQ@mail.gmail.com>
 <20230705093507.7458eada3ae05e0e1740a10e@hugovil.com>
 <AS2PR08MB88082608DB46EC1287C6E54B852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <CAOMZO5D-a4sUEqqsppjpgkCRFfeetY32+QP0CvrGw6v5q=J+KA@mail.gmail.com>
 <20230705102502.d8c9fa894bd271a5526d81f7@hugovil.com>
 <AS2PR08MB88085D6B7338AD6D4D3C9956852FA@AS2PR08MB8808.eurprd08.prod.outlook.com>
 <20230705104837.e620da576f22f28244daacb1@hugovil.com>
 <CAOMZO5D_p3hf+HVHNAijEevJRpzwmyGPcoHjiapsOx_ddsoksg@mail.gmail.com>
 <20230705113419.183f686f47252abf3532fc9e@hugovil.com>
 <45545984-ef00-f653-91db-cb6c1cb0a3a4@linaro.org>
 <20230705115106.a4c314e8e177f6516bebda13@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230705115106.a4c314e8e177f6516bebda13@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 17:51, Hugo Villeneuve wrote:
>> As I wrote, interrupt type cannot be none. What does it even mean "none"
>> for your case?
> 
> Hi,
> I have no idea why Variscite are using this IRQ type of NONE.

Because it worked :)

> 
> I can put IRQ_TYPE_EDGE_FALLING since I tested it and it works.

Seems reasonable because on schematics this looked pulled up.

Best regards,
Krzysztof

