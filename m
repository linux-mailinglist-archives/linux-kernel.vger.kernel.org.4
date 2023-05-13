Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4727017E3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjEMOi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjEMOiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:38:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBA273B
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 07:38:53 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230513143850epoutp011503f5d2d0a25e7feeaf15d98ebdba12~eutP3a9fv2224622246epoutp01M
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 14:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230513143850epoutp011503f5d2d0a25e7feeaf15d98ebdba12~eutP3a9fv2224622246epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683988730;
        bh=ExyfzvUAW4vN02Z+mVoNYoTYoz20fsFioSM+3YgtLFo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lMJjb7YTcUc3PBYIACEC7DNxFnxNKPAUIXNdM4amWUNZF/zFxgrGd78PVjboajmZ/
         hjT0SOx4Qy3yJ+G/qKqOXxw9NrZS1NfgI0ZB8HZT5o4yJEux00oYivDk+2bg6oV7vQ
         ryD+8mKko7G9YTQf6bTTtefFLt4FU33NYVvJYLmo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230513143849epcas5p1160a31e4357afb4f105877cc68774fa4~eutPFsen_0713407134epcas5p1l;
        Sat, 13 May 2023 14:38:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QJStc1NCkz4x9Pq; Sat, 13 May
        2023 14:38:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.AA.54880.8F0AF546; Sat, 13 May 2023 23:38:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230513143847epcas5p1fe373b68084b786f3bf66809688bfc11~eutM5ulUs0954109541epcas5p1j;
        Sat, 13 May 2023 14:38:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230513143847epsmtrp2705b8592b87c5e1f134d52019d260968~eutM47CpC1515715157epsmtrp2F;
        Sat, 13 May 2023 14:38:47 +0000 (GMT)
X-AuditID: b6c32a49-8c5ff7000001d660-1f-645fa0f8fce7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.E7.27706.6F0AF546; Sat, 13 May 2023 23:38:46 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230513143845epsmtip159ced5ec90308a0a16bfbaaa453bf7ca~eutLFcAoy2977329773epsmtip1m;
        Sat, 13 May 2023 14:38:44 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-samsung-soc@vger.kernel.org>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        "'Liam Girdwood'" <lgirdwood@gmail.com>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Jaroslav Kysela'" <perex@perex.cz>,
        "'Takashi Iwai'" <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'Arnd Bergmann'" <arnd@arndb.de>,
        "'Olof Johansson'" <olof@lixom.net>, <p.rajanbabu@samsung.com>,
        =?ks_c_5601-1987?B?J8bHxKvB7ic=?= <pankaj.dubey@samsung.com>
In-Reply-To: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from
 Samsung audio
