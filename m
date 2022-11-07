Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0476561F5F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKGO2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiKGO10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:26 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0CD1E72C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:21:24 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221107142123epoutp04442cf870d97787a190aef6f8379ea055~lU1oSLm641628616286epoutp04T
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:21:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221107142123epoutp04442cf870d97787a190aef6f8379ea055~lU1oSLm641628616286epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667830883;
        bh=GJPGR28YHzLW8aa+11D1L3daiZSgpHyWT54CiXQP0a0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=lBQxt8BIpyT45Jwg1blX2mWvsWzx5hkFCce68XiILqidCo8GysX5GHUpnV2po7JXP
         /8EiTeXmgu2zKdvDSRFrpvy+OSOn+pVaxoBkDdD+LUcKjuipDZL13eoMVJNQXyic8S
         iBu0wcHJ0WBeEfiu/2LknwRAXppKIWmNpnpjrP2c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221107142122epcas5p2c58404c8859ef86ae9ce9725f137d723~lU1nUdSMw1427014270epcas5p2h;
        Mon,  7 Nov 2022 14:21:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N5YLm0HYGz4x9Pv; Mon,  7 Nov
        2022 14:21:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.24.56352.F5419636; Mon,  7 Nov 2022 23:21:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221107123746epcas5p41165707efc8f199d341bcbcd308cd1e1~lTbKBbDJw2127721277epcas5p4K;
        Mon,  7 Nov 2022 12:37:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221107123746epsmtrp2b8de868dccbc7f7e7093c96ad3542b0f~lTbKAf5q82307523075epsmtrp2T;
        Mon,  7 Nov 2022 12:37:46 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-32-6369145f010a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.4C.14392.91CF8636; Mon,  7 Nov 2022 21:37:45 +0900 (KST)
