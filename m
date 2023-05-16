Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B0705126
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbjEPOpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjEPOpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:45:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E1030E6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:45:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (p7097156-ipoefx.ipoe.ocn.ne.jp [153.231.19.155])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CCBBC4A9;
        Tue, 16 May 2023 16:45:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1684248307;
        bh=4kgPpp8sYDiUYX8Gm/m6Tot8dUsJ+Xl/5YYIFuROs7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cryflzdhTVIjE2MobT15qyKMzJ8Zr8Tl7hIi7eQk6DIofsLYU4a7C3OVnWvppTHjF
         2G/QWQD6aVGke21kUfjHJa21hUPS1N/khjfiVGVghrR5E2XGJIEfO3sVNFH9eQdmHo
         FWfX/OCGuJUdsCsZsZycLsuYBW8diEgbis4jTAAk=
Date:   Tue, 16 May 2023 17:45:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove Hyun and Anurag from maintainer list
Message-ID: <20230516144516.GC30231@pendragon.ideasonboard.com>
References: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Tue, May 16, 2023 at 03:47:15PM +0200, Michal Simek wrote:
> There is no activity from them for these drivers. All of them have Laurent
> as active maintainer and their emails no longer works that's why remove
> them from the list.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Will you merge this yourself ?

> ---
> 
>  MAINTAINERS | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..60f6effb168c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7077,7 +7077,6 @@ F:	Documentation/gpu/xen-front.rst
>  F:	drivers/gpu/drm/xen/
>  
>  DRM DRIVERS FOR XILINX
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> @@ -23162,7 +23161,6 @@ S:	Maintained
>  F:	drivers/tty/serial/uartlite.c
>  
>  XILINX VIDEO IP CORES
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Supported
> @@ -23191,7 +23189,6 @@ F:	include/linux/dma/amd_xdma.h
>  F:	include/linux/platform_data/amd_xdma.h
>  
>  XILINX ZYNQMP DPDMA DRIVER
> -M:	Hyun Kwon <hyun.kwon@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	dmaengine@vger.kernel.org
>  S:	Supported
> @@ -23207,7 +23204,6 @@ F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yam
>  F:	drivers/edac/zynqmp_edac.c
>  
>  XILINX ZYNQMP PSGTR PHY DRIVER
> -M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported

-- 
Regards,

Laurent Pinchart
