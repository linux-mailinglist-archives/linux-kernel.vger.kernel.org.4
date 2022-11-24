Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F3C637D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKXPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKXPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:41:00 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F26DCD9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:40:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id p8so3045769lfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCFr/V7FAnUFT7OVq5HHngjGTeEZtVW0kYV/zxFYTPc=;
        b=aYxs7vhu8jPqjCN15B5pqN7dNBgORyB31x0aypGBK2YwE7g5ceffh8fof5vayOy2ym
         JJ+o3oU+LsVvV2NTv4QxCdTv99YNZkNoMXl/GACPYrkuUhKsyecybMpRrdIfacUIosFa
         lcjwddYZehnydafRKjU2Pk75H0O91Gn3NguQRr0xAl3ogyYztTQdJ1AH9TGwIaiQof2w
         mU+WWX69KP7fT68FbnnhyLYx5WkxWVzBPDuVqIlw9tfFbfBC8nQzLTFyJTKVw1Fyb5vj
         GN+nrCoPHjzsu2YHpuyoz8fNX2DTikokIsAzHwxrQpR/xqqi+45+E/fJb2v0ChVMzqbS
         BZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCFr/V7FAnUFT7OVq5HHngjGTeEZtVW0kYV/zxFYTPc=;
        b=Urfone8prAY3ROJdQwjLi0D10iHuUFjjBYKI2DdNPjJP2VW8bQtTFfpz/crTFEje+s
         WOjYXKjTeWIiNG93q+NDK8/QC61cvMpT7dZKVkkPK5HM+1mzrnPPetBBrR7DYIxyF9KO
         LXIzm11V18n3QHz9gcS11hy0mC4Q21E6zQ+XbjcFcERNxY3Yi8vXzOZ3bFcDyXP2rVWn
         /kOcnEgIW7QhCCrKOnwtCvg1waIBAstouoMo+OBPSqO93qBERNglyVzguZjwiirkGvIp
         K5I9veiM9J700anvTOusjvGjNl+eRae969QXm4SJdg/dzoCNN7vozj2l2fd0n9r+hNco
         fDSg==
X-Gm-Message-State: ANoB5pm0u+xjsATNTyaxN9bFtVgInLfR7fcald3iHt6GLGOQNZdJ7KL5
        VYzSieCV483owa0GDxQcuVXsbQ==
X-Google-Smtp-Source: AA0mqf536HBjiuDg+9ktwHptPvepcOWScFiBLpyxA9u0eHO58gQM32+AjiQz+blwQ/A6LK087PUDCg==
X-Received: by 2002:ac2:4c50:0:b0:4b1:8a90:6524 with SMTP id o16-20020ac24c50000000b004b18a906524mr10455255lfk.628.1669304454885;
        Thu, 24 Nov 2022 07:40:54 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id j17-20020a056512029100b004b4e77ae383sm156008lfp.88.2022.11.24.07.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:40:54 -0800 (PST)
Message-ID: <0a119446-4ec1-46ce-68e5-f177f9cb49e3@linaro.org>
Date:   Thu, 24 Nov 2022 16:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 02/10] arm64: dts: qcom: Add base SM8550 dtsi
Content-Language: en-US
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
 <20221124135646.1952727-3-abel.vesa@linaro.org>
 <351fa466-90cb-b73f-a2a4-749bc3529e22@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <351fa466-90cb-b73f-a2a4-749bc3529e22@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2022 16:39, Sai Prakash Ranjan wrote:
> Hi,
> 
> On 11/24/2022 7:26 PM, Abel Vesa wrote:
>> Add base dtsi for SM8550 SoC and includes base description of
>> CPUs, GCC, RPMHCC, UART, interrupt controller, TLMM, reserved
>> memory, RPMh PD, TCSRCC, ITS, IPCC, AOSS QMP, LLCC, cpufreq,
>> interconnect, thermal sensor, cpu cooling maps and SMMU nodes
>> which helps boot to shell with console on boards with this SoC.
>>
>> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> 
> <snip>...
> 
>> +    timer {
>> +        compatible = "arm,armv8-timer";
>> +        interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +                 <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> 
> This last interrupt must be Hypervisor physical irq(10) and 12 is Hyp virtual irq, so please change it to 10. I guess you got this from downstream but it's not right and they don't boot kernel in EL2.
Does non-CrOS 8550 FW allow Linux to boot in EL2?

Konrad
> 
> Thanks,
> Sai