Date:   Sat, 13 May 2023 20:08:43 +0530
Message-ID: <000001d985a8$9fd3fb50$df7bf1f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8ulEntpu5hcXYUg5WkhbxdD/5AgFi1R7trwa9mgA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRT2vb29bdGSa8fcu+oMXq1kCJUy2l1wqGQLXsRkZDiNuqS70itl
        lLbphx/8mNsgY8AG6yZYKsroEEiHgZGOMBDE1sLAMLZRRJQ5iMxlQhlQBg4ws+1lhn/nPOc5
        5zzP+8HniG5gYn6O1sQYtLSGwMLQNvf27bH/nFOq4v4axEjvdRdC/numl0dWTE5hZNf0JR65
        5D2BkMMd1RhpHepGyIFRP0Z6LmaS9kuLPLK4o5xLumeKuGTL8nfgdSHV4j+GUasrZwB12XaT
        R7U6ijFq/JfvMcp75RiX6vbVY1SZ0wGoZucISvlbn80Iez93l5qhVYwhktFm6VQ52uxkIj1T
        uVspV8TJYmWJ5E4iUkvnMcnEnrcyYlNzNAHxROTHtMYcgDJoo5F4+dVdBp3ZxESqdUZTMsHo
        VRp9gl5qpPOMZm22VMuYkmRxcfHyAPFgrnrgzo+Yvn3zp5crurlHQFFECRDwIZ4A71nbeSUg
        jC/COwGsHZ1H2GQBwOHKexw2WQLQ03gfPGrxOR3rhS4Af7ANoWxyF8A/bG40yMLwWNh+/jgW
        LETgCwi8cHIltIWDNwDYVlrKDbIE+G442XYbC8ab8P3w64rOEI7iEni0cCaghM8X4omw98vP
        g7AQfxL2V02FFnDweFh3oQZh45dgfe00h5UXCR/crg+NicCT4K2vbgGWswXe9fwU0gDxGT4s
        rC7nBedDfA+03jezvZvg331OHhuLoX+2C2MpFLSviVlYDX0Nzesn8Rrs8VavywmHp1anEJYu
        hCeOi1iKBBbMjqBs/DS0rBsPTlwuWwanwXO2DcZsG4zZNhizbTBwDqAOsJXRG/OyGaNcL9My
        n/x/41m6vFYQetzRae3g5sSc1AUQPnAByOcQEcKiKqVKJFTRn+UzBp3SYNYwRheQB07bwhFv
        ztIFfofWpJQlJMYlKBSKhMQdChmxRRiV3J8lwrNpE5PLMHrG8KgP4QvERxCrmdvZpmwpifd/
        U25aWVjz2WVp+pNui22v2CP59osDSw9jriwKGlLmxgeZ9Cr6seQhWVFf4aqoKcaaMcrUjNmJ
        xbqnUrnPTz+wNka9sG+yqd+jvjZc+nPmNsfiwWcm7JqRox8SmoFDZW/HI8LDZx8XDzqubf01
        p1fgMDTVOA69mbIzP6aueAGmF0wsWAX1qa6rc5q+6MYhLyr5yP0buFo7fqe+cbpg5OGpsXdm
        pfuFZ/PfqN73waLkAGrRlT0hng+P6vndPYZdfPcVUY9c+l5aZR6Izi2aJHw7UuaT6tbU5/eO
        Xn9RHl4+dVhRss3x57jLYyloZSqbun1eZ7PkRgeBGtW0LJpjMNL/AegFLzxlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSnO63BfEpBieeW1pcuXiIyeLvpGPs
        FlMfPmGz2Pt6K7vFtysdTBaXd81hs5hxfh+Txanrn9ksjm4Mtli09Qu7ReeuflaLw2/aWS02
        fF/L6MDrseFzE5vH71+TGD12zrrL7rFpVSebx51re9g8rpxoYvXY93YZm0ffllWMHuu3XGXx
        +LxJLoArissmJTUnsyy1SN8ugStj7+8j7AVTBStOz1zG2MC4ha+LkZNDQsBE4u2WVcwgtpDA
        bkaJ7g9lEHFpiesbJ7BD2MISK/89B7K5gGqeM0ps33QOrIFNQFdix+I2NpCEiMAPJolVl7aA
        VTELrGSUuLn/BDNEyxRGibObrrCBtHAKOEs83PYUzBYWCJZ4c+YzmM0ioCrR2PKGqYuRg4NX
        wFLi2PR6kDCvgKDEyZlPWEBsZqBTGw93Q9naEssWvmaGOE9B4ufTZawgtoiAlcT92fcZIWrE
        JV4ePcI+gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+du
        YgRHr5bmDsbtqz7oHWJk4mA8xCjBwawkwts+Mz5FiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+F
        rpPxQgLpiSWp2ampBalFMFkmDk6pBqaEu7yzZRq5DtTwH7q6a9GdJZd2zFv/Ty834r53Uiff
        ztmLqx9WeXJ8Evs+r9ux82je2ugrzyafnJNru4shSnabZ2ccd9aJrTfC972qumL84eLV4+e+
        BikZ3dtw6/VS6aAXMh+m7D70Xm9resgsy8Ntn9c/7Pt3NvaF57dbW5Q4U62vnsia/KOZeTnP
        mUCW2zXJXWc0VnaK6ejOmFxsvi5hi/S1JTox7wXP/F3g/aLt/4Z9905Pq771QPt2Jb+ysr2e
        8hS3/R/S75xcK53HfKax34LZs1ponujJ9HN/zZ6/EXl9c1WwsHewWRPbpKJNIhrvvQ7JHOXh
        u6XSXOh18faXlc+Sz68MeL3a5W6ZUYP5KyWW4oxEQy3mouJEAIL3jIxNAwAA
