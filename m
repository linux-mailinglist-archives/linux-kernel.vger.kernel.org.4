Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97A67F4B7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjA1EeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjA1EeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:34:10 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240D117
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:34:09 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230128043408epoutp01e9c097713790051475111ddafac6cc59~_XuTCUT6j0795007950epoutp01T
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:34:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230128043408epoutp01e9c097713790051475111ddafac6cc59~_XuTCUT6j0795007950epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880448;
        bh=1nIsxQcQcorTfXjXfX1x/lCc8XLMWXez/pcYyw8xjYU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DfFlqxnMRy/dzByBvEFp6gjhnnDQkRzAKVpMm9Vw1OeSNUXgO0qBR2cz2YUvXAoVV
         //20CdRPYWJs7nlBcVeSjfhPRHwvs9GO7/TFIsiD/JF0ni9YFjCE+a4X/65b2yisSI
         McteZWj0/7P2yPFijwpBmKLgLfMWMiISCElqH+CA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230128043407epcas5p49abace2b29072944e6ba603e6319d38f~_XuSpil6_1850718507epcas5p4R;
        Sat, 28 Jan 2023 04:34:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4P3hRK74fWz4x9Pv; Sat, 28 Jan
        2023 04:34:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.3A.06765.DB5A4D36; Sat, 28 Jan 2023 13:34:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230128043405epcas5p458dcd6119f8fd4a8448a9cad7af5fc65~_XuQjIJ7n1855418554epcas5p4B;
        Sat, 28 Jan 2023 04:34:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128043405epsmtrp16cdbe20c81d79868800b6d2d76ff61f9~_XuQhMQWw2266522665epsmtrp1H;
        Sat, 28 Jan 2023 04:34:05 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-44-63d4a5bdc911
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.1C.17995.DB5A4D36; Sat, 28 Jan 2023 13:34:05 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128043402epsmtip128677103cdb585a33fd8dcf27eb8fa40~_XuN2rnXR1607516075epsmtip1e;
        Sat, 28 Jan 2023 04:34:02 +0000 (GMT)
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
In-Reply-To: <20230120155404.323386-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 03/11] ARM: dts: exynos: correct cd-gpios property in
 Exynos4412 Itop Elite
Date:   Sat, 28 Jan 2023 10:03:59 +0530
Message-ID: <000201d932d1$c0d26d70$42774850$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQC8C8QOAwKMfomurDxIQA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmlu7epVeSDS7dNbGYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
        XbfMHKD7lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
        hgYGRqZAhQnZGS+Pn2YquC5Usf50L1MD4wvBLkZODgkBE4lb/c8Zuxi5OIQEdjNKvNnbzgbh
        fGKUuP+jhQXC+cwo0bbqBnMXIwdYy5YHShDxXYwS0zpbmSGcl4wSN/fdZAKZyyagK7FjcRvY
        KBGBtcwSB7ZsA3OYBU4zSlxZuY0RpIpTwFVi/TaQBCeHsECiRMOaXhYQm0VAVeL5u5tgNbwC
        lhJr3u6HsgUlTs58AlbDLKAtsWzha2aILxQkfj5dxgpiiwg4SVzqucAMUSMu8fLoEXaQxRIC
        HzgkWu78ZYFocJG4tugrK4QtLPHq+BZ2CFtK4mV/GzvEnx4Si/5IQYQzJN4uX88IYdtLHLgy
        hwWkhFlAU2L9Ln2IVXwSvb+fMEF08kp0tAlBVKtKNL+7CrVUWmJidzfUUg+JV082s09gVJyF
        5LFZSB6bheSBWQjLFjCyrGKUTC0ozk1PLTYtMM5LLYdHeHJ+7iZGcPLW8t7B+OjBB71DjEwc
        jIcYJTiYlUR4tzpeShbiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cD8kVcSb2hiaWBiZmZm
        YmlsZqgkzqtuezJZSCA9sSQ1OzW1ILUIpo+Jg1OqgelI+9OVrwKs5jtu9Gy/4yh8PsM4d14M
        q/EuoeL/+ct18h+ZXXvl97du81r15y1XJeoeCQWcnd5usVRD1WArT/q6BQ+T9tiffRG0bNbP
        oLq5X4/9WB1lIXG7dI/q2oQdTC7MpteWH6ic81SBs9sjN9D00BGb+Td32xf/fWD07oSQlsa5
        +WVucZ+bdLtyr5XUme2enRfYpPg+66SuWrRP6Yor1cbBtzv2VAedjQm/oNf+3sffZY34p+67
        x00eLAqc/P5wxobtanWvl0rPfrhMmuNBVmx6fHd35JFtZ/13/V5o0/UwdYe28OQHG+7P2KD+
        Pz87KfvrQ6/kV3zaz79cfqf5/NrRo6GFhaa6fVGJJ+uUWIozEg21mIuKEwE2PySHZwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnO7epVeSDb4f4rGYf+Qcq8XbJbsY
        LSbdn8Bi0f/4NbNF34uHzBZ7X29ltzjb9IbdYtPja6wWl3fNYbOYcX4fk8WZf1NZLBb8sbNY
        t0bQonXvEXaLzd//Mjrwe+ycdZfd4+iVe6wem1Z1snncubaHzWPzknqP/3fWsnt8ae5m9ejb
        sorR4/MmuQDOKC6blNSczLLUIn27BK6M478WMBbc4Kv49nkjYwPjVZ4uRg4OCQETiS0PlLoY
        uTiEBHYwSky/d5O1i5ETKC4tcX3jBHYIW1hi5b/n7BBFzxklZq/rYAZJsAnoSuxY3MYGkhAR
        2MwscXzSQWYQh1ngPKPEjRkHWCFagJw9V+cxgbRwCrhKrN+2jQ1kt7BAvMTWFlGQMIuAqsTz
        dzcZQWxeAUuJNW/3Q9mCEidnPmEBsZkFtCWe3nwKZy9b+JoZ4jwFiZ9Pl4GdLSLgJHGp5wIz
        RI24xMujR9gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOAY1tLawbhn1Qe9Q4xMHIyHGCU4mJVEeLc6XkoW4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        znuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWmv+IzV61fa+R935+9YuIXv8HPR4vx7x6PKDu9T
        1eY2nc37i/FUS7Tb0zPtVkveX33oN9PomV3nRk+9qb+/eBz9adXyv3vlEf/DX/RL09pf6STG
        mT9OuLb5zDalgM2d4SfNn3zgK+1ZtrO26yCHSeu0uVszVNZmftCM+dy15umCFVOCZm+f/lr0
        qd0tr0ufCvYu/W6e0iz8wLw1aImVs9X+sic8pfMT+74IqFb3lTn367P/8Hxxu1zj5NQZk57a
        nVW3SvK7KmjxarJZw4kJ5t5ir56uMVx/6slqdr1lfRu9ORd0fuQU/nZ9o43pDzXncwJHm/y+
        1y3jqb/hL6f7KYg30mFxU97fkwuiM3XWXuNUYinOSDTUYi4qTgQAlQ2lglADAAA=
