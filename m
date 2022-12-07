Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44349645F1E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLGQkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiLGQkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:40:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA45CD09
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1670431233; bh=vHbyI4KninQa8GUacM2PEFRzfxzNLfAd/A2kuP75LOs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ezsSHQWcbR3URE/ostikH9C57NPdlvVk7q57jl46Y97jxgdrqlhLjmRm8qHoqNNLr
         d3UA40ZFvNKk+NA8MEZcOs17gYloE6mX+nWr7YKniqlK9nD4r5f8WrFmcBNY6PtVB/
         0tWookI6hJNLeXS0rRfizRaId0+OuQ5UOTcNHohqBzGLEvOcAmLQ0S5VG7PBwNBzLh
         /8wyJynZeTmEgjLT82gnd1nhYBOq7EGN/8dl1vG2gmrvQdAi8HX/4X0vam64IwTtv3
         f5Fpqwlcnz9uEGkk2TEnVTqeH/zRkAsQQDre0R60e7zCN3O8kyepcwLNN0RSE0gP9P
         HHBfcXqf2C3Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([95.223.44.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4zAy-1ov5lt0Iho-010rgE; Wed, 07
 Dec 2022 17:40:33 +0100
Date:   Wed, 7 Dec 2022 17:40:29 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5DB/aUpFrS68DMd@probook>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O+tGawdhdu6+c3kL"
Content-Disposition: inline
In-Reply-To: <Y5CxBzy47Gjn/V5a@lunn.ch>
X-Provags-ID: V03:K1:V11AYrdqEj4rb7KhTFXacb2WROqGOGmd9a3u6s/zvSCOlwpxjWD
 4h0UBKSdcKVeL64D2XKr/MVJsGkUCggLNO8bPlGKvo0P2AkrMX1PPdcRB9ACT07KJban97p
 uohE/eSu6bHR4ORYPVKJrHiQoazhHjn5vXByR84/lbTyMmUQjFH+ZZldjC61hS8XwG09LrI
 Ip72V4/ZMbNyJKc4Nx4UQ==
UI-OutboundReport: notjunk:1;M01:P0:z2dBSeZxrsM=;gv55Z+ag1tD3Y/zdVE3OINcPK13
 KVHUMKgmS0+DW49tHvpzwz1auArARUXoNoll7JZ1s2MOv0d7qGAn9NPAVY8yKHnRgmbWdSqNF
 T0tYT8BsoEF6fH/LcjcVGIeAiJCOV0XUWQP2SZKGs2uj7u+ZklX56ZsLyj7F2g8QLTgDOJjNh
 lypyufaeZMI4voj9+ERpUkgs73OdtihcvY2YXYSvmStDVuoho5PMCRW14pzs1A3PR8vSI/zXz
 79c3siuOEWU1SOfXdBM9zGrwGp+U9NlUajETOUABVcSLHti70ZXzlbLs+oUNOtV2aYwvq0YYM
 SaCfCkM3/Sr65GIHMtceGQ6VGuwF/dO0MR0IXwy0fHDruD6MhzG8UPpeiGTbukwFpb8xfwCbw
 KwXdYmCzUwj0+6t7TMw0NgWjZ6t5tYjVuyRHTXhvhsGqzmoY8kOxJGxI5nX61XTAlsk2F3pjy
 Hr4BAmjtFnCCzoUlhdRYUXojiw6S/A2nvdZCIL8BBvGc/+y5UJjnMsiQrJhuw/zTuFD+R2uVk
 YFPJQQX0BVqPNcGu5F2mI5fMs24dVUMYmsrJvUqVk9zoWmMrEMenpgnQJEz06CSvSGB0q6oHg
 Gd+PILWSVuKEHw/66cGFEJnNu5BIbRxlhlB+SZ5kaR3p2+gM5nV66celVRmGqyl6XuYmEoUik
 wDTmlLgES9aKGrUplzhhgjheeeC+GprS5oYPA5wMgePgEOJuMCsuTDK10zKuqHklgRimiOGcr
 TTEkgsWOMm+Uc9qrcnzX5w4x85kYDfOvalxlJvFzbKxYUyRHdueahkRiSQUPxlUWozco3qC7B
 1JgDF/CQjjDTGeuP3pbmC7+M83i6jH2sVdhWOkUcEOv3H/2M/EqCAfQ/thhcmCAhY5pidZ+0N
 PvsRsb4uUkQnr1ePp5H2FNGs57iE7k5mDjaU6EbB2KTfdki8nSVPe0+wQExO8Wme9qQTdRHJN
 ZthDInCLo11XJ9z2RUp45f1DalY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O+tGawdhdu6+c3kL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 04:28:07PM +0100, Andrew Lunn wrote:
> On Wed, Dec 07, 2022 at 12:25:53PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > Hello,
> >=20
> > I am currently trying to bring up Linux 6.1-rcX on a PXA255 board, usin=
g a
> > devicetree. One problem I encountered is that the PXA GPIO driver fails=
 to
> > probe because it uses the same MMIO register range as the pinctrl drive=
r:
> >=20
> > [    0.666169] pxa25x-pinctrl 40e00054.pinctrl: initialized pxa2xx pinc=
trl driver
> > [    0.694407] pxa-gpio 40e00000.gpio: can't request region for resourc=
e [mem 0x40e00000-0x40e0ffff]
> > [    0.695050] pxa-gpio: probe of 40e00000.gpio failed with error -16
> >=20
> > Before I try to fix this myself: Is GPIO on PXA25x currently expected to
> > work and when has it last been seen working?
> >=20
> > What would be a good way to fix this?
>=20
> How are the registers arranged? Is 0x40e00000-0x40e0ffff simply too
> large, and making it smaller would fix the issue? Or are the registers
> interleaved? It is possible to request a region in a non-exclusive
> manor. Or is it more than interleaving, individual registers need to
> be shared between the two drivers? If so, you have the locking issues
> you mentioned.
>=20
>     Andrew

(I wrote this before I saw the other reply, so there are probably
 duplicate information)

They overlap. pxa25x.dtsi declares:

	pinctrl: pinctrl@40e00000 {
		reg =3D <0x40e00054 0x20>,  // base_af[0]
		      <0x40e0000c 0xc>,   // base_dir[0]
		      <0x40e0010c 4>,     // base_dir[3]
		      <0x40f00020 0x10>;  // base_sleep[0]
		compatible =3D "marvell,pxa25x-pinctrl";
	};

(comments mine, based on pinctrl-pxxa25x.c)


The GPIO driver mentions these registers (for PXA25x):

	          GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
	BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
	BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
	BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050

So, there are overlaps in GPDR (0x0c-0x14, GPIO pin direction register).

The register at 0x10c seems bogus for PXA25x: gpio-pxa.c mentions it as
part of bank 3, which only exists in PXA27x or later.


Jonathan

--O+tGawdhdu6+c3kL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmOQwc4ACgkQCDBEmo7z
X9u11hAAtyDGP3CwoepPK3iQ5rD1e1Mqiy+Qntdz8sgUKGVNzCqspco4Pn9GFs7C
MrLTd/IGIgwWNFVs2mexqQZuVRz8drUSjfns2SLgQl5XoJow/imTuMWdgEjSDcSV
vBsfc9JEZLe1TASxkKpI9xY0my2CHby8/Eko2vg5BYRb4Fn8UAPX52ECSYS42IG8
7jVn3cv+btT6HcyCA1kI3et/OjojGSUG4u8qFjZsNevLpD5ypb+pabU6Y8W1B0hJ
lN37pykzO4RLwM6/hIsRH+gkEhDdZS1ZXFi+PwusGsBr7cqqgBclLi0brabBkEP4
TU6W9Uns2AEJ8lAWoK8r1iT6f4XcaG/S88tCXpJXzZ5ZHONtbGB2ZtJq/sAqiPr3
V3rMIC2B7RExpmrhxX0hny1OnKHDQqw6zt1X0pCWjJzLR2tehK0V2CYTNkkjgLQy
DmCBwilGiIQ4Rbb+QvP0innL5XyOXP29BZosJrmrAiTGLkhTOcOg95zthEnAuBef
s9EPwiCMOMo3cHwFp2oQaKEeFHR4aZYEiy3yG3FZo/tAjvncG0u3GniXC2wMELBt
N9dF0qrbLYR4XEUSir6QUbMOi83LKXXI1xmj7Medh/M1TPJjOInRcs/RIvv7jTzq
qHpjP8tB8OgPCLhG4HlLWNj6NE1UF0jUqnf5LrH6fyCv0OGN1bE=
=1vx/
-----END PGP SIGNATURE-----

--O+tGawdhdu6+c3kL--
