Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61079643FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbiLFJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiLFJbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:31:05 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ECC1DA68
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:31:02 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221206093101epoutp0338cbe153f5ee3240cd2240cd9b6256a9~uKlYs7YNk0908009080epoutp03_
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:31:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221206093101epoutp0338cbe153f5ee3240cd2240cd9b6256a9~uKlYs7YNk0908009080epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670319061;
        bh=HNO3iKv0tdeztCA+GhMEbWBRz9DiegBTAmYuUUAaPCQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Acs1j0b8Kr0OCqxmhuc525EN1lkjde0vzaV3bL0YdDyYni/ACv5s83RkBv6FniAuM
         tUlbEtL0cxOQZuTt0xL/CUGIX8TtdawAwCr8oFHRd2oqgAecgDAT8IsrBPVYgqj4EL
         Fg7/3nA8UJ/CwXR1bZdH0+iboWX9fgLtruQFsiNU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221206093100epcas5p11b3eee5d3e0bd68934d4fcae0c4a6fd3~uKlYSE0K12695226952epcas5p1Q;
        Tue,  6 Dec 2022 09:31:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NRFXL1mNRz4x9Py; Tue,  6 Dec
        2022 09:30:58 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.64.56352.1DB0F836; Tue,  6 Dec 2022 18:30:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221206090643epcas5p277d1a3c99a3ebc478341d5c794bc6b34~uKQLYQdWd0517805178epcas5p2W;
        Tue,  6 Dec 2022 09:06:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221206090643epsmtrp23fe8ea17cdd1868603468156caea9adc~uKQLXhyJB2940229402epsmtrp24;
        Tue,  6 Dec 2022 09:06:43 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-41-638f0bd104d6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.C5.14392.3260F836; Tue,  6 Dec 2022 18:06:43 +0900 (KST)
