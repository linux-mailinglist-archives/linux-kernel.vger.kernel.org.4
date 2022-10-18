Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4781602D71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJRNxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJRNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:03 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197ACF856
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:53:01 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221018135257epoutp036d48a0fe6f0a85f86730bdca1405c88c~fLjGU3sWe1642916429epoutp037
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 13:52:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221018135257epoutp036d48a0fe6f0a85f86730bdca1405c88c~fLjGU3sWe1642916429epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666101177;
        bh=5BJ+aEKVpMuiW5mv8B/nlmP+efBLO3FdnUVno/0wS0s=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DbzisJz01G1/wGXPF2gPJR/ZuArKB0DimJfoUiTr2LwkLoS4uSSD77V6LyKQf8a+e
         ZnDG+p1Ns4U4074r19tHakoaM3zjR/jyGUcGz5NZy/KWxAgRTwkvE4EQ2HmtibEJHU
         S7skZj055qtMjbe8z1/fb64eQB9jskWVTluaEpRc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221018135256epcas5p465c21355e9a22f9c7bf05a78ca6698d7~fLjFl2Rli1998519985epcas5p4Z;
        Tue, 18 Oct 2022 13:52:56 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MsFgB4JCsz4x9Pt; Tue, 18 Oct
        2022 13:52:54 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.80.56352.6BFAE436; Tue, 18 Oct 2022 22:52:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221018132159epcas5p24b856ad2c1aa9e10f2b0f18505d27f2e~fLIEDbQeW1111711117epcas5p2J;
        Tue, 18 Oct 2022 13:21:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221018132159epsmtrp2ae6b99bccb78e512cd005665aa5935c2~fLIECHZYP2061920619epsmtrp2k;
        Tue, 18 Oct 2022 13:21:59 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-7d-634eafb6a5dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.3A.18644.778AE436; Tue, 18 Oct 2022 22:21:59 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221018132156epsmtip2460f70dc805400ebf48c155e4d6d2dd7~fLIAkqsCu0556505565epsmtip2j;
        Tue, 18 Oct 2022 13:21:55 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Rob Herring'" <robh@kernel.org>
Cc:     <linux-fsd@tesla.com>, <linux-media@vger.kernel.org>,
        <pankaj.dubey@samsung.com>, <linux-arm-kernel@lists.infradead.org>,
        <dillon.minfei@gmail.com>, <devicetree@vger.kernel.org>,
        <krzk+dt@kernel.org>, <smitha.t@samsung.com>,
        <benjamin.gaignard@collabora.com>, <stanimir.varbanov@linaro.org>,
        <jernej.skrabec@gmail.com>, <robh+dt@kernel.org>,
        <aswani.reddy@samsung.com>, <mchehab@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <mark.rutland@arm.com>,
        <m.szyprowski@samsung.com>, <linux-kernel@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <andi@etezian.org>,
        <andrzej.hajda@intel.com>, <ezequiel@vanguardiasur.com.ar>,
        <david.plowman@raspberrypi.com>
