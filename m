Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1AF635F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbiKWN3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiKWN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:29:23 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59B5BD42
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:08:28 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221123130824epoutp04b436df34368b45f841f55be773c3897c~qOKesW6At2335023350epoutp04R
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 13:08:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221123130824epoutp04b436df34368b45f841f55be773c3897c~qOKesW6At2335023350epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669208904;
        bh=JfJFLl6XBoNYsvURoj0Waez8t4/c3SzpzTyFT3tKuY8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WFpPKaN2RManqkiHxMaWs6SY1hL11Jqi9fn5aakyYViXWVgTsD1DDkuGrmOjWKYYd
         gksGyTHS78KR8fSL3RnBtt7luYgjXSvMs6F20b9k1Q8goVV8eYvplfUKHrNhOeQt7C
         024tnHfFzqg6PQrnvBh4UF+AxhpiAgvaOCRUQYNI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221123130824epcas5p1cf231c493f92e51128c75018b8dacfed~qOKeXNsmd2415124151epcas5p1I;
        Wed, 23 Nov 2022 13:08:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NHLzB5H73z4x9Pr; Wed, 23 Nov
        2022 13:08:22 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.CC.39477.64B1E736; Wed, 23 Nov 2022 22:08:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221123120204epcas5p36f0bd5dc96225c4a809cb5b1b7adfb23~qNQkK5J_S2252022520epcas5p3S;
        Wed, 23 Nov 2022 12:02:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123120204epsmtrp27862646e73c4bb3b8b8545b8c34c1511~qNQkKN5XV1773917739epsmtrp2l;
        Wed, 23 Nov 2022 12:02:04 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-56-637e1b46f74a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.FD.14392.CBB0E736; Wed, 23 Nov 2022 21:02:04 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123120203epsmtip264b92b0af1f66fcd5584f100893e140b~qNQi2b2-n1568015680epsmtip2D;
        Wed, 23 Nov 2022 12:02:03 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     "'Lee Jones'" <lee@kernel.org>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
        <linux-kernel@vger.kernel.org>,
        "'Vivek Yadav'" <vivek.2311@samsung.com>
