Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AED6EC350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 02:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDXArz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 20:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDXArx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 20:47:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121F8ED;
        Sun, 23 Apr 2023 17:47:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 88E81A1A;
        Mon, 24 Apr 2023 02:47:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1682297261;
        bh=UvHK5ejvNaBh175IM/hCv2Wm14Z61EZyBdKY9d92WCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEn8QMGi7MqG5cV3/x8be4Q5/XvgX9EBj9nLWjXEGA5LNONwZYKx9EutkCAQn3yE7
         x0QFheXfJ8hho5htKKF0RQ7Aw+imxtQNujLCFIoNQunmrSArVJIN404hwizFjbLUBx
         sHoofb3lCO0jxu7fOFxnzeMkei+fzaY7L0mnFBnE=
Date:   Mon, 24 Apr 2023 03:48:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable video capture drivers on
 imx8mm/imx8mn
Message-ID: <20230424004802.GM21943@pendragon.ideasonboard.com>
References: <20230423212656.1381002-1-aford173@gmail.com>
 <20230423212656.1381002-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230423212656.1381002-2-aford173@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thank you for the patch.

On Sun, Apr 23, 2023 at 04:26:56PM -0500, Adam Ford wrote:
> The imx8m Mini and imx8m Nano both use the same CSIS driver for
> interfacing with sensors and cameras.  The Mini routes the CSIS
> output to the imx7-CSI driver, and the Nano routes the CSIS
> through the imx8-isi driver like the one used on the imx8mp.
> 
> Enable the drivers necessary to facilitate capture on both of
> these two platforms.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a24609e14d50..7005640fbb8e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -743,6 +743,10 @@ CONFIG_SDR_PLATFORM_DRIVERS=y
>  CONFIG_V4L_MEM2MEM_DRIVERS=y
>  CONFIG_VIDEO_MEDIATEK_JPEG=m
>  CONFIG_VIDEO_MEDIATEK_VCODEC=m
> +CONFIG_VIDEO_IMX7_CSI=m
> +CONFIG_VIDEO_IMX_MIPI_CSIS=m
> +CONFIG_VIDEO_IMX8_ISI=m
> +CONFIG_VIDEO_IMX8_ISI_M2M=y
>  CONFIG_VIDEO_QCOM_CAMSS=m
>  CONFIG_VIDEO_QCOM_VENUS=m
>  CONFIG_VIDEO_RCAR_ISP=m

-- 
Regards,

Laurent Pinchart
