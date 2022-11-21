Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695CC6320E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKULlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiKULkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:40:40 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE82F24E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:40:24 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221121114023epoutp03b9b022bb6b0d74a518928e3f0483016d~plrDmOMXc0989409894epoutp03J
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:40:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221121114023epoutp03b9b022bb6b0d74a518928e3f0483016d~plrDmOMXc0989409894epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669030823;
        bh=eyxXHtPX2IpW05RGPwWkC63Z9+TKtyB5JS6JrP+N5lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJA8xRuvTttX/yNL6q/ifRIeoVAiKPAQa9ucBA5bgNUScEb0NwdISvah/z+6tovNC
         2n+XyBYiH1qn6kvzZmBImdizG+8S7HYBKf1Y7KCnjodJJx3l/o94h5DVzAuvyGvL/x
         IxkiA8rG9yfY7oEBllWuOgh+ZodDgvttu0UgNIk0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221121114022epcas5p4cf077f6abdd4f030e531c171d9090f16~plrDEr4WL1612616126epcas5p4n;
        Mon, 21 Nov 2022 11:40:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG56Y2C4xz4x9Pq; Mon, 21 Nov
        2022 11:40:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.84.56352.5A36B736; Mon, 21 Nov 2022 20:40:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f~pjk8PPYQa1994519945epcas5p4E;
        Mon, 21 Nov 2022 09:06:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221121090647epsmtrp20c9f2523cdce3c9e80d270e1833ee96c~pjk8OluVP2849228492epsmtrp2L;
        Mon, 21 Nov 2022 09:06:47 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-37-637b63a5b297
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.29.18644.6AF3B736; Mon, 21 Nov 2022 18:06:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121090645epsmtip16179088c3243f5dc038dc9f9379b53f3~pjk61Bn332096020960epsmtip1G;
        Mon, 21 Nov 2022 09:06:45 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 2/2] arm64: dts: fsd: add sysreg device node
Date:   Mon, 21 Nov 2022 14:41:18 +0530
Message-Id: <20221121091118.48628-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121091118.48628-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmhu7S5Opkg2e7+SwezNvGZjH/yDlW
        i74XD5ktdrQtZLG4vGsOm8WirV/YLR5+2MNu0br3CLvF7TfrWB04PTat6mTzuHNtD5tH35ZV
        jB6fN8kFsERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM64c/IQc8FSzoo/i2exNTBeZO9i5OSQEDCR+NjVzdbFyMUhJLCbUeLYo9WsEM4n
        RokfD1YxglQJCXxmlLjZqw7T0XXlAQtE0S5GiaYzX6GcViaJ5YefsIBUsQnoSrRe+8wEkhAR
        2MIosfL8TiaQBLOAp8SBK8/BbGEBG4m7u9+A2SwCqhJP5m9hA7F5BWwldrUcYYFYJy+xesMB
        ZhCbU8BOYm3ja3aQoRICl9gljjY/Y4IocpFoX38SqkFY4tXxLVDfSUl8freXDcJOl9h8ZDMr
        hJ0j0dHUzAxh2wMdNAeolwPoOE2J9bv0IcKyElNPrYO6mU+i9/cTqFW8EjvmwdhqEosfdULZ
        MhJrH32CGu8hMfX8QnZI0E1klNjyRGgCo9wshA0LGBlXMUqmFhTnpqcWmxYY56WWw2MtOT93
        EyM4vWl572B89OCD3iFGJg7GQ4wSHMxKIrz1MdXJQrwpiZVVqUX58UWlOanFhxhNgeE3kVlK
        NDkfmGDzSuINTSwNTMzMzEwsjc0MlcR5F8/QShYSSE8sSc1OTS1ILYLpY+LglGpg6pfrV/wR
        r/9zpt6X1QeSNSSECiOtNX+uEdY9qZkrEH2hsjB6TuL2UNP6OOEb62xmn5/V/fKUwInyqzNC
        FuROnH975QQrQacT+i8bbz9qF0vdY5X+ZKW74D7eO2V2c0Uq+Q9phuZxH5e8xRnYsPHY/MPe
        OpNNZvryKxkkhy7+IdE9Y0Ztv2X8fwf2FWmrRTJa+nkqzf65O3uq37WYt17uzJp3KWrngrps
        PueKudd90ZE94sNd4JF/XlzhbdmUMJt190/x9Vq7K/JNlHm6sqZWoXzl/X8uz0IzZY++fKI2
        e67p1YtvK1d/uCT1dkbczn0rH35N2ekueLQi8N2dZVWp76/tePh15zmvzsrn3B9rlViKMxIN
        tZiLihMBr83rePgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnO4y++pkgwcNthYP5m1js5h/5Byr
        Rd+Lh8wWO9oWslhc3jWHzWLR1i/sFg8/7GG3aN17hN3i9pt1rA6cHptWdbJ53Lm2h82jb8sq
        Ro/Pm+QCWKK4bFJSczLLUov07RK4Mu6cPMRcsJSz4s/iWWwNjBfZuxg5OSQETCS6rjxg6WLk
        4hAS2MEoceNyFytEQkbi5IMlzBC2sMTKf8/ZIYqamSQ+rmkH62YT0JVovfaZCSQhIrCHUeLd
        9BNA3RwczALeElN+q4HUCAvYSNzd/YYJxGYRUJV4Mn8LG4jNK2ArsavlCAvEAnmJ1RsOgC3j
        FLCTWNv4mh1kjBBQzZs9URMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAgO
        Py2tHYx7Vn3QO8TIxMF4iFGCg1lJhFfkWGWyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfj
        hQTSE0tSs1NTC1KLYLJMHJxSDUxS+QkrX7qefn76yJOfVkfdWLdPn879/OGFf2x3jx//biPt
        43dYVrt3X5JTmLlj9I19rllfg5tVWLzV9c7GGWkLSi9UFUt9dmI+1+1XBpLdLZMst8/4IWBV
        M83gp8e+ttT7NhlVEUwMj1/xzZ6xQdls3hGnlg0zn3MsuZ6iVsPXnWl2f+KWSQ4F3f7//jjW
        v3aMZYo6UPdnfeJWntSpl870lnDzOi6YvaJs1mKxQw7fNd6EBFraNsx2UHqVzWpz3fmunUdR
        RK9+7JWdvzSjtzUaxFrZ9x29efXd7udfmPsd037+mp/IKTKzkuV13tOS3eLtwj8iN3TftNq+
        dGFj0iSB06wfrwncurrs/5dDngeUWIozEg21mIuKEwG3BKvbrgIAAA==
X-CMS-MailID: 20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f
References: <20221121091118.48628-1-sriranjani.p@samsung.com>
        <CGME20221121090647epcas5p439dc84f0c4f435a703a1f8396a11202f@epcas5p4.samsung.com>
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
index f35bc5a288c2..db78816ba0bf 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -518,6 +518,21 @@
 				"dout_cmu_fsys1_shared0div4";
 		};
 
+		sysreg_peric: syscon@14030000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x14030000 0x0 0x1000>;
+		};
+
+		sysreg_fsys0: syscon@15030000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x15030000 0x0 0x1000>;
+		};
+
+		sysreg_fsys1: syscon@16830000 {
+			compatible = "tesla,fsd-sysreg", "syscon";
+			reg = <0x0 0x16830000 0x0 0x1000>;
+		};
+
 		mdma0: dma-controller@10100000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0x10100000 0x0 0x1000>;
-- 
2.17.1

