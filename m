Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A1D68F9D7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBHVku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjBHVkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:40:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C072A24CA1;
        Wed,  8 Feb 2023 13:40:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F02617EB;
        Wed,  8 Feb 2023 21:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93802C433D2;
        Wed,  8 Feb 2023 21:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675892443;
        bh=vGjgAzSDM+kGykXXRO7m7rBzi73B3auHxgdl5bgfbnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aqjZrxxMYKIiSPQm9f7FJmtV0jqkueYWuBV+K/zYJRSK0FdcxAxBW0pBFnOiW+zgc
         OzLxBrI3PcBxj8zwX4Fm5pmzHVJQJTYk0m/sJNx6SeRk5mS7KBJIiHGwGa4QAxTKEf
         6UASXCJBAuhQ3DjmKccYJlEcGDiv2uUnxXcRA9ElyDMYMzM1SXXHHOz0ItjxKvGZMl
         3wsnKrb4S2VmbJhXMr4CUERAg7JN6/oAHv08Q0dXZ9Dybw1OGlqEnxprZbMQaOh3EZ
         Q2fozt4xDea8XL/KduLQV8N5tXSyNNfl+QMULYAUc6C71VUN5qMayd+B0OF2zX2p+J
         fOyr9b9JP4Rtw==
Date:   Wed, 8 Feb 2023 13:42:54 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: [PATCH V3] arm64: defconfig: Enable scm download mode config for
 IPQ Targets
Message-ID: <20230208214254.nabavfpj5ymdgr3a@ripper>
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-5-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208053332.16537-5-quic_poovendh@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 11:03:31AM +0530, Poovendhan Selvaraj wrote:
> Enabling the download mode config by default as the IPQ Targets use
> crashdump feature extensively to debug crashes.
> 

No thanks.

You can pass qcom_scm.download_mode=1 on the kernel command line to turn
this on dynamically when you want it. There's no reason to attempt
enabling download mode on every Qualcomm board running the upstream
kernel.

Regards,
Bjorn

> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>  Changes in V3:
> 	- Updated the commit message
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 37a60df14e1d..42c9ccdbf0dc 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -258,6 +258,7 @@ CONFIG_ARM_SCPI_PROTOCOL=y
>  CONFIG_RASPBERRYPI_FIRMWARE=y
>  CONFIG_INTEL_STRATIX10_SERVICE=y
>  CONFIG_INTEL_STRATIX10_RSU=m
> +CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT=y
>  CONFIG_EFI_CAPSULE_LOADER=y
>  CONFIG_IMX_SCU=y
>  CONFIG_IMX_SCU_PD=y
> -- 
> 2.17.1
> 
