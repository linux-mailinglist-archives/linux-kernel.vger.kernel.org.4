Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9C63F8DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLAUPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiLAUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:15:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A7BEE22;
        Thu,  1 Dec 2022 12:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52F06B82025;
        Thu,  1 Dec 2022 20:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DC8C433D6;
        Thu,  1 Dec 2022 20:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669925743;
        bh=NJZdGIoTQ+syZmGFc9QowZvmsGy6Ky1CvgYKtzEukIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UoCrH0/cQsxc9IjEbuD5u3e9fmgx3T1slPaJJPc9macrTyYP5SSVV9e1vIDUWYX74
         jfjgS8kZFGEPdm6FQQPpGaMyL+hZ9Z73FDsd4+utvQARXPkm/S04USxyCglP8O94JQ
         k/ALzVut9f78dqhlXiJzMCdENjpnS+z0NbGwV/6HgiJLN2aexYf1YWjY0ZWiV+QbLa
         mYkXRN2xLYy7w9Mu4WAbNI5X2QPgydRtY1kuTE9MTlZQjX7uXbdt2DOmJ9tZLA4Nbe
         6gbQ6gkDNintLXmpf/kUs3JaeQukAlrKiimbKekL2pgsdH5ZfVqP24xcwzsvOf/8yC
         Kw/ha74cQuwNQ==
Date:   Thu, 1 Dec 2022 14:15:39 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com, vkoul@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: Re: [PATCH v4 23/23] MAINTAINERS: Add myself as the maintainer for
 Qcom UFS drivers
Message-ID: <20221201201539.ohhbs2n75ryw6lad@builder.lan>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
 <20221201174328.870152-24-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201174328.870152-24-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 11:13:28PM +0530, Manivannan Sadhasivam wrote:
> Qcom UFS drivers are left un-maintained till now. I'd like to step up to
> maintain the drivers and the binding.
> 

Acked-by: Bjorn Andersson <andersson@kernel.org>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3583c5f6889d..3c8214f4a3cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21379,6 +21379,14 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/ufs/host/ufs-mediatek*
>  
> +UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER QUALCOMM HOOKS
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	linux-scsi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +F:	drivers/ufs/host/ufs-qcom*
> +
>  UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER RENESAS HOOKS
>  M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:	linux-renesas-soc@vger.kernel.org
> -- 
> 2.25.1
> 
