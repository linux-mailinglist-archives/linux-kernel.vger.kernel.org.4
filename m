Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D55631CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKUJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiKUJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:21:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582242F3A1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:21:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15F9DB80D33
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78860C433D6;
        Mon, 21 Nov 2022 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669022498;
        bh=wMnIkGX/+4CxQcSMr92gcyLZT+n15ZtIVaEimSz4LIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQlTkqlHZsG9b1RY8j0kqin6sAa9sRQEjwGjYROr+CEfGsKEarzDENqptitdxDBZH
         NCY5opgI9IGFIBm1AFhj4KOp5C9gUx33+ADg83lGVKQ6GCeLKOnr1gP6rxjhx5XVYP
         rn1/Z7tGDiHV2YNpziS/PQfRycKh8meZItQ+Hn/TLQozfYZ1ajts17+7ZUbYoQprns
         /OzxeU809dSRU8Vq/iOCjpGDt7uRdimdo00q49OM+nNoOwnZjsSZzd87AHEPRZXQ2C
         Mty0ZJvliiV+SvzdKAuKfjQRZ4k+nGwZl0Q8/OY/bZantRx8E0WoA4ZsX+M2U0KKre
         e27i2vLNunLGg==
Date:   Mon, 21 Nov 2022 10:21:35 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sujuan Chen <sujuan.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-kernel@vger.kernel.org,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] net: ethernet: mtk_wed: add wcid overwritten support for
 wed v1
Message-ID: <Y3tDH13Pf9f6uRc7@lore-desk>
References: <217932f091aa9d9cb5e876a2e958ca25f80f80b2.1668997816.git.sujuan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4eo3k1jS5flplOqN"
Content-Disposition: inline
In-Reply-To: <217932f091aa9d9cb5e876a2e958ca25f80f80b2.1668997816.git.sujuan.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4eo3k1jS5flplOqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> All wed versions should enable wcid overwritten feature,
> since the wcid size is controlled by the wlan driver.
>=20

I guess this patch should be posted to netdev mailing list
(netdev@vger.kernel.org) since it should go through net-next tree.

Regards,
Lorenzo

> Tested-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_wed.c      | 9 ++++++---
>  drivers/net/ethernet/mediatek/mtk_wed_regs.h | 2 ++
>  include/linux/soc/mediatek/mtk_wed.h         | 3 +++
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethern=
et/mediatek/mtk_wed.c
> index 7d8842378c2b..a20093803e04 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -526,9 +526,9 @@ mtk_wed_dma_disable(struct mtk_wed_device *dev)
>  			MTK_WED_WPDMA_RX_D_RX_DRV_EN);
>  		wed_clr(dev, MTK_WED_WDMA_GLO_CFG,
>  			MTK_WED_WDMA_GLO_CFG_TX_DDONE_CHK);
> -
> -		mtk_wed_set_512_support(dev, false);
>  	}
> +
> +	mtk_wed_set_512_support(dev, false);
>  }
> =20
>  static void
> @@ -1290,9 +1290,10 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_=
mask)
>  		if (mtk_wed_rro_cfg(dev))
>  			return;
> =20
> -		mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
>  	}
> =20
> +	mtk_wed_set_512_support(dev, dev->wlan.wcid_512);
> +
>  	mtk_wed_dma_enable(dev);
>  	dev->running =3D true;
>  }
> @@ -1338,6 +1339,8 @@ mtk_wed_attach(struct mtk_wed_device *dev)
>  	dev->irq =3D hw->irq;
>  	dev->wdma_idx =3D hw->index;
>  	dev->version =3D hw->version;
> +	if (hw->version !=3D 1)
> +		dev->rev_id =3D wed_r32(dev, MTK_WED_REV_ID);
> =20
>  	if (hw->eth->dma_dev =3D=3D hw->eth->dev &&
>  	    of_dma_is_coherent(hw->eth->dev->of_node))
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_regs.h b/drivers/net/e=
thernet/mediatek/mtk_wed_regs.h
> index 9e39dace95eb..873d50b9a6e6 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> +++ b/drivers/net/ethernet/mediatek/mtk_wed_regs.h
> @@ -20,6 +20,8 @@ struct mtk_wdma_desc {
>  	__le32 info;
>  } __packed __aligned(4);
> =20
> +#define MTK_WED_REV_ID					0x004
> +
>  #define MTK_WED_RESET					0x008
>  #define MTK_WED_RESET_TX_BM				BIT(0)
>  #define MTK_WED_RESET_TX_FREE_AGENT			BIT(4)
> diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/med=
iatek/mtk_wed.h
> index 8294978f4bca..1b1ef57609f7 100644
> --- a/include/linux/soc/mediatek/mtk_wed.h
> +++ b/include/linux/soc/mediatek/mtk_wed.h
> @@ -85,6 +85,9 @@ struct mtk_wed_device {
>  	int irq;
>  	u8 version;
> =20
> +	/* used by wlan driver */
> +	u32 rev_id;
> +
>  	struct mtk_wed_ring tx_ring[MTK_WED_TX_QUEUES];
>  	struct mtk_wed_ring rx_ring[MTK_WED_RX_QUEUES];
>  	struct mtk_wed_ring txfree_ring;
> --=20
> 2.18.0
>=20

--4eo3k1jS5flplOqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY3tDHwAKCRA6cBh0uS2t
rEzWAP9YAtui+5jejaI/UWop4jE+qY+dgvA440pi888pffHuZAEA9tJ9A7MfLMD5
gxef2frPRzvMlZ8USpaRzIcLD3DAZwI=
=YJnc
-----END PGP SIGNATURE-----

--4eo3k1jS5flplOqN--
