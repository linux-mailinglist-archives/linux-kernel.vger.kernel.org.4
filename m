Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAE63C862
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiK2T3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiK2T3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:29:11 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3E1A23F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:27:30 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221129192728epoutp012e4537d5d7cbad13c6831cc2aeaa37ab~sJNJttOmR0188801888epoutp01D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:27:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221129192728epoutp012e4537d5d7cbad13c6831cc2aeaa37ab~sJNJttOmR0188801888epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669750048;
        bh=STCK5RfPzELDMJmCy9YzVVF5dbjowicVwJJKF6VsqJg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FcQwOuatDuTv0S01TA6kRCLlcF67Yug4My7rvTLddQPtly70FeBiP9kG+SEPvk3XJ
         LH6Pjhu9FzYq0bxbxZPiH8KLvsXLrKDWnOxqGdvDfvU45U/SsdrPD1eZ9jRI4ZgQPT
         exdFIfxOK1z9/jBiTl5jr9fEvXezVdwe78zPQt10=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221129192727epcas5p257b0887b90992e4feb97542860cb89cc~sJNJS1M1P3081130811epcas5p2Q;
        Tue, 29 Nov 2022 19:27:27 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NMC5n6Xhfz4x9Pp; Tue, 29 Nov
        2022 19:27:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.16.01710.D1D56836; Wed, 30 Nov 2022 04:27:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481~sDCrY4q0z1588315883epcas5p35;
        Tue, 29 Nov 2022 11:55:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221129115540epsmtrp269114761f9371f5f541c956ed776a204~sDCrYGQu31810718107epsmtrp2G;
        Tue, 29 Nov 2022 11:55:40 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-2d-63865d1d7739
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.F1.14392.B33F5836; Tue, 29 Nov 2022 20:55:39 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221129115538epsmtip1cb909db884274918e41d6ea77e3ad035~sDCpzIBhZ0481604816epsmtip1g;
        Tue, 29 Nov 2022 11:55:38 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v4 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
