Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DB67F4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjA1En0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjA1EnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:43:22 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB847D9A0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:43:17 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230128044315epoutp0316d8e49c34db47c5d693c9f116acf94d~_X2RNtTZV0709107091epoutp03F
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:43:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230128044315epoutp0316d8e49c34db47c5d693c9f116acf94d~_X2RNtTZV0709107091epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880995;
        bh=2h5BhorETNaW9v1a9wB3VGwTbVEqu5lyKwfvFa7DHWk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=LbSXMmLHhL2feNfSa9EEoyfTDwfBvFRMnOqBFTDddb2Vtp5/TcimS8hM30Of9O7/j
         cQ2k76LqvSj0AMu7xD28fifRTQKdZ6rEM35Y+fpr08OslR4IXR1mNAYuFRFcEjqQkE
         sWx8kqM6QXa+z7s8KM3HFj6gRTRM6FmTxxfGC1Ig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230128044315epcas5p2b6710f5de3ed16cbb7c74182eb90281f~_X2Qv8A_Z2534925349epcas5p2T;
        Sat, 28 Jan 2023 04:43:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4P3hds5Lvkz4x9Pv; Sat, 28 Jan
        2023 04:43:13 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.7B.55678.1E7A4D36; Sat, 28 Jan 2023 13:43:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230128044312epcas5p28d26462cfb202e9b883da0e6a7d0f30d~_X2OCjm1v2368623686epcas5p2Y;
        Sat, 28 Jan 2023 04:43:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128044312epsmtrp1f382f7ab44de12fb0150b3678ab074df~_X2OBu43Q2650226502epsmtrp1v;
        Sat, 28 Jan 2023 04:43:12 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-af-63d4a7e1c41b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.8D.05839.0E7A4D36; Sat, 28 Jan 2023 13:43:12 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128044310epsmtip24883bad5d84a081cb8df6603746480f2~_X2L9M9nH0659406594epsmtip2h;
        Sat, 28 Jan 2023 04:43:10 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Inki Dae'" <inki.dae@samsung.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Kukjin Kim'" <kgene@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <replicant@osuosl.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?utf-8?Q?'Martin_J=C3=BCcker'?= <martin.juecker@gmail.com>,
        "'Henrik Grimler'" <henrik@grimler.se>
In-Reply-To: <20230120155404.323386-11-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 10/11] ARM: dts: exynos: correct HS200 property in
 Exynos5260
Date:   Sat, 28 Jan 2023 10:13:08 +0530
Message-ID: <000601d932d3$06e32ce0$14a986a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQHefuibAS0GbVKusdeZcA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTZxTG8/befoArXtouvHQG4QaChRVaBt1ls+g2IFdnskazkUkWvCk3
        LeunbVE0xhkZRMomoGMbndv8QDrIGKaWKgyGlDKGqATsgGwoEnHCgAmywFRwa7lz47/fOed5
        cs55P3iI4CZHzCsw2miLkdLjnFDU0yXZJB13+tWyPncc8bXvBpuYrW0FxImxSpSouDuNEMcn
        xxGifbqZS1w/OsMlXHeH2MTN1lMc4vP+H1jEtafVKHF6OYP47ttwoqTdxyUuLq2ArevJFsct
        Ltntv80mXQ1lHHJ0qI1DXqz9gPx7tJFL/llcziaPuxsAueCKUoXs1m3W0lQ+bYmmjWpTfoFR
        o8Tf3JX3Rl6aQiaXytOJl/FoI2WglXjmDpU0u0AfmB+P3kfpCwMpFWW14skZmy2mQhsdrTVZ
        bUqcNufrzanmJCtlsBYaNUlG2vaKXCZLSQsI9+i0oz2zHPOkoOj+gBs9ApbC7SCEB7FU2DF8
        DdhBKE+AfQ9g32cOdrAgwB4CONWWxvAigA8e7H1mcJ1fRBlDO4CtiyscJpgC8MKKBwRVHEwK
        L58rXS2IsEYEXnF7VgME6wPQX8+oQrBseHLAyQqyENsFJ4eKVxnF4mDduTZOkPlYOmyc+Qkw
        HA57aybQICNYIqw7M40wM0XDR/fqVucWYa/DhpYuLqOJgFPdPm6wMcRmeLDhwxUWY8iECwPL
        XIaF8Pce978shlMVpQHmBZiEZ5fFTFoLZ51NgOEt8Ir/FBqUIJgENrUmM63C4MdPJliMkw+P
        lQoYdRws/uNnlOEXYFV5OZthEl7vHgSVIMaxZjHHmsUcaxZw/N/sNEAbQCRttho0tDXNnGKk
        9/9332qTwQVWX3fC9stg/M5ckheweMALIA/BRfzm1wbVAn4+deAgbTHlWQr1tNUL0gKnXYWI
        n1ebAt/DaMuTp6bLUhUKRWr6Swo5HsGPV/aqBZiGstE6mjbTlmc+Fi9EfIT11WF76Vh8Lek/
        W/nRwKdPbhOHwvf1s3V6XREoiSWq8YlYSYVbEjP7ibRzf73I+cXhBGFOy1uPF5Si6l9zL22p
        3KA5sXfni+rcEVViLumVdUUOxex+N6umcUTcUXyDt65Hs7y8Mq8uiQ/7xnO++f1Izvo81bEd
        0qh13V96X93O18eOeZNDN76X6K++6thAIR7Lwx+3HXiahL/9nOjosOvWfcPgpbAUi6+zipQU
        7Ty4scOuQsYGWs4IMfOdrHvDh8p+iaoYFPY/EhoimiSZOWW+pXdG99jtcl/H3Ij/gseZs02p
        1M7367L+cg9i4xk1j5fGexUdPVc757KNm+bR+t+24qhVS8kTEIuV+ge9G1Z0ZgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO6D5VeSDa4f4beYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6Mr/vcC+7zVfx5Ope1gfEOTxcjJ4eEgInEpqXfWLoY
        uTiEBHYzSkzYcpYJIiEtcX3jBHYIW1hi5b/n7BBFzxklJn5dzgiSYBPQldixuI0NJCEisJlZ
        4vikg8wgDrPAeUaJGzMOsIJUCQlcYJRofAk2llPATWLyxeVgtrBAoMSG711sIDaLgKrEssV7
        wGxeAUuJtW9OMELYghInZz5hAbGZBbQlnt58CmcvW/iaGeI8BYmfT5eB7RIRcJJYtfMwO0SN
        uMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95Pzc
        TYzgGNbS3MG4fdUHvUOMTByMhxglOJiVRHi3Ol5KFuJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoFJWGji8YcRMYGiBndeO6k6JfczWtqe7Ttbs1F0xbp5
        Juf3bLuRsfvMfvmFaR3b/MN1V22Ufac2M+27R6tkzeolQhueeOXbbPrew+zSabRxVZzqoxnr
        zV5FNd1v+s1x7Vqmq7Pt/eylQjdL2rbIrWdZLmHhsyrU/GvyJuaEgqQqz7Kdkm27Fn43YNIw
        277q5K8Lp4sOvFuRbqPfkvuLX3Gax+LoqxOWz+uat/KH4uSTNwVMtp+b6f6e9cbhhJpKq90V
        K23W/FJwuZ4mvme99HO9shIvf2m2E/xGqtPrvnNvYTo3zTh8V0MYj60gq0fj0QkbzH+uN535
        9M2+WY6xExfLfWW08F2pPP/Tz+jYhKeVSizFGYmGWsxFxYkAYB+O21ADAAA=
