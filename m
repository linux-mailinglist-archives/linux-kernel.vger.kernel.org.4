Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A56006A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiJQGZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJQGZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2B15282A;
        Sun, 16 Oct 2022 23:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB7860EFC;
        Mon, 17 Oct 2022 06:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A56C433D6;
        Mon, 17 Oct 2022 06:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665987944;
        bh=r/qtiRQSzBRuWHx4CJJv3HpvlT6NVIUzeaBeeHmIZG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hcp97rWBRX/WgBigojhm+05r8ogVbW0GdnMcQ3ZnP0doK2xfx9QJPC1cDmJS/gbmX
         OzmOAOkjEF3YdDhSXW/R2bBOxuvRk7nWbdV7nzuWMxI/gUrgN2jocJyASmfy76WxHa
         v5EXM7zMludWfyys8cA2gySRBnhqaWh3DBQPb5PobshAktEQKcR2lx06tHyjammGvg
         4Ko602g1gAftiBgBNuoJXz26Y51Im0RSq65g9jVGVNxiN0qseP1MgS+vNqAFCw0Vfp
         P88foPby74DRmGxkYBUrzXLKS9A3CjrEsT/QTOrGOrBSq3wMYdpKb82crJfugswn0e
         tFlJ3mQdfYn0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1okJZ7-0004qj-0B; Mon, 17 Oct 2022 08:25:33 +0200
Date:   Mon, 17 Oct 2022 08:25:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     stable-commits@vger.kernel.org, johan+linaro@kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch "phy: qcom-qmp-combo: disable runtime PM on unbind" has
 been added to the 5.15-stable tree
Message-ID: <Y0z1XFHN2Ax9AD27@hovoldconsulting.com>
References: <20221017031601.2437904-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017031601.2437904-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending with Vinod and the lists on CC. You forgot to CC the
maintainer. ]

On Sun, Oct 16, 2022 at 11:16:01PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     phy: qcom-qmp-combo: disable runtime PM on unbind
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      phy-qcom-qmp-combo-disable-runtime-pm-on-unbind.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit f3aca84b69977d7c024d9fbf52163de4b852df22
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Wed Sep 7 13:07:13 2022 +0200
> 
>     phy: qcom-qmp-combo: disable runtime PM on unbind
>     
>     [ Upstream commit 4382d518d1887e62234560ea08a0203d11d28cc1 ]
>     
>     Make sure to disable runtime PM also on driver unbind.
>     
>     Fixes: ac0d239936bd ("phy: qcom-qmp: Add support for runtime PM").
>     Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>     Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     Link: https://lore.kernel.org/r/20220907110728.19092-2-johan+linaro@kernel.org
>     Signed-off-by: Vinod Koul <vkoul@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index c7309e981bfb..dcf8a8764e17 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c

This driver did not exist in 5.15. Please don't tell me you're
backporting the QMP driver split and all the follow up cleanups?

Note that hardly any of these QMP fixes had a stable tag for a reason.

> @@ -6273,7 +6273,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
>  	/*
>  	 * Prevent runtime pm from being ON by default. Users can enable
>  	 * it using power/control in sysfs.
> @@ -6323,13 +6325,10 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>  	if (!IS_ERR(phy_provider))
>  		dev_info(dev, "Registered Qcom-QMP phy\n");
> -	else
> -		pm_runtime_disable(dev);
>  
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  
>  err_node_put:
> -	pm_runtime_disable(dev);
>  	of_node_put(child);
>  	return ret;
>  }

Johan