In-Reply-To: <1b079ee2-d406-507c-77f9-a228d337ad71@kernel.org>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Tue, 18 Oct 2022 18:51:53 +0530
Message-ID: <009301d8e2f4$9a2cbb30$ce863190$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3kBq/W9FwFzDpXTAgbDwbWtQJN84A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxzNfX3tKy7FJ2i81iFNF0YgKbSD1osDRIb4NnAhbjJdSGotL4CU
        tmvBj2UqmTgDMphmGqhdnbQyZFVYgfIxjIAlBBwaNwJjUGGggxJgypcwNlxLy8Z/557fOTk5
        v5sfm+FjILjsDGU2rVHKFHzWBtx6PyhQYK16Xy7sfslFwwYrCxkXxzA0ZJzFUVtNHYFqe64x
        0HcdLUx03faQiepbR3D0w7hz+rjUjqOx63cAcuiesNCjR9UEsoz2MtHvEx+hX5r0LFRYXcdE
        t212At3se4yhcsvfGCqrmyPQ+bs2Ar1qbiCQvdkKUN4XNixmG2U2mAHVYDcBqs80w6AadXaC
        MjY7MMpSmc+iBnubWVSN6Sx1vv0vnCqqrQTUyuffEFSBrY9FzVp2UF3zs0SS98eZkem0LJXW
        8GilXJWaoUyL4id8IH1HKpYIRQJRBNrJ5yllWXQUPy4xSRCfoXDugs87LlPkOKkkmVbLD42O
        1KhysmleukqbHcWn1akKdbg6RCvL0uYo00KUdPYukVD4ltgpPJKZPl5fhKsdG0+2XsVzQRun
        ALDZkAyH7Q17C8AGtg/5I4APLrUy3Y8ZAMcWij2PWQA7cy/gaw57HbcAeDn5JgArKj9xa8YA
        tC7mY64BiwyFQ12FTBfeTB6AVqsZd4kYpI4J6/40r4q8yGg4010OXNiXTIZ5tsVVA04GwKLn
        3asaDhkB8xobGG68CXaWPsVdmEH6w/op/SoPSR5celbuCUuGRQP3MLdmK2xfKmS4giH5xAvq
        z/XibkMcdBgLPNgXTnTUEm7MhbPTd1luLIejZQ5PgAJWNX/t0e+GLT361U0wyCBY1RTqpv3g
        la47nlxv+OXyU8zNc2CDYQ2/CfWD7o6QfB3e//4m+Arwdeuq6dZV062roPs/7VuAV4JttFqb
        lUZrxeowJX3iv++Wq7IsYPVQghMawMjw85A2gLFBG4BsBn8zJ34uUe7DSZWd+pTWqKSaHAWt
        bQNi574vMbhb5CrnpSmzpaLwCGG4RCIJjwiTiPhbOcaSYLkPmSbLpjNpWk1r1nwY24ubi+3h
        6PadVvMS4omRaZNvzfx0ymfGMz8drGpJ7I88MBR6eU91Z+fF1/KnK0cv+wtE2+ULSftPPbt4
        zO+Wd+8/AvVZw8D2yUNNR4p1hv7df+wrxH15g5HFEzdKTuplL+OKFpqCEjNi6lOSYo0B4jK/
        1ui3582m0kMt1xqj/VnE0Qcv9g8bQjDpwIevWqorTPNY/wnFxpKUyMM7lnkrk2cu1D+cDNyr
        9I8N9Dl8Oujqz3sripnvgtLy9473tLN157ZEpwZ6DSft7CrHWQkdFpng4NGJMLEkluDM/xog
        vZX8RiuauiIWHtu08ht7fOL2yBSmVMU6Vsw36OXcpRe75uJ97i3QMXxcmy4TBTM0Wtm/NCz0
        jLEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdlhJXrd8hV+ywZql6hYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVmc
        P7+B3WLT42usFg9fhVtc3jWHzaJnw1ZWi7VH7rJbLL1+kcli2aY/TBaLtn5ht2jde4Td4v+e
        HewWd/dsY7RoaTvC5CDpsWbeGkaPHXeXMHpcX/KJ2WPnrLvsHov3vGTy2LSqk83jzrU9bB6b
        l9R7tB79xeLRt2UVo8e/prnsHl1HrrN5fN4k53Hq62f2AL4oLpuU1JzMstQifbsErowX2/tY
        Cl7yVxycxtLAeIi3i5GDQ0LAROLuVqkuRi4OIYEdjBITV19k7mLkBIrLSPxvO8YOYQtLrPz3
        HMwWEnjKKLF9hjaIzSagL3H/VA8riC0iECSx7f8jVpBBzAKbWCXeXZjLCDH1DpPExb3X2ECq
        OAXsJD6dXcYIsllYIERi97c6kDCLgKpE34ezTCA2r4ClRMvOHcwQtqDEyZlPWEBsZgFtiac3
        n0LZ8hLb386BOlRB4ufTZVBHhEn03d7PBFEjLnH0Zw/zBEbhWUhGzUIyahaSUbOQtCxgZFnF
        KJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iRGcVLS0djDuWfVB7xAjEwfjIUYJDmYlEV63
        Lz7JQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDNvvT8
        yYytppLW4ea3I8NNhBzSLc2sGySaJJ4nfmNQPjc5oO3NA+++d7u3WB9051/VtG5y/XzFvg8P
        rPLTRB/cyDPrFC+5oCS/5OX9/2naMTNFs+bfsZjgv/vc2jOPP5xz3bJlTxTj08alBxp/eJxY
        ezhftNs/hK9gzf69XXlL2gO03GVrNq47/ElwvnhXwoMF2SsvJt6u6XIVd1ZcF/ozufL/q4Db
        6vU3+I5UvX3q236PN1i26pf9mjudte9rda8pXqwz+i1neXHRdDu1SSv2MqoHZ4QdTepTfpx/
        YcdaB581B8JX7rlysuCs8WEpKY06kd/1874zPdR1b245Hrlr+eHLb2zWq5lf7Nl6eu1SJZbi
        jERDLeai4kQAS32PS5kDAAA=
