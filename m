Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA063643FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiLFJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiLFJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:30:57 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C84A1CFF9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:30:53 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221206093051epoutp0302fda64d71eace1cbab2fb662b5aa8e1~uKlPBzcRU0908009080epoutp036
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:30:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221206093051epoutp0302fda64d71eace1cbab2fb662b5aa8e1~uKlPBzcRU0908009080epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670319051;
        bh=YH9K9iLYbtXDUJ5T7+RebxYrY30NQhJkDWhYlBPHz+w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=f5VIYEfRpgHhaHAiiX/JjwbV/eayJE2WwhGASeyJgK/+cBo+unAVxM6yL8Icvl63V
         b5mE6e0ZEbc+zVdxD5KufaBItEAQllB3NMO75BcTriGPKWEZEK6GMJJxdTblciYiqQ
         wW9JbYoiFM2tOkhv5ti53Qy1Mdzwrnnn7SnEkzfo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221206093050epcas5p47eb774d011e4769f5db8e1eeca7145c6~uKlOmZtlI2692626926epcas5p46;
        Tue,  6 Dec 2022 09:30:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NRFX72twYz4x9Pv; Tue,  6 Dec
        2022 09:30:47 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.84.39477.7CB0F836; Tue,  6 Dec 2022 18:30:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221206085733epcas5p4396af1ef457c2f3e34c3a0462b3eb1d7~uKIK0WvkW0412204122epcas5p4k;
        Tue,  6 Dec 2022 08:57:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221206085733epsmtrp1c65be4330a767e828fc883c9dd3744df~uKIKzhHgJ1200812008epsmtrp1C;
        Tue,  6 Dec 2022 08:57:33 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-ac-638f0bc7aec6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.F4.14392.DF30F836; Tue,  6 Dec 2022 17:57:33 +0900 (KST)
