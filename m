Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23586B57AD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 03:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCKCDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 21:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCKCDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 21:03:53 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC911F635
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 18:03:49 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230311020344epoutp0182dd46c5ae6cf30757f0e16b6de9c84c~LOw_vzUIu0393303933epoutp01l
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 02:03:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230311020344epoutp0182dd46c5ae6cf30757f0e16b6de9c84c~LOw_vzUIu0393303933epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678500224;
        bh=6sp75/w5DYKuOo0fBoqltJ2eK/rdk5SAkhAmTtLfQqI=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=f8YPy23fY+Pg4iVWMCHUDccNezJ9cmQNBtPyH3r0Yo0Mdsz8SWOn+equzKU4f42V3
         Det361Eqf5EqYm+4XYmunCJrS/Slw1yCO1yGvUYPLDDk8zi3db4UWBo6rXkSa6rsgY
         xveu/0fXGMZZ3fAX2IUCgz/snRCEpz5eIHa1pLQ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230311020343epcas5p1b9a56c605770c80d738ef450f20458ea~LOw9gwsZ02774727747epcas5p15;
        Sat, 11 Mar 2023 02:03:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PYR6Q1P3gz4x9Pv; Sat, 11 Mar
        2023 02:03:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.B4.10528.D71EB046; Sat, 11 Mar 2023 11:03:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230311020341epcas5p426fbfdd41da70feae86e39856e9dfe89~LOw79p9Il1707317073epcas5p4l;
        Sat, 11 Mar 2023 02:03:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230311020341epsmtrp169b3181b7a86bd09484bd3a2af157dc5~LOw78zLHw2570025700epsmtrp1V;
        Sat, 11 Mar 2023 02:03:41 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-d0-640be17d8d5f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.4B.18071.D71EB046; Sat, 11 Mar 2023 11:03:41 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230311020339epsmtip278d83d1e090c70e09b020ccba855c8d5~LOw6RHW400193401934epsmtip23;
        Sat, 11 Mar 2023 02:03:39 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'James E.J. Bottomley'" <jejb@linux.ibm.com>,
        "'Martin K. Petersen'" <martin.petersen@oracle.com>,
        "'Manivannan Sadhasivam'" <mani@kernel.org>,
        "'Andy Gross'" <agross@kernel.org>,
        "'Bjorn Andersson'" <andersson@kernel.org>,
        "'Konrad Dybcio'" <konrad.dybcio@linaro.org>,
        <linux-scsi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
In-Reply-To: <20230310214435.275127-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/3] ufs: exynos: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 07:33:38 +0530
Message-ID: <000001d953bd$b3b099c0$1b11cd40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJBeF328n03Zy3knz/Oyu2u3S3OAAGgvl5mAcbfUW6uCU0dQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOJsWRmVeSWpSXmKPExsWy7bCmum7dQ+4Ug95NzBbnHv9msdjWYWOx
        6MY2JouOydtZLPa+3spusenxNVaLifvPsltc3jWHzWLG+X1MFt3Xd7BZHPiwitFi+fF/TA48
        HptWdbJ53Lm2h81jwqIDjB6bl9R7fHx6i8Xj8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ0ye9YSyYIVTxd9Uq5gbGewJdjBwc
        EgImEv8WJXcxcnEICexmlPi2fjojhPOJUeLDgS1MEM43RomzK/4xdzFygnV0/zsKldjLKPF+
        1VKolpdALbOfsoNUsQnoSuxY3MYGkhARaGWROPz7HhNIglPAVeL28tcsILawgIvE29bvYHEW
        AVWJhoMnwFbwClhK/H4ykRHCFpQ4OfMJWD2zgLbEsoWvoc5QkPj5dBkriC0i4CRx58YHRoga
        cYmXR4+wgyyWENjCIfF14goWiAYXie73m1ghbGGJV8e3sEPYUhIv+9vYIaHhIbHojxREOEPi
        7fL1jBC2vcSBK3NYQEqYBTQl1u/Sh1jFJ9H7+wkTRCevREebEES1qkTzu6tQS6UlJnZ3Qy31
        kDj4+A4rJKwuM0psPvKMdQKjwiwkX85C8uUsJN/MQti8gJFlFaNkakFxbnpqsWmBYV5qOTzC
        k/NzNzGCU7CW5w7Guw8+6B1iZOJgPMQowcGsJML7XYojRYg3JbGyKrUoP76oNCe1+BCjKTDo
        JzJLiSbnA7NAXkm8oYmlgYmZmZmJpbGZoZI4r7rtyWQhgfTEktTs1NSC1CKYPiYOTqkGpvp/
        b575nXPYUt8xI2Hy+WMzt9VuSG9ymvh/T2m64RELH70DUa9PTQwM2xwWFnP8v8/lQvM+u6sm
        PtbGluv0IuTYD05KZeG6xccdumX7bQsvNivpRsMF77jbdr3YdixRddPJ2b2GZyL8tu7fUl6Z
        6Zz9ZuEF+5/xq8xWTVBs213ReENNuCRLR7Dzhenhw5M+7LQ6pLXDZX/g9qrzCzM5HnwxK/PO
        8gp+XC11fss7OcN63flJxpcFX/Xt+33QVOP9i4Dyi/umLdL4tYFfcWnMnnMJdw4Xd4ftNP36
        cXaYsni7RUHl/YI1z3M1jFun7TN4b+a9Rn3+2t6AvNgJ8YtfaAjtnxX0XnhXpOvpFcFzHJRY
        ijMSDbWYi4oTAR6pkV9KBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvG7tQ+4Ug8YOZYtzj3+zWGzrsLFY
        dGMbk0XH5O0sFntfb2W32PT4GqvFxP1n2S0u75rDZjHj/D4mi+7rO9gsDnxYxWix/Pg/Jgce
        j02rOtk87lzbw+YxYdEBRo/NS+o9Pj69xeLxeZNcAFsUl01Kak5mWWqRvl0CV0bXizNsBTP4
        Kx7/2sPawPiRp4uRk0NCwESi+99Rpi5GLg4hgd2MEq9/LmSBSEhLXN84gR3CFpZY+e85O0TR
        c0aJSYv2sIIk2AR0JXYsbmMDSYgI9LJIrNh9jRmi6jyjxOGVj5lAqjgFXCVuL38NNlZYwEXi
        bet3sDiLgKpEw8ETzCA2r4ClxO8nExkhbEGJkzOfgNUzC2hLPL35FM5etvA1M8RJChI/ny4D
        u0JEwEnizo0PjBA14hIvjx5hn8AoNAvJqFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQsM81LL
        9YoTc4tL89L1kvNzNzGCY05Lcwfj9lUf9A4xMnEwHmKU4GBWEuH9LsWRIsSbklhZlVqUH19U
        mpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT/3OjQB+Z3y7ZiceEi7Sr5S41
        3mj1fn371JLbgfvLH7LmpLY4qS4T+l6gr8X071UE+/d1ms7/z9eLitWE2dvYWZ2yXdJgLf5f
        a1HNHPZiKXPbScGyZ0K9U2vN0g1r+G93tmzQ9DnsfDXsw27xF9P2Pav/9jLkjtCyrrx3y9QF
        9BR0Htxfo1amfn6+/e8YTa6qh+/O3Q22XcqmHXXcu7VecOX8rPWhAsdX5L5feq4wWUSyyV9G
        tbFOt9NVz3vlWgmmR4/3b23ffHrBs7YHbmVTl4r++ajou9N6eoz1o67g5K9v73Nr3+STkLBu
        bg1Sv5M2eU3Pyrn7c32FN1mlZ13qUT3+eM26tHsvy6tnMiixFGckGmoxFxUnAgCpsftTKAMA
        AA==
