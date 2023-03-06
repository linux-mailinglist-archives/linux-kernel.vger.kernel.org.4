Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F686AC4C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCFPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCFPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:25:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF6D2F7BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:25:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j3so5913130wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4M5EShhmBFcxGCEVKdfTzXS4LcKaSaPPMq/FXQBqpRY=;
        b=rJc0ZmWlRsislesjGL/TkmWEjmzmC0aj+usOVImE2SGezdIOLdByoUGSgz5mseeIeg
         G4+WoxAq/rA2gHbTtQP9RgGHR3QxenX03pIIWJKNsUydyH0hGrXGL39A/0n4tq+iorCH
         pIWDOrWuID5Do6J9I5RRcfYiwXvzaAVFmYqWnajGg97ySn7gTO+ses+RAdtl6NE7YiFf
         tzHO34Zi01bqNFN7V7bUB5lOB897U1X7xzx5kyoLjQupoqvC+Hta/3IjrLRYLFk7PAmz
         491iCP118gNV7xBbNEsktjf1HA0xVweJhYFKoR7pd0fYqTaZVV6i6pjL4xEB3EqefZBp
         BLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4M5EShhmBFcxGCEVKdfTzXS4LcKaSaPPMq/FXQBqpRY=;
        b=xduIAXeEyOE8impEIEyDb8gf7ByJPHeXJPjxGVcku1tZwtY8JpdgiZwSxMKH/eObWa
         C55pKRiWhDSOqOudJT9s1wsSNg++lmoKbHZOLw3MmYBlLxwGiq2FUKoOxOzEhCIcPSBf
         Y0UkgvaOPSThKawunqh/h/U0BV0bWBrLqmWmHW7t/XIo2Bv5TzMZ8U90dPEabgqBRSte
         oIAw3Y+wsU+/FOEa8TdSZC/KYVsBUbkSOPIg7LNF9YUZNwTkrVFPhKm/smTHtbKibR1w
         0meC9VkScallifyOG1NOdizssSNGh75M+yw+GjdLz9xIqAyUbp077SsF/G38VqRr3fHo
         CfbQ==
X-Gm-Message-State: AO0yUKWK5I9Ub+xXZUhrr/ouEWeWzWqZNh/UgLRoYUsGs7Ez6CkJSRgs
        RLrKqA7HYn/e1ZuzAGSpRnW+6k3UTyXM+rbylZA=
X-Google-Smtp-Source: AK7set8gtdgb5xFxUcPdEhKc20fGna/uDLX920yNR6Jzf7oVQ93NP0gO6L91ddBHqGZ1mW4lsscUmw==
X-Received: by 2002:a05:600c:450d:b0:3d9:f769:2115 with SMTP id t13-20020a05600c450d00b003d9f7692115mr10152722wmo.26.1678116352022;
        Mon, 06 Mar 2023 07:25:52 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s19-20020a05600c45d300b003df7b40f99fsm15508874wmo.11.2023.03.06.07.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 07:25:51 -0800 (PST)
Message-ID: <a041186e-fd7d-0bd2-eb67-8e6000b50c32@linaro.org>
Date:   Mon, 6 Mar 2023 15:25:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
 <20230223153655.262783-3-bryan.odonoghue@linaro.org>
 <ZAYA4cdlpIfjdqt2@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZAYA4cdlpIfjdqt2@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 15:04, Stephan Gerhold wrote:
> Hi Bryan,
> 
> Thanks for making the changes. I only have some minor nitpicks now:

>> +
>> +			tsens_base1: base1@a0 {
>> +				reg = <0xa0 0x1>;
>> +				bits = <0 8>;
>> +			};
>> +
>> +			tsens_s5_p1: s5-p1@a1 {
>> +				reg = <0xa1 0x1>;
>> +				bits = <0 6>;
>> +			};
>> [...]
>> +		tsens: thermal-sensor@4a9000 {
>> +			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
>> +			reg = <0x004a9000 0x1000>, /* TM */
>> +			      <0x004a8000 0x1000>; /* SROT */
>> +			nvmem-cells = <&tsens_mode>,
>> +				      <&tsens_base1>, <&tsens_base2>,
>> +				      <&tsens_s0_p1>, <&tsens_s0_p2>,
>> +				      <&tsens_s1_p1>, <&tsens_s1_p2>,
>> +				      <&tsens_s2_p1>, <&tsens_s2_p2>,
>> +				      <&tsens_s3_p1>, <&tsens_s3_p2>,
>> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
>> +				      <&tsens_s4_p1>, <&tsens_s4_p2>,
>> +				      <&tsens_s5_p1>, <&tsens_s5_p2>,
>> +				      <&tsens_s6_p1>, <&tsens_s6_p2>,
>> +				      <&tsens_s7_p1>, <&tsens_s7_p2>,
>> +				      <&tsens_s8_p1>, <&tsens_s8_p2>;
>> +			nvmem-cell-names = "mode",
>> +					   "base1", "base2",
>> +					   "s0_p1", "s0_p2",
>> +					   "s1_p1", "s1_p2",
>> +					   "s2_p1", "s2_p2",
>> +					   "s3_p1", "s3_p2",
>> +					   "s4_p1", "s4_p2",
>> +					   "s4_p1", "s4_p2",
> 
> s4_p1/p2 are specified twice, is this on purpose or accidental?

On purpose I believe.

@Dmitry ?

> 
>> +					   "s5_p1", "s5_p2",
>> +					   "s6_p1", "s6_p2",
>> +					   "s7_p1", "s7_p2",
>> +					   "s8_p1", "s8_p2";
>> +			#qcom,sensors = <9>;
>> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "uplow";
>> +			#thermal-sensor-cells = <1>;
>> +		};
>> [...]
>> +		usb: usb@78d9000 {
>> +			compatible = "qcom,ci-hdrc";
>> +			reg = <0x078d9000 0x200>,
>> +			      <0x078d9200 0x200>;
>> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
>> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			clock-names = "iface", "core";
>> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
>> +			assigned-clock-rates = <80000000>;
>> +			resets = <&gcc GCC_USB_HS_BCR>;
>> +			reset-names = "core";
>> +			#reset-cells = <1>;
>> +			phy_type = "ulpi";
>> +			dr_mode = "otg";
> 
> Please add
> 
> 			hnp-disable;
> 			srp-disable;
> 			adp-disable;
> 
> here for consistency with msm8916.dtsi. These are needed for correct
> behavior if you enable CONFIG_USB_OTG_FSM, see commit bfd5d21abcd5c
> ("arm64: dts: qcom: msm8916: Move common USB properties to msm8916.dtsi")
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfd5d21abcd5c7941ad79b594f5f42e27496eb28
> 

Hmm, I haven't noticed any problems with OTG - then again, I'm looking 
at my kernel config and +# CONFIG_USB_OTG_FSM is not set


