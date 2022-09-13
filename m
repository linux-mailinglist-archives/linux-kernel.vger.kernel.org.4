Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF885B758F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiIMPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiIMPt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:49:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94A89814;
        Tue, 13 Sep 2022 07:51:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m1so17930501edb.7;
        Tue, 13 Sep 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MgOl5Ps7/2BViAuks7F+2zguUGoKnsho7d41gsbe7gU=;
        b=phI1mDsJ91Ezqe+J9QSI4gKmWBYFwLv3a4vgdotqIDXesK/xAcMRrInv1BxehcSiNn
         iO4wEx62cNKtkhxm3LUUkgHKwWoD8+oL3CoKCCkGIJSmzyHoC60ESSeM8AnlpBoUESO9
         PW/02GNVA7Jnp9RjsxA3tQ0y95Ub4Y/MY2lKLzvkdi8lJLmVa40SE4Lvzh315cSvt0jO
         Vvo1c9LtMxEsqrOtLjIQyftz3hTn9QuMuhlMaJGbfS91mRgeHiIfHHhxVnjB8sRjvghW
         pPge+mK0EuTEpiPznBIHcLW3Nc9ZehX/WvuH6hXva4oBfGLrd/0jZlhQhttIzxmIEG8C
         uVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MgOl5Ps7/2BViAuks7F+2zguUGoKnsho7d41gsbe7gU=;
        b=3Ar/rmxpZhZrhiSOFd7SVRFMWSVk7cqV13tEMC1XzsFQlahJxIu+m4UpalBB4+epto
         zNmxfzt2aYcxtHG0fNGa6j3hvFd7JzolpZVlB/q4Z1DSq+T6eLMxjfOyQ4BREbAk1Dgo
         zSdPQRV/xhNPzQqTtjnpC02mm6V48bCpe5AYhl3PAbSVqjWCu8vDGevqHRUQ3Efo2jre
         32zb4H7WsZkSjI4Tjxlml28D/FCoxd0M4QoH85KNXxpHOoBMobWUcWceQ2CIG/aNsHok
         fd4teJdI6VuEuC3VPvUtK/762QcSdrsdO20jSzEiRUUc+bvtzma8xpkWBBIp+JphbiGB
         VlCQ==
X-Gm-Message-State: ACgBeo06nIagcjnkh4UsvIMlWhRUqmOdmbHi27ti8JXRPho+RLoQyQ6b
        5J7sa+YgHKJZbJhYPko6mCW1d3nyP80=
X-Google-Smtp-Source: AA6agR7OqLSlYti2bg9ewEBW2lVZRnfEoBgDi0E0GHMdwoZmfrnb33kN60z1XTcfTWmSe4rdpS3fMw==
X-Received: by 2002:a17:906:6a03:b0:779:e97d:9a94 with SMTP id qw3-20020a1709066a0300b00779e97d9a94mr14384553ejc.507.1663079914209;
        Tue, 13 Sep 2022 07:38:34 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id dk9-20020a0564021d8900b0044ea683d04csm7964177edb.14.2022.09.13.07.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 07:38:33 -0700 (PDT)
Message-ID: <37fd8d4b-3a66-bc51-c2dc-76c9e756fed8@gmail.com>
Date:   Tue, 13 Sep 2022 16:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add
 rockchip,rk3128-pwm
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-rockchip@lists.infradead.org, philipp.tomsich@vrull.eu,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, kever.yang@rock-chips.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        heiko@sntech.de
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com>
 <1662821635.180247.34700.nullmailer@robh.at.kernel.org>
 <1c13181b-8421-69d8-21ee-9742dd5f55dd@gmail.com>
 <20220912162159.GA1397560-robh@kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220912162159.GA1397560-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/22 18:21, Rob Herring wrote:
> On Sat, Sep 10, 2022 at 09:48:04PM +0200, Johan Jonker wrote:
>> Reduced CC.
>>
>> Hi Rob,
>>
> 
> Seemed like a simple enough warning to fix...

Some examples for comment.
Let us know what would be the better solution?

===========================================================================

option1:

	combpwm0: combpwm0 {
		compatible = "rockchip,rv1108-combpwm";
		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
		#address-cells = <2>;
		#size-cells = <2>;

		pwm0: pwm@20040000 {
			compatible = "rockchip,rv1108-pwm";
			reg = <0x20040000 0x10>;
		};

		pwm1: pwm@20040010 {
			compatible = "rockchip,rv1108-pwm";
			reg = <0x20040010 0x10>;
		};

		pwm2: pwm@20040020 {
			compatible = "rockchip,rv1108-pwm";
			reg = <0x20040020 0x10>;
		};

		pwm3: pwm@20040030 {
			compatible = "rockchip,rv1108-pwm";
			reg = <0x20040030 0x10>;
		};
	};

PRO:
- Existing driver might still work.
CON:
- New compatible needed to service the combined interrupts.
- Driver change needed.

===========================================================================
option 2:

	combpwm0: pwm@10280000 {
		compatible = "rockchip,rv1108-pwm";
		reg = <0x10280000 0x40>;
		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
		#address-cells = <1>;
		#size-cells = <0>;

		pwm4: pwm-4@0 {
			reg = <0x0>;
		};

		pwm5: pwm-5@10 {
			reg = <0x10>;
		};

		pwm6: pwm-6@20 {
			reg = <0x20>;
		};

		pwm7: pwm-7@30 {
			reg = <0x30>;
		};
	};

CON:
- Driver change needed.
- Not compatible with current drivers.

===========================================================================

Current situation:

	pwm0: pwm@20040000 {
		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
		reg = <0x20040000 0x10>;
		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
	};

	pwm1: pwm@20040010 {
		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
		reg = <0x20040010 0x10>;
		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
	};

	pwm2: pwm@20040020 {
		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
		reg = <0x20040020 0x10>;
		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
	};

	pwm3: pwm@20040030 {
		compatible = "rockchip,rv1108-pwm", "rockchip,rk3288-pwm";
		reg = <0x20040030 0x10>;
		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
	};

CON:
- The property "interrupts 39" can only be claimed ones by one probe function at the time.
- Has a fall-back string for rk3288, but unknown identical behavior for interrupts ???


> 
>> The rk3328 and rv1108 PWM interrupt is chaired between blocks I think.
>> For rv1108 the same interrupt is used for all PWM nodes.
>> For rk3328 only added to one PWM node.
>> Currently not in use in a Linux drivers??
> 
> How is that relevant to the binding? It's used in dts files.
> 
>>
>> No consensus yet...on removing or parent node, so it stays as it is...
>> Maybe if you have ideas things will change. ;)
> 
> Only that existing issues should be addressed before adding new 
> platforms especially if the binding might change in an incompatible way 
> (splitting nodes).
> 
> Rob