Date:   Tue, 29 Nov 2022 17:25:29 +0530
Message-Id: <20221129115531.102932-1-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmpq5sbFuywYVWE4sH87axWcw/co7V
        ou/FQ2aLTY+vsVpc3jWHzWLG+X1MFou2fmG3ePhhD7tF694j7BZfjrxmtLj9Zh2rA7fHplWd
        bB53ru1h89i8pN6jb8sqRo/Pm+QCWKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
        LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU
        6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcfnqZqWACb8X+5YuYGhgvcXUxcnJICJhInLp8irWL
        kYtDSGA3o8SpXXOYIZxPjBKtHy6yQDjfGCU2zz/OBtOydt5cNojEXkaJdR23GSGcViaJQxfu
        sYBUsQnoSrRe+8wEkhAR2MEo8XrSATCHWWAKo0T3t/WsIFXCAg4SzX/amUFsFgFViScnv4Lt
        4BWwk/j68QEjxD55idUbDoBdJSFwjl3idGMLVMJF4vuqncwQtrDEq+Nb2CFsKYnP7/ZCHZsu
        sfnIZlYIO0eio6kZqt5e4sCVOUCncgBdpCmxfpc+RFhWYuqpdUwgNrMAn0Tv7ydMEHFeiR3z
        YGw1icWPOqFsGYm1jz5BjfeQuPDhLtj3QgKxEo1LV7NOYJSdhbBhASPjKkbJ1ILi3PTUYtMC
        w7zUcnhcJefnbmIEpzktzx2Mdx980DvEyMTBeIhRgoNZSYT3Y1BrshBvSmJlVWpRfnxRaU5q
        8SFGU2CYTWSWEk3OBybavJJ4QxNLAxMzMzMTS2MzQyVx3sUztJKFBNITS1KzU1MLUotg+pg4
        OKUamBbGT98R/OXsx6ruLUJpfK3ub47N33RgerYbYwVDrvMvzittpzav998z1+rhzsYq1xX7
        3rC+kzjL4aqq5Bfuvu6AymqN0M0ls2a5n3noyv3uCe/rtQ6ax6ZtsVh+bn/rwmXRPF+Tn/6+
        mrb+0yyLmfUvrha9/Nyfc/9x1exsvaa7S99yTr2WnmHs//Pokd/n1zqsvDlz8+sXyRsfe4ZN
        78hjCHSLqT908p7/cV3p489efF/wf86yCf2LLv04yt7k/2yj/JfnSQnPmvRdYyKely+71yT/
        aoJ3/IyYcrMJv7naPLJdH28qObv1Ri+PSX/v/fqCU2p/jkz8LLfsfWJJ6fbHz5cz3z3gZ6F5
        cb3YFy/tWiWW4oxEQy3mouJEAG98iJ78AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSnK7159Zkg4XfTSwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0eL2m3WsDtwem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyrj89DJTwQTeiv3LFzE1MF7i
        6mLk5JAQMJFYO28uG4gtJLCbUeLKMUmIuIzEyQdLmCFsYYmV/56zdzFyAdU0M0nM3jCZCSTB
        JqAr0XrtMxNIQkTgAKPE7t4ljCAOs8AMRom/6+cwglQJCzhINP9pBxvFIqAq8eTkV7B1vAJ2
        El8/PmCEWCEvsXrDAeYJjDwLGBlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh5uW
        5g7G7as+6B1iZOJgPMQowcGsJML7Mag1WYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC
        6YklqdmpqQWpRTBZJg5OqQamhP6NAv+fcgYpNfSHb1zGZ+abf/HohO/NPfdEIwPvagR8Xey2
        +7n25sXM8XW7r0me/tQ+85Vmd7fIbe2vd46zJBS9rro+816q5bMNPw4Gb1kZrm+v+quvKzDM
        5suB5VmJfzpDDU94XDnmLMVc5PcpurX848msN7n9hUwB6kc6F74IXnuT0+Lt0kvFE3f+37Bu
        XY6IiOnr1R6vzhaJaS1l+zTz/o+nklVayvtLTQ8eX/RP7MlGz2qhxhVZi1Zzz7XVili4h+lA
        gtbPAo/pp/8X3Nnx5bTui7/z/05OmCzjVNjDZbjO3MX4VvBy361qbMp8K3wXVlfYCsxzXRR7
        nvvbw04pj+WzLsS+ThM/8HF6uxJLcUaioRZzUXEiANlXU2OmAgAA
X-CMS-MailID: 20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481
References: <CGME20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSD has few system controller register blocks. This patch series intends to
add support of device node for system controller registers group that
resides in PERIC, FSYS0, FSYS1 and CAM blocks of FSD SoC. As these will
be used by PCIE, EQoS and CSI module. Patches for adding support for PCIE,
EQoS and CSI are already under review at [1], [2] and [3].

Also this patch series add required DT bindings for such system controller
of FSD SoC.

[1]: https://lkml.org/lkml/2022/11/21/463
[2]: https://lkml.org/lkml/2022/11/4/420
[3]: https://lkml.org/lkml/2022/11/20/363

These changes are made on top of Krzysztof's patches [4] posted as part of
splitting Samsung Exynos SoC SYSREG bindings to own file.

[4]: https://lkml.org/lkml/2022/11/25/370

Changes since v3:
1. As per update from Krzysztof, add dedicated compatibles for sysreg found
on FSD SoC in the exynos-sysreg.yaml file.
2. Add CAM block sysreg changes in the dtsi file and respective compatible
in binding document.

Changes since v2:
1. Updated compatibles as per improvements suggested by Krzysztof.

Changes since v1:
1. Fixed SoB in [PATCH 1/2] dt-bindings: mfd: syscon: Add tesla compatible
found on FSD SoC.
2. Address review comments from Krzysztof on [PATCH 2/2] and aligned sysreg
node near to respective blocks sorted in order of unit address.

Sriranjani P (2):
  dt-bindings: soc: samsung: exynos-sysreg: Add tesla FSD sysreg
    compatibles
  arm64: dts: fsd: add sysreg device node

 .../soc/samsung/samsung,exynos-sysreg.yaml    |  4 ++++
 arch/arm64/boot/dts/tesla/fsd.dtsi            | 20 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.17.1

