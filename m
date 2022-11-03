Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7806183F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKCQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiKCQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:17:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FCE18363;
        Thu,  3 Nov 2022 09:17:31 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66FEB6602962;
        Thu,  3 Nov 2022 16:17:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667492249;
        bh=UF8gcf9Zdsra79jQbu7uASjF23J3RPW5N777RLTHhuY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BuefWQlJf8M4p09e0/uP4GwZBjBH8QwGMfRznG/AwyOlcJj/RN64+2lpdnSV4cTNK
         n+huZqFNDDR3di5xNQ/VMT5NhuiG0V9Xq/50r3FVSBLnY/VAeg4HPpl7iryOOPFazz
         xAnb4V7qFNpJVHZbEDNFS3VSkWY7jWTXdyl3tAv29BtVo17G0BMwKR9/mKBxAGtK1B
         UXEf5yEGt8vDymhc5wEnFfMFhj2wmOPe1NFdWOejaPwclO+ASdD+i+K4HNwIF0RE4X
         accQfnWvEhuO/Ph1cAufgt6fTa0P1fuXvZ/alaa5/rrH2zX55/ezcLRmhhh6u3qgTi
         WogQ4pHX/hJ4A==
Message-ID: <df2676f0e4dce565d483ce2149b2c54da05b34a5.camel@collabora.com>
Subject: Re: [PATCH v2] vcodec: mediatek: add check for NULL for
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
Date:   Thu, 03 Nov 2022 12:17:17 -0400
In-Reply-To: <20221102121027.4285-1-abelova@astralinux.ru>
References: <20221102121027.4285-1-abelova@astralinux.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 02 novembre 2022 =C3=A0 15:10 +0300, Anastasia Belova a =C3=A9c=
rit=C2=A0:
> Any time calling vp9_is_sf_ref_fb we need fb !=3D NULL after checks.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video De=
coder Driver")

As Angelo said, this change is a no-op in practice, for this reason I would
suggest to drop the `Fixes` tag (not worth the effort of back-porting this)=
.

>=20
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> index 70b8383f7c8e..776468cd834a 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c
> @@ -208,6 +208,9 @@ static bool vp9_is_sf_ref_fb(struct vdec_vp9_inst *in=
st, struct vdec_fb *fb)
>  	int i;
>  	struct vdec_vp9_vsi *vsi =3D inst->vsi;
> =20
> +	if (!fb)
> +		return true;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(vsi->sf_ref_fb); i++) {
>  		if (fb =3D=3D &vsi->sf_ref_fb[i].fb)
>  			return true;

