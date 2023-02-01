Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B1685EA1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBAEur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjBAEuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:50:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1178A1E2A3;
        Tue, 31 Jan 2023 20:50:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B98602F4;
        Tue, 31 Jan 2023 20:51:22 -0800 (PST)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 622DD3F71E;
        Tue, 31 Jan 2023 20:50:35 -0800 (PST)
Message-ID: <e1688749-bcdf-14f4-ac34-137a602286e1@arm.com>
Date:   Wed, 1 Feb 2023 10:20:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] arm64: Add a couple of missing part numbers
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Michal Orzel <michal.orzel@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230201000900.3150295-1-konrad.dybcio@linaro.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230201000900.3150295-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/23 05:39, Konrad Dybcio wrote:
> Add Cortex X1C and add/clarify various recent Qualcomm Kryo cores,
> which almost exclusively mimic ARM IDs nowadays.

Why add these cpu numbers ? Is there an errata being worked on for them ?
Without specific implementation requirement, these might not be necessary.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> 
> - Don't change the name of QCOM_CPU_PART_KRYO_4XX_SILVER
> 
>  arch/arm64/include/asm/cputype.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 683ca3af4084..a4260d3194fc 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -84,6 +84,7 @@
>  #define ARM_CPU_PART_CORTEX_X2		0xD48
>  #define ARM_CPU_PART_NEOVERSE_N2	0xD49
>  #define ARM_CPU_PART_CORTEX_A78C	0xD4B
> +#define ARM_CPU_PART_CORTEX_X1C		0xD4C
>  
>  #define APM_CPU_PART_POTENZA		0x000
>  
> @@ -107,9 +108,17 @@
>  #define QCOM_CPU_PART_KRYO		0x200
>  #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
>  #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
> +#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
>  #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
>  #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
>  #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
> +#define QCOM_CPU_PART_KRYO_5XX_GOLD	ARM_CPU_PART_CORTEX_A77
> +#define QCOM_CPU_PART_KRYO_6XX_GOLD	ARM_CPU_PART_CORTEX_A78
> +#define QCOM_CPU_PART_KRYO_6XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X1
> +#define QCOM_CPU_PART_KRYO_6XX_SILVER_V1	ARM_CPU_PART_CORTEX_A55
> +#define QCOM_CPU_PART_KRYO_7XX_GOLD	ARM_CPU_PART_CORTEX_A710
> +#define QCOM_CPU_PART_KRYO_7XX_GOLDPLUS	ARM_CPU_PART_CORTEX_X2
> +#define QCOM_CPU_PART_KRYO_7XX_SILVER	ARM_CPU_PART_CORTEX_A510
>  
>  #define NVIDIA_CPU_PART_DENVER		0x003
>  #define NVIDIA_CPU_PART_CARMEL		0x004
