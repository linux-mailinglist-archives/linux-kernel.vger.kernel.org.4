Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB26F4744
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjEBPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbjEBPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:31:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C5197
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:31:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so5139866e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683041485; x=1685633485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoJQYLN9+L2vo//E4FPW+gR4+BR6F8D80HI3lzLvkwM=;
        b=uqZp8ZiBtNP+mnlO4cyVx9iYmYWhKgXTXqfzB8xUSuH95IiMEBZT9ZRTmzOfYjuKtH
         rYgKn+AORrJ7nKDpbwk2TjucLsdS05oYZNdbqQRHjhTdn8xLaW1/7zR/aMgRdmW28J85
         9mPnKVYhox4OuX06Blz8WiIscMbgKOQ70seeI3BKZoXhNUaq5xizS8eJ7qu3Rb2voWor
         1qKFmkcSgDte5qeuI6z22c9lVC9izVngvAZ8Gv2kGZKZGUdoEdtdATG1si+HA4RjuiTI
         pfuEbe4D3XGLs758kn/RVMuHb0VAxLJqqlQKcv6qelQk7ItbPwn4DwXRTNNC/MHj6bpF
         YzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041485; x=1685633485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoJQYLN9+L2vo//E4FPW+gR4+BR6F8D80HI3lzLvkwM=;
        b=Ibz6qocYbOrM6Rd27MScH1XcWrrdfYQ+ze4KQtxvpwULdY62FIz80097fDAU/xQlFF
         fAiX/8czkW0zU4866ijmF5uOo/zYEiYNP8tp6K6pr4wppveIS7+sNRYziL9iuO2aWzix
         NCRKb9jmEnclxUuKVE71lKfMc2zbsLkpMmXQ2/oCV08TiypmLzHid3rbxYKmnVo3cFKf
         rREKwIEiQjHMP5Ese3NP8dH35ElABxZ3P2tW1t0X6HHjwTsVXuXT3Q6rjusSvvRmg/iL
         DN/KdUnRzJ+AHdsjl9xsNsLqFtCKl+SznOqdVKIdnzGjUyWMHqEv1BtzJEJRarAm4Gyc
         3dsg==
X-Gm-Message-State: AC+VfDyKEK/cLrrdV7K9nAvI6p5g5Q8Bh2P6w0/2xzH/MucKDQkEvrSz
        pUPtX0KaVWvxdnhSJuPFc3tNhQ==
X-Google-Smtp-Source: ACHHUZ51SVSBDDVPKnQnishgpr1pLCdOwbhgoqe5mZ1r5oKxWYpc0PJDXL8PfEmCInG1t7hJAhQZMg==
X-Received: by 2002:ac2:5fa4:0:b0:4f0:18e2:c0d7 with SMTP id s4-20020ac25fa4000000b004f018e2c0d7mr139274lfe.60.1683041485360;
        Tue, 02 May 2023 08:31:25 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2442f000000b004f09126b291sm1542450lfl.213.2023.05.02.08.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:31:24 -0700 (PDT)
Message-ID: <64e12896-4043-e01a-1a1b-aafc441b268e@linaro.org>
Date:   Tue, 2 May 2023 17:31:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974-hammerhead: Add vibrator
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
 <20230427-hammerhead-vibra-v1-4-e87eeb94da51@z3ntu.xyz>
 <fc22fd34-6cce-c175-d845-cf4435b4b0be@linaro.org>
 <112204300.nniJfEyVGO@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <112204300.nniJfEyVGO@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.05.2023 17:28, Luca Weiss wrote:
> On Dienstag, 2. Mai 2023 12:40:40 CEST Konrad Dybcio wrote:
>> On 27.04.2023 22:34, Luca Weiss wrote:
>>> The Nexus 5 has a vibrator connected to the clock output of GP1_CLK
>>> which we can use with the clk-pwm driver, then we can use that pwm with
>>> pwm-vibrator to get haptics functionality.
>>>
>>> This patch is based on Brian Masney's previous patch with clk-vibrator.
>>>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>>
>>>  .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     | 35
>>>  ++++++++++++++++++++++ 1 file changed, 35 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
>>> b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts index
>>> ab35f2d644c0..fea8a6be9021 100644
>>> --- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
>>> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
>>> @@ -41,6 +41,25 @@ key-volume-down {
>>>
>>>  		};
>>>  	
>>>  	};
>>>
>>> +	clk_pwm: pwm {
>>> +		compatible = "clk-pwm";
>>> +		clocks = <&mmcc CAMSS_GP1_CLK>;
>>
>> Are you sure it's <&mmcc CAMSS_GP1_CLK> and not <&gcc GCC_GP1_CLK>?
> 
> Quite sure.
> 
> The driver uses:
> 
> 	cam_gp1_clk = clk_get(&pdev->dev, "cam_gp1_clk");
> 
> and this comes from the clock-8974.c driver
> 
> 	CLK_LOOKUP("cam_gp1_clk", camss_gp1_clk.c, "vibrator"),
> 
> Regards
> Luca
ugh that hurts my brain but fine, maybe the camss clock had a
pad closer to the vibrator pcb traces..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
>>
>> Konrad
>>
>>> +
>>> +		pinctrl-0 = <&vibrator_pin>;
>>> +		pinctrl-names = "default";
>>> +
>>> +		#pwm-cells = <2>;
>>> +	};
>>> +
>>> +	vibrator {
>>> +		compatible = "pwm-vibrator";
>>> +		pwms = <&clk_pwm 0 100000>;
>>> +		pwm-names = "enable";
>>> +
>>> +		vcc-supply = <&pm8941_l19>;
>>> +		enable-gpios = <&tlmm 60 GPIO_ACTIVE_HIGH>;
>>> +	};
>>> +
>>>
>>>  	vreg_wlan: wlan-regulator {
>>>  	
>>>  		compatible = "regulator-fixed";
>>>
>>> @@ -637,6 +656,22 @@ shutdown-pins {
>>>
>>>  			function = "gpio";
>>>  		
>>>  		};
>>>  	
>>>  	};
>>>
>>> +
>>> +	vibrator_pin: vibrator-state {
>>> +		core-pins {
>>> +			pins = "gpio27";
>>> +			function = "gp1_clk";
>>> +			drive-strength = <6>;
>>> +			bias-disable;
>>> +		};
>>> +
>>> +		enable-pins {
>>> +			pins = "gpio60";
>>> +			function = "gpio";
>>> +			drive-strength = <2>;
>>> +			bias-disable;
>>> +		};
>>> +	};
>>>
>>>  };
>>>  
>>>  &usb {
> 
> 
> 
> 
