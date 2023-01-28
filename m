Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CC67F4BA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjA1Ehz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjA1Ehv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:37:51 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E674EC6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:37:47 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230128043745epoutp02bf9e0d64272517d6c8ac16e01ec6df46~_Xxdz5EzU3170731707epoutp02j
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:37:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230128043745epoutp02bf9e0d64272517d6c8ac16e01ec6df46~_Xxdz5EzU3170731707epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880665;
        bh=7e8+loPByN05ZSxqHfhAGZVA3K8lA9e1Oam9gGHZCEw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=OI8QCatK1mQ6GwOvLTZfueZyV7Z2zMg5Qht5tNyWmyHgCBmF5AmeiQGCyAT+0RajF
         291oR9hUtygJZX5qSv/nOZzJ1cwkj3maP/ZSbByfqDLRNrGhg7lmD+xl8Az4tR+Ocx
         9ht5OyO7URqNm1XCOYHLRAOEzF3NIFo40SSALnwQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230128043745epcas5p3ade9a5d6893ff8cf4b022809b2944516~_XxdLqFZa2820028200epcas5p3m;
        Sat, 28 Jan 2023 04:37:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4P3hWV5rgDz4x9Pp; Sat, 28 Jan
        2023 04:37:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.AA.06765.696A4D36; Sat, 28 Jan 2023 13:37:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230128043741epcas5p3b031b55efe37ebea89ed0ce74a75634d~_XxaHiIlB2820028200epcas5p3c;
        Sat, 28 Jan 2023 04:37:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230128043741epsmtrp210aaa26cf2d63e2bda395e5737519e3c~_XxaGtIuC2767227672epsmtrp2l;
        Sat, 28 Jan 2023 04:37:41 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-a3-63d4a696187c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.2C.17995.596A4D36; Sat, 28 Jan 2023 13:37:41 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128043735epsmtip29d2300e53100a036f7baefc5b050857f~_XxT1iyP30728207282epsmtip2B;
        Sat, 28 Jan 2023 04:37:34 +0000 (GMT)
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
In-Reply-To: <20230120155404.323386-5-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 04/11] ARM: dts: exynos: align pin node names in
 Exynos4412
Date:   Sat, 28 Jan 2023 10:07:31 +0530
Message-ID: <000301d932d2$41d5ec80$c581c580$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQLfHGsjAbJTSV2upaZ4gA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmhu60ZVeSDR4+0bWYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGb8nvGEr+CRSceDgRqYGxt/CXYycHBICJhLb+q4zdjFycQgJ7GaUeH/iJguE
        84lR4vDZ4+wgVUICnxklWruMYDomTbnEBlG0i1Gi6c5iKOclo8T/x89YQarYBHQldixuA0uI
        CKxlljiwZRuYwyxwmlHiysptQBs5ODgFXCWOLkkHaRAWCJSYcO0RG0iYRUBVYsZfZ5Awr4Cl
        xJXjr9kgbEGJkzOfsIDYzALaEssWvmaGuEhB4ufTZWB7RQScJN4ebGGCqBGXeHn0CDvIWgmB
        NxwSWw4dZYJocJFoPP6aFcIWlnh1fAs7hC0l8fndXrAbJAQ8JBb9kYIIZ0i8Xb6eEcK2lzhw
        ZQ4LSAmzgKbE+l36EKv4JHp/P2GC6OSV6GgTgqhWlWh+d5UFwpaWmNjdDbXUQ2LWs1XsExgV
        ZyF5bBaSx2YheWAWwrIFjCyrGCVTC4pz01OLTQuM81LL4dGdnJ+7iRGcuLW8dzA+evBB7xAj
        EwfjIUYJDmYlEd6tjpeShXhTEiurUovy44tKc1KLDzGaAgN7IrOUaHI+MHfklcQbmlgamJiZ
        mZlYGpsZKonzqtueTBYSSE8sSc1OTS1ILYLpY+LglGpgmnVutu3TaycaJH+e53V7Kz5boDSZ
        p37B7K4rl8xnzWK4MWMy+2YZ/zPy8p0v3pw+Xnxgs2yZj/H8mYW7++8n7e6fmMLq08raka+X
        ueXJo8U5ThPZuMv+OLy/Llzz4fhTft9u1Tv5ua4BCoeVL+Q8XtIzZ/EX3iy7j9JzSg7cjz8f
        2XszUGvzvNqaScrRadpXMy+2z7DcZfd3bpTJzaqb7z0PPXmjZ1qc7L64vGzGmX0vfR8tMH3/
        qfEsp48Qs+LiZd7lQa4WWt9q7y30rRPzi1ye8Xmm20vTlRrNHR0c+4/7RH3bcn8pA4siown7
        8p4rE7sf3TbkWztNdjZPnP3fzuRw6Zu3d+nuCtrxYt6scCWW4oxEQy3mouJEAGhW+NVlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSvO7UZVeSDV6+VbeYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6Mq3tvshZc4a9obT3M3sA4l7eLkZNDQsBEYtKUS2xd
        jFwcQgI7GCUe7pvCApGQlri+cQI7hC0ssfLfc3aIoueMErsPX2EGSbAJ6ErsWNwG1i0isJlZ
        4vikg8wgDrPAeUaJGzMOsEK0ADk3u3uByjg4OAVcJY4uSQfpFhbwl7jyppUdJMwioCox468z
        SJhXwFLiyvHXbBC2oMTJmU/ALmIW0JZ4evMpnL1s4WtmiOsUJH4+XcYKYosIOEm8PdjCBFEj
        LvHy6BH2CYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93
        EyM4hrW0djDuWfVB7xAjEwfjIUYJDmYlEd6tjpeShXhTEiurUovy44tKc1KLDzFKc7AoifNe
        6DoZLySQnliSmp2aWpBaBJNl4uCUamASemXlz5BcL3RWa43P1LOnJibbvvFkdBTz6sx8GnC1
        44idiDAHS1uaftrcWW9nzWYR3+E2sWKjetKFZ1k/Q0vqzRM4Fm+RzhdYkaZW25SzkS/WZT/L
        4UeL5jyR5Xx8bsFj7fvJBf6vpS0b3i/pqJV7/0RIY/vTqojSextdnYok/7/zvXiQ/UdqmUOC
        aNPb0EVfJ31LNRbu0PgcPKfkx1399lgBgRMnrivM4/LYW/N1verDZxcXT3i18PunI7yNZvMq
        LvmUx6/5GXa2RM/tY97BGzPPpfbtTTR6bvjKIKLHPPFB2561S3+GqMs0/MgrSwx/fHP752td
        C5mmFZ504Ozkc1v/ZcUluaCfN/krJTmVWIozEg21mIuKEwErLZnYUAMAAA==
