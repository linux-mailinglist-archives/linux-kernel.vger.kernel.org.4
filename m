Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926997459B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGCKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGCKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:09:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF7A6196;
        Mon,  3 Jul 2023 03:09:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 273432F4;
        Mon,  3 Jul 2023 03:10:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.27.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4700B3F762;
        Mon,  3 Jul 2023 03:09:38 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:09:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: pmuv3: Add Cortex-A520, Cortex-A715, and
 Cortex-A720 PMUs
Message-ID: <ZKKeX4LU0_8qpTxk@FVFF77S0Q05N>
References: <20230630185602.2175559-1-robh@kernel.org>
 <20230630185602.2175559-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630185602.2175559-2-robh@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 12:56:02PM -0600, Rob Herring wrote:
> Add support for the Arm Cortex-A520, Cortex-A715, and Cortex-A720 CPU
> PMUs. They are straight-forward additions with just new compatible
> strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_pmuv3.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 08b3a1bf0ef6..0bf522b05dc3 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1266,7 +1266,10 @@ PMUV3_INIT_SIMPLE(armv8_cortex_a76)
>  PMUV3_INIT_SIMPLE(armv8_cortex_a77)
>  PMUV3_INIT_SIMPLE(armv8_cortex_a78)
>  PMUV3_INIT_SIMPLE(armv9_cortex_a510)
> +PMUV3_INIT_SIMPLE(armv9_cortex_a520)
>  PMUV3_INIT_SIMPLE(armv9_cortex_a710)
> +PMUV3_INIT_SIMPLE(armv9_cortex_a715)
> +PMUV3_INIT_SIMPLE(armv9_cortex_a720)
>  PMUV3_INIT_SIMPLE(armv8_cortex_x1)
>  PMUV3_INIT_SIMPLE(armv9_cortex_x2)
>  PMUV3_INIT_SIMPLE(armv8_neoverse_e1)
> @@ -1334,7 +1337,10 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
>  	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_cortex_a77_pmu_init},
>  	{.compatible = "arm,cortex-a78-pmu",	.data = armv8_cortex_a78_pmu_init},
>  	{.compatible = "arm,cortex-a510-pmu",	.data = armv9_cortex_a510_pmu_init},
> +	{.compatible = "arm,cortex-a520-pmu",	.data = armv9_cortex_a520_pmu_init},
>  	{.compatible = "arm,cortex-a710-pmu",	.data = armv9_cortex_a710_pmu_init},
> +	{.compatible = "arm,cortex-a715-pmu",	.data = armv9_cortex_a715_pmu_init},
> +	{.compatible = "arm,cortex-a720-pmu",	.data = armv9_cortex_a720_pmu_init},
>  	{.compatible = "arm,cortex-x1-pmu",	.data = armv8_cortex_x1_pmu_init},
>  	{.compatible = "arm,cortex-x2-pmu",	.data = armv9_cortex_x2_pmu_init},
>  	{.compatible = "arm,neoverse-e1-pmu",	.data = armv8_neoverse_e1_pmu_init},
> -- 
> 2.40.1
> 
