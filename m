Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7839E6DF424
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDLLsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLLsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:48:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A15241
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:47:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t20so14284931lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681300075; x=1683892075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PDRGxEShggzOR/Xl7EtJnVQmJ9Lo2xgV6jIShMWMhA=;
        b=ca5oA4kEl5+/mD44LGcCDwGW3QVv1/zYr/QfZFtpDE12/3os2aUbsL5ri1hEH399HN
         ro3mIL2K0pa26p3NsnOABz2or32+1JTSU/eBi+ahLqj08/kOVc9fZ5g68nxRsMbrwnPU
         CT9TAl1tpBZVzpd/p5VsnDtt3GW0ox0ZGKFCPxvwWu4f8vIuHrdZx6DHxcUFcf4UMY17
         t5b1kySo+mX2X07wjM41DBzfgMOPxkKy/FuB8MfPOdBw85s1g4Dpi20EUFDHKBsNKKiT
         owCDjingQECnAOfpg/wGUtRIKMLjIeM0yqtXfEblW76rCtF1IqrvEPTD9Rp8KBeKCmrM
         CLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681300075; x=1683892075;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PDRGxEShggzOR/Xl7EtJnVQmJ9Lo2xgV6jIShMWMhA=;
        b=DqY/h028B3XotUoSgSuoYd6GnJOF5GW7vcIL7HO6F3GqRETotN6KNTF58NAVy0Xv2r
         BeIlQUxcrxiuRu4gx3HIwATRoAM2A3azEKbUTOZEh2WFQ9Ouh5NIZ8ehAWwutShOVIjY
         bV2cYCgEZI0maBjKmX4MJ2PQFGm87yqUl1cj0IZ41btuS+fES8jYxVNz7jO/+90cnJQR
         ucLOcqgtczYu8yqCJM89bw97PyM+Wh8Kdvv71g0JYJWrFge6BLqtvKPsn6qhxCck39XB
         KpkE/ORIDjgyzzuYME3hAxLqJFuvB1xni3HLhm98o7X1TwhBZnc+xBt39UHbph8ECLqo
         3WSQ==
X-Gm-Message-State: AAQBX9eSVftTMC1/RCFHQi8FkzNeIP6JU+AqDkdFK+knCK9zfz4by7mP
        TyVMFUZM3mo692nZMjwBRGAtvQ==
X-Google-Smtp-Source: AKy350aUZ3CGJoUofIeVVJ4YAhyMxqUiZCUMEwpEb3JCUeppyK803LMkXw+XpWVL55zLVoq/SS8BKA==
X-Received: by 2002:a05:6512:21aa:b0:4ec:9f24:3e57 with SMTP id c10-20020a05651221aa00b004ec9f243e57mr534056lft.3.1681300075131;
        Wed, 12 Apr 2023 04:47:55 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id q10-20020ac2510a000000b004ec5229092dsm2907440lfb.34.2023.04.12.04.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:47:54 -0700 (PDT)
Message-ID: <198523f5-d06f-15cd-af6c-f391c02bcaa9@linaro.org>
Date:   Wed, 12 Apr 2023 13:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
 <ZDAAToSzNLVo6le8@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZDAAToSzNLVo6le8@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.04.2023 13:36, Stephan Gerhold wrote:
> On Thu, Apr 06, 2023 at 09:55:40PM +0200, Konrad Dybcio wrote:
>> [...]
>> I don't really know what kind.. I can add something like:
>>
>> rpm {
>> 	compatible = "qcom,rpm", "simple-mfd";
>>
>> 	mpm: interrupt-controller {
>> 	...
>> };
>>
> 
> IMO we should indeed add something like this, because the current
> representation of the RPM below the top level /smd node is misleading.
> "SMD" is not a device, bus, component or anything like that. It is just
> the communication protocol. There should not be a top-level DT node for
> this.
> 
> Instead there should be a dedicated device tree node for the RPM like in
> your example above, which will allow adding properties and subnodes to
> it as needed.
> 
> For unrelated reasons I actually have some patches for this, that switch
> the /smd top-level node to a "remoteproc-like" node dedicated to the
> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
> add additional (optional) properties like "resets" and "iommus" for the
> RPM, but it would allow adding arbitrary subnodes as well:
> 
> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
> 
> I could finish those up and post them if that would help...
Krzysztof, what do you think?

On a note, the bindings check is gone with dtschema-2023.4

Konrad
> 
> Thanks,
> Stephan
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index dcbc5972248b22..1c24b01bd268c8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -310,10 +310,10 @@
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
>  
> -		rpm {
> +		smd-edge {
>  			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>  			qcom,ipc = <&apcs 8 0>;
>  			qcom,smd-edge = <15>;
> 
> 
