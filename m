Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61E5F78C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJGNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJGNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:18:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DCCBFFD;
        Fri,  7 Oct 2022 06:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 977C061316;
        Fri,  7 Oct 2022 13:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4248DC433D6;
        Fri,  7 Oct 2022 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148725;
        bh=8EM0VhfZpgIlWPgAdUMjVvdT66pVAie47ABJTZJS8mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fmVR6gHTJt3aVmfmhR8NTy5NbikusmaylP8QASv1qiH2ojlCye56yffJ27JpbhOzB
         bg8ts4x9TnJhC0FE53fmJiwMzeTC7ABeLRZduK05n5zR6+vNIBSj46zRf8wQrye7sl
         AESc6Dxf+GbxFTutFztk6sLsK4IJtyqwA2jPuxHcLbrTUTxmFzu1ClfoDgwZxrBSnn
         5Bq2kk/rF9OzvM+R7wT8IDUkJNMNhZb6S4DNkX3ksyUYDfY01zLznhrL9n3W5BYE+o
         lbFx7facMfMBg84BicOEZAtJAIXiCJGgLAkYbYl5uRKARCVKlzcpVgxKHxtWFQZXis
         X8L0I4BdjBEdg==
Date:   Fri, 7 Oct 2022 14:18:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, catalin.marinas@arm.com
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Hongbo Yao <yaohongbo@linux.alibaba.com>,
        Neng Chen <nengchen@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify file entry in ALIBABA PMU DRIVER
Message-ID: <20221007131838.GC26341@willie-the-truck>
References: <20220929122937.20132-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929122937.20132-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 02:29:37PM +0200, Lukas Bulwahn wrote:
> Commit cf7b61073e45 ("drivers/perf: add DDR Sub-System Driveway PMU driver
> for Yitian 710 SoC") adds the DDR Sub-System Driveway PMU driver here:
> 
>   drivers/perf/alibaba_uncore_drw_pmu.c
> 
> The file entry in MAINTAINERS for the ALIBABA PMU DRIVER, introduced with
> commit d813a19e7d2e ("MAINTAINERS: add maintainers for Alibaba' T-Head PMU
> driver"), however refers to:
> 
>   drivers/perf/alibaba_uncore_dwr_pmu.c
> 
> Note the swapping of characters.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken file pattern.
> 
> Repair this file entry in ALIBABA PMU DRIVER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 485d66af5c9a..e14e37c7c734 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -754,7 +754,7 @@ ALIBABA PMU DRIVER
>  M:	Shuai Xue <xueshuai@linux.alibaba.com>
>  S:	Supported
>  F:	Documentation/admin-guide/perf/alibaba_pmu.rst
> -F:	drivers/perf/alibaba_uncore_dwr_pmu.c
> +F:	drivers/perf/alibaba_uncore_drw_pmu.c
>  
>  ALIENWARE WMI DRIVER
>  L:	Dell.Client.Kernel@dell.com

Acked-by: Will Deacon <will@kernel.org>

Will
