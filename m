Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E73638789
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiKYK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKYK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:29:37 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D41FF9E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:29:35 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221125102933epoutp02360b28c7c26bba1330df5bc0edf8a628~qzSWw_x5R0915209152epoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:29:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221125102933epoutp02360b28c7c26bba1330df5bc0edf8a628~qzSWw_x5R0915209152epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669372173;
        bh=Qz+eV7p2SiAqzfOXSkHcLqNKXTb4xAoU6QB4WhAZL4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdebLzh3dM2qTMIgSEcqWrm+w0CpKjawHq66JPsualOtmslBgAvEqGPrmSk/CkmhR
         T9p6VUTeR2T42NvGPZn4ZA9s2HytsLeRCg9UEw//vSq2HJzXIytXhC73sPDzkxMJys
         CW7wEUZC/TOloHt3uODnvLnwos5HAznk5y51bta8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221125102933epcas5p2265aadf5491ea285db05e44a8662f0ab~qzSWbmWMR0249602496epcas5p2r;
        Fri, 25 Nov 2022 10:29:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NJWLz5v57z4x9Pw; Fri, 25 Nov
        2022 10:29:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.9F.01710.B0990836; Fri, 25 Nov 2022 19:29:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3~qwhop-9Sq0788907889epcas5p34;
        Fri, 25 Nov 2022 07:07:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125070709epsmtrp2244c3e8b469dcf97e2c5adcce5f18b4c~qwhopJV_Y2100721007epsmtrp2Q;
        Fri, 25 Nov 2022 07:07:09 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-16-6380990b5fe2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.3B.18644.D9960836; Fri, 25 Nov 2022 16:07:09 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221125070708epsmtip1a8131bd72e47498ce23bfc71fc2c42d0~qwhnWrNME0174001740epsmtip14;
        Fri, 25 Nov 2022 07:07:07 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Date:   Fri, 25 Nov 2022 12:36:56 +0530
Message-Id: <20221125070657.28335-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221125070657.28335-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7bCmhi73zIZkg7kHdC0ezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM54ObGbpeARa8WkaV0sDYzHWboYOTkkBEwkLt/eDmRzcQgJ7GaUuPTiEpTziVFi
        9sNWdgjnM6PE9uctzDAte59NBLOFBHYxSjRtzYYoamWSWPBlLViCTUBXovXaZyaQhIjAFkaJ
        led3MoEkmAU8JQ5ceQ5kc3AIC0RJPN+eBRJmEVCV2HflGhuIzStgK9E6oY8JYpm8xOoNB5hB
        yjkF7CTe3BcHGSkhcIld4umCE6wQNS4SMyb3MULYwhKvjm9hh7ClJD6/28sGYadLbD6yGao+
        R6KjqRnqGXugc+awgMxnFtCUWL9LHyIsKzH11Dqoi/kken8/gTqHV2LHPBhbTWLxo04oW0Zi
        7aNPrCBjJAQ8JHqmekOCZCKjxLXe1+wTGOVmIWxYwMi4ilEytaA4Nz212LTAMC+1HB5nyfm5
        mxjBqU3Lcwfj3Qcf9A4xMnEwHmKU4GBWEuEVsWtIFuJNSaysSi3Kjy8qzUktPsRoCgy+icxS
        osn5wOSaVxJvaGJpYGJmZmZiaWxmqCTOu3iGVrKQQHpiSWp2ampBahFMHxMHp1QDk6yAS9it
        D1rskq3Seor6PUs4l1TLZdw48rLIdQfzD7E5vJ5PjffYrvu2UNSzrW2t9vrloo2+zclltx/d
        YOupVpIrqDVJtpII1Nsi5nnObL7Y3Qfrvit4mXElT2ZlO9Sw/e/6dtvczjOMy6bdyHLcuGi3
        4oX6GYv2/D635F5vTsCXly0r9zC4nFg4v12m9/eFnB1Pfme0ubyMljgZIGfxeTVveKGV3+6a
        /zvPf3/2dZn+bbYanwTrW1M2ve7tWfLg/fnKeXOPsSZcmbHzudjRPnG/Cx3up37opTy8JO7Z
        Pn99SJj4ZbcXDI4/yh2ucV2us4vyeSoQvnjWxNo7WifqgqJEVSVmfJA0Z72x8LGpkBJLcUai
        oRZzUXEiABfT/vz2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnO7czIZkg8mvJC0ezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERx2aSk5mSWpRbp2yVwZbyc2M1S8Ii1YtK0LpYGxuMsXYycHBICJhJ7n01k7mLk
        4hAS2MEosfbgW2aIhIzEyQdLoGxhiZX/nrNDFDUzSfy4OpUVJMEmoCvReu0zE0hCRGAPo8S7
        6SeAEhwczALeElN+q4HUCAtESKxeNh9sEIuAqsS+K9fYQGxeAVuJ1gl9TBAL5CVWbzjADNLK
        KWAn8ea+OEhYCKjkzIPTbBMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgO
        Py2tHYx7Vn3QO8TIxMF4iFGCg1lJhFfEriFZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
        QgLpiSWp2ampBalFMFkmDk6pBiYunVva8tsKLBP8OD9f8pma/0niUanLpFtR1lMD5Bx1Hkx8
        1hIybxq35tMb6rNenznwcl+Mt/YfHo067f1r1v+5//ii1Q6DBzmcMu9N31ZsX77K5AibhM8q
        dtOtNut2yXx493XD4bkrn2ftZmTmixSyCl8mV35u9X33y/XcO+34H526ECeRYac8ddK6OSX7
        TjXsW6R+67Xug/JMafN4VZVLO2ct5b1vuYGbVXPB4o1BR7Y7Mu/avyV3t+X3Cw5pH1dOeyCv
        P8nVUpbxq9b9qS4XnD1vBX69a1kR2q14V/vhq3KV1uSgVyqqv0/83J7z6JuHnd4jTk955+eK
        hQsfMGVtN1rosf1w+jqhb2lhtY5TlViKMxINtZiLihMBOnJMDq4CAAA=
X-CMS-MailID: 20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3
References: <20221125070657.28335-1-sriranjani.p@samsung.com>
        <CGME20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Tesla SYSREG controllers found on FSD SoC.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4e4baf53796d..8c3334999bec 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -69,6 +69,7 @@ properties:
               - samsung,exynos5433-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
+              - tesla,fsd-sysreg
 
           - const: syscon
 
-- 
2.17.1

