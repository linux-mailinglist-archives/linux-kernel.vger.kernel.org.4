Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C95FADC4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJKHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJKHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:50:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9E36DDB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:50:13 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221011075010epoutp04036ec42d9957f1bcb17f16022dabfbc2~c9FWCJcFT2302223022epoutp043
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:50:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221011075010epoutp04036ec42d9957f1bcb17f16022dabfbc2~c9FWCJcFT2302223022epoutp043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665474610;
        bh=KrjaEB67KPSXvfBN++C5b4N285bkJVilgQAZpyyUIlY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=A3u2ZW0bCjGOD6xCecr0NJs+2jdc0D3DCdqumrmG82R7uGqsD3PMeB0cU5OMrrR1r
         GC9JSdoJMpqwWzTLrZYdehc8hxQZ834dPK+MC/gbd99S3U7OzYqnlJ+QlgwmXIn252
         EOSgWMzxn5h4SMC/tPbqi/sA170Zq28TTT+DPayE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221011075009epcas5p311dcdafb5ef96eb9738d957239e02fad~c9FVhbDTg0852408524epcas5p3l;
        Tue, 11 Oct 2022 07:50:09 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Mmnxq00wVz4x9QF; Tue, 11 Oct
        2022 07:50:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.47.39477.E2025436; Tue, 11 Oct 2022 16:50:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221011045302epcas5p2fcf0e6c52adbbff712ff9befc58434e3~c6qsUooqf0952609526epcas5p2F;
        Tue, 11 Oct 2022 04:53:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011045302epsmtrp2531c1c45b84ed6d0a40b5563f84d29bb~c6qsTvVLt2783927839epsmtrp25;
        Tue, 11 Oct 2022 04:53:02 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-29-6345202ed22d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.2D.14392.EA6F4436; Tue, 11 Oct 2022 13:53:02 +0900 (KST)
