Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC12635346
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiKWIvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiKWIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:51:35 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A70153ECD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:51:33 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221123085130epoutp033e9109f4c6cac26fe6c3a236c5bb2a48~qKqK6zNtk2800428004epoutp03z
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221123085130epoutp033e9109f4c6cac26fe6c3a236c5bb2a48~qKqK6zNtk2800428004epoutp03z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669193490;
        bh=qev6UnzdGy1mmJcmsUfCNgx8+YskLF9J9jkltPhZKbo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XNLEFwzfD+naA+Y/kUYyUuLdVVR25X7XJ88SZtKl9Rp+fWsbX9S7dcR1gY75CiM+6
         kuuTJpAzDjHOuHPQ75INp8u6kSFm+uRQoxflqEwa3cmitacRkbIwMOQ9HhJBsPga0Y
         1gWG89hXPZ1nQ8ULOT00uvahFHzO6c4OI0a4nX6g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221123085129epcas5p1471c91f55ff3e5d700e9ab4eca23a229~qKqKYCdvZ2224622246epcas5p11;
        Wed, 23 Nov 2022 08:51:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NHFGk6wqyz4x9Q1; Wed, 23 Nov
        2022 08:51:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.8D.56352.E0FDD736; Wed, 23 Nov 2022 17:51:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221123084557epcas5p4d687cc32aad813e90144dfe12fc9d49c~qKlU3uCRX3110331103epcas5p4D;
        Wed, 23 Nov 2022 08:45:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123084557epsmtrp1c1291ecdbd7767cc63175826f528e811~qKlU2sx2d1438414384epsmtrp1E;
        Wed, 23 Nov 2022 08:45:57 +0000 (GMT)
