Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971016029C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJRLBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJRLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:01:41 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE90B5FDF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:01:34 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221018110129epoutp01c2be1f54980b73d116b11ccc83e3d4c2~fJNYo3eJS1357813578epoutp01I
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:01:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221018110129epoutp01c2be1f54980b73d116b11ccc83e3d4c2~fJNYo3eJS1357813578epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666090889;
        bh=k4vYvvGuuWfM3VOKoxhBAgCgz9idhglV/m3UVogcGcg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iMYWVWiwGYRu8Xaset6LzKa8oajGiV5eZ7Yxm9+9CI3e2/9zHt4/j/EmNgXtq78cR
         fatR3KTQvR2C5jMRMb+jCvZQ2LfzDh5wfSeBHYLK9VrPndIcSuatMmbDDF7ITB6iAx
         VmqWkAUZn+RUWnDWRlAA2vip/+2baZ7pEQmNNQrc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221018110128epcas5p10dbf5058053acc545c49e1ff8dcac98c~fJNXsr3vd1116011160epcas5p1T;
        Tue, 18 Oct 2022 11:01:28 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Ms9sK5wHJz4x9Pt; Tue, 18 Oct
        2022 11:01:25 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.3D.39477.5878E436; Tue, 18 Oct 2022 20:01:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221018104904epcas5p265c1716075593f6ae69bea4c842a87df~fJCis4ay11025610256epcas5p2F;
        Tue, 18 Oct 2022 10:49:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221018104904epsmtrp1ebf2132bbf0e0c93576efe3d105cf9f9~fJCiqzNRs1943319433epsmtrp1D;
        Tue, 18 Oct 2022 10:49:04 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-e9-634e8785460d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.6B.14392.0A48E436; Tue, 18 Oct 2022 19:49:04 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221018104900epsmtip1a157ace2e193ff79beb666c3f1dc5939~fJCfd9tk-2216622166epsmtip1k;
        Tue, 18 Oct 2022 10:49:00 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>
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
In-Reply-To: <166558064414.1937173.2124012536890566845.robh@kernel.org>
Subject: RE: [Patch v3 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Date:   Tue, 18 Oct 2022 16:18:59 +0530
Message-ID: <000501d8e2df$3d209700$b761c500$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIjXZOHgvokXGuofbg3rWbxTFZEMQGGfBLcASb/h3kBq/W9F61cN4wA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxjlvqwwA30iLReGQvpGRBlZogEvKG2dIn2IdRjbgnVoMSZvCJLN
        BGrRFnCBjiwVZ6hKWDWgAyIihEUMFkNsBKwbFIatotJCGBkZoCxqoQkJLf/O953v3HPPd+ey
        aY6FLFd2vDSRUkj5YoJpR29o2+jtk/7jHoH/wmsvNFzcwETq+VEMPVVP05Gurp6FNN0FNHTF
        0MpAJfoHDNR45zkd3RgzsY/zh+hotKQaIKPqDyaqfdHDQM/Go1FXcyETZdfUM9A1/RALlfc+
        xtDl2rcYulQ/w0LpLXoWWtI2sdCQtgGgUxl67GNIVhVXAbJpqAyQvWVTNPKmaohFqrVGjKyt
        PM0kB3u0TLKuLJVMv/uaTv6kqQTk4okiFpmp72WS07XuZMff06xIh/0J20UUX0gpOJRUIBPG
        S+NCiIjPYz+JDQj05/pwg9BWgiPlS6gQInR3pE9YvNi0BoLzLV+cZGpF8pVKwu/D7QpZUiLF
        EcmUiSEEJReK5Ty5r5IvUSZJ43ylVGIw199/c4Bp8ECC6PbAAiZf8Pyue3CSmQYecTKBLRvi
        PFjWdRxkAju2I34LwFcn5+mWYgrApYLTVmYWwPKCl2BF0p49x7QQLQDOGQcZlmIUwPsjnUzz
        FBP3g087shlm7IR7whOq4eVzabiKAetfVWFmwhb/FFZoHy4L1uJR8JR+fllANwmmO3NYmYDN
        tseDoCZrk7ltj6+B7fkjdDOm4R6wcaKQZrkRBy78ednqFQa72gzWGWd4dyGbZvaFeI8tHNTV
        WSOEwvtVhXQLXgvHDRqWBbtC45kMKxbAF5eMVgMxvK7Ns85/BFu7zVq2yWAjvN7sZ2m/D3/u
        qMYsvg4w580IZunbw6biFbweFg5aIkLcDbZdLQe5gFCtiqZaFU21KoLqf7dSQK8ELpRcKYmj
        lAHyzVLqyH8vLpBJasHyN/He1QSeDU/66gDGBjoA2TTCyT5sZrfA0V7ITz5KKWSxiiQxpdSB
        ANO6z9Jc3xXITP9MmhjL5QX58wIDA3lBWwK5hLO9+oK3wBGP4ydSCRQlpxQrOoxt65qGHZsz
        2OxM2YquTdyurnmvIGWdNxy7EZ1/ssT9g+/fhocZU7y8Ir6SYUW6Uc55jzPGm1ExhqKI7uiv
        ZcGaq/3P1QaRU+1vCcf6KmKSwyu++MxuIJZObEp1WXM0T7cr3WtvLnbafcNEzo69IlueRDIx
        kLXu9w2SRW9C/WCu5Zd+v8ONk6GHsuxaz5cKv9RoQn7dGfVNWkTz7LZz+/7ixxyctv2hVLIt
        NXzJI2X0YPv+8Ts2MFd42OaJds+iumawKnWccFyvOf5mdsrzHZ5/Hf4oriev88o95wNNxMMt
        wefa+MojtxxyczIW3eCh9AsXXe719buNVbREJl/8Z0j1JGNmx77ql31nCbpSxOd60xRK/r+e
        Pg8yrwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJTndBi1+ywb6PLBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLhq3CLy7vmsFn0bNjKarH2yF12i6XXLzJZLNv0h8li0dYv7Bate4+wW/zfs4Pd4u6e
        bYwWLW1HmBwkPNbMW8PosePuEkaP60s+MXvsnHWX3WPxnpdMHptWdbJ53Lm2h81j85J6j9aj
        v1g8+rasYvT41zSX3aPryHU2j8+b5DxOff3MHsAXxWWTkpqTWZZapG+XwJWx7/ZPpoKfqhVX
        7nxga2C8oNDFyMkhIWAicbLnO1sXIxeHkMBuRol/e6cwQiRkJP63HWOHsIUlVv57DmYLCTxl
        lJj0OBPEZhPQl7h/qocVxBYRUJVomvWABWQQs8AmVol3F+YyQkz9wyjxYP86sCpOAXeJlXvO
        A63j4BAWCJHY/a0OJMwC1Pz5dC87SJhXwFJiS7cOSJhXQFDi5MwnLCBhZgE9ibaNYKcxC8hL
        bH87hxniNAWJn0+XQZ3gJnH58HEWiBpxiaM/e5gnMArPQjJpFsKkWUgmzULSsYCRZRWjZGpB
        cW56brFhgWFearlecWJucWleul5yfu4mRnAi0dLcwbh91Qe9Q4xMHIyHGCU4mJVEeN2++CQL
        8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwGRUmcJm0hqo
        +TqvlvHN+70sVfLT/UozkvYG6Omt6z6wXtfYqoVBdImifRST0M5titreN63O5DiXXI1Y+239
        IufmwmyFG+9+GLoJxyff/H6hdxe/k56Es893Tkm78/frHk1s+iX2rd1i79KNPbo+3NMdLGVY
        T6xl/3bkj1mUqTKfzvqcQLlnNQ/tV1wK/fx1m3edUmCHzWSPAl2pySyBd9g7n79TW18n1iWp
        4yyqbrZ2zt/oVT7mrFo33518rv9kVW5Nc+HCZmmXzLc1ZTeaIhn+NBszvz760nDqHd9f9vVh
        Yf/zNCPyRJ8XzHT4fajJOa9y2idvvQ/hsvOue3+Xam2w43grw/F1Usb6R+ZKLMUZiYZazEXF
        iQCGAXqIkwMAAA==
X-CMS-MailID: 20221018104904epcas5p265c1716075593f6ae69bea4c842a87df
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
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: 12 October 2022 18:50
> To: aakarsh jain <aakarsh.jain@samsung.com>
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
> On Tue, 11 Oct 2022 17:55:02 +0530, aakarsh jain wrote:
> > From: Smitha T Murthy <smitha.t@samsung.com>
> >
> > Convert DT schema for s5p-mfc in yaml format
> >
> > Cc: linux-fsd@tesla.com
> > Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> > ---
> >  .../devicetree/bindings/media/s5p-mfc.txt     |  75 --------
> >  .../bindings/media/samsung,s5p-mfc.yaml       | 163
> ++++++++++++++++++
> >  2 files changed, 163 insertions(+), 75 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> >
> 
> Running 'make dtbs_check' with the schema in this patch gives the
following
> warnings. Consider if they are expected or the schema is incorrect. These
> may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here:
https://protect2.fireeye.com/v1/url?k=b651482e-
> e9ca7131-b650c361-000babdfecba-bb28230f82534754&q=1&e=25a7ee78-
> 697f-4371-880e-
> dcf4e3072c99&u=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F
> 
> 
> codec@13400000: clock-names: ['mfc', 'sclk_mfc'] is too long
> 	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
> 	arch/arm/boot/dts/exynos3250-monk.dtb
> 	arch/arm/boot/dts/exynos3250-rinato.dtb
> 
> codec@13400000: clocks: [[7, 178], [7, 228]] is too long
> 	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
> 	arch/arm/boot/dts/exynos3250-monk.dtb
> 	arch/arm/boot/dts/exynos3250-rinato.dtb
> 
> codec@13400000: iommus: [[36]] is too short
> 	arch/arm/boot/dts/exynos3250-monk.dtb
> 	arch/arm/boot/dts/exynos3250-monk.dtb
> 
> codec@13400000: iommus: [[40]] is too short
> 	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
> 	arch/arm/boot/dts/exynos3250-artik5-eval.dtb
> 
> codec@13400000: iommus: [[47]] is too short
> 	arch/arm/boot/dts/exynos3250-rinato.dtb
> 	arch/arm/boot/dts/exynos3250-rinato.dtb
> 
> codec@13400000: memory-region: [[31], [32]] is too long
> 	arch/arm/boot/dts/exynos4210-smdkv310.dtb
> 
> codec@13400000: memory-region: [[37], [38]] is too long
> 	arch/arm/boot/dts/exynos4210-origen.dtb
> 
> codec@13400000: memory-region: [[41], [42]] is too long
> 	arch/arm/boot/dts/exynos4412-smdk4412.dtb
> 
> codec@13400000: memory-region: [[43], [44]] is too long
> 	arch/arm/boot/dts/exynos4412-origen.dtb
> 
> codec@13400000: memory-region: [[47], [48]] is too long
> 	arch/arm/boot/dts/exynos4412-itop-elite.dtb
> 	arch/arm/boot/dts/exynos4412-odroidx2.dtb
> 	arch/arm/boot/dts/exynos4412-odroidx.dtb
> 
> codec@13400000: memory-region: [[48], [49]] is too long
> 	arch/arm/boot/dts/exynos4412-odroidu3.dtb
> 
> codec@f1700000: clock-names:0: 'mfc' was expected
> 	arch/arm/boot/dts/s5pv210-aquila.dtb
> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
> 	arch/arm/boot/dts/s5pv210-goni.dtb
> 	arch/arm/boot/dts/s5pv210-smdkc110.dtb
> 	arch/arm/boot/dts/s5pv210-smdkv210.dtb
> 	arch/arm/boot/dts/s5pv210-torbreck.dtb
> 
> codec@f1700000: clock-names:1: 'sclk_mfc' was expected
> 	arch/arm/boot/dts/s5pv210-aquila.dtb
> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
> 	arch/arm/boot/dts/s5pv210-galaxys.dtb
> 	arch/arm/boot/dts/s5pv210-goni.dtb
> 	arch/arm/boot/dts/s5pv210-smdkc110.dtb
> 	arch/arm/boot/dts/s5pv210-smdkv210.dtb
> 	arch/arm/boot/dts/s5pv210-torbreck.dtb
> 
> codec@f1700000: memory-region: [[51], [52]] is too long
> 	arch/arm/boot/dts/s5pv210-fascinate4g.dtb
> 
> codec@f1700000: memory-region: [[55], [56]] is too long
> 	arch/arm/boot/dts/s5pv210-galaxys.dtb



Hi Rob,

We tried reproducing warnings as reported above, but I am not able to see
these warnings after  running make dtbs_check & make DT_CHECKER_FLAGS=-m
dt_binding_check.
Packages used-
yamllint 1.10.0
$ dt-mk-schema --version
2022.9

Am I missing anything? Do let me know.


Thanks,
Aakarsh