X-CMS-MailID: 20230513143847epcas5p1fe373b68084b786f3bf66809688bfc11
X-Msg-Generator: CA
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230513090242epcas5p34625f5b6f0a180263e6607a38e0c996f
References: <CGME20230513090242epcas5p34625f5b6f0a180263e6607a38e0c996f@epcas5p3.samsung.com>
        <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Saturday, May 13, 2023 2:32 PM
> To: linux-samsung-soc=40vger.kernel.org; Sylwester Nawrocki
> <s.nawrocki=40samsung.com>; Liam Girdwood <lgirdwood=40gmail.com>;
> Mark Brown <broonie=40kernel.org>; Jaroslav Kysela <perex=40perex.cz>;
> Takashi Iwai <tiwai=40suse.com>; alsa-devel=40alsa-project.org; linux-
> kernel=40vger.kernel.org
> Cc: Alim Akhtar <alim.akhtar=40samsung.com>; Arnd Bergmann
> <arnd=40arndb.de>; Olof Johansson <olof=40lixom.net>; Krzysztof Kozlowski
> <krzysztof.kozlowski=40linaro.org>
> Subject: =5BPATCH=5D ASoC: MAINTAINERS: drop Krzysztof Kozlowski from
> Samsung audio
>=20
> Remove Krzysztof Kozlowski from maintainer of Samsung SoC Audio drivers
> and change the status to maintenance (no one is reality being paid for
> looking at this).
>=20
Thank you=21 For your over the year=A1=AFs=20contribution=20and=20support=
=20in=0D=0Amaintaining=20and=20enhancing=20Samsung=20SoC=20Audio=20driver.=
=20Your=20input=20always=20helps=0D=0Aand=20I=20hope=20that=20will=20contin=
ue=20in=20future=20as=20well.=0D=0AWhile=20at=20it,=20I=20know=20Padmanabhn=
a=20(CCed)=20was=20recently=20doing=20and=20is=20working=20on=0D=0AI2S=20dr=
iver=20and=20Audio=20codec=20driver=20upstreaming=20to=20add=20support=20fo=
r=20some=20of=0D=0Athe=20recent=20platforms.=20I=20will=20check=20with=20hi=
m=20if=20he=20has=20interest=20to=20take=20up=0D=0Athis.=0D=0AOnce=20again=
=20Thank=20you=21=0D=0A=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<=
krzysztof.kozlowski=40linaro.org>=0D=0A>=20---=0D=0AReviewed-by:=20Alim=20A=
khtar=20<alim.akhtar=40samsung.com>=0D=0A=0D=0A>=20=20MAINTAINERS=20=7C=203=
=20+--=0D=0A>=20=201=20file=20changed,=201=20insertion(+),=202=20deletions(=
-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/MAINTAINERS=20b/MAINTAINERS=0D=0A>=
=20index=20c7082004ac55..746ec43ff244=20100644=0D=0A>=20---=20a/MAINTAINERS=
=0D=0A>=20+++=20b/MAINTAINERS=0D=0A>=20=40=40=20-18581,10=20+18581,9=20=40=
=40=20F:=09Documentation/admin-=0D=0A>=20guide/LSM/SafeSetID.rst=0D=0A>=20=
=20F:=09security/safesetid/=0D=0A>=20=0D=0A>=20=20SAMSUNG=20AUDIO=20(ASoC)=
=20DRIVERS=0D=0A>=20-M:=09Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40li=
naro.org>=0D=0A>=20=20M:=09Sylwester=20Nawrocki=20<s.nawrocki=40samsung.com=
>=0D=0A>=20=20L:=09alsa-devel=40alsa-project.org=20(moderated=20for=20non-s=
ubscribers)=0D=0A>=20-S:=09Supported=0D=0A>=20+S:=09Maintained=0D=0A>=20=20=
B:=09mailto:linux-samsung-soc=40vger.kernel.org=0D=0A>=20=20F:=09Documentat=
ion/devicetree/bindings/sound/samsung*=0D=0A>=20=20F:=09sound/soc/samsung/=
=0D=0A>=20--=0D=0A>=202.34.1=0D=0A=0D=0A=0D=0A
