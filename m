Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BC3747656
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGDQUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDQUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:20:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD5DC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:20:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99313a34b2dso291368366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688487650; x=1691079650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uBm8+FaUJV+uFONmKepf4mjmqPz8WmqR3uRoqac8MM=;
        b=jlckq1F73JWNEknDS7Se2UsyvRwlU6kHSsljOHLZkP7pTaOqPIyEXzh2V8+fs2VQ1f
         v5lygo3sRj+hnUm9oDMH/xXv2/AF8E+WUdos1KBzZ3cc5SBhx2SQO9VOIYXrfmbY8Dpr
         aS3zJnSMcCsOpacQSKNC7lLUmmkFtUFzyIc9YJMqILgXDK7GqZKGwSRE9yFbHp8VrVpL
         z498dSn7cocI/3JbCJmjx3XQy72PTc31hPodrqWrrgNOv+llMqo+y+OkdGbz+iORrKnx
         JAQBlV5oPnKEldC6Ysxr0taYrUVNPw4ShScY7DQthje4qWbdMMBTQUpjJ5SUmC2VkG/a
         PTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487650; x=1691079650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uBm8+FaUJV+uFONmKepf4mjmqPz8WmqR3uRoqac8MM=;
        b=eXjUGJJ5UYHyPTAM7mM6A1c86Z6RbUdt7Mz/SIBCe3yBIb3DxK/+iyUIBtUEH9AhFZ
         7EkHvo3Twr49qX5AsgehmXgqSF0nuavMajDzP03E3qVbXFxji5m7HMLXMGl1Acl6Kcg/
         kfPkhtAm0tUor8XqcE0AeUb4MTT2KJ3VPxZAxvASdzscrTum7jkSO5vLbzUAHDTNzl3W
         IXwo2512gW5aSfKGUXZWYDX4ADbg1qG8TeXKUsfUeI5mwjCvCTt1xxKVLmPc0CYPJ2kb
         ev3t6vVIcSWXZhkAG/C8EKsHlMuvHdn9V31jZ2ICmFsA1ByI3xkRHygEiEhyEeUmFgpJ
         2xNg==
X-Gm-Message-State: ABy/qLZzBi5bhsKL6aYnYelZTdH0ww9fHIl4F/FGCgfMgTQOWKP2bfhY
        CjsSk3lT+Q/0UTv6hbmH7Lrh5w==
X-Google-Smtp-Source: ACHHUZ5ZCKXe9jYq/Y+TlqY37dd23GmvvAkuF8gVgHWTjLylQjC6OLdle9tmCHQQGCgXfZO0BN4ymA==
X-Received: by 2002:a17:906:c408:b0:96f:e45f:92e9 with SMTP id u8-20020a170906c40800b0096fe45f92e9mr10296491ejz.16.1688487650298;
        Tue, 04 Jul 2023 09:20:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l16-20020a1709065a9000b0098d93142ce1sm13362229ejq.109.2023.07.04.09.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 09:20:49 -0700 (PDT)
Message-ID: <834a0679-7e0c-150f-68be-c75d7dac0bc8@linaro.org>
Date:   Tue, 4 Jul 2023 18:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230704150240.2022020-1-hugo@hugovil.com>
 <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
 <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704113124.f2830afe1d9df252afe5abdc@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 17:31, Hugo Villeneuve wrote:
> On Tue, 4 Jul 2023 17:08:12 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 04/07/2023 17:02, Hugo Villeneuve wrote:
>>> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>>
>>> USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
>>> nano SOM.
>>>
>>> Import changes from linux-5.15 branch of  doen't giveto fix it.
>>>
>>> Link: https://github.com/varigit/linux-imx.git
>>> Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
>>> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>>> ---
>>>  .../dts/freescale/imx8mn-var-som-symphony.dts | 37 ++++++++++++++++++-
>>>  1 file changed, 35 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
>>> index 406a711486da..aef89198f24c 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
>>> @@ -6,6 +6,7 @@
>>>  
>>>  /dts-v1/;
>>>  
>>> +#include <dt-bindings/usb/pd.h>
>>>  #include "imx8mn-var-som.dtsi"
>>>  
>>>  / {
>>> @@ -104,10 +105,29 @@ extcon_usbotg1: typec@3d {
>>>  		compatible = "nxp,ptn5150";
>>>  		reg = <0x3d>;
>>>  		interrupt-parent = <&gpio1>;
>>> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>>> +		interrupts = <11 IRQ_TYPE_NONE>;
>>
>> That's surprising, why?
> 
> Hi,
> the varigit repos log or source code has no information about this
> particular configuration.
> 
> In the schematics, the interrupt output pin of the PTN5150 is connected
> to two different resistors, one of these being connected to GPIO1 pin
> 11. But these two resistors are not assembled on any versions of the
> board, so the interrupt pin is currently not used.

OK, so there is no interrupt, but not interrupt of type none. Just drop
the property and make it optional in the bindings. The driver however
requires the interrupt, so I wonder how the device is going to work
without it?

Are you sure that interrupt line is not shorted instead of missing resistor?

Best regards,
Krzysztof