Received: from FDSFTE411 (unknown [107.122.81.184]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221206090642epsmtip227da82da167203708e6df857128ceb3d~uKQJ5TCPL3139431394epsmtip2Z;
        Tue,  6 Dec 2022 09:06:42 +0000 (GMT)
From:   "Ravi Patel" <ravi.patel@samsung.com>
To:     "'Sriranjani P'" <sriranjani.p@samsung.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <pankaj.dubey@samsung.com>,
        <sathya@samsung.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221129115531.102932-2-sriranjani.p@samsung.com>
Subject: RE: [PATCH v4 1/2] dt-bindings: soc: samsung: exynos-sysreg: Add
 tesla FSD sysreg compatibles
Date:   Tue, 6 Dec 2022 14:36:41 +0530
Message-ID: <000f01d90952$0f8df4b0$2ea9de10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLJnMxoNyT45a9R9PTdsX6iVXIE+wIe+S2iAhqr56msXZzrsA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmuu5F7v5kg9vruSwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXdonXvEXaLL0deM1rcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7IzjuyrKFjLW7H3yi32BsYfXF2MnBwSAiYSH9u3MXYxcnEICexm
        lLi76Sw7hPOJUWJV1wKozDdGiek3HrPDtOw/dAEqsZdR4uPm5VAtLxglvjfvZ+li5OBgE9CW
        uLLGECQuInCTUaL3zFU2kG5mgUKJY2c2gk3iFLCX2DF9BTOILSyQIdF2+iUTiM0ioCLx6uEU
        sBpeAUuJfWu3MUHYghInZz5hgZijLbFs4WtmiIsUJH4+XcYKYosIOEm8ungFape4xNGfPcwg
        R0gIrOSQuP6mkQWiwUVi9ZT/UM3CEq+Ob4F6TUri87u9bBB2vsTFOW1MEHaGRMepy4wQtr3E
        gStzwJ5kFtCUWL9LHyIsKzH11DomiL18Er2/n0C18krsmAdicwDZKhIzHpbCbDp05hPjBEal
        WUg+m4Xks1lIPpiFsGwBI8sqRsnUguLc9NRi0wLjvNRyeHwn5+duYgQnWS3vHYyPHnzQO8TI
        xMF4iFGCg1lJhPfFxt5kId6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwlmpwPTPN5JfGGJpYGJmZm
        ZiaWxmaGSuK8S6d0JAsJpCeWpGanphakFsH0MXFwSjUw6Qgf7WzPFBLTWpyb09WYqCtqGOi7
        N+/0Y0PFCs6YB7MuNvmx+B2pl+VwDkwULRJxPtJnzPZ3RebzT3t0V+41eeOTt/Btq3bHqoNV
        GmcdvQLrX2s+Zc13Vdu+1E0w8L0GN9d/ybv2+yx6pJbsWWznN9++clupdvYd3iLFZclv4sLc
        juUEiXjpvUoX/5P6K1Re2VH36UozqaDtLxe8NvVIdpD8NP27jEhDxK/niwUjZON95CQZoj/N
        fcDTaygln93BEKVa+WrTI62LDFzBhWxZvinN7ZZbOrVkZhZtPy8c43zi5+MNhQvvMx64uWPC
        vizJCeEvly1rmr58SmC6gmjJotXT5G6p+F5lqVD3V2Ipzkg01GIuKk4EAPuYFnA7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvK4yW3+ywfpvphYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu0br3CLvFlyOvGS1uv1nH6sDlsWlVJ5vHnWt7
        2Dw2L6n36NuyitHj8ya5ANYoLpuU1JzMstQifbsErox7V9pZC/7zVDzeW97AeIqri5GTQ0LA
        RGL/oQuMXYxcHEICuxklTn05xw6RkJL4s+UxC4QtLLHy33N2iKJnjBKP/29h7WLk4GAT0Ja4
        ssYQJC4i8JBR4sP1RWDNzALFEvu23GaGaDjMKLH86ySwBKeAvcSO6SuYQWxhgTSJ3ZO2gcVZ
        BFQkXj2cAmbzClhK7Fu7jQnCFpQ4OfMJC8RQbYmnN5/C2csWvmaGuE5B4ufTZawgtoiAk8Sr
        i1fYIGrEJY7+7GGewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYJjTUtzB+P2VR/0DjEycTAeYpTgYFYS4X2xsTdZiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqaU+T9uqO91N38bpqA8P3XZ1PZX+2pmK3g/
        ZaxcaHy8OldLRfltZ0Rw9NKVbxgdRafLKMrXmhyWPJNby8ufajHt1e4fR19muipNvXvy0X2f
        r+Zhrnu/rXe4c/rAy47CS8b9QlLOMuuiL/kfm33Ne6vUdP5nnQFC52+uF97s+4GVx/x6+vP2
        /1Py3sldMp/aEV9xI2L+nCmfrgs7nQ9mUt2uyaxWKrnrp4/0s8M6F/i2/JN/L+BXmDVr9qJt
        0jKKl3e7yV75LaTS/bD7gXn3FdZ8NsEsHzHxZZZhLNnrl3s3cUlvy9hSfrQ6pcx6n3vMlWc7
        bN6tM7/ioH116UvGjqNGj06az/OLurnM+8mD7e+VWIozEg21mIuKEwG8WW2mJAMAAA==
X-CMS-MailID: 20221206090643epcas5p277d1a3c99a3ebc478341d5c794bc6b34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b
References: <20221129115531.102932-1-sriranjani.p@samsung.com>
        <CGME20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b@epcas5p3.samsung.com>
        <20221129115531.102932-2-sriranjani.p@samsung.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
>Subject: =5BPATCH v4 1/2=5D dt-bindings: soc: samsung: exynos-sysreg: Add =
tesla
>FSD sysreg compatibles
>
>Add compatible for Tesla SYSREG controllers found on FSD SoC.
>
>Signed-off-by: Sriranjani P <sriranjani.p=40samsung.com>
>---
> .../bindings/soc/samsung/samsung,exynos-sysreg.yaml           =7C 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git
>a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>index e7c80dd73081..4954790eda6c 100644
>--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>=40=40 -19,6 +19,10 =40=40 properties:
>               - samsung,exynos5-sysreg
>               - samsung,exynos850-sysreg
>               - samsung,exynosautov9-sysreg
>+              - tesla,fsd-cam-sysreg
>+              - tesla,fsd-fsys0-sysreg
>+              - tesla,fsd-fsys1-sysreg
>+              - tesla,fsd-peric-sysreg
>           - const: syscon
>       - items:
>           - enum:
>--
>2.17.1

Reviewed-by: Ravi Patel <ravi.patel=40samsung.com>