Received: from FDSFTE302 (unknown [107.122.81.78]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221206085730epsmtip12553f3e72821ec1124b8d21227b9098d~uKIH4zqL80389603896epsmtip1o;
        Tue,  6 Dec 2022 08:57:30 +0000 (GMT)
From:   "Sriranjani P" <sriranjani.p@samsung.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
        <sathya@samsung.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221129115531.102932-1-sriranjani.p@samsung.com>
Subject: RE: [PATCH v4 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
Date:   Tue, 6 Dec 2022 14:27:28 +0530
Message-ID: <01ff01d90950$c7768fd0$5663af70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJIV2Olzk+ELyo7QW3TKaqGaIvwsQLJnMxorWukoWA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmpu5x7v5kg7snhC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7IzTvyVLbgmXLF523y2BsZ+gS5GTg4JAROJL8/msnUxcnEICexm
        lLj3YxUzhPOJUWLGugOMEM43oMydJUwwLf/X74RK7GWUOD6zjx0kISTwnFHi8iM7EJtNQF/i
        9Yr5YHNFBI4xSpw/+Besm1mgUOLYmY1gDZwC9hKnOz6xgtjCAi4Ss2c9AIuzCKhIvH+9A6ye
        V8BSYsXxs2wQtqDEyZlPWCDmaEssW/iaGeIiBYmfT5cBzeEAWmYlcfNsPkSJuMTRnz1g70gI
        rOSQmNG2jg2i3kXiwsZXULawxKvjW9ghbCmJl/1tUHa6xOYjm1kh7ByJjqZmqF32EgeuzGEB
        2cUsoCmxfpc+RFhWYuqpdVAv8kn0/n4CDSxeiR3zYGw1icWPOqFsGYm1jz6xTmBUmoXks1lI
        PpuF5IVZCNsWMLKsYpRMLSjOTU8tNi0wyksth8d3cn7uJkZwktXy2sH48MEHvUOMTByMhxgl
        OJiVRHhfbOxNFuJNSaysSi3Kjy8qzUktPsRoCgzuicxSosn5wDSfVxJvaGJpYGJmZmZiaWxm
        qCTOu3RKR7KQQHpiSWp2ampBahFMHxMHp1QDk9edwM3Ru5elWHzvvhya1LH98pMozasZXZWH
        9ZxE474viHRcJNgoqi6opPDo9D7h8nlJrv8s4qWOZ77b+TTt9O5nEY/fhkWwMJzcpfwjo4LJ
        +GpHRP7qlz3L7/vfaHprJ/Nwx8kmg10/f7FL/W3b4ZHWIecfc43Vxna3Q5CM+acP6T/OHpC4
        1NSyJvXYnUtS3WtEf008crrsJSf/TbHtTNpxATwrtJb1XexPObdE9J7eg1slwd+d8zTPuRz/
        JRN7Kbx0xiGjCoF/ik01e2dcichputDmzXOBV1D23gTVR6L/b+1oF7+++cXtlmMel5werrQ7
        m3LvMf/VGpmNF2aty/aZvvMez4o6vgZW79g8VyWW4oxEQy3mouJEAEXfEc07BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO5f5v5kgyl75CwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBnPJx1hLJggXPH93jm2Bsaj/F2MnBwS
        AiYS/9fvZOxi5OIQEtjNKHH031IWiISMxMkHS5ghbGGJlf+es0MUPWWU6NqzByzBJqAv8XrF
        fDaQhIjAOUaJ5183gyWYBYol9m25zQzRMYFRYuOefewgCU4Be4nTHZ9YQWxhAReJ2bMegMVZ
        BFQk3r/ewQRi8wpYSqw4fpYNwhaUODnzCQvEUG2J3oetjDD2soWvoc5TkPj5dBnQTA6gK6wk
        bp7NhygRlzj6s4d5AqPwLCSTZiGZNAvJpFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7N
        S9dLzs/dxAiONi3NHYzbV33QO8TIxMF4iFGCg1lJhPfFxt5kId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpj0r8VLxc7hbptygTVg4cOe+zay+U2LCh0O
        plltqGizzWDZfaru/J+QjJafejIR93gf3q9241rts2sfu92dmLkl9/+UPHphvpP/UYwUS7jn
        hmrto2YagawcmXU33/G+3nxC5E3gs5QpT/78VTqpVOmdxzWvylpxj0GN64rsnE/NQf673uY+
        8ROaf/PC4bbtJcJKnvN+7V6/9+GEB+x8h0TPHC33q4o/xST/nUezbWdxuK7HiWm60nl/tu87
        zXCj06fr5PJ41wMPE1/ZnTR99kBM0e/O5jJPljIPxxLVF163S5bmHzou6vXvjYfIik3l91cJ
        vK9aVRNhxRj85dbNh/q7ObY7rdXwOcpq1BJx2ESJpTgj0VCLuag4EQCpCTbjJQMAAA==
X-CMS-MailID: 20221206085733epcas5p4396af1ef457c2f3e34c3a0462b3eb1d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481
References: <CGME20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481@epcas5p3.samsung.com>
        <20221129115531.102932-1-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Gentle Reminder to review this patch series.

Thanks,
Sriranjani P.

> -----Original Message-----
> From: Sriranjani P =5Bmailto:sriranjani.p=40samsung.com=5D
> Sent: 29 November 2022 17:25
> To: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
> sathya=40samsung.com
> Cc: linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.or=
g;
> linux-samsung-soc=40vger.kernel.org; Sriranjani P
> <sriranjani.p=40samsung.com>
> Subject: =5BPATCH v4 0/2=5D arm64: dts: Add SYSREG nodes for FSD SoC
>=20
> FSD has few system controller register blocks. This patch series intends =
to
> add support of device node for system controller registers group that res=
ides
> in PERIC, FSYS0, FSYS1 and CAM blocks of FSD SoC. As these will be used b=
y
> PCIE, EQoS and CSI module. Patches for adding support for PCIE, EQoS and
> CSI are already under review at =5B1=5D, =5B2=5D and =5B3=5D.
>=20
> Also this patch series add required DT bindings for such system controlle=
r of
> FSD SoC.
>=20
> =5B1=5D: https://lkml.org/lkml/2022/11/21/463
> =5B2=5D: https://lkml.org/lkml/2022/11/4/420
> =5B3=5D: https://lkml.org/lkml/2022/11/20/363
>=20
> These changes are made on top of Krzysztof's patches =5B4=5D posted as pa=
rt of
> splitting Samsung Exynos SoC SYSREG bindings to own file.
>=20
> =5B4=5D: https://lkml.org/lkml/2022/11/25/370
>=20
> Changes since v3:
> 1. As per update from Krzysztof, add dedicated compatibles for sysreg fou=
nd
> on FSD SoC in the exynos-sysreg.yaml file.
> 2. Add CAM block sysreg changes in the dtsi file and respective compatibl=
e in
> binding document.
>=20
> Changes since v2:
> 1. Updated compatibles as per improvements suggested by Krzysztof.
>=20
> Changes since v1:
> 1. Fixed SoB in =5BPATCH 1/2=5D dt-bindings: mfd: syscon: Add tesla compa=
tible
> found on FSD SoC.
> 2. Address review comments from Krzysztof on =5BPATCH 2/2=5D and aligned
> sysreg node near to respective blocks sorted in order of unit address.
>=20
> Sriranjani P (2):
>   dt-bindings: soc: samsung: exynos-sysreg: Add tesla FSD sysreg
>     compatibles
>   arm64: dts: fsd: add sysreg device node
>=20
>  .../soc/samsung/samsung,exynos-sysreg.yaml    =7C  4 ++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi            =7C 20 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
>=20
> --
> 2.17.1