In-Reply-To: <Y3tuKNhbMaSsZc6+@google.com>
Subject: RE: [PATCH 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Date:   Wed, 23 Nov 2022 17:32:02 +0530
Message-ID: <000901d8ff33$672ee090$358ca1b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGtZdCQDJwhTh87CLfF3yzsQrDlqwKSRiFZAtvre9gA6G+sSq5w5OrQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmpq6bdF2ywfVHqhYP5m1js5h/5Byr
        Rd+Lh8wWO9oWslhc3jWHzWLR1i/sFg8/7GG3aN17hN3i18LDLA6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTd
        MnOAblFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBka
        GBiZAhUmZGfcOdXBVrBLoOLFsncsDYwHebsYOTkkBEwkbh+bwdjFyMUhJLCbUWLP2Q9sEM4n
        Ronm9s+sIFVCAt8YJd7OFYTpWHBoMgtEfC+jxK7TIRANzxklLm1fAdbAJqAv8XrFfDYQW0RA
        SeLQ2uPsIEXMAn8YJbYf+scEkuAU0JJ4/XYpWJGwQLRE7+QjYHEWAVWJjYufgdm8ApYSDa/3
        skPYghInZz4B28wsoC2xbOFrZoiLFCR+Pl3GCrHMTaLh5DRGiBpxiaM/e5hBFksIzOSQWNa/
        iRGiwUXi1d6TLBC2sMSr41vYIWwpic/v9rJB2OkSm49sZoWwcyQ6mpqhltlLHLgyB6iXA2iB
        psT6XfoQYVmJqafWMUHs5ZPo/f2ECSLOK7FjHoytJrH4USeULSOx9tEn1gmMSrOQvDYLyWuz
        kLwwC2HbAkaWVYySqQXFuempxaYFRnmp5fAIT87P3cQITqpaXjsYHz74oHeIkYmD8RCjBAez
        kghvvWdNshBvSmJlVWpRfnxRaU5q8SFGU2B4T2SWEk3OB6b1vJJ4QxNLAxMzMzMTS2MzQyVx
        3sUztJKFBNITS1KzU1MLUotg+pg4OKUamNpnGn2Xt96fPV256/+RjXmbBG9OvX4+QUth84WE
        lg0FU1R/R/ZksEdo/plhuzGWS/FB6emj66fybmLd6JWy+fb34gO7tE3WVWUnzlynZ6e8N21/
        Quktv9OXHXaf6zacd0Lc+M9vC515l9ibjOttP4uuWSHfeKS2zO+yhenUmNQo3c2idue3Kbkp
        Wl8pMbznepjj+MfJKV3Tyq7rW65in2/0nbVJTjDfqDBqq3e3oFZ8l3Zj0/rle6/PORjLtuyr
        2yPrXq127//rdfjNSv+FZjw3sL8WLxExPc1oafzlwJc9Sa7fpRlMf+q3LdCf7BtdXHGv5dw9
        17g/nSH7wkUP/OZtKeexvaDxYqe5evJ6JZbijERDLeai4kQAg2GhoTMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXncPd12yQfdLPYsH87axWcw/co7V
        ou/FQ2aLHW0LWSwu75rDZrFo6xd2i4cf9rBbtO49wm7xa+FhFgdOj02rOtk87lzbw+bRt2UV
        o8fnTXIBLFFcNimpOZllqUX6dglcGc23e5gK3vJXzDu0lL2B8TVPFyMnh4SAicSCQ5NZuhi5
        OIQEdjNKfNx0lxEiISNx8sESZghbWGLlv+fsEEVPGSXat99gB0mwCehLvF4xnw3EFhFQkji0
        9jhYEbNAC5PE7NXrmSA67jNK/GpdywJSxSmgJfH67VKwDmGBSIl5m+aDrWMRUJXYuPgZE4jN
        K2Ap0fB6LzuELShxcuYTsF5mAW2JpzefwtnLFr6GOk9B4ufTZawQV7hJNJycxghRIy5x9GcP
        8wRG4VlIRs1CMmoWklGzkLQsYGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHF1a
        mjsYt6/6oHeIkYmD8RCjBAezkghvvWdNshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE
        0hNLUrNTUwtSi2CyTBycUg1Miha7DaaJfXP8u05eRU3b+ljr1TYPgY2siw8cCpo60UBzdvLK
        c/Gf76kbPdxX84WnUO7mlCssuSv+d53pU5gZfNqis4ez/2bB1QPd8dn688z+eO5+45Rn/Uox
        dd2aFxZ8J1ssS3j3meidefevZQGDzLXWszO4vZzVZ7/6ebyAvcFgc9mZr4H/+V3PKIbulX4s
        mJXb0bYpY416d4uPpefJyNcL06fqWNWf29g9Lf127fHZ2fwnw9T0u2S/n92a+DFia/K8HeW8
        V9zb2xSF+b5bVXN/6Fhxyeec22fZhfu3FVoWfHzzQvx0elvUy5pJ66crzlxyZ4bz7o1XDAq8
        V4ce4+rc1aOsd8Tb4Eb1BbVOJZbijERDLeai4kQA83tGah0DAAA=
X-CMS-MailID: 20221123120204epcas5p36f0bd5dc96225c4a809cb5b1b7adfb23
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
        <CGME20221121090622epcas5p4cbce7d07007fc76d3c69e0013d3c4cf4@epcas5p4.samsung.com>
        <20221121091118.48628-2-sriranjani.p@samsung.com>
        <Y3tuKNhbMaSsZc6+@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Lee Jones =5Bmailto:lee=40kernel.org=5D
> Sent: 21 November 2022 17:55
> To: Sriranjani P <sriranjani.p=40samsung.com>
> Cc: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com; linux-
> kernel=40vger.kernel.org; Vivek Yadav <vivek.2311=40samsung.com>
> Subject: Re: =5BPATCH 1/2=5D dt-bindings: mfd: syscon: Add tesla compatib=
les
> found on FSD SoC
>=20
> On Mon, 21 Nov 2022, Sriranjani P wrote:
>=20
> > Describe the compatible properties for Tesla SYSREG controllers found
> > on FSD SoC.
>=20
> Not much describing going on here.
>=20
> > Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Ravi Patel <ravi.patel=40samsung.com>
> > Signed-off-by: Vivek Yadav <vivek.2311=40samsung.com>
> > Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
>=20
> Struggling to imagine how it took 5 of you to author a single line patch.
=5BSriranjani P=5D Previous version of this patch had some yaml changes, I =
amended the new changes in the same patch and posted it, forgot to remove t=
he sign off.
Will fix it in the next version.
>=20
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml =7C 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 4e4baf53796d..8c3334999bec 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > =40=40 -69,6 +69,7 =40=40 properties:
> >                - samsung,exynos5433-sysreg
> >                - samsung,exynos850-sysreg
> >                - samsung,exynosautov9-sysreg
> > +              - tesla,fsd-sysreg
> >
> >            - const: syscon
> >
>=20
> --
> Lee Jones =5B=E6=9D=8E=E7=90=BC=E6=96=AF=5D=0D=0A=5BSriranjani=20P=5D=20T=
hank=20you=20=0D=0A=0D=0A
