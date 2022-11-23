Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14890636FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKXBej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKXBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:34:37 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1837C44B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:34:36 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221124013431epoutp03e1428bbfed1057a8ef3abfcb775fbbe7~qYV68wrxK1010210102epoutp03Q
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:34:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221124013431epoutp03e1428bbfed1057a8ef3abfcb775fbbe7~qYV68wrxK1010210102epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669253671;
        bh=hzh0uXlGNgxC1Ur5J8oL7NUjS+Fu0EqYvS8Mub/tDM4=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MY8Ri5Xwkw9uwWuD3sBo2U64ztIIF+mUVLlWUdO/nwuy6Kmu4Pm+L7pZdQhDjv7mv
         ZVoEl7h6sDRa5Qqviow1i7lyu84tDbPvuVnlBy6S4YtfHq2hx7nYImSaPER6wz//VH
         E4Y7lEFudVPLxOj6KxNJtudyIJ382cJONl9LEFOM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221124013430epcas5p3eea376bfb07ad7a14484e4bee67f678b~qYV503M6J0714807148epcas5p3v;
        Thu, 24 Nov 2022 01:34:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NHgX449gQz4x9Q6; Thu, 24 Nov
        2022 01:34:28 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.C9.56352.42ACE736; Thu, 24 Nov 2022 10:34:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221123134023epcas5p4d4c20dedcf9caf2f40c00a38a7431a6b~qOmZ0btE02965429654epcas5p4Q;
        Wed, 23 Nov 2022 13:40:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123134023epsmtrp1113807c6483f3efbcdb560a6c5b4f799~qOmZzuq882658726587epsmtrp1X;
        Wed, 23 Nov 2022 13:40:23 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-c0-637eca24ab76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.F8.18644.7C22E736; Wed, 23 Nov 2022 22:40:23 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123134022epsmtip2503ea0ce93746ddf3e6bd2d713f8feb1~qOmYf9eL20547605476epsmtip2j;
        Wed, 23 Nov 2022 13:40:22 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <ravi.patel@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>
