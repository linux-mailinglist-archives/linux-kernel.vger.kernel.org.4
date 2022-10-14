Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21005FE72E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJNC4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNC4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:56:38 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1415CB25;
        Thu, 13 Oct 2022 19:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1665716176; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=B4NBc5U0vzrb2IVhCmCpkKbCP4qH6kmHNgQSDj+NtSA5jy6VPbXqQlkeejCusg+9/wBJgR5EcHRDsUQIz6pxypvy52qRI/6ulmI1R2lmS/J1ZbTfW2ty8iBUBjDXIRJtBm3J05o6IQYIqLeRxKLF810fC8/Zo61/3MdlzEANXIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1665716176; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Xch6Ahc6mpKh0o//bMOoqcUw4dYUZ7qun8hT0y/mZyM=; 
        b=lhkNZN9QvOxPKHYEAuGj43TIiyLsQArkOSH8XbnoRMmkzMai5z1JlRYDeabWrq0jqw7+Zr8J454IiHdmIx20AG9MjcdsP6eYC6493ZgZV6umO8OWa21GIFf6Ckz111JoJVLYt5fyNA/lsPGmVU3EMpDUHqoeX3R/w/EkUmcK4HU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665716176;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Xch6Ahc6mpKh0o//bMOoqcUw4dYUZ7qun8hT0y/mZyM=;
        b=BtjTPZBXxvbVdpOh5ub/SM0ayFIbV8M1wxZx54XiFfx8hRU/8tD6FLJhpUrxjMVN
        jbv1ebptl52p5/ndZF3nTB0YRCeGVfQ+nM+bwk1H+3YZe5aShg4rznGSNsd3dq/9J1y
        0M7HZZQzzgvtjqiwEyW6IkMxed3z6SKH5OPSXxhU=
Received: from edelgard.fodlan.icenowy.me (112.94.102.144 [112.94.102.144]) by mx.zohomail.com
        with SMTPS id 1665716174157848.8917127364606; Thu, 13 Oct 2022 19:56:14 -0700 (PDT)
Message-ID: <fc626a1eacee3ff9e25d4ef71ecb153c1fa836eb.camel@icenowy.me>
Subject: Re: Re: [PATCH v2 04/10] phy: sun4i-usb: add support for the USB
 PHY on F1C100s SoC
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Jernej =?gb2312?Q?=810=947krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org
Date:   Fri, 14 Oct 2022 10:56:08 +0800
In-Reply-To: <3442772.V25eIC5XRa@kista>
References: <20221012055602.1544944-1-uwu@icenowy.me>
         <4218006.ejJDZkT8p0@kista>
         <439b685e3aada19021d94669f6f855f1fc81d08e.camel@icenowy.me>
         <3442772.V25eIC5XRa@kista>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-10-13=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 20:25 +0200=EF=BC=
=8CJernej =C5=A0krabec=E5=86=99=E9=81=93=EF=BC=9A
> Dne =C4=8Detrtek, 13. oktober 2022 ob 10:49:51 CEST je Icenowy Zheng
> napisal(a):
> > =E5=9C=A8 2022-10-12=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 23:21 +0200=EF=
=BC=8CJernej =C5=A0krabec=E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > > Hi Icenowy,
> > >=20
> > > Dne sreda, 12. oktober 2022 ob 07:55:56 CEST je Icenowy Zheng
> > >=20
> > > napisal(a):
> > > > The F1C100s SoC has one USB OTG port connected to a MUSB
> > > > controller.
> > > >=20
> > > > Add support for its USB PHY.
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > > > No changes since v1.
> > > >=20
> > > > =C2=A0drivers/phy/allwinner/phy-sun4i-usb.c | 11 +++++++++++
> > > > =C2=A01 file changed, 11 insertions(+)
> > > >=20
> > > > diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > > b/drivers/phy/allwinner/phy-sun4i-usb.c index
> > > > 3a3831f6059a..2f94cb77637b
> > > > 100644
> > > > --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> > > > +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> > > > @@ -109,6 +109,7 @@ enum sun4i_usb_phy_type {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sun8i_v3s_phy,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sun50i_a64_phy,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sun50i_h6_phy,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suniv_f1c100s_phy,
> > > > =C2=A0};
> > > >=20
> > > > =C2=A0struct sun4i_usb_phy_cfg {
> > > > @@ -859,6 +860,14 @@ static int sun4i_usb_phy_probe(struct
> > > > platform_device
> > > > *pdev) return 0;
> > > > =C2=A0}
> > > >=20
> > > > +static const struct sun4i_usb_phy_cfg suniv_f1c100s_cfg =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_phys =3D 1,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D suniv_f1c100s_phy,
> > >=20
> > > I think you should just use sun4i_a10_phy. It has no special
> > > handling. I don't
> > > see a point adding new phy types if there is no special cases for
> > > it.
> >=20
> > Sounds reasonable, although I think we should finally drop .type
> > and
> > use only describing items.
>=20
> That would be even better. Will you do it?

At least not now.

But I will at least drop suniv_f1c100s_phy in the next revision.

>=20
> >=20
> > > Best regards,
> > > Jernej
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .disc_thresh =3D 3,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .phyctl_offset =3D REG_PHYCTL=
_A10,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .dedicated_clocks =3D true,
> > > > +};
> > > > +
> > > > =C2=A0static const struct sun4i_usb_phy_cfg sun4i_a10_cfg =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_phys =3D 3,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D sun4i_a10_phy,
> > > > @@ -988,6 +997,8 @@ static const struct of_device_id
> > > > sun4i_usb_phy_of_match[] =3D { { .compatible =3D
> > > > "allwinner,sun50i-a64-usb-phy",
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .data =3D &s=
un50i_a64_cfg},
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwi=
nner,sun50i-h6-usb-phy", .data =3D
> > >=20
> > > &sun50i_h6_cfg },
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { .compatible =3D "allwinner,=
suniv-f1c100s-usb-phy",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .data =3D &suniv_=
f1c100s_cfg },
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { },
> > > > =C2=A0};
> > > > =C2=A0MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
> > > > --
> > > > 2.37.1
>=20
>=20

