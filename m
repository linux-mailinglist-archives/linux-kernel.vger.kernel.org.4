Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0648643FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiLFJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiLFJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:31:17 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7CF1F9D5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:31:09 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221206093108epoutp02dd0e9065906540295103bdfd1b6fc671~uKlfK3XHh3219632196epoutp02j
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221206093108epoutp02dd0e9065906540295103bdfd1b6fc671~uKlfK3XHh3219632196epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670319068;
        bh=JZXQx+IsTmTwNlYjn0Q0pBoHGpl7jVav9aBC81tQrFY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Z3pHOBtt8KtYTOuMJbCdy/SI5DmSBxm42uV4XGee5ypNRP69C/OjPzd3apptx3jHe
         PXZYYqdWxFJS9+0C/GTYDrXvwA+14tr0KLmQLf9YpDRe0SEAsesbRoP9vSIy3GADKI
         joymrqDQxRJj/llwM8GDxVFzLzpx+ObhrKx4u4QQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221206093107epcas5p21abeaf6ad2ab5b6476a2a9486ecc1e48~uKlekFpi40348903489epcas5p2n;
        Tue,  6 Dec 2022 09:31:07 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NRFXV0T8vz4x9Q3; Tue,  6 Dec
        2022 09:31:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.74.56352.8DB0F836; Tue,  6 Dec 2022 18:31:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221206090723epcas5p447daee3deb05ef72fac0befc9cc80aeb~uKQv8C7fy0247502475epcas5p4C;
        Tue,  6 Dec 2022 09:07:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221206090723epsmtrp1a97cc362b01d889309f0d65882dd8f5b~uKQv7SJiZ1765517655epsmtrp1D;
        Tue,  6 Dec 2022 09:07:23 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-57-638f0bd85b31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.C0.18644.B460F836; Tue,  6 Dec 2022 18:07:23 +0900 (KST)