X-CMS-MailID: 20221018132159epcas5p24b856ad2c1aa9e10f2b0f18505d27f2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125142epcas5p13c858a5f27830fb1de50fa51e9730eca@epcas5p1.samsung.com>
        <20221011122516.32135-2-aakarsh.jain@samsung.com>
        <166558064414.1937173.2124012536890566845.robh@kernel.org>
        <000501d8e2df$3d209700$b761c500$@samsung.com>
        <1b079ee2-d406-507c-77f9-a228d337ad71@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski [mailto:krzk@kernel.org]
> Sent: 18 October 2022 18:40
> To: Aakarsh Jain <aakarsh.jain@samsung.com>; 'Rob Herring'
> <robh@kernel.org>
> Cc: linux-fsd@tesla.com; linux-media@vger.kernel.org;
> pankaj.dubey@samsung.com; linux-arm-kernel@lists.infradead.org;
> dillon.minfei@gmail.com; devicetree@vger.kernel.org; krzk+dt@kernel.org;
> smitha.t@samsung.com; benjamin.gaignard@collabora.com;
> stanimir.varbanov@linaro.org; jernej.skrabec@gmail.com;
> robh+dt@kernel.org; aswani.reddy@samsung.com; mchehab@kernel.org;
> hverkuil-cisco@xs4all.nl; mark.rutland@arm.com;
> m.szyprowski@samsung.com; linux-kernel@vger.kernel.org;
> alim.akhtar@samsung.com; andi@etezian.org; andrzej.hajda@intel.com;
> ezequiel@vanguardiasur.com.ar; david.plowman@raspberrypi.com
> Subject: Re: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT
> schema for MFC
> 
> On 18/10/2022 06:48, Aakarsh Jain wrote:
> >>
> >> codec@f1700000: clock-names:1: 'sclk_mfc' was expected
> >> 	arch/arm/boot/dts/s5pv210-aquila.dtb
> >> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
> >> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
> >> 	arch/arm/boot/dts/s5pv210-goni.dtb
> >> 	arch/arm/boot/dts/s5pv210-smdkc110.dtb
> >> 	arch/arm/boot/dts/s5pv210-smdkv210.dtb
> >> 	arch/arm/boot/dts/s5pv210-torbreck.dtb
> >>
> >> codec@f1700000: memory-region: [[51], [52]] is too long
> >> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
> >>
> >> codec@f1700000: memory-region: [[55], [56]] is too long
> >> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
> >
> >
> >
> > Hi Rob,
> >
> > We tried reproducing warnings as reported above, but I am not able to
> > see these warnings after  running make dtbs_check & make
> > DT_CHECKER_FLAGS=-m dt_binding_check.
> > Packages used-
> > yamllint 1.10.0
> > $ dt-mk-schema --version
> > 2022.9
> 
> 
> Are you sure you are running these commands on proper config and arch?
> 
yes. arm64/defconfig .

> Best regards,
> Krzysztof


