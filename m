Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E663878B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiKYK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKYK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:29:45 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B18442F8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:29:42 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221125102941epoutp0492d5475944b7bb51a275f6bbb05166ac~qzSd4J7bZ1850118501epoutp04U
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:29:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221125102941epoutp0492d5475944b7bb51a275f6bbb05166ac~qzSd4J7bZ1850118501epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669372181;
        bh=5c1sUYxiWV+rcbYFnipvKbPgkyrqwMa4+U0qmAi8g50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6UwcJwzqkR3MosQVtnoayK0HW7Bi0t0VDjVXVIcWpsjtHo2EsWrjTfVh41EEmuDB
         X0udx/jjk7voak0mOlGamb5VDKBStCPu4AMLsGnUQZRFEHwkC10bNZ8rG9u00DgczR
         hD/yyo8WR9w1rGJFzxiYp6Pw1dPguriteLAOwlb4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221125102940epcas5p293c22665ef55dec64a4f95c4a310f458~qzSdihpVt2543925439epcas5p2i;
        Fri, 25 Nov 2022 10:29:40 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NJWM71lMSz4x9Px; Fri, 25 Nov
        2022 10:29:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.F9.39477.21990836; Fri, 25 Nov 2022 19:29:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221125070713epcas5p1cd9041af82e153cd2dc88ee18e041af9~qwhsX1-wE0846408464epcas5p1m;
        Fri, 25 Nov 2022 07:07:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221125070713epsmtrp17a28377c2e7654b3820ddb4af3284009~qwhsXHi0u1701217012epsmtrp1i;
        Fri, 25 Nov 2022 07:07:13 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-e8-63809912b2d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.3B.18644.1A960836; Fri, 25 Nov 2022 16:07:13 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221125070711epsmtip1d8f85e6e97ac36acdfb62ceb84a80d06~qwhqhwK-O0141301413epsmtip1Q;
        Fri, 25 Nov 2022 07:07:11 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 2/2] arm64: dts: fsd: add sysreg device node