Received: from FDSFTE411 (unknown [107.122.81.184]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221206090721epsmtip16743d02d357e15dbfa820c65d0a3954a~uKQue64Se0566105661epsmtip1V;
        Tue,  6 Dec 2022 09:07:21 +0000 (GMT)
From:   "Ravi Patel" <ravi.patel@samsung.com>
To:     "'Sriranjani P'" <sriranjani.p@samsung.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <sathya@samsung.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221129115531.102932-3-sriranjani.p@samsung.com>
Subject: RE: [PATCH v4 2/2] arm64: dts: fsd: add sysreg device node
Date:   Tue, 6 Dec 2022 14:37:20 +0530
Message-ID: <001001d90952$26faa8f0$74effad0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLJnMxoNyT45a9R9PTdsX6iVXIE+wFDZibaATEvXGSsa8XgAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmpu4N7v5kgw8f5S0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXdonXvEXaLL0deM1rcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7Izpl1cyFKwQKzi8Z+vbA2ML4W6GDk5JARMJE58+cDUxcjFISSw
        m1Hi7ITnbCAJIYFPjBL7DoZCJD4zSsz/sJsZpmPj1E/sEIldjBKPbuxmhHBeMEr83rOUpYuR
        g4NNQFviyhpDkLiIwE1Gid4zV8HGMgsUShw7s5EdxOYUsJc4s/gpE4gtLOAs8WDXMkYQm0VA
        RWL7+Q1gNq+ApcT25kssELagxMmZT1gg5mhLLFv4GuoiBYmfT5exgtgiAk4Sl57fZYaoEZc4
        +rOHGeQICYGVHBIdS+4xQjS4SDxbeB7KFpZ4dXwLO4QtJfGyvw3Kzpe4OKeNCcLOkOg4dRmq
        3l7iwJU5YE8yC2hKrN+lDxGWlZh6ah0TxF4+id7fT6BaeSV2zAOxOYBsFYkZD0thNh0684lx
        AqPSLCSfzULy2SwkH8xCWLaAkWUVo2RqQXFuemqxaYFxXmo5PL6T83M3MYKTrJb3DsZHDz7o
        HWJk4mA8xCjBwawkwvtiY2+yEG9KYmVValF+fFFpTmrxIUZTYHBPZJYSTc4Hpvm8knhDE0sD
        EzMzMxNLYzNDJXHepVM6koUE0hNLUrNTUwtSi2D6mDg4pRqYREPCxd43svQqqu54Ws7N9nJF
        LYfiCrHrQtUrHx8qUnfbZi9bLRIw8V+Qw6zqrrx1q6KULNztnhkW7eo5+ff7FLVv6549yT/D
        tym87VfVVFNrv8WbXa6pbonN0+b+0Td7arnmtB3THCfkCEYLv3csnvtjcq3yCh65E41VbVaX
        TW1r8lddbvt9xH5Bgf/VBZpsOSXfb2ReT14der56fwx77tytTz0C9ZZPvmt+4Kr0n03XzF8E
        7c+0Uz998udmLumdbovjU0zvK9ueutv7J9SkvqEieOtzjef3DK7umnGRQ/X8QufDHKfY5t9O
        3anouWlPyd8PW+1mrWtb0Zu1x8009OjETUonduq/nrpk9Zs6XyWW4oxEQy3mouJEAOncGlY7
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnK43W3+ywZJdXBYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu0br3CLvFlyOvGS1uv1nH6sDlsWlVJ5vHnWt7
        2Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsEroxDt7azFjwSqfh6Zh5jA+NqwS5GTg4J
        AROJjVM/sXcxcnEICexglFg8dzEzREJK4s+WxywQtrDEyn/PoYqeMUpc3fAIqIiDg01AW+LK
        GkOQuIjAQ0aJD9cXsYM0MAsUS+zbcpsZouEwo8S5rrlMIAlOAXuJM4ufgtnCAs4SD3YtYwSx
        WQRUJLaf3wBm8wpYSmxvvsQCYQtKnJz5hAViqLbE05tP4exlC19DXaog8fPpMlYQW0TASeLS
        87vMEDXiEkd/9jBPYBSehWTULCSjZiEZNQtJywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV5
        6XrJ+bmbGMHRpqW1g3HPqg96hxiZOBgPMUpwMCuJ8L7Y2JssxJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9Nsh/UtV2KD2PYHSRlHfdbytpSoKr2TkD/v
        56Hztgu8RBgym+I3WTibbM1ax1gxQ/tN65SA8wvZrhhf57hkdGv96lV2s/PDrz/WC2+tZDWI
        qeZa/fLkMc8H4lXx6XprlTQKpmeELd1068UnQaNt/Iuu6eY+bWi1c6/ouye6+MoB1g/V//Lt
        vlTFfJFJuWG3Tf2U1NrlfVy/X3RZ6XHevH/5agGrzfXNDXwTqw8YZb4VerD5Vw/XBt2Nj5Z5
        974M49ew2NZxO/aVa8Lf6rDHG5+3HLm8fP09zzcHpm169WSe5PWXBivLiznWOIqvjKqyyT+n
        4fDcZ13Qse6a80rGh7K4nBmqMj5P3yb/fdJx77tKLMUZiYZazEXFiQAs/bOCJQMAAA==
X-CMS-MailID: 20221206090723epcas5p447daee3deb05ef72fac0befc9cc80aeb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c
References: <20221129115531.102932-1-sriranjani.p@samsung.com>
        <CGME20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c@epcas5p3.samsung.com>
        <20221129115531.102932-3-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Sriranjani P =5Bmailto:sriranjani.p=40samsung.com=5D
>Sent: 29 November 2022 17:26
>To: robh+dt=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
>devicetree=40vger.kernel.org; alim.akhtar=40samsung.com;
>pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
>sathya=40samsung.com
>Cc: linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org=
; linux-
>samsung-soc=40vger.kernel.org; Sriranjani P <sriranjani.p=40samsung.com>
>Subject: =5BPATCH v4 2/2=5D arm64: dts: fsd: add sysreg device node
>
>Add SYSREG controller device node, which is available in PERIC, FSYS0,
>FSYS1 and CAM block of FSD SoC.
>
>Signed-off-by: Alim Akhtar <alim.akhtar=40samsung.com>
>Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
>Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
>---
> arch/arm64/boot/dts/tesla/fsd.dtsi =7C 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
>b/arch/arm64/boot/dts/tesla/fsd.dtsi
>index f35bc5a288c2..ff625fb71fbe 100644
>--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
>+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
>=40=40 -466,6 +466,11 =40=40
> 			clock-names =3D =22fin_pll=22;
> 		=7D;
>
>+		sysreg_cam: system-controller=4012630000 =7B
>+			compatible =3D =22tesla,fsd-cam-sysreg=22, =22syscon=22;
>+			reg =3D <0x0 0x12630000 0x0 0x500>;
>+		=7D;
>+
> 		clock_mfc: clock-controller=4012810000 =7B
> 			compatible =3D =22tesla,fsd-clock-mfc=22;
> 			reg =3D <0x0 0x12810000 0x0 0x3000>;
>=40=40 -492,6 +497,11 =40=40
> 				=22dout_cmu_peric_shared1div4_dmaclk=22;
> 		=7D;
>
>+		sysreg_peric: system-controller=4014030000 =7B
>+			compatible =3D =22tesla,fsd-peric-sysreg=22, =22syscon=22;
>+			reg =3D <0x0 0x14030000 0x0 0x1000>;
>+		=7D;
>+
> 		clock_fsys0: clock-controller=4015010000 =7B
> 			compatible =3D =22tesla,fsd-clock-fsys0=22;
> 			reg =3D <0x0 0x15010000 0x0 0x3000>;
>=40=40 -506,6 +516,11 =40=40
> 				=22dout_cmu_fsys0_shared0div4=22;
> 		=7D;
>
>+		sysreg_fsys0: system-controller=4015030000 =7B
>+			compatible =3D =22tesla,fsd-fsys0-sysreg=22, =22syscon=22;
>+			reg =3D <0x0 0x15030000 0x0 0x1000>;
>+		=7D;
>+
> 		clock_fsys1: clock-controller=4016810000 =7B
> 			compatible =3D =22tesla,fsd-clock-fsys1=22;
> 			reg =3D <0x0 0x16810000 0x0 0x3000>;
>=40=40 -518,6 +533,11 =40=40
> 				=22dout_cmu_fsys1_shared0div4=22;
> 		=7D;
>
>+		sysreg_fsys1: system-controller=4016830000 =7B
>+			compatible =3D =22tesla,fsd-fsys1-sysreg=22, =22syscon=22;
>+			reg =3D <0x0 0x16830000 0x0 0x1000>;
>+		=7D;
>+
> 		mdma0: dma-controller=4010100000 =7B
> 			compatible =3D =22arm,pl330=22, =22arm,primecell=22;
> 			reg =3D <0x0 0x10100000 0x0 0x1000>;
>--
>2.17.1

Reviewed-by: Ravi Patel <ravi.patel=40samsung.com>