In-Reply-To: <03a26971-e54b-a8e7-c02f-ae5a8feba71a@linaro.org>
Subject: RE: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Date:   Wed, 23 Nov 2022 19:10:21 +0530
Message-ID: <001601d8ff41$231deaf0$6959c0d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGtZdCQDJwhTh87CLfF3yzsQrDlqwDaao/AAgr8Mq4BlHJjcwI2urOOA12SKrWuU0JOYA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmlq7Kqbpkg6W3pSwezNvGZjH/yDlW
        i74XD5kt9r7eym6xo20hi8XlXXPYLBZt/cJu8fDDHnaL1r1H2B04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM64crqTpWCZcsWsjs1MDYzbFboYOTkkBEwkri78ytjFyMUhJLCbUeJQ/1MWCOcT
        o8SuqWeYIZzPjBK/O3+zwrR8fjedDSKxi1Gi7WQzVMtzRomFy1YygVSxCehLvF4xH6xKROAf
        o8SxRSeBHA4OZgEliaun5EBqOAXsJP7MfMYMYgsLOEhsWnoFbAOLgKrEy4U7wOK8ApYSTY8W
        MkHYghInZz5hAbGZBbQlli18zQxxkYLEz6fLwHpFBMIk5h86BVUjLnH0Zw/YCxICMzkkpm7c
        xA7R4CJxYcosqHeEJV4d3wIVl5J42d8GZadLbD6yGaomR6KjqRlqmb3EgStzWCB+0ZRYv0sf
        IiwrMfXUOiaIvXwSvb+fMEHEeSV2zIOx1SQWP+qEsmUk1j76xDqBUWkWktdmIXltFpIXZiFs
        W8DIsopRMrWgODc9tdi0wDgvtRwe48n5uZsYwWlVy3sH46MHH/QOMTJxMB5ilOBgVhLhrfes
        SRbiTUmsrEotyo8vKs1JLT7EaAoM74nMUqLJ+cDEnlcSb2hiaWBiZmZmYmlsZqgkzrt4hlay
        kEB6YklqdmpqQWoRTB8TB6dUA9Mxu+iaGXP+uVjsEty+kv3JvZiuVJ8vr1YwVLhc0PKM/blR
        J+xifco85teZbyJ+zI9Zs45bZbPY54yzBoFem5cLZlqzy+7d3+U0v4s5yXEe267XSpzfct10
        Yqauv7gpTrjTcVKIaKHsSj/briWffDlFunN5g2R+pdRduui1V1jVcs7HgxzTwp/sCptvniye
        emxDZcGkOuP752VuBzq4Vj/ZX8st5Cf9yCi1qmVPc9DO/GtbXc+5uVzwbJn1comztCVT2mM5
        l27OkqrgRQbblq341VVfXb1LuEv+WFi/9sZ1nRX7ywM7rFKjpr4yq1lY8+HDyb4f57bPzWJu
        rf6dqNa/bZHHa67gJPt/31xVlFiKMxINtZiLihMBdAs1nzQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXve4Ul2ywbdnchYP5m1js5h/5Byr
        Rd+Lh8wWe19vZbfY0baQxeLyrjlsFou2fmG3ePhhD7tF694j7A6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKK4bFJSczLLUov07RK4Mjp725gLDspULFw4h72BcYF4FyMnh4SAicTnd9PZQGwh
        gR2MEi/msEHEZSROPljCDGELS6z895y9i5ELqOYpo8Si6fOZQBJsAvoSr1fMZwNJiAi0MUms
        nbcVKMHBwSygJHH1lBxEw2UmiY2XTrOCNHAK2En8mfkMbKqwgIPEpqVXwOIsAqoSLxfuAIvz
        ClhKND1ayARhC0qcnPmEBcRmFtCWeHrzKZy9bOFrqOsUJH4+XQY2R0QgTGL+oVNQNeISR3/2
        ME9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwZGl
        pbWDcc+qD3qHGJk4GA8xSnAwK4nw1nvWJAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5I
        ID2xJDU7NbUgtQgmy8TBKdXAJJFn977uuMGTS4v9nXZ9/33fZaaMmbXtHL5PNm5uL6zaztjx
        CxS4TWLs77jedbg/aZ1PlH++5jbfe8139nl4rPm7aV3Rr3l2z9/drRHZc2L2utUPzxd7PUt4
        LiWeH2iazn11lufNy/ObipZdmF3F17a5NG+mqsoF82PnOA+t2TljdcjT7XZm2mzr9NdMyfkZ
        6Z7EupTp6evctdNy15k857+kepkx1dZwqcjSggKvWQncFzrm1seXRevHsuvJT+J18lK0Ljss
        uUfkQI1csN7p6VtsbFM4f7ktfjHhn/jUJ6or/evdrzqcc1QqdlrvO+vjxL1X4x9N16/PPHh5
        8lfevEQOcaGry5SvxkV1hrVVKrEUZyQaajEXFScCAK88pwgbAwAA
X-CMS-MailID: 20221123134023epcas5p4d4c20dedcf9caf2f40c00a38a7431a6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
        <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
        <20221121091118.48628-3-sriranjani.p@samsung.com>
        <a98ac5d7-0c0e-110e-5405-83a09c77ceac@linaro.org>
        <000001d8ff32$c8b78e30$5a26aa90$@samsung.com>
        <03a26971-e54b-a8e7-c02f-ae5a8feba71a@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 23 November 2022 18:43