X-CMS-MailID: 20230128043405epcas5p458dcd6119f8fd4a8448a9cad7af5fc65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155420epcas5p290fac31489a8de12b55578839eb63a95
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155420epcas5p290fac31489a8de12b55578839eb63a95@epcas5p2.samsung.com>
        <20230120155404.323386-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Subject:=20=5BPATCH=2003/11=5D=20ARM:=20dts:=20exynos:=20correct=20cd-gpios=
=20property=20in=0D=0A>=20Exynos4412=20Itop=20Elite=0D=0A>=20=0D=0A>=20The=
=20property=20is=20cd-gpios:=0D=0A>=20=0D=0A>=20=20=20exynos4412-itop-elite=
.dtb:=20mmc=4012530000:=20Unevaluated=20properties=20are=20not=0D=0A>=20all=
owed=20('cd-gpio'=20was=20unexpected)=0D=0A>=20=0D=0A>=20Signed-off-by:=20K=
rzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=
=0A=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=0A=
=0D=0A>=20=20arch/arm/boot/dts/exynos4412-itop-elite.dts=20=7C=202=20+-=0D=
=0A>=20=201=20file=20changed,=201=20insertion(+),=201=20deletion(-)=0D=0A>=
=20=0D=0A>=20diff=20--git=20a/arch/arm/boot/dts/exynos4412-itop-elite.dts=
=0D=0A>=20b/arch/arm/boot/dts/exynos4412-itop-elite.dts=0D=0A>=20index=2020=
2ab0fee3b7..b596e997e451=20100644=0D=0A>=20---=20a/arch/arm/boot/dts/exynos=
4412-itop-elite.dts=0D=0A>=20+++=20b/arch/arm/boot/dts/exynos4412-itop-elit=
e.dts=0D=0A>=20=40=40=20-214,7=20+214,7=20=40=40=20&sdhci_2=20=7B=0D=0A>=20=
=20=09bus-width=20=3D=20<4>;=0D=0A>=20=20=09pinctrl-0=20=3D=20<&sd2_clk=20&=
sd2_cmd=20&sd2_bus4>;=0D=0A>=20=20=09pinctrl-names=20=3D=20=22default=22;=
=0D=0A>=20-=09cd-gpio=20=3D=20<&gpx0=207=20GPIO_ACTIVE_LOW>;=0D=0A>=20+=09c=
d-gpios=20=3D=20<&gpx0=207=20GPIO_ACTIVE_LOW>;=0D=0A>=20=20=09cap-sd-highsp=
eed;=0D=0A>=20=20=09vmmc-supply=20=3D=20<&ldo23_reg>;=0D=0A>=20=20=09vqmmc-=
supply=20=3D=20<&ldo17_reg>;=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
