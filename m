Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E526E38A1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDPNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:25:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E377919A6;
        Sun, 16 Apr 2023 06:25:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4DAEF10A;
        Sun, 16 Apr 2023 15:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681651516;
        bh=K1YyYPxqlo8x0z8CFYuKhkS6h5XnbugyXRD+m3v6t+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYEa6rBvV07FbhTKRy/yVdc+naA/KunzZ6mX4AppiJWXdNntc79/o/GnhdOGqUclj
         fRx7IrQDMxoOL6R8n5tD17FPAqCmj4jBJ9vAw/NvFmDmyPnZFwVp8b5SQ0hquODq2G
         32u742q+tNl/je0x1epHRxYwt1Yrbnk0zxGT2NA8=
Date:   Sun, 16 Apr 2023 16:25:31 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org, jonas@kwiboo.se, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: h3: beelink-x2: Disable DW-HDMI CEC
Message-ID: <20230416132531.GA28551@pendragon.ideasonboard.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
 <20230415104613.61224-4-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230415104613.61224-4-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch.

On Sat, Apr 15, 2023 at 12:46:13PM +0200, Jernej Skrabec wrote:
> Beelink X2 uses software implementation of CEC even though DW-HDMI has
> working hardware implementation.

Why ? The reason should be explained in the commit message.

> Disable unused DW-HDMI CEC.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> index a6d38ecee141..38f40d69e5c5 100644
> --- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> @@ -150,6 +150,7 @@ &emac {
>  };
>  
>  &hdmi {
> +	snps,disable-cec;
>  	status = "okay";
>  };
>  

-- 
Regards,

Laurent Pinchart
