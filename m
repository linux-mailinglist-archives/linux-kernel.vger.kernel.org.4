Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B66C86FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjCXUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjCXUoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:44:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2015B88
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:43:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D83D5A58;
        Fri, 24 Mar 2023 21:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679690637;
        bh=DPS8aitjZuB3YdWtqamZnZNEefbvtVegFZpEpNFCGXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew23VkUl8ZFTEcq96y3KGxB75HxLGiGVEvGTUINqBuYp2HyplL5AoKIVfrDqdjiaL
         iQo/2CX6ta6HYuoTZR3VyDrT3YTJH6ts4Va35mGX1XeZCishpK1lwqyNQ3ao0bRZkb
         zaenu0RDO6Z/1ZTVmphFzdcQsnQ2W0xvYu8QgsCY=
Date:   Fri, 24 Mar 2023 22:44:02 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: mention SGMII as supported
 protocol
Message-ID: <20230324204402.GD23868@pendragon.ideasonboard.com>
References: <1679660679-10409-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1679660679-10409-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Radhey,

Thank you for the patch.

On Fri, Mar 24, 2023 at 05:54:39PM +0530, Radhey Shyam Pandey wrote:
> SGMII is validated on kria KR260 robotics starter kit. So modify the
> comment description to include it in supported controllers list.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 9be9535ad7ab..ebe5ba730234 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -8,9 +8,9 @@
>   * Author: Subbaraya Sundeep <sundeep.lkml@gmail.com>
>   * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>   *
> - * This driver is tested for USB, SATA and Display Port currently.
> - * Other controllers PCIe and SGMII should also work but that is
> - * experimental as of now.
> + * This driver is tested for USB, SGMII, SATA and Display Port currently.
> + * Other controller i.e PCIe should also work but that is experimental

As only PCIe is left, I'd write

 * PCIe should also work but that is experimental as of now.

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Of course it would be even better if you could test PCIe ;-)

> + * as of now.
>   */
>  
>  #include <linux/clk.h>

-- 
Regards,

Laurent Pinchart