X-CMS-MailID: 20230128044312epcas5p28d26462cfb202e9b883da0e6a7d0f30d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155430epcas5p37a9c25aff53026b8963fb7a427b84ccc
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155430epcas5p37a9c25aff53026b8963fb7a427b84ccc@epcas5p3.samsung.com>
        <20230120155404.323386-11-krzysztof.kozlowski@linaro.org>
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
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Friday, January 20, 2023 9:24 PM
> To: Rob Herring <robh+dt=40kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; Inki Dae <inki.dae=40samsung.com>; Kyungmin
> Park <kyungmin.park=40samsung.com>; Kukjin Kim <kgene=40kernel.org>;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org
> Cc: replicant=40osuosl.org; phone-devel=40vger.kernel.org;
> =7Epostmarketos/upstreaming=40lists.sr.ht; Martin J=C3=BCcker=0D=0A>=20<m=
artin.juecker=40gmail.com>;=20Henrik=20Grimler=20<henrik=40grimler.se>;=0D=
=0A>=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20=
Subject:=20=5BPATCH=2010/11=5D=20ARM:=20dts:=20exynos:=20correct=20HS200=20=
property=20in=0D=0A>=20Exynos5260=0D=0A>=20=0D=0A>=20There=20is=20no=20supp=
orts-hs200-mode=20property=20for=20MMC=20nodes,=20so=20assume=0D=0A>=20inte=
ntion=20was=20mmc-hs200-1_8v:=0D=0A>=20=0D=0A>=20=20=20exynos5260-xyref5260=
.dtb:=20mmc=4012140000:=20Unevaluated=20properties=20are=0D=0A>=20not=20all=
owed=20('supports-hs200-mode'=20was=20unexpected)=0D=0A>=20=0D=0A>=20Signed=
-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A=
>=20---=0D=0A=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.co=
m>=0D=0A=0D=0A>=20=20arch/arm/boot/dts/exynos5260-xyref5260.dts=20=7C=202=
=20+-=0D=0A>=20=201=20file=20changed,=201=20insertion(+),=201=20deletion(-)=
=0D=0A>=20=0D=0A>=20diff=20--git=20a/arch/arm/boot/dts/exynos5260-xyref5260=
.dts=0D=0A>=20b/arch/arm/boot/dts/exynos5260-xyref5260.dts=0D=0A>=20index=
=203c3b751d4360..387b8494f18f=20100644=0D=0A>=20---=20a/arch/arm/boot/dts/e=
xynos5260-xyref5260.dts=0D=0A>=20+++=20b/arch/arm/boot/dts/exynos5260-xyref=
5260.dts=0D=0A>=20=40=40=20-87,7=20+87,7=20=40=40=20&mmc_0=20=7B=0D=0A>=20=
=20=09status=20=3D=20=22okay=22;=0D=0A>=20=20=09broken-cd;=0D=0A>=20=20=09c=
ap-mmc-highspeed;=0D=0A>=20-=09supports-hs200-mode;=20/*=20200=20MHz=20*/=
=0D=0A>=20+=09mmc-hs200-1_8v;=0D=0A>=20=20=09card-detect-delay=20=3D=20<200=
>;=0D=0A>=20=20=09samsung,dw-mshc-ciu-div=20=3D=20<3>;=0D=0A>=20=20=09samsu=
ng,dw-mshc-sdr-timing=20=3D=20<0=204>;=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=
=0A=0D=0A