X-CMS-MailID: 20230128043741epcas5p3b031b55efe37ebea89ed0ce74a75634d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155420epcas5p474c90e6a1bf1d83365d2db230507b402
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155420epcas5p474c90e6a1bf1d83365d2db230507b402@epcas5p4.samsung.com>
        <20230120155404.323386-5-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Subject:=20=5BPATCH=2004/11=5D=20ARM:=20dts:=20exynos:=20align=20pin=20node=
=20names=20in=0D=0A>=20Exynos4412=0D=0A>=20=0D=0A>=20The=20DT=20schema=20ex=
pect=20pin=20configuration=20nodes=20to=20have=20pin=20prefix=20or=0D=0A>=
=20suffix:=0D=0A>=20=0D=0A>=20=20=20exynos4412-trats2.dtb:=20pinctrl=403860=
000:=20sleep-state:=20'gpz-0',=20'gpz-1',=20'gpz-2',=0D=0A>=20'gpz-3',=20'g=
pz-4',=20'gpz-5',=20'gpz-6'=0D=0A>=20=20=20=20=20do=20not=20match=20any=20o=
f=20the=20regexes:=20'=5E(pin-=5Ba-z0-9-=5D+=7C=5Ba-z0-9-=5D+-pin)=24',=0D=
=0A>=20'pinctrl-=5B0-9=5D+'=0D=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=
=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=0AReviewe=
d-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20arch/=
arm/boot/dts/exynos4412-pinctrl.dtsi=20=7C=202=20+-=0D=0A>=20=201=20file=20=
changed,=201=20insertion(+),=201=20deletion(-)=0D=0A>=20=0D=0A>=20diff=20--=
git=20a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi=0D=0A>=20b/arch/arm/boot/=
dts/exynos4412-pinctrl.dtsi=0D=0A>=20index=2058847d4fa846..8ab31c3daa48=201=
00644=0D=0A>=20---=20a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi=0D=0A>=20+=
++=20b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi=0D=0A>=20=40=40=20-12,7=20=
+12,7=20=40=40=0D=0A>=20=20=23include=20=22exynos-pinctrl.h=22=0D=0A>=20=0D=
=0A>=20=20=23define=20PIN_SLP(_pin,=20_mode,=20_pull)=09=09=09=09=09=5C=0D=
=0A>=20-=09_pin=20=7B=09=09=09=09=09=09=09=09=5C=0D=0A>=20+=09pin-=20=23=23=
=20_pin=20=7B=09=09=09=09=09=09=09=5C=0D=0A>=20=20=09=09samsung,pins=20=3D=
=20=23_pin;=09=09=09=09=09=5C=0D=0A>=20=20=09=09samsung,pin-con-pdn=20=3D=
=20<EXYNOS_PIN_PDN_=20=23=23_mode>;=0D=0A>=20=09=5C=0D=0A>=20=20=09=09samsu=
ng,pin-pud-pdn=20=3D=20<EXYNOS_PIN_PULL_=20=23=23_pull>;=0D=0A>=20=09=5C=0D=
=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