X-CMS-MailID: 20230311020341epcas5p426fbfdd41da70feae86e39856e9dfe89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230310214444epcas5p19f82f433948288464f1c63d97eaa9110
References: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
        <CGME20230310214444epcas5p19f82f433948288464f1c63d97eaa9110@epcas5p1.samsung.com>
        <20230310214435.275127-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Saturday, March 11, 2023 3:15 AM
> To: Alim Akhtar <alim.akhtar=40samsung.com>; James E.J. Bottomley
> <jejb=40linux.ibm.com>; Martin K. Petersen <martin.petersen=40oracle.com>=
;
> Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>; Manivannan Sadhas=
ivam
> <mani=40kernel.org>; Andy Gross <agross=40kernel.org>; Bjorn Andersson
> <andersson=40kernel.org>; Konrad Dybcio <konrad.dybcio=40linaro.org>; lin=
ux-
> scsi=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sam=
sung-
> soc=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-arm-
> msm=40vger.kernel.org
> Subject: =5BPATCH 2/3=5D ufs: exynos: drop of_match_ptr for ID table
>=20
> The driver can match only via the DT table so the table should be always =
used
> and the of_match_ptr does not have any sense (this also allows ACPI match=
ing
> via PRP0001, even though it is not relevant here).
>=20
>   drivers/ufs/host/ufs-exynos.c:1738:34: error: =E2=80=98exynos_ufs_of_ma=
tch=E2=80=99=20defined=0D=0A>=20but=20not=20used=20=5B-Werror=3Dunused-cons=
t-variable=3D=5D=0D=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=
=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=0A=0D=0AReviewed-by:=
=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20drivers/uf=
s/host/ufs-exynos.c=20=7C=202=20+-=0D=0A>=20=201=20file=20changed,=201=20in=
sertion(+),=201=20deletion(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/u=
fs/host/ufs-exynos.c=20b/drivers/ufs/host/ufs-exynos.c=20index=0D=0A>=207c9=
85fc38db1..0bf5390739e1=20100644=0D=0A>=20---=20a/drivers/ufs/host/ufs-exyn=
os.c=0D=0A>=20+++=20b/drivers/ufs/host/ufs-exynos.c=0D=0A>=20=40=40=20-1761=
,7=20+1761,7=20=40=40=20static=20struct=20platform_driver=20exynos_ufs_pltf=
orm=20=3D=20=7B=0D=0A>=20=20=09.driver=09=3D=20=7B=0D=0A>=20=20=09=09.name=
=09=3D=20=22exynos-ufshc=22,=0D=0A>=20=20=09=09.pm=09=3D=20&exynos_ufs_pm_o=
ps,=0D=0A>=20-=09=09.of_match_table=20=3D=20of_match_ptr(exynos_ufs_of_matc=
h),=0D=0A>=20+=09=09.of_match_table=20=3D=20exynos_ufs_of_match,=0D=0A>=20=
=20=09=7D,=0D=0A>=20=20=7D;=0D=0A>=20=20module_platform_driver(exynos_ufs_p=
ltform);=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
