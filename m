Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA05B9DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIOOtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiIOOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:49:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81FB7EA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:49:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so31312592wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u+MEx5X3tH0fljhxGvHQehUVImd5GhUM1h1Z4SXLLYI=;
        b=JCVUvByF49G5XLnjbdd4yUFKZVdv/7edOBeVAAqmyxi2aqpjJoG/hDEIvfD6bm1Orm
         luepYghg92YFh+ykjBbDhZqOEbL5pIQHuAKOeVdKC3tB1B/T/SYAKLNHMiDR+9gz9jrG
         Tsb65OBW715HfOtzLuCSWkXA3y+Wjc6BmHNkoEg8+e5NpLnXx5TtOH4UTc3YKAJGDnRI
         9HJgNgiH3VyBOTBEaYK2Rnn52WTFBQRkUsWlvSaa5J9AN5GSRMUhIoC6YXaKEA3fLHlc
         RzkQ1zwrHdSHSmhakhnHA2aMI80k7fMg+FnChWOQlUujQqIFLMXMusrKg8C0NpJTFj27
         8Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u+MEx5X3tH0fljhxGvHQehUVImd5GhUM1h1Z4SXLLYI=;
        b=EWqaEGZhfYIacIm9ROaoon/LVgKU6H4FfqVybEqCtw5NxckjPFrln9KFWgmujVcFJF
         W/OvjORCxG+mNyBW94s8/CegVvNBVc+UzftPdTF5vHp1G8Xf3hLucLPz2ufurIj/ur5O
         dRFSu8C5QCNq34HW7m5kY5KZN7DTAeJsF1hrQ4Z7GzJBYSsfLDs8sVyjiaK1Ug5qzXOi
         Yba+mAnrQAjM0x87ruUv/UkGnAmbmdRXZNnap0xQEzFxI5UXKMBN0gfM9Ps8rPCv1KS2
         EoDE9QyH8AeUjzgY9jk7KVjT4KpylbAB8EdHY9zdlzDd4GdhnWJFdmiNvACVy3s9G6R+
         r2CQ==
X-Gm-Message-State: ACrzQf0mrOd433OQpUv8SP17TFa3jXIfGCtUOOaeZs5QXefxIuMBuXND
        ewVbtSclAi5w5PJqIQ6E4oKGbA==
X-Google-Smtp-Source: AMsMyM5XOGsqrjqboyvXUIJfpP7pyqYRF4cq1JP8xx8yhipEVSCPdpV3hhNdVUJhIN58nfUGXwHOhA==
X-Received: by 2002:a5d:5a0d:0:b0:228:da3f:738 with SMTP id bq13-20020a5d5a0d000000b00228da3f0738mr22398wrb.526.1663253378697;
        Thu, 15 Sep 2022 07:49:38 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.72])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c420a00b003b4935f04aasm3157668wmh.10.2022.09.15.07.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 07:49:38 -0700 (PDT)
Message-ID: <79889adc-9224-c257-3957-3a02ec55f091@linaro.org>
Date:   Thu, 15 Sep 2022 15:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 10/15] ARM: dts: qcom: msm8974: split TCSR halt regs
 out of mutex
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-11-krzysztof.kozlowski@linaro.org>
 <20220913224418.jvvguc66y5le7qjo@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913224418.jvvguc66y5le7qjo@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 23:44, Bjorn Andersson wrote:
> On Fri, Sep 09, 2022 at 11:20:30AM +0200, Krzysztof Kozlowski wrote:
> [..]
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> index 90a6d4b7605c..ada232bed2c8 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -1189,7 +1189,7 @@ remoteproc_mss: remoteproc@fc880000 {
>>  			resets = <&gcc GCC_MSS_RESTART>;
>>  			reset-names = "mss_restart";
>>  
>> -			qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
>> +			qcom,halt-regs = <&tcsr_1 0x180 0x200 0x280>;
>>  
>>  			qcom,smem-states = <&modem_smp2p_out 0>;
>>  			qcom,smem-state-names = "stop";
>> @@ -1230,10 +1230,15 @@ smd-edge {
>>  
>>  		tcsr_mutex_block: syscon@fd484000 {
>>  			compatible = "syscon";
>> -			reg = <0xfd484000 0x2000>;
>> +			reg = <0xfd484000 0x1000>;
>>  		};
>>  
>> -		tcsr: syscon@fd4a0000 {
>> +		tcsr_1: syscon@fd485000 {
> 
> While the accessed registers look general purpose in nature, I would
> prefer that we stick with naming it based on the register blocks - and
> this is part of what's named "tcsr_mutex".

Then everything would be like:

tcsr_mutex_1: syscon@fd484000
tcsr_mutex_2: syscon@fd485000
tcsr: syscon@fd4a0000
?

> 
> Is it not possible to claim that this region is a
> "qcom,msm8974-tcsr-mutex" and a "syscon"?

Hm, yes, that's another approach. We can go this way, but it has one
drawback - you could have two different devices (mutex and syscon user)
poking to the same registers. The regmap makes it safe from concurrency
point of view, but not safe from logic point of view.

Splitting these makes it sure, that no one touches hwlock registers,
except the hwlock driver.

Any preference?

> 
>> +			compatible = "qcom,tcsr-msm8974", "syscon";
>> +			reg = <0xfd485000 0x1000>;
>> +		};
>> +
>> +		tcsr_2: syscon@fd4a0000 {
> 
> And I would like to keep this as "tcsr".



Best regards,
Krzysztof