Date:   Fri, 25 Nov 2022 12:36:57 +0530
Message-Id: <20221125070657.28335-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221125070657.28335-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmuq7wzIZkgz8HuCwezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM6Y33yAreAqT8WK3WtZGhiXcnUxcnJICJhI7L/aydTFyMUhJLCbUeLg9d0sEM4n
        Rol5z3rZIZzPjBKvL31ngmm5OekTM0RiF6PEi+mLofpbmSSu9K1hB6liE9CVaL32GSwhIrCF
        UWLl+Z1g7cwCnhIHrjwHsjk4hAXsJa4/VAIJswioSvzt7wQr4RWwlXj94gMzxDZ5idUbDjCD
        lHMK2Em8uS8OMlJC4By7xISnrYwQNS4SX+5cY4WwhSVeHd/CDmFLSbzsb4Oy0yU2H9kMVZMj
        0dHUDDXfHuicOSwg85kFNCXW79KHCMtKTD21DupiPone30+gnueV2DEPxlaTWPyoE8qWkVj7
        6BPUeA+J2zcboSE3kVHiyfa5TBMY5WYhrFjAyLiKUTK1oDg3PbXYtMAoL7UcHmvJ+bmbGMHp
        TctrB+PDBx/0DjEycTAeYpTgYFYS4RWxa0gW4k1JrKxKLcqPLyrNSS0+xGgKDL+JzFKiyfnA
        BJtXEm9oYmlgYmZmZmJpbGaoJM67eIZWspBAemJJanZqakFqEUwfEwenVANTxqPPPMsLTovw
        f7+4rLXA4E/xy8f77s79NGVOeHT5CWebh8sXBt5fK6Za076s+c3uxmr3TzkmGe0/135Un2Qy
        74Rg95WAl3rtSgvurcsRqv8UZBHxUYXdM0Rq35Lz/urzNqackbxZ+aXrlo6Aj/uXczIf16e4
        SaiylPwMKXgt31P8+84Vnvl7RA1+cJqrKH/nar0ZJJz51eaDZINhQNm8zMXZMZfv9rG4GP9d
        P+/TvI4HW4x+zU0W9ZSNYtNeK3BZ7f6lp/yn5qfOi5HuOyfw3j9J//VXNo9HIVOv/No6KYmj
        PvvRpv9xJ23j6otDTgtU2x99nflNszunz1emcMOBsCsn/9s6yfbzfp4W+qhOiaU4I9FQi7mo
        OBEAOD/YFvgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSnO7CzIZkg40XJSwezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERx2aSk5mSWpRbp2yVwZcxvPsBWcJWnYsXutSwNjEu5uhg5OSQETCRuTvrE3MXI
        xSEksINRYu+ht0wQCRmJkw+WMEPYwhIr/z1nhyhqZpLobXsKVsQmoCvReu0zE0hCRGAPo8S7
        6SdYuxg5OJgFvCWm/FYDMYUF7CWuP1QCKWcRUJX4298J1sorYCvx+sUHqPnyEqs3HGAGKecU
        sJN4c18cJCwEVHLmwWm2CYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAef
        ltYOxj2rPugdYmTiYDzEKMHBrCTCK2LXkCzEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QDk97sa+9Y9xU3OTtLnSld//TW/jlh1b1W/LcDVxRc7H2hJeqp
        lRQv1vR3juOcKM8NXo0hGzTOttm/en4j6a+RVSaHxqc0zntbzkn+mfHNIZw57ntdc5+Gf9hE
        xhc+plvWqLWXdDbPcuaL3v/waldn0cqUfpPioLMsLIJhTULWyjE+RuHntt0ojjm2rcD3i6fB
        JdvkJT7lW7XcfMJqxOLDFwot4ry0zPhBUMZd7Z9Rcu8eSKgWnDn8oCj91px123nWK5rIHWsp
        vCt+vdNjevB6phmaO6c/nfHxZaVWY0pexxkRs3kaP06JLvNR3ByjsnOiNXvegoYPBo8vOnpH
        RO9LNdTul0tef8PPvmlj40clluKMREMt5qLiRADSjp52rQIAAA==
X-CMS-MailID: 20221125070713epcas5p1cd9041af82e153cd2dc88ee18e041af9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125070713epcas5p1cd9041af82e153cd2dc88ee18e041af9
References: <20221125070657.28335-1-sriranjani.p@samsung.com>
        <CGME20221125070713epcas5p1cd9041af82e153cd2dc88ee18e041af9@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SYSREG controller device node, which is available in PERIC, FSYS0 and
FSYS1 block of FSD SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..76d08d9fa01d 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -492,6 +492,11 @@
 				"dout_cmu_peric_shared1div4_dmaclk";
 		};
 
+		sysreg_peric: system-controller@14030000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x14030000 0x0 0x1000>;
+		};
+
 		clock_fsys0: clock-controller@15010000 {
 			compatible = "tesla,fsd-clock-fsys0";
 			reg = <0x0 0x15010000 0x0 0x3000>;
@@ -506,6 +511,11 @@
 				"dout_cmu_fsys0_shared0div4";
 		};
 
+		sysreg_fsys0: system-controller@15030000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x15030000 0x0 0x1000>;
+		};
+
 		clock_fsys1: clock-controller@16810000 {
 			compatible = "tesla,fsd-clock-fsys1";
 			reg = <0x0 0x16810000 0x0 0x3000>;
@@ -518,6 +528,11 @@
 				"dout_cmu_fsys1_shared0div4";
 		};
 
+		sysreg_fsys1: system-controller@16830000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x16830000 0x0 0x1000>;
+		};
+
 		mdma0: dma-controller@10100000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0x10100000 0x0 0x1000>;
-- 
2.17.1

