Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368516368E2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbiKWScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbiKWSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:31:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB741CB69C;
        Wed, 23 Nov 2022 10:31:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3AC61E69;
        Wed, 23 Nov 2022 18:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22FEC433C1;
        Wed, 23 Nov 2022 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669228294;
        bh=K+Iq1u99ln+hWt6sHmpc/POIaayidRC/UWiGVIGIdPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWnz1fYtlQovd9Sfe2d4PpK7jSZeCJaljf/94LGXGqteXYfT08QpviBEtK9bQhwqw
         SQ9+2Iv5n6HXH0auYSojq8L/BgP65EZpmw8ZONZcsId5WEopaI/a8UiBfid7flzF+R
         xv4dXbjWBTHAC+ODl1jg+IZMWJB178FFxFe7H+qvKlTdfehFfSVZAo9tcMRoV9I2Ks
         xo0zS8Hpi7OndVwilZP33AGfYc5NpkNZdCAAokI94jWLe+gZ8vnRjEgBCSWBAAZQo6
         mjClvOwG52kLWL5eFaNooFlPP/hVZ3PZ9LJN9qeY90+G8JknHoGI1YmY6K6VTUEFm1
         +Gki26dGDBEIQ==
Date:   Wed, 23 Nov 2022 18:31:32 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org, quic_cang@quicinc.com,
        quic_asutoshd@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com, abel.vesa@linaro.org
Subject: Re: [PATCH v3 20/20] MAINTAINERS: Add myself as the maintainer for
 Qcom UFS driver
Message-ID: <Y35nBIIRmu3w9C1C@gmail.com>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
 <20221123074826.95369-21-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123074826.95369-21-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 01:18:26PM +0530, Manivannan Sadhasivam wrote:
> Qcom UFS driver has been left un-maintained till now. I'd like to step
> up to maintain the driver and its binding.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..149fd6daf52b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21097,6 +21097,14 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/ufs/host/ufs-mediatek*
>  
> +UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER QUALCOMM HOOKS
> +M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	linux-scsi@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +F:	drivers/ufs/host/ufs-qcom.c

Thanks for volunteering to maintain this driver!

What about ufs-qcom.h and ufs-qcom-ice.c?  Those are part of this driver too.

The pattern drivers/ufs/host/ufs-qcom* would cover all these files.

- Eric
