Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9165BACE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbjACGmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjACGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:41:49 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A1D2C3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:41:36 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103064135epoutp029dcb971a8889f8fba151b2f8c330c434~2uVcbfiHQ2497424974epoutp02c
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:41:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103064135epoutp029dcb971a8889f8fba151b2f8c330c434~2uVcbfiHQ2497424974epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672728095;
        bh=B3Bv04YS1AnZ+r2Idi8FfyBdbKjTeoLuGqGo3NHfQM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATm5CE4/mcSjb2hfIvMR8mwoBhE4DpcVFvOIkwJJ/OgqBzqxTlMLyEC2xOBC5BNYx
         tLDf9D2wh8/pT/7p8Mzcg5JJrQLyPOWteWBY/myvkNCz6ddRjH63dk5mdI1ywulcs/
         6Rt+si/kt8xDwTCsYQ2sfznA4ItKcB7l5t+Z5d7U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230103064134epcas5p269634dab6c4fb614ab4773e4325da615~2uVb-xaXb0989809898epcas5p2s;
        Tue,  3 Jan 2023 06:41:34 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NmNRv4qg0z4x9Q3; Tue,  3 Jan
        2023 06:41:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.82.02301.B1EC3B36; Tue,  3 Jan 2023 15:41:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045703epcas5p2344520777efa3c06321732e2784e6c6c~2s6LIZMxc0807308073epcas5p2Z;
        Tue,  3 Jan 2023 04:57:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230103045703epsmtrp1a294a99cc0d9ae9c0449491fd84be4fe~2s6LHgXwK0133401334epsmtrp1u;
        Tue,  3 Jan 2023 04:57:03 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-88-63b3ce1b4fa3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.94.02211.F95B3B36; Tue,  3 Jan 2023 13:57:03 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045700epsmtip269360129d0ecb64ce993e68b99a92fe6~2s6I5EcZa3211632116epsmtip2U;
        Tue,  3 Jan 2023 04:57:00 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Tue,  3 Jan 2023 10:26:12 +0530
Message-Id: <20230103045613.100309-5-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103045613.100309-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmuq70uc3JBl+mqVk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZnfO/MhXsZa+Yve0gSwNjN1sXIyeHhICJxJpJSxm7GLk4hAR2M0rMfnOb
        BcL5xCjx7PoiqMw3Ronm5iUsMC0/5nxkhUjsZZSYsPo8O4TTyiTxe9MDZpAqNgFTiVVzGsGq
        RASamCTa3kwEG8wssJFR4vSxh0xdjBwcwgKuEk/3V4E0sAioStw5uoodxOYVsJV4fbGNCWKd
        vMTqDQfAhnIK2En86bjABDJHQmAhh8SjZYsZIYpcJI5s7oV6SVji1fEt7BC2lMTL/jYoO19i
        2sdmqJoKibaPG6AW2EscuDKHBeQeZgFNifW79CHCshJTT60DK2EW4JPo/f0EqpxXYsc8GFtV
        Yv3yTVAnSEvsu74XyvaQuL7tC1iNkMBERonl67kmMMrNQtiwgJFxFaNkakFxbnpqsWmBYV5q
        OTzakvNzNzGCk6mW5w7Guw8+6B1iZOJgPMQowcGsJMI76cWmZCHelMTKqtSi/Pii0pzU4kOM
        psDwm8gsJZqcD0zneSXxhiaWBiZmZmYmlsZmhkrivKlb5ycLCaQnlqRmp6YWpBbB9DFxcEo1
        MPnsKtV0/vL36WcHG2fGSQs7H6WlcSRPnnIiu+mrteMhsxkbdiUK+Br/OfEs6cMFoW9OC7gv
        brpevtZmedBpz7CVOs8E3iX+PX/OQuvFatF7kZZvF8rbXvy30e2r3S3B5KrAA8cK5G3a1vcx
        P/s3/9Mzn7P9JxdODX/77vJk+8ajH0vrrSfozAy52XtAfbu4hvZFwaNP03yUnp18/lDncuCC
        G1cdzWd8+7/zp9yy6ocfEyf+XPnz926TTSc+ufhkPDjOvH3595ZFnybIv0+Obv3028Ez7rfA
        022ftitUbN1W03SlrOHQ8aJuDv4TeTeSH6rMtn48pfJFE4uhXVlw/roy703XSt25+zKNLVI0
        9iSYKbEUZyQaajEXFScCAL6eqAgvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO78rZuTDf5c57Z4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2RxdGOwxaKtX9gtOnf1s1rM
        urCD1aJ17xF2i8Nv2lktNnxfy+gg4LHhcxObx85Zd9k9Nq3qZPO4c20Pm8e+t8vYPPq2rGL0
        WL/lKovH501yARxRXDYpqTmZZalF+nYJXBmd878yFexlr5i97SBLA2M3WxcjJ4eEgInEjzkf
        WUFsIYHdjBIPJuVDxKUlpvfvgaoRllj57zl7FyMXUE0zk8SVhrVgDWwCphKr5jSygiREBCYw
        SZx8d4wFJMEssJVRYupnoy5GDg5hAVeJp/urQMIsAqoSd46uYgexeQVsJV5fbGOCWCAvsXrD
        AWYQm1PATuJPxwUmiINsJbY3fGKewMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+
        7iZGcKhrae5g3L7qg94hRiYOxkOMEhzMSiK8k15sShbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBaUVv9o3XSvVa79vOT4l59+2gDbuzuCuTok+Jlf4R
        t+sPdvV9aZ+UuqZMbfmeRA+fU4pVWUzak30SzG+uTWwwPS/4wPb2hvpnBxLyVm4T3L2xpnqH
        Y4t+WdyzaWLnRdeVNlf9P7FPIvKwRFC1/FMJHR6+fU9C1xxZ6lik3LqDjfHdzgdTn7tcmHyw
        ZPl0i4f5VqLMMz7MvXsvy9j9N6/whOKrCsGqtkHxK+8UGRYWvIpeZHjb+UG00EPuXJsVd8M/
        8R1W3Cw0k+/8+Rxv87tcwXLeXrcX2f8RyzJnuq/94KtS8Os95js5e42PdZ/deGjj/UlRU3/5
        umTFm66w/j7n5oH2ndEege0Hwju45W59VWIpzkg01GIuKk4EAI/YpHfkAgAA
X-CMS-MailID: 20230103045703epcas5p2344520777efa3c06321732e2784e6c6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045703epcas5p2344520777efa3c06321732e2784e6c6c
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045703epcas5p2344520777efa3c06321732e2784e6c6c@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node support for codec on Tesla FSD platform.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index cf5f2ce4d2a7..e2fd49774f15 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "fsd.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Tesla Full Self-Driving (FSD) Evaluation board";
@@ -34,6 +35,18 @@
 	clock-frequency = <24000000>;
 };
 
+&hsi2c_5 {
+	status = "okay";
+
+	tlv320aic3x: codec@18 {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3104";
+		reg = <0x18>;
+		reset-gpios = <&gpg1 6 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+};
+
 &serial_0 {
 	status = "okay";
 };
-- 
2.17.1