Received: from FDSFTE196 (unknown [107.116.189.214]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221107123743epsmtip1eae7ecf77d881767d0f45f2c1faa5d2b~lTbH77Bmc1469414694epsmtip1N;
        Mon,  7 Nov 2022 12:37:43 +0000 (GMT)
From:   "Inbaraj E" <inbaraj.e@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <chanho61.park@samsung.com>,
        "'Sylwester Nawrocki'" <s.nawrocki@samsung.com>,
        <tomasz.figa@gmail.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>,
        "'ALIM AKHTAR'" <alim.akhtar@samsung.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
Cc:     <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "'PANKAJ KUMAR DUBEY'" <pankaj.dubey@samsung.com>
In-Reply-To: <0e929d35-2a90-94fb-49d6-7f6a0f0a3ed0@linaro.org>
Subject: RE: [PATCH] dt-bindings: clock: exynosautov9: fix reference to
 CMU_FSYS1 mmc card clock
Date:   Mon, 7 Nov 2022 18:07:42 +0530
Message-ID: <001201d8f2a5$bcb8e870$362ab950$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC1phSFSdu+vla0SFvWf4cJPX/nGQGqLtLGAhvc4qsBWKVYVQHZlEqXsEI86EA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFJsWRmVeSWpSXmKPExsWy7bCmlm68SGaywca/lhYP5m1js7i8X9vi
        +pfnrBbzj5xjtdj7eiu7xabH11gtPvbcY7W4vGsOm8WM8/uYLC6ecrVYtPULu0Xr3iPsFoff
        tLNa/Lu2kcVi1a4/jA78Hu9vtLJ77Jx1l91j06pONo871/aweWxeUu/Rt2UVo8fnTXIB7FHZ
        NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
        lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjM2
        fGljLWjmr5j3dC9bA+MZni5GTg4JAROJPzsWsHYxcnEICexmlFg+8zEbhPOJUeLPpzXsIFVC
        At8YJeYu5ofpOP7kKhNE0V5GidvbLjJDOC8ZJXa9amMDqWIT0JS4efQfI0hCROAok8Sct2dZ
        QBxmgceMEs0zuoA2cnBwCthJnDsgCtIgLJAkMeP4IyYQm0VARWL/xLdgNq+ApcTD59dYIGxB
        iZMzn4DZzALaEssWvmaGOElB4ufTZWAjRQT8JA5fToMoEZc4+rMH7DgJgTscEvd3vGOBqHeR
        aDjZwQ5hC0u8Or4FypaS+PxuLxuE7SOxf84vRgg7Q+LY9uWsELa9xIErc1hAdjEDPbl+lz5E
        WFZi6ql1TBB7+SR6fz9hgojzSuyYB2MrS8w8ch9qvKTEzss7WSYwKs1C8tksJJ/NQvLCLIRt
        CxhZVjFKphYU56anFpsWGOellsMjPDk/dxMjOFFree9gfPTgg94hRiYOxkOMEhzMSiK8N9zS
        koV4UxIrq1KL8uOLSnNSiw8xmgKDeyKzlGhyPjBX5JXEG5pYGpiYmZmZWBqbGSqJ8y6eoZUs
        JJCeWJKanZpakFoE08fEwSnVwLRot3/nCpvwJ6UHZGvnvLUJX+ZfcuD6I44flTeMfrVNavKw
        P2YqcbafteL4rUZOteuXQ5fJBCUsCOD24BQQXTg9S+76rZWtvdK7WL5kb/vFtP3ZbtW+jUov
        T6858qfGMer6yW7rr6GB4kYm617xfNQKztTI53/c7JOpd+vwKSW9OYzXBV7Ofeemwyi4rKbF
        /P3xrin3rO2vzy64cWte5UZZt4hjKbs78mQXTF28z8BPKK789dPShXOYte49bVw23XibkIlH
        1eJAjV+x1k07XFe9s1c8NLE+vfZ3b71S4bEiq7j8qVoO4gslkq3yKsJOBMfe6+cRqU5MtWV4
        dn2eVMHFzyddQx5Vfbu3zyTKVYmlOCPRUIu5qDgRAIqfntFdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsWy7bCSnK7kn4xkg9X/zC0ezNvGZnF5v7bF
        9S/PWS3mHznHarH39VZ2i02Pr7FafOy5x2pxedccNosZ5/cxWVw85WqxaOsXdovWvUfYLQ6/
        aWe1+HdtI4vFql1/GB34Pd7faGX32DnrLrvHplWdbB53ru1h89i8pN6jb8sqRo/Pm+QC2KO4
        bFJSczLLUov07RK4MmZtXsxUsJuv4lT3O8YGxg6eLkZODgkBE4njT64ydTFycQgJ7GaUOLjq
        HjtEQlJi9u/pULawxMp/z9khip4zSixd8JMRJMEmoClx8+g/RpCEiMBZJom/GxrARjGDVC1/
        fIINomUZk0RTbzdrFyMHB6eAncS5A6Ig3cICCRJ9+yYyg9gsAioS+ye+ZQKxeQUsJR4+v8YC
        YQtKnJz5BMxmFtCWeHrzKZy9bOFrZojzFCR+Pl0GNl5EwE/i8OU0iBJxiaM/e5gnMArPQjJp
        FpJJs5BMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOB41dLcwbh91Qe9
        Q4xMHIyHGCU4mJVEeG+4pSUL8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwNSU7iOZOrWnd8YTztK2Gz1z59w8Y382N3bL31aL9NOvdoQm894+tmh/WNN0
        rRMPl/0+YqVz8+Pc9pcvLrl8Ul+YwRwdvmvSl22nN9iLrZDmvqe210PL8Wt1bgCrY8eK8Jky
        Yis4q7tPuH46X8nb4y+4MfLsydD+QvHVX2b8XemzKvz0kWAt8cqY97ZCi5fFCUSlcR0pffzd
        qzLxn9vDk60ef5y/F3scO29UEX3uyX3HzcrTpnwIaXlZl95meM47oX/vo23Hj5b0bsjSE4ye
        t3pVqdYjn4qgrU6L9P8+ehx3X6vklnJa/nnbhcFRVWf//Az3Vil/pXE57abd5Gsa38WSMxeG
        n8+onXrjbf/FE2pKLMUZiYZazEXFiQDUdp06RgMAAA==
X-CMS-MailID: 20221107123746epcas5p41165707efc8f199d341bcbcd308cd1e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221104085410epcas5p24d88f59001b739075e9e190e2c47841e
References: <8f026f38-ef09-788e-7bd8-45683b074075@linaro.org>
        <20221104090019.88387-1-inbaraj.e@samsung.com>
        <CGME20221104085410epcas5p24d88f59001b739075e9e190e2c47841e@epcms2p3>
        <20221107000401epcms2p3eeeecbfb2b1cdfb30dcee99bbb48780c@epcms2p3>
        <0e929d35-2a90-94fb-49d6-7f6a0f0a3ed0@linaro.org>
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
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 07 November 2022 14:42
> To: chanho61.park=40samsung.com; Inbaraj E <inbaraj.e=40samsung.com>;
> Sylwester Nawrocki <s.nawrocki=40samsung.com>; tomasz.figa=40gmail.com;
> Chanwoo Choi <cw00.choi=40samsung.com>; ALIM AKHTAR
> <alim.akhtar=40samsung.com>; mturquette=40baylibre.com;
> sboyd=40kernel.org; robh+dt=40kernel.org
> Cc: linux-samsung-soc=40vger.kernel.org; linux-clk=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> kernel=40vger.kernel.org; PANKAJ KUMAR DUBEY
> <pankaj.dubey=40samsung.com>
> Subject: Re: =5BPATCH=5D dt-bindings: clock: exynosautov9: fix reference =
to
> CMU_FSYS1 mmc card clock
>=20
> On 07/11/2022 01:04, CHANHO PARK wrote:
> >>> Fix reference to CMU_FSYS1 mmc card clock to gout clock instead of
> dout.
> >>>
> >>> This fixes make dtbs_check warning as shown below:
> >>>
> >>> arch/arm64/boot/dts/exynos/exynosautov9-sadk.dtb: clock-
> >> controller=4017040000:
> >>> clock-names:2: 'dout_clkcmu_fsys1_mmc_card' was expected From
> schema:
> >>> /home/inbaraj/mainline/linux/Documentation/devicetree/
> >>> bindings/clock/samsung,exynosautov9-clock.yaml
> >>
> >> I don't understand:
> >> 1. Why bindings are wrong not DTSI?
> >> 2. What is =22gout=22? =22dout=22 had a meaning as clock divider outpu=
t.
> >
> > =22gout=22 is output of a gate clock, AFAIK.
> > Unlike any other clocks, the fsys1 mmc top clock does not have a divide=
r.
> So, it should be =22mout -> gout=22 instead of =22mout -> gout -> dout=22=
.
>=20
> OK, then this should be in commit msg.
>=20
> My question about full legal name remains, as here in replies I see =22In=
baraj
> E=22.
>=20

I have address your review comment, and posted v2.=20
Thanks for review.

> Best regards,
> Krzysztof


