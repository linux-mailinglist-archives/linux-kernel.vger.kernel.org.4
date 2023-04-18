Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5D6E6DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDRUsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjDRUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:48:30 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6FEB2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:48:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8eb8db083so738981fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681850906; x=1684442906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNwxn7R3RC0Mn5I/0czxoNzHSIGSOJyF/CObdh+ww64=;
        b=J1q4mU0mtcCp+gqTWSS4C6bpd4cupq8q6sAEwQfqiFGPLQAPMSyiHy/uYXZT4F9SRZ
         AtqC+bEjUfoAg81CcnbkU/ovGrOwFX1o8CX8ZRuQtzxpxIu3oz3S025ofBgKe0709mTc
         2/PWQ8ijlH2cSxALOas5Bb/hG60plEe09kKqqb7XpL+/UD41M5DelghqzAf8NbL5CDqX
         xfzDLiGkY+r/xvkF/y37bVFo92E56lG2b8FLIQrHqpgZkSz4wDf2h+TN/0gzerhzEGm6
         BwDlAwMJY2mR4ilSTxODWOL0MO+RvNWQl90UuVlwgHYuoAWmn+opAdafmeqaGg5+imo6
         posA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850906; x=1684442906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNwxn7R3RC0Mn5I/0czxoNzHSIGSOJyF/CObdh+ww64=;
        b=aJqL2XF0U/geXxMy0y2ZldZk22hxFzi+XteYwqUqYioYL0dT5K83GvL7Xv6k+VSuoD
         ql9FTqnuvvTPZS6xhbeNcPK6olZ2SNeXV1gM3IK4FzQThTN4LO97edqZpP5/TFnPDKHL
         oNktUCa5aNTFY70+OLN0Ssm4AI1Ir90H/vjDdMdNgoiOBsFA9yQbK9ac4wn+fyTDN0RW
         LsjV4bqehODeEFu3WXL3kSk2dy/OusY6mh0iZ6k4oN9MV24kQaWNFz781oU+RQ7HHNSV
         7p/eivN1NHxHyOMj++ko1ttdbqkKxjVahnCR8p8rqe13pWqUcfKLCaAorC9YlrdTvfNC
         tRwg==
X-Gm-Message-State: AAQBX9eLPCnEFXQvKoT0INsQNy7y43OhB2WhfMRDNEbTSsGMrNIO+f2r
        7R8J1HCtZevNCTneeAf7fylvvw==
X-Google-Smtp-Source: AKy350Y0rp9M04y2mgcsfCadZ2RsHQeKO2g8fIO9Z9SyLGPsCtSR3WQdzlGY3R8UACvAURNVFgwfYw==
X-Received: by 2002:ac2:4155:0:b0:4e8:44a5:6018 with SMTP id c21-20020ac24155000000b004e844a56018mr3426540lfi.44.1681850906209;
        Tue, 18 Apr 2023 13:48:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a14-20020ac2520e000000b004cc8196a308sm2475903lfl.98.2023.04.18.13.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 13:48:25 -0700 (PDT)
Message-ID: <0d071242-5851-7311-694a-b5b437a3a276@linaro.org>
Date:   Tue, 18 Apr 2023 22:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/5] arm64: dts: qcom: sa8775p: add the pcie smmu node
Content-Language: en-US
To:     Eric Chanudet <echanude@redhat.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
References: <20230417125844.400782-1-brgl@bgdev.pl>
 <20230417125844.400782-3-brgl@bgdev.pl>
 <20230418165224.vmok75fwcjqdxspe@echanude>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230418165224.vmok75fwcjqdxspe@echanude>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 18:52, Eric Chanudet wrote:
> On Mon, Apr 17, 2023 at 02:58:41PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Add the PCIe SMMU node for sa8775p platforms.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 74 +++++++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
> 
> Hi Bartosz,
> 
> Adding Shazad.
> 
> I upgraded to the meta Shazad mentioned in v2[1], but I still get a
> synchronous external abort on reboot:
Taking a look at downstream, looks like:

- it's marked as dma-coherent
- it expects interconnects (MAS_PCIE[01]<->SLV_EBI1)

