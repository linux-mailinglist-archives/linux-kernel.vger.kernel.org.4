Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2A674997F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGFKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:30:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C02CD123
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 03:29:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61FEE1480;
        Thu,  6 Jul 2023 03:30:41 -0700 (PDT)
Received: from [10.57.27.160] (unknown [10.57.27.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E1E3F663;
        Thu,  6 Jul 2023 03:29:57 -0700 (PDT)
Message-ID: <af4524c7-6af4-ddfb-1b9f-00e1f8afdc6b@arm.com>
Date:   Thu, 6 Jul 2023 11:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] perf/smmuv3: Remove build dependency on ACPI
Content-Language: en-GB
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     jean-philippe@linaro.org, jkchen@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
References: <20230706-smmuv3-pmu-noacpi-v1-1-7083ef189158@axis.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230706-smmuv3-pmu-noacpi-v1-1-7083ef189158@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-06 10:23, Vincent Whitchurch wrote:
> This driver supports working without ACPI since commit 3f7be43561766
> ("perf/smmuv3: Add devicetree support"), so remove the build dependency.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>   drivers/perf/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 711f824000864..4eef9ad3c1954 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -92,7 +92,7 @@ config ARM_PMU_ACPI
>   
>   config ARM_SMMU_V3_PMU
>   	 tristate "ARM SMMUv3 Performance Monitors Extension"
> -	 depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
> +	 depends on ARM64 || (COMPILE_TEST && 64BIT)
>   	 depends on GENERIC_MSI_IRQ
>   	   help
>   	   Provides support for the ARM SMMUv3 Performance Monitor Counter
> 
> ---
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
> change-id: 20230706-smmuv3-pmu-noacpi-fc835b93a893
> 
> Best regards,