X-AuditID: b6c32a4b-b8c77a800001dc20-23-637ddf0e2cfd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.4C.14392.5CDDD736; Wed, 23 Nov 2022 17:45:57 +0900 (KST)
Received: from FDSFTE460 (unknown [107.122.81.232]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123084555epsmtip18c1f09271609ae9da780e4e3abb6df74~qKlSxQKL81960619606epsmtip1J;
        Wed, 23 Nov 2022 08:45:55 +0000 (GMT)
From:   "Sathyakam M" <sathya@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>
Cc:     "'Kishon Vijay Abraham I'" <kishon@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Pankaj Kumar Dubey'" <pankaj.dubey@samsung.com>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        "'Aswani Reddy'" <aswani.reddy@samsung.com>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
        "'Ming Qian'" <ming.qian@nxp.com>,
        "'Jacopo Mondi'" <jacopo@jmondi.org>,
        "'Will Deacon'" <will@kernel.org>,
        "'Shawn Guo'" <shawnguo@kernel.org>,
        "'Marcel Ziswiler'" <marcel.ziswiler@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <5ebc0bb2-55a0-eba3-6391-27e190c68b4f@linaro.org>
Subject: RE: [PATCH 0/5] media: add FSD MIPI-CSI2 Rx controller driver
Date:   Wed, 23 Nov 2022 14:15:54 +0530
Message-ID: <00c201d8ff18$01257680$03706380$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHErhTxzKLn4Qgij71VY6BNmcGtGgHLRT2zAPpDKOauXoWp0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmpi7f/dpkg5e7TSwezNvGZrH4x3Mm
        i0Obt7JbXJx5l8Xi7vMWRoujrf+ZLfpePGS22PsaKLHp8TVWi8u75rBZND5exWSxa/oOdotF
        W7+wW7zYIm7RcsfUgd/j+pJPzB7/bzxi9ti0qpPN4861PWwem5fUe2x8t4PJo2/LKkaPTa88
        PD5vkvM49fUzewBXVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtAPSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL28
        1BIrQwMDI1OgwoTsjEXd65kL9spX3H/ymb2BcYlUFyMnh4SAicTuF4fZuhi5OIQEdjNK3F4x
        jx3C+cQocfndLajMN0aJhXcfMcG03F6yhhkisZdR4ufUp0wQzgtGiccLdzKCVLEJaEhcPtoI
        lODgEBGwkbh8IwWkhlngGYvE1j2zwSZxCthJXH98mQ3EFhZwk2hc3sEKYrMIqEosO7CeBcTm
        FbCUWLNoNZQtKHFy5hMwm1lAW2LZwtfMEBcpSPx8uowVIi4ucfRnD1hcRMBJYsrNbWCXSgi8
        4ZC4//UfO0SDi8T3s80sELawxKvjW6DiUhIv+9ug7GSJztkH2CDsDIljrw5D1dtLHLgyhwXk
        MWYBTYn1u/QhwrISU0+tY4K4gU+i9/cTaGjxSuyYB2MrSCzovQo1UkzidPcFtgmMSrOQvDYL
        yWuzkLwzC2HbAkaWVYySqQXFuempxaYFxnmp5fAYT87P3cQITuNa3jsYHz34oHeIkYmD8RCj
        BAezkghvvWdNshBvSmJlVWpRfnxRaU5q8SFGU2B4T2SWEk3OB2aSvJJ4QxNLAxMzMzMTS2Mz
        QyVx3sUztJKFBNITS1KzU1MLUotg+pg4OKUamILUBU8tr5le9NdGbL3nyXWOcv/uKSpNY9nZ
        tv6/wcM1i270a8Res593RmpR4M7/rnmmMnXz1Q/y2q0wcHzFsfd1roNkjO/r2AyH3ceCu7Un
        bU2YfzsxZGsY5+KemrehyREPT35qXuD36O0xnc7Vj5t47Rh9zty2vr3z4EKffuZJ/JbH9Xhi
        5nJP9RTN7vy931OFrUPnDsO3xMtuU/9Esiy+fGj3beXvNd5dmkIr7RwtluX3bZs+S5FXesb2
        mtqs/0r9DBnfDLynP8sWSl0T5869X6X55or3tc+qSl6u+XhpcqfhiSez0mbUyKrc8ZzDOfe2
        bET5pHOGldpfRF6oJi4Luqp+hvOq9f6fhheLcpRYijMSDbWYi4oTAR2L24xsBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO7Ru7XJBmeP81k8mLeNzWLxj+dM
        Foc2b2W3uDjzLovF3ectjBZHW/8zW/S9eMhssfc1UGLT42usFpd3zWGzaHy8isli1/Qd7BaL
        tn5ht3ixRdyi5Y6pA7/H9SWfmD3+33jE7LFpVSebx51re9g8Ni+p99j4bgeTR9+WVYwem155
        eHzeJOdx6utn9gCuKC6blNSczLLUIn27BK6Mb8vfMhecl6s4t+g9YwPjNskuRk4OCQETidtL
        1jB3MXJxCAnsZpSY/2svC0RCTGLDynvMELawxMp/z9khip4xStzubWECSbAJaEhcPtoIZHNw
        iAjYSFy+kQJSwyzwgUXi1LtuFoiGnYwS7W3b2UEaOAXsJK4/vswGYgsLuEk0Lu9gBbFZBFQl
        lh1YD7aZV8BSYs2i1VC2oMTJmU/AbGYBbYmnN5/C2csWvoa6TkHi59NlrBBxcYmjP3vA4iIC
        ThJTbm5jnsAoPAvJqFlIRs1CMmoWkvYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNz
        NzGCY1lLcwfj9lUf9A4xMnEwHmKU4GBWEuGt96xJFuJNSaysSi3Kjy8qzUktPsQozcGiJM57
        oetkvJBAemJJanZqakFqEUyWiYNTqoHp0udb125G+XwMLV1hm3OqS1Sueltpq45l4mLrf/d1
        Jp28tXZR/OUDRfOezlM7o9n5U2OtSfEMrycbvml2fNxYIFjTulSTM+TjtK/mapxc4XFfFBtf
        3T33Kq55oYlDariMWXGThNwN2QtvBaoKS0vLtj3vyGxrtQ9nyz7+qHWTMmf1D+kpgXM6mKY/
        nPyqMXqT5QSJk8L//KfvY/CSKgh9rG/vHKe85JzkrplWuVtEDzVbzQs9yGdgvvCM2BaBSPdN
        zKyL7Iq+zt0YLSH/+PqXzrfPz+b0nouwnCTImbiyoYi3rU05tet3QbXMo+/zkr8q233McV89
        IV1qymkGg5VJdrwaxgUMB92v6KWzvFBiKc5INNRiLipOBABuphlfVAMAAA==
X-CMS-MailID: 20221123084557epcas5p4d687cc32aad813e90144dfe12fc9d49c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f
References: <CGME20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f@epcas5p3.samsung.com>
        <cover.1668963790.git.sathya@samsung.com>
        <5ebc0bb2-55a0-eba3-6391-27e190c68b4f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
Thank you for taking your time to review the patches.

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 21 November 2022 15:01
> To: Sathyakam M <sathya=40samsung.com>
> Cc: Kishon Vijay Abraham I <kishon=40kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt=40linaro.org>; Pankaj Kumar Dubey
> <pankaj.dubey=40samsung.com>; Alim Akhtar <alim.akhtar=40samsung.com>;
> Aswani Reddy <aswani.reddy=40samsung.com>; Andi Shyti
> <andi=40etezian.org>; Hans Verkuil <hverkuil-cisco=40xs4all.nl>; Ming Qia=
n
> <ming.qian=40nxp.com>; Jacopo Mondi <jacopo=40jmondi.org>; Will Deacon
> <will=40kernel.org>; Shawn Guo <shawnguo=40kernel.org>; Marcel Ziswiler
> <marcel.ziswiler=40toradex.com>; linux-arm-kernel=40lists.infradead.org; =
linux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 0/5=5D media: add FSD MIPI-CSI2 Rx controller drive=
r
>=20
> On 20/11/2022 19:52, Sathyakam M wrote:
> > This patch series adds the V4L2 media driver for Tesla Full Self
> > Driving (FSD) SoC MIPI-CSI2 Rx controller.
> >
> > The controller is compliant to MIPI CSI2 v1.3 specification.
> > It receives images from camera sensors over the D-PHY interface.
> >
> > The D-PHY interface is compliant to MIPI D-PHY v1.2 specification. It
> > supports up to maximum of 4 data lanes.
> >
> > V4L2 user control is provided to set the desired number of data lanes.
> >
> > Maximum of up to 4 streams can be received simultaneously by one Rx
> > port. (Each streams identified by designated Virtual Channel
> > Identifier).
> >
> > The controller instances consist of port property describing the endpoi=
nts.
> > When combined with remote-endpoint property the driver instantiates
> > video device nodes using V4L2 async subdev methods.
> >
> > Streaming formats supported:
> > - YUV420
> > - RGB565, RGB666, RGB888
> > - RAW8, RAW10, RAW12
> > - JPEG
> >
> > The driver implementation is verified on FSD evaluation board.
> >
> > Thanks, Sathyakam
> >
> > Cc: Sathyakam M <sathya=40samsung.com>,Vinod Koul <vkoul=40kernel.org>
> > Cc: Kishon Vijay Abraham I <kishon=40kernel.org>,Rob Herring
> > <robh+dt=40kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt=40linaro.org>
> > Cc: Pankaj Kumar Dubey <pankaj.dubey=40samsung.com>,Mauro Carvalho
> > Chehab <mchehab=40kernel.org>
> > Cc: Alim Akhtar <alim.akhtar=40samsung.com>,Shashank Prashar
> > <s.prashar=40samsung.com>
> > Cc: Aswani Reddy <aswani.reddy=40samsung.com>,Chandrasekar R
> > <rcsekar=40samsung.com>
> > Cc: Andi Shyti <andi=40etezian.org>,Laurent Pinchart
> > <laurent.pinchart=40ideasonboard.com>
> > Cc: Hans Verkuil <hverkuil-cisco=40xs4all.nl>,Jernej Skrabec
> > <jernej.skrabec=40gmail.com>
> > Cc: Ming Qian <ming.qian=40nxp.com>,Dmitry Osipenko
> <digetx=40gmail.com>
> > Cc: Jacopo Mondi <jacopo=40jmondi.org>,Catalin Marinas
> > <catalin.marinas=40arm.com>
> > Cc: Will Deacon <will=40kernel.org>,Bjorn Andersson
> > <andersson=40kernel.org>
> > Cc: Shawn Guo <shawnguo=40kernel.org>,Arnd Bergmann
> <arnd=40arndb.de>
> > Cc: Marcel Ziswiler <marcel.ziswiler=40toradex.com>,Mark Brown
> > <broonie=40kernel.org>
> > Cc:
> > linux-arm-kernel=40lists.infradead.org,linux-phy=40lists.infradead.org,=
dev
> > icetree=40vger.kernel.org
> > Cc: linux-kernel=40vger.kernel.org,linux-media=40vger.kernel.org
> >
> > Sathyakam M (5):
> >   dt-bindings: phy: fsd: MIPI CSI2 Rx controller syscon node
> >   media: dt-bindings: fsd: MIPI CSI2 Rx controller device nodes
> >   arm64: dts: fsd: add device tree nodes for MIPI CSI2 Rx controller
> >   media: fsd: add MIPI CSI2 Rx controller driver
>=20
> I did not get your patch =234. Don't Cc selectively.
Sorry for that. There was problem with sending the bundled patch set. I see=
 that you got =22=5BPATCH 4/5=5D media: fsd: add MIPI CSI2 Rx controller dr=
iver=22.
I will address the comments for the same.
>=20
> Best regards,
> Krzysztof