Perhaps that's worth looking into

Konrad

> 
> [    8.285500] arm-smmu 15200000.iommu: disabling translation
> 4      12.145913 Injecting instruction/data abort to VM 3, original ESR_EL2 = 0x93800047, fault VA = 0xffff80000a080000, fault IPA = 0x15200000, ELR_EL2 = 0xffffae99a42c96e4
> [    8.310145] Internal error: synchronous external abort: 0000000096000010 [#1] PREEMPT SMP
> [    8.316561] Modules linked in: qcom_pon crct10dif_ce gpucc_sa8775p i2c_qcom_geni spi_geni_qcom ufs_qcom phy_qcom_qmp_ufs socinfo fuse ipv6
> [    8.331284] CPU: 4 PID: 1 Comm: systemd-shutdow Not tainted 6.3.0-rc7-next-20230417-00014-g93340f644112 #136
> [    8.341365] Hardware name: Qualcomm SA8775P Ride (DT)
> [    8.346555] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    8.353705] pc : arm_smmu_device_shutdown+0x64/0x154
> [    8.358815] lr : arm_smmu_device_shutdown+0x3c/0x154
> [    8.363915] sp : ffff80000805bc00
> [    8.367322] x29: ffff80000805bc00 x28: ffff69c250ca0000 x27: 0000000000000000
> [    8.374643] x26: ffffae99a53357f8 x25: 0000000000000001 x24: ffffae99a60d5028
> [    8.381963] x23: ffff69c2516ab890 x22: ffffae99a614e218 x21: ffff69c251668c10
> [    8.389283] x20: ffff69c2516ab810 x19: ffff69c251479a80 x18: 0000000000000006
> [    8.396603] x17: 0000000000000014 x16: 0000000000000030 x15: ffff80000805b5d0
> [    8.403923] x14: 0000000000000000 x13: ffffae99a5ce1a28 x12: 00000000000005eb
> [    8.411243] x11: 00000000000001f9 x10: ffffae99a5d39a28 x9 : ffffae99a5ce1a28
> [    8.418563] x8 : 00000000ffffefff x7 : ffffae99a5d39a28 x6 : 80000000fffff000
> [    8.425884] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
> [    8.433204] x2 : 0000000000000000 x1 : ffff80000a080000 x0 : 0000000000000001
> [    8.440524] Call trace:
> [    8.443039]  arm_smmu_device_shutdown+0x64/0x154
> [    8.447784]  platform_shutdown+0x24/0x34
> [    8.451821]  device_shutdown+0x150/0x258
> [    8.455857]  kernel_restart+0x40/0xc0
> [    8.459623]  __do_sys_reboot+0x1f0/0x274
> [    8.463656]  __arm64_sys_reboot+0x24/0x30
> [    8.467778]  invoke_syscall+0x48/0x114
> [    8.471633]  el0_svc_common+0x40/0xf4
> [    8.475397]  do_el0_svc+0x3c/0x9c
> [    8.478806]  el0_svc+0x2c/0x84
> [    8.481947]  el0t_64_sync_handler+0xf4/0x120
> [    8.486334]  el0t_64_sync+0x190/0x194
> [    8.490100] Code: f9400404 b50005e4 f9400661 52800020 (b9000020) 
> [    8.496361] ---[ end trace 0000000000000000 ]---
> 
> [1] https://lore.kernel.org/linux-arm-kernel/24804682-6ead-03b1-8b21-3ac413187c4a@quicinc.com/
> 
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 2343df7e0ea4..a23175352a20 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -809,6 +809,80 @@ apps_smmu: iommu@15000000 {
>>  				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
>>  		};
>>  
>> +		pcie_smmu: iommu@15200000 {
>> +			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
>> +			reg = <0x0 0x15200000 0x0 0x80000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <2>;
>> +
>> +			interrupts = <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 925 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 926 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 927 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 928 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 952 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 953 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 954 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 955 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 956 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 957 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 958 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 888 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 843 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 844 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 845 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 847 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 855 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>>  		intc: interrupt-controller@17a00000 {
>>  			compatible = "arm,gic-v3";
>>  			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
>> -- 
>> 2.37.2
>>
> 