Received: from FDSFTE070 (unknown [107.116.189.86]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221011045301epsmtip1c3d53220bd2a0f0db04a03ab360e1534~c6qqzREVq2838728387epsmtip1k;
        Tue, 11 Oct 2022 04:53:00 +0000 (GMT)
From:   "Padmanabhan Rajanbabu" <p.rajanbabu@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <alim.akhtar@samsung.com>, <chanho61.park@samsung.com>,
        <linus.walleij@linaro.org>, <pankaj.dubey@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <ebf9e667-6b08-4a04-2241-04295cc28058@linaro.org>
Subject: RE: [PATCH] arm64: dts: fix drive strength macros as per FSD HW UM
Date:   Tue, 11 Oct 2022 10:22:59 +0530
Message-ID: <000001d8dd2d$57d6a060$0783e120$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJKGaiSsiqhKxku7uYTSPaoJqYSAAESoaKbAd+H3XmtDpGHcA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmlq6egmuywYUtFhYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW+x9vZXdYsqf5UwWl3fNYbOYcX4fk8WirV/YLVr3HmF34PLYtKqTzePOtT1s
        Hn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
        4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
        tcTK0MDAyBSoMCE749/Cp4wFx8QrjjzpZG5gvC7cxcjJISFgInH0/WO2LkYuDiGB3YwSlw4/
        YIVwPjFK3Pp1ggnC+cYosfTRASaYlovv5jFCJPYySiz/fosFJCEk8IJRYua8DBCbTcBcYtHe
        pWBFIgJvGSVWzJ7NCJJgFkiXODl7NjuIzSlgJ7G7ZT8ziC0s4C3Rc/kRK4jNIqAqce/BabB6
        XgFLiSl7F7BD2IISJ2c+YYGYoy2xbOFrZoiLFCR+Pl0G1isi4CRx5+NbJogacYmjP3uYQY6Q
        EJjLIbG3ZzvUCy4Si7+sZoGwhSVeHd/CDmFLSXx+t5cNws6XmPaxGcqukGj7uAGq117iwJU5
        QL0cQAs0Jdbv0ocIy0pMPbUOai+fRO/vJ1DlvBI75sHYqhLrl29ihLClJfZd38s4gVFpFpLX
        ZiF5bRaSF2YhbFvAyLKKUTK1oDg3PbXYtMAoL7UcHuPJ+bmbGMHpVctrB+PDBx/0DjEycTAe
        YpTgYFYS4WWc75QsxJuSWFmVWpQfX1Sak1p8iNEUGN4TmaVEk/OBCT6vJN7QxNLAxMzMzMTS
        2MxQSZx38QytZCGB9MSS1OzU1ILUIpg+Jg5OqQamVVfsGD/YFW5lMhQzjDDmrC+5dY3j6axT
        TA9s6vhuXpFdyLIwNOlqlrCs0PmrdhU5NtbrXrXkJrEu8OeJivLR3zD1+dT2FSfOzN4tXSpQ
        wsrrY/L4k8bXEy9vmE5QjnzxOcV6be7v6Zfuqq6f+HZX04Lcc/+X9r3KuBAV5rD7z6kf645c
        sNHaHZDa+jhs9kYhhqRXsf45TSzpFVnbP03Qj/3oI+Lu/uZJe62wQUPZ0c21t2zVF0Xd5TE9
        2qMszCpv8EpSWvthY5f+Gbnghl9ON9VWukTf84zssa76pXnzjHI365WzAknMii/SHiZnzQ/W
        cJ1hd+zKxoT5rHedS9RKJf6r7eZgC4wqi9FwWK3EUpyRaKjFXFScCADJxSrlOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTnfdN5dkgwv96hYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW+x9vZXdYsqf5UwWl3fNYbOYcX4fk8WirV/YLVr3HmF34PLYtKqTzePOtT1s
        Hn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJVxec9LxoIJ4hXve54xNzDOFe5i5OSQEDCRuPhu
        HmMXIxeHkMBuRon3OzrZIBLSEtP790DZwhIr/z1nhyh6xijR8vM0WIJNwFxi0d6lYN0iAp8Z
        JdbNWAKWYBbIlOg+epQFouMAo8SPW18YQRKcAnYSu1v2M4PYwgLeEj2XH7GC2CwCqhL3HpwG
        q+EVsJSYsncBO4QtKHFy5hMWiKHaEk9vPoWzly18zQxxnoLEz6fLwOaICDhJ3Pn4lgmiRlzi
        6M8e5gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMj
        OMq0NHcwbl/1Qe8QIxMH4yFGCQ5mJRFexvlOyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3Sd
        jBcSSE8sSc1OTS1ILYLJMnFwSjUwiXTLfJy0Y56AumN583yPK1ItHKsbDqW+f6F7/dRGS6XF
        blvmzXiu13xBQ2PtAtXiTWcemahy9xol3u3Ov7HUM1ypwj3URZW/iXFbni1vCWcYD0dvlIfP
        tAfb3Ro4nvRe/3AyvzVK/u5Gg60icYf3se8OrpUO/nxiV7P37I15EUpLw8L//XCcsenivMmy
        NttW1sZdF3a4GP0o50Nd1vHVd95N2Lkrc95e/tveroku4kqfH+tME783Md/4JTd70yvJ/VK9
        t0L1A9S3v1CelX3z9IlPGu6eBRtzboXGsKTmy/sXWmhbLipOtFd88mfpvQfm0ycvY70pvfAU
        e94k3etTT7C9+aW04yj75cAlmoe7lFiKMxINtZiLihMB5aISbSEDAAA=
X-CMS-MailID: 20221011045302epcas5p2fcf0e6c52adbbff712ff9befc58434e3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe
References: <CGME20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe@epcas5p3.samsung.com>
        <20221010120438.80680-1-p.rajanbabu@samsung.com>
        <ebf9e667-6b08-4a04-2241-04295cc28058@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 10 October 2022 06:54 PM
> To: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>;
> robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> alim.akhtar=40samsung.com; chanho61.park=40samsung.com;
> linus.walleij=40linaro.org; pankaj.dubey=40samsung.com
> Cc: devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> samsung-soc=40vger.kernel.org
> Subject: Re: =5BPATCH=5D arm64: dts: fix drive strength macros as per FSD=
 HW UM
>=20
> On 10/10/2022 08:04, Padmanabhan Rajanbabu wrote:
> > In FSD pinctrl implementation, the pinctrl driver is using drive
> > strength MACROs, which are deviating from the actual values specified
> > in FSD HW UM
>=20
> But you are changing DTS, not pinctrl driver. The message is a bit confus=
ing.
Sorry about the commit description. I'll update it to reflect the right con=
text.
>=20
> Add full stop to the sentence.
okay
>=20
> >
> > This patch adds the right pinctrl drive strength values for FSD SoC.
> > This
>=20
> Do not use =22This commit/patch=22.
> https://protect2.fireeye.com/v1/url?k=3D7c0c10dd-239729b8-7c0d9b92-
> 000babff32e3-25043687ce355c88&q=3D1&e=3D110f55cc-c214-4bfd-b74b-
> 928d7f2efcbc&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv5.17.1%2F
> source%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23L95
Okay.
>=20
> > patch also ensures that the peripherals are using right drive strength
> > MACROs in-order to function as expected
>=20
> Full stop
Okay.
>=20
> Which commit introduced it? Add a Fixes tag.
I'll add the fixes tag.
>=20
>=20
> >
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 34 +++++++++++---------=
--
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.h    =7C  6 ++--
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > index d0abb9aa0e9e..e3852c946352 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
> > =40=40 -55,14 +55,14 =40=40
> >  		samsung,pins =3D =22gpf5-0=22;
> >  		samsung,pin-function =3D <FSD_PIN_FUNC_2>;
> >  		samsung,pin-pud =3D <FSD_PIN_PULL_NONE>;
> > -		samsung,pin-drv =3D <FSD_PIN_DRV_LV2>;
> > +		samsung,pin-drv =3D <FSD_PIN_DRV_LV4>;
>=20
> Are you sure? The original commit used here value of =222=22, your change=
 also
> set value of =222=22, so what deviates from actual values?
The intention of the patch is to change the value of MACROs as well as name=
 of the MACROs
according to the FSD HW user manual.
>=20
> You need to describe better the problem.
In the next version, I'll update the problem description in a much better w=
ay.
>=20
> Best regards,
> Krzysztof
Thanks for quick review.

Regards,
Padmanabhan R.