> To: Sriranjani P <sriranjani.p=40samsung.com>; robh+dt=40kernel.org;
> krzysztof.kozlowski+dt=40linaro.org; lee=40kernel.org;
> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com
> Cc: linux-kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 2/2=5D arm64: dts: fsd: add sysreg device node
>=20
> On 23/11/2022 12:57, Sriranjani P wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=
=5D
> >> Sent: 21 November 2022 17:58
> >> To: Sriranjani P <sriranjani.p=40samsung.com>; robh+dt=40kernel.org;
> >> krzysztof.kozlowski+dt=40linaro.org; lee=40kernel.org;
> >> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> >> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com
> >> Cc: linux-kernel=40vger.kernel.org
> >> Subject: Re: =5BPATCH 2/2=5D arm64: dts: fsd: add sysreg device node
> >>
> >> On 21/11/2022 10:11, Sriranjani P wrote:
> >>> Add SYSREG controller device node, which is available in PERIC,
> >>> FSYS0 and
> >>> FSYS1 block of FSD SoC.
> >>>
> >>> Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> >>> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>> Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
> >>> ---
> >>>  arch/arm64/boot/dts/tesla/fsd.dtsi =7C 15 +++++++++++++++
> >>>  1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >>> b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >>> index f35bc5a288c2..db78816ba0bf 100644
> >>> --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> >>> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> >>> =40=40 -518,6 +518,21 =40=40
> >>>  				=22dout_cmu_fsys1_shared0div4=22;
> >>>  		=7D;
> >>>
> >>> +		sysreg_peric: syscon=4014030000 =7B
> >>
> >> Node name system-controller
> > =5BSriranjani P=5D Will fix it in the next version. We added =E2=80=9Cs=
yscon=E2=80=9D=20since=20I=0D=0A>=20referred=20other=20dtsi=20files=20in=20=
mainline=20for=20example=20exynosautov9.dtsi=20used=0D=0A>=20syscon=20as=20=
node=20name.=20If=20this=20is=20the=20name=20we=20should=20add=20then=20I=
=E2=80=99ll=20post=20few=0D=0A>=20more=20patches=20fixing=20this=20node=20n=
ame=20in=20other=20Exynos=20dtsi=20files.=0D=0A>=20=0D=0A>=20Use=20proper=
=20wrapping=20for=20mailing=20lists.=20It's=20difficult=20to=20read=20your=
=20emails.=0D=0A=0D=0ASorry=20for=20the=20confusion.=20I=20have=20fixed=20m=
y=20email=20client=20now.=0D=0A=0D=0A>=20=0D=0A>=20>>=20and=20either=20put=
=20it=20next=20to=20existing=20one=20or=20next=20to=20functional=20block=0D=
=0A>=20>>=20(peric=0D=0A>=20>>=20clocks?)=20ordered=20by=20unit=20address.=
=0D=0A>=20>=20=5BSriranjani=20P=5D=20We=20thought=20of=20it=20but=20as=20I=
=20saw=20current=20fsd.dtsi=20file=20and=20other=0D=0A>=20exynos=20file=20l=
ike=20exynosautov9.dtsi,=20in=20that=20nodes=20are=20not=20properly=20arran=
ged=20as=0D=0A>=20per=20unit=20address.=0D=0A>=20=0D=0A>=20I=20know,=20that=
's=20why=20I=20proposed=20to=20order=20by=20unit=20address=20within=20other=
=20syscons=0D=0A>=20or=20other=20functional=20blocks=20(e.g.=20peric-relate=
d).=0D=0A=0D=0AGot=20it.=20I'll=20move=20the=20sysreg=20nodes=20near=20to=
=20their=20functional=20blocks=20and=20order=20them=20by=20unit=20address.=
=0D=0A=0D=0A>=20=0D=0A>=20>=0D=0A>=20>=20So=20I=20can=20think=20of=20follow=
ing=20two=20approaches:=0D=0A>=20>=201:=20For=20the=20time=20being=20I=20wi=
ll=20put=20this=20sysreg=20node=20in=20between=0D=0A>=20>=20clock_peric=20n=
ode=20and=20clock_fysys0=20node=20and=20clock_fsys1=20node=20as=20per=0D=0A=
>=20>=20increasing=20unit=20address.=20I=20will=20clean=20up=20other=20exyn=
os=20and=20FSD=20DTSI=0D=0A>=20>=20files=20and=20post=20a=20new=20patch=0D=
=0A>=20=0D=0A>=20Not=20sure=20what=20cleaning=20you=20have=20in=20mind.=0D=
=0A>=20=0D=0A>=20>=202:=20First=20I=20will=20clean=20up=20exynos=20and=20FS=
D=20DTSI=20files=20and=20then=20post=20this=20sysreg=0D=0A>=20patch=20keepi=
ng=20it=20at=20appropriate=20place.=0D=0A>=20=0D=0A>=20What=20cleaning?=0D=
=0A=0D=0ABy=20cleaning=20I=20meant=20fixing=20these=20dtsi=20files=20to=20h=
ave=20the=20device=20nodes=20in=20the=20order=20of=20ascending=20unit=20add=
ress.=0D=0A=0D=0A>=20=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=
=0AThank=20you.=0D=0A=0D=0A=0D=0A
