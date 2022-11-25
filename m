Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54943638785
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKYK3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKYK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:29:33 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D6A1F606
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:29:30 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221125102925epoutp046604d171ef9f908aa2553806a552691d~qzSPMlvAt1930519305epoutp04r
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221125102925epoutp046604d171ef9f908aa2553806a552691d~qzSPMlvAt1930519305epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669372165;
        bh=e22VHG7Ev48w/+fcrRlFL+uyDahpGUOfBXkdzCxPlaA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=liKlPjjgM2S78XIGRjdX2rXnKxPrdNIaSbmw84Wo99ZE0vuEdWHf8O7e5+Fd68s2P
         0d/1KPaxFLQF1X/q5Sby8nfHOIQiHwIxzo6yo3/J24Ye0OoH+bUcRrKyN9IwJgRYQK
         /pSBoapqZSpabpYbDgp2w3YoTJClq+FK7elishD0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221125102925epcas5p4577e17e5146fb2f1bf1e4fb0130a5809~qzSO2MSG10873108731epcas5p4i;
        Fri, 25 Nov 2022 10:29:25 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NJWLq43WMz4x9Pv; Fri, 25 Nov
        2022 10:29:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.F9.39477.30990836; Fri, 25 Nov 2022 19:29:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221125070706epcas5p4a0a136ac916f69381817197c88ad9ad8~qwhlcWL-G2013820138epcas5p4F;
        Fri, 25 Nov 2022 07:07:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221125070706epsmtrp1363db4adf8ae6ee9c336b9699ceb2ab7~qwhlbmr0r1701217012epsmtrp1X;
        Fri, 25 Nov 2022 07:07:06 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-c0-63809903d3d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.3B.18644.99960836; Fri, 25 Nov 2022 16:07:05 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221125070704epsmtip138a9f757291c41ddc50daca087234dac~qwhkKLuV50174001740epsmtip13;
        Fri, 25 Nov 2022 07:07:04 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
Date:   Fri, 25 Nov 2022 12:36:55 +0530
Message-Id: <20221125070657.28335-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7bCmui7zzIZkgyt3JC0ezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM7Y8OEwY8FRjoolB9YyNzC+Y+ti5OCQEDCROHZKvYuRi0NIYDejRMflLcwQzidG
        idl/WlggnM+MEm+X3GbtYuQE61g0o5kRIrGLUeLh0m3sEE4rk0TT2cvMIFVsAroSrdc+M4Ek
        RAS2MEqsPL+TCSTBLOApceDKczBbWMBB4veel+wgNouAqsTLc1eYQY7iFbCVaPqfCbFNXmL1
        hgNgN0kI7GKXODl3JQtEwkVi2pkT7BC2sMSr41ugbCmJl/1tUHa6xOYjm6HOzpHoaGpmhrDt
        gW6YwwKyi1lAU2L9Ln2IsKzE1FProM7kk+j9/YQJIs4rsWMejK0msfhRJ5QtI7H20Seo8R4S
        +xq+gZ0mJBArcfRIL9sERtlZCBsWMDKuYpRMLSjOTU8tNi0wyksth0dUcn7uJkZwEtPy2sH4
        8MEHvUOMTByMhxglOJiVRHhF7BqShXhTEiurUovy44tKc1KLDzGaAoNsIrOUaHI+MI3mlcQb
        mlgamJiZmZlYGpsZKonzLp6hlSwkkJ5YkpqdmlqQWgTTx8TBKdXAFHE6f40rQ4VrwKuvEuWN
        6uw/DvT7Waz32qVeF7SEp+mTFp/ljG0PooXlvZ42Ok174m9S4JB/uDBLr/3FsoriCvGb0j8y
        Ao4oPWQtv1f8PyHSsX0G++kMcWur6QXaCc/v1jDZ63NazV7ymPf+RJlH6n6TLlfE171hcuTg
        iWbj81Lmc1ukk2Uiaz7Z4bPY07sXl50Ncz1Yrf4oZc0DYU7TokPCKb+89zZdcxR7w+KsIvNv
        pT3vBLEJxbEbzueUzz7vOrtzymarPCUGfanrGXwTq76uC7i5gEnpgYe+iF+hS1+Fzfuz1V7T
        cw0WPDJ4tuX1YrPI3c6/hc9Fsz3/MzNx7c2WjP+Kcb0xGuvWvlRiKc5INNRiLipOBABrR4r9
        6wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42LZdlhJTndmZkOywYM7NhYP5m1js5h/5Byr
        Rd+Lh8wWO9oWslhc3jWHzWLR1i/sFg8/7GG3aN17hN3i9pt1rA6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKK4bFJSczLLUov07RK4MjZ8OMxYcJSjYsmBtcwNjO/Yuhg5OSQETCQWzWhm7GLk
        4hAS2MEo8azvAhNEQkbi5IMlzBC2sMTKf8/ZIYqamSRaL4B0cHKwCehKtF77zASSEBHYwyjx
        bvoJ1i5GDg5mAW+JKb/VQGqEBRwkfu95yQ5iswioSrw8d4UZpIRXwFai6X8mxHx5idUbDjBP
        YORZwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOJy0tHYw7ln1Qe8QIxMH4yFG
        CQ5mJRFeEbuGZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYmM0LOHt3zVhsP/m+XXNj0VyNoK2zbzY8NA2uMIpy3H+i6vzj+OgzDAJnI/vEQsTYnGPO
        PL67vNtQ7vEfLW3nF1e1w7qmi6y2T5giVVy02eHkkdbACQYC+jyHY8QDJRtPPGt5GMJodSHh
        xPVt0i5Zryzkkhcv9o06x2kgsibU/UEYxyINXYUbH37xP5jD9f7K0zu95jdXszR3H7frKmDJ
        klm1amNDc9Luyf2KR1u1zzGwa2YHnn7YqvS05tShyVdfGN/quXYueBJTdVL/fb2ueUandJ9s
        3bXq+4F5m1u//zzxpDpv7+uHDyXnCd/Zdnynie7Oq4FvXB92lejtv+O+p+/u3H1BGfI/j9tO
        2FvDocRSnJFoqMVcVJwIAO4AsAiWAgAA
X-CMS-MailID: 20221125070706epcas5p4a0a136ac916f69381817197c88ad9ad8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125070706epcas5p4a0a136ac916f69381817197c88ad9ad8
References: <CGME20221125070706epcas5p4a0a136ac916f69381817197c88ad9ad8@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSD has few system controller register blocks. This patch series intends to
add support of device node for system controller registers group that
resides in PERIC, FSYS0 and FSYS1 blocks of FSD SoC. As these will be used
by PCIE and EQoS module. Patches for adding support for PCIE and EQoS are
already under review at [1] and [2].

Also this patch series add required DT bindings for such system controller
of FSD SoC.

[1]: https://lkml.org/lkml/2022/11/21/463
[2]: https://lkml.org/lkml/2022/11/4/420

Changes since v1:
1. Fixed SoB in [PATCH 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
found on FSD SoC.
2. Address review comments from Krzysztof on [PATCH 2/2] and aligned sysreg
node near to respective blocks sorted in order of unit address.

Sriranjani P (2):
  dt-bindings: mfd: syscon: Add tesla compatibles found on FSD SoC
  arm64: dts: fsd: add sysreg device node

 Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
 arch/arm64/boot/dts/tesla/fsd.dtsi                | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.17.1

