Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31337258CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbjFGIzt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Jun 2023 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbjFGIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:55:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C32119
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:54:28 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1q6ovb-0007f2-IU; Wed, 07 Jun 2023 10:54:03 +0200
Message-ID: <e0eeae3b35e8efac7c577ca3159abcf7f43d5082.camel@pengutronix.de>
Subject: Re: [PATCH 3/9] drm/verisilicon: Add basic drm driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@edgeble.ai>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Shawn Guo <shawnguo@kernel.org>, christian.koenig@amd.com
Date:   Wed, 07 Jun 2023 10:53:57 +0200
In-Reply-To: <20230602074043.33872-4-keith.zhao@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
         <20230602074043.33872-4-keith.zhao@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

Am Freitag, dem 02.06.2023 um 15:40 +0800 schrieb Keith Zhao:
> Add a basic platform driver of the DRM driver for JH7110 SoC.
> 
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  MAINTAINERS                          |   2 +
>  drivers/gpu/drm/Kconfig              |   2 +
>  drivers/gpu/drm/Makefile             |   1 +
>  drivers/gpu/drm/verisilicon/Kconfig  |  13 ++
>  drivers/gpu/drm/verisilicon/Makefile |   6 +
>  drivers/gpu/drm/verisilicon/vs_drv.c | 284 +++++++++++++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_drv.h |  48 +++++
>  include/uapi/drm/drm_fourcc.h        |  83 ++++++++
>  include/uapi/drm/vs_drm.h            |  50 +++++
>  9 files changed, 489 insertions(+)
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
>  create mode 100644 include/uapi/drm/vs_drm.h
> 
> 
> [...]
> +#endif /* __VS_DRV_H__ */
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index de703c6be969..af4fb50f9207 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -419,6 +419,7 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
>  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
>  #define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> +#define DRM_FORMAT_MOD_VENDOR_VS      0x0b
>  
>  /* add more to the end as needed */
>  
> @@ -1519,6 +1520,88 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
>  #define AMD_FMT_MOD_CLEAR(field) \
>  	(~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
>  
> +#define DRM_FORMAT_MOD_VS_TYPE_NORMAL        0x00
> +#define DRM_FORMAT_MOD_VS_TYPE_COMPRESSED    0x01
> +#define DRM_FORMAT_MOD_VS_TYPE_CUSTOM_10BIT  0x02
> +#define DRM_FORMAT_MOD_VS_TYPE_MASK     ((__u64)0x3 << 54)
> +
> +#define fourcc_mod_vs_code(type, val) \
> +	fourcc_mod_code(VS, ((((__u64)type) << 54) | (val)))
> +
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_MODE_MASK    0x3F
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_8X8_XMAJOR   0x00
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_8X8_YMAJOR   0x01
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_16X4     0x02
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_8X4      0x03
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_4X8      0x04
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_16X4   0x06
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_64X4     0x07
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_32X4     0x08
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_256X1  0x09
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_128X1  0x0A
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_64X4   0x0B
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_256X2  0x0C
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_128X2  0x0D
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_128X4  0x0E
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_64X1   0x0F
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_16X8     0x10
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_8X16     0x11
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_512X1  0x12
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_32X4   0x13
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_64X2   0x14
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_32X2   0x15
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_32X1   0x16
> +#define DRM_FORMAT_MOD_VS_DEC_RASTER_16X1   0x17
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_128X4    0x18
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_256X4    0x19
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_512X4    0x1A
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_16X16    0x1B
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_32X16    0x1C
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_64X16    0x1D
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_128X8    0x1E
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_8X4_S    0x1F
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_16X4_S   0x20
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_32X4_S   0x21
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_16X4_LSB 0x22
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_32X4_LSB 0x23
> +#define DRM_FORMAT_MOD_VS_DEC_TILE_32X8     0x24
> +
> +#define DRM_FORMAT_MOD_VS_DEC_ALIGN_32      (0x01 << 6)
> +#define DRM_FORMAT_MOD_VS_DEC_ALIGN_64      (0x01 << 7)
> +
> +#define fourcc_mod_vs_dec_code(tile, align) \
> +	fourcc_mod_vs_code(DRM_FORMAT_MOD_VS_TYPE_COMPRESSED, \
> +				((tile) | (align)))
> +
> +#define DRM_FORMAT_MOD_VS_NORM_MODE_MASK        0x1F
> +#define DRM_FORMAT_MOD_VS_LINEAR                0x00
> +#define DRM_FORMAT_MOD_VS_TILED4x4              0x01
> +#define DRM_FORMAT_MOD_VS_SUPER_TILED_XMAJOR    0x02
> +#define DRM_FORMAT_MOD_VS_SUPER_TILED_YMAJOR    0x03
> +#define DRM_FORMAT_MOD_VS_TILE_8X8              0x04
> +#define DRM_FORMAT_MOD_VS_TILE_MODE1            0x05
> +#define DRM_FORMAT_MOD_VS_TILE_MODE2            0x06
> +#define DRM_FORMAT_MOD_VS_TILE_8X4              0x07
> +#define DRM_FORMAT_MOD_VS_TILE_MODE4            0x08
> +#define DRM_FORMAT_MOD_VS_TILE_MODE5            0x09
> +#define DRM_FORMAT_MOD_VS_TILE_MODE6            0x0A
> +#define DRM_FORMAT_MOD_VS_SUPER_TILED_XMAJOR_8X4    0x0B
> +#define DRM_FORMAT_MOD_VS_SUPER_TILED_YMAJOR_4X8    0x0C
> +#define DRM_FORMAT_MOD_VS_TILE_Y                0x0D
> +#define DRM_FORMAT_MOD_VS_TILE_128X1            0x0F
> +#define DRM_FORMAT_MOD_VS_TILE_256X1            0x10
> +#define DRM_FORMAT_MOD_VS_TILE_32X1             0x11
> +#define DRM_FORMAT_MOD_VS_TILE_64X1             0x12
> +#define DRM_FORMAT_MOD_VS_TILE_MODE4X4          0x15
> +
> +#define fourcc_mod_vs_norm_code(tile) \
> +	fourcc_mod_vs_code(DRM_FORMAT_MOD_VS_TYPE_NORMAL, \
> +				(tile))
> +
> +#define fourcc_mod_vs_custom_code(tile) \
> +	fourcc_mod_vs_code(DRM_FORMAT_MOD_VS_TYPE_CUSTOM_10BIT, \
> +				(tile))
> +

You are opening a new namespace for what is effectively the VIVANTE
tiling. While your list seems much more exhaustive than the (reverse
engineered) list provided under the VIVANTE namespace, this is still
unacceptable as it adds new aliases for existing modifiers.

Also any modifier additions should be in a separate patch and not
buried in another change.

Regards,
Lucas
