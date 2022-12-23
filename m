Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFA655087
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiLWMmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLWMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:42:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57064C09
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:42:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x11so7031788lfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4qmM61VuVsMz3hWuuFqDNaRjKZS92VzYxO6N789ZujY=;
        b=GzHQdZkYbJbi++UjndFq62mZeWuRE3WGSuxDMVXmLN902lPb8HgvUAUqdopqgAGBhg
         VR6Kq1YukRTl3z8CadkazNSj8nsB4G4DFmEsQR3TcAmSRB6smbjB4EvCgeo5mJU4HdxL
         2emCJBSVRKrkk73fBvMPPhfOyTzzkg7FELbKBbz6BUpOF5rd69/y0RObWwNPuhPZ99BI
         ga0B94N5/rQIloJ6auDs3UJcyOXTbMbR2WeH+tfYhJ0ONa2CJuH8N/JptqNUzmz2Ha+O
         Zhgu4S0iWpBrSI+9CAyv0dKXPLjQMnDOLsi2btl1Z2CV15C4hIFdeHgZDkuTRwyXpV8y
         om6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qmM61VuVsMz3hWuuFqDNaRjKZS92VzYxO6N789ZujY=;
        b=R6ISiWlRSDrdS787M+Waa29ruZ4EeszptcGssySZ8l+ZPoTiTQrlfe0RYGQj7ERohR
         wZzonnqjjyH17PPNn/tAkJ86USxv0zbfk2qNrqZANxSFvSH/Wm7Q51NgnaoR8R1YAxKv
         qKB0eg/sT53NFgb5180BZCqcs3lvjkJIefWzuggUSRQIctxz9rQSrcLnRpFownkmxmhP
         6Jo2T77PNpi7h/34qT/z6uGDHh+Kz6Tn2A2xl6RrwOuDygpiPM1QOfvLNJgDXriWwyGZ
         kNFPrP3dPOmxwgTzbW+WfcPgj3Y+SD18lZgoF91Ixxiowea4o4iFMPHKmJ0o4Lw66aWd
         94Vg==
X-Gm-Message-State: AFqh2koi3wuMYas34rnDnxsZDBlYBrHcvFt0YYHTs/HZ2duOqimZV6eS
        ATU0Sa6h83xM4SUFiFEfuCumENe8a52+hfBq
X-Google-Smtp-Source: AMrXdXuFBk1LXdG+7B9WICf/qlh6ef/eg1lbv2rOmQf21avxt//OWM2MxXaCWhSiuwsOs7OCsCWcIw==
X-Received: by 2002:a05:6512:1115:b0:4aa:e120:b431 with SMTP id l21-20020a056512111500b004aae120b431mr3211495lfg.38.1671799354663;
        Fri, 23 Dec 2022 04:42:34 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004b4bae1a05asm504569lff.293.2022.12.23.04.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 04:42:34 -0800 (PST)
Message-ID: <80ef7460-2c92-1636-96c7-c91b7d5c62e6@linaro.org>
Date:   Fri, 23 Dec 2022 13:42:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: sc8280xp: add missing i2c nodes
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-5-bmasney@redhat.com>
 <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y6WEzkcP31S2JGrL@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.12.2022 11:37, Johan Hovold wrote:
> On Tue, Dec 20, 2022 at 02:28:51PM -0500, Brian Masney wrote:
>> Add the missing nodes for the i2c buses that's present on this SoC.
>>
>> This work was derived from various patches that Qualcomm delivered
>> to Red Hat in a downstream kernel.
>>
>> Signed-off-by: Brian Masney <bmasney@redhat.com>
>> ---
>> Changes from v2 to v3
>> - None
>>
>> Changes from v1 to v2
>> - Dropped qupX_ prefix from labels. (Johan)
>>
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 352 +++++++++++++++++++++++++
>>  1 file changed, 352 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index f1111cd7f679..a502d4e19d98 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -813,6 +813,38 @@ qup2: geniqup@8c0000 {
>>  
>>  			status = "disabled";
>>  
>> +			i2c16: i2c@880000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0 0x00880000 0 0x4000>;
>> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
>> +				clock-names = "se";
>> +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
> 
> I'm aware that the two current i2c nodes has these two properties here
> in the middle, but would you mind moving '#address-cells' and
> '#size-cells' after 'reg' instead where I'd expect them to be?
Hm.. we've been sticking them somewhere near the end for the longest
time for every bus-like, or generally "i have childen" type node..
I see it's a rather mixed bag in non-qcom SoCs, people just seem to
put it wherever they please.. The dt spec doesn't seem to mention any
preference fwiw.

Konrad
> 
> Same for the spi patch.
> 
> I can clean up the existing two nodes (and binding example) unless you
> want to do it.
> 
>> +				power-domains = <&rpmhpd SC8280XP_CX>;
>> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
>> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
>> +				interconnect-names = "qup-core", "qup-config", "qup-memory";
>> +				status = "disabled";
>> +			};
> 
> Johan
