Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9B6C0265
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 15:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCSOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCSOYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 10:24:34 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F42D113E4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 07:24:30 -0700 (PDT)
Received: from pendragon.ideasonboard.com (85-76-162-78-nat.elisa-mobile.fi [85.76.162.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4900A1858;
        Sun, 19 Mar 2023 15:24:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679235868;
        bh=w+dkC9MWnejOzS6P8ye/zUNBDJBYdWNlGyEoaQz3niE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQuAAfQ8aiKPzhFhBF5zEauCz3mIDghGKUoDXgAMHIz03NE261MD4vl2NbUXmSJ/K
         vLSdT8cI2KzAAhc4itHT/+ovC7JutO6FuJw+jjRS8ZEet4ePymC63YZUP2ILHYmyMo
         TuB56T+AvBSXkjWEbVHA7UwSnXWIF98rfmK9TYqQ=
Date:   Sun, 19 Mar 2023 16:24:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 02/37] drm/xlnx/zynqmp_disp: Use correct kerneldoc
 formatting in zynqmp_disp
Message-ID: <20230319142432.GM10144@pendragon.ideasonboard.com>
References: <20230317081718.2650744-1-lee@kernel.org>
 <20230317081718.2650744-3-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230317081718.2650744-3-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Fri, Mar 17, 2023 at 08:16:43AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'blend' not described in 'zynqmp_disp'
>  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'avbuf' not described in 'zynqmp_disp'
>  drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or member 'audio' not described in 'zynqmp_disp'
> 
> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 3b87eebddc979..63358f4898625 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -128,9 +128,9 @@ struct zynqmp_disp_layer {
>   * struct zynqmp_disp - Display controller
>   * @dev: Device structure
>   * @dpsub: Display subsystem
> - * @blend.base: Register I/O base address for the blender
> - * @avbuf.base: Register I/O base address for the audio/video buffer manager
> - * @audio.base: Registers I/O base address for the audio mixer
> + * @blend: .base: Register I/O base address for the blender
> + * @avbuf: .base: Register I/O base address for the audio/video buffer manager
> + * @audio: .base: Registers I/O base address for the audio mixer

This is a hack, it won't work properly if the nested structures get
extended with more fields.

Is there a correct kerneldoc syntax for this code construct ?

>   * @layers: Layers (planes)
>   */
>  struct zynqmp_disp {

-- 
Regards,

Laurent Pinchart
