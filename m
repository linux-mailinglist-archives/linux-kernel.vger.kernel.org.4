Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20125FBFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 05:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJLDvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 23:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLDuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 23:50:51 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074DBAC38C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 20:48:58 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221012034856epoutp03eb5e76c992e73472f6b97f275be059ac~dNcATFLrl2833228332epoutp03L
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:48:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221012034856epoutp03eb5e76c992e73472f6b97f275be059ac~dNcATFLrl2833228332epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665546536;
        bh=o7QIEcScA/33C6YdFxTxnsg5BaDgsPatm7VHbSWXZVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjlB39tLbbKbqWf69Lr+Kiydw93v1ZNTQltdF82EvGbCG2laeuMAIIHDzzrIh6FLl
         ygYg+XK5RGUWgNYZSqQNCxeR24tqfp5i2pB/jtL47NTvaFnhd8lTY4t7Mqrv2ZTAJm
         DMHMkDk5yWfoShd36D+ymH3PehYQHmP0rlUs9PTM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221012034855epcas5p35b6ca2f32c0ccf31455b2c3cccb06d21~dNb-pG-S71108411084epcas5p3O;
        Wed, 12 Oct 2022 03:48:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MnJY069smz4x9Q2; Wed, 12 Oct
        2022 03:48:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.5E.26992.42936436; Wed, 12 Oct 2022 12:48:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221011125229epcas5p434cecc44beb02450c876de71c0f06011~dBNTRidnM1729617296epcas5p4s;
        Tue, 11 Oct 2022 12:52:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221011125229epsmtrp2206ccdadeb7f266ab4ab9b12e3d7d18e~dBNTQeBTR1820118201epsmtrp2Q;
        Tue, 11 Oct 2022 12:52:29 +0000 (GMT)
X-AuditID: b6c32a49-319fb70000016970-22-6346392468ef
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.1D.14392.D0765436; Tue, 11 Oct 2022 21:52:29 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221011125226epsmtip11bf61fb7e73799627eae74100ac2bdba~dBNQO9w_Y2675826758epsmtip1K;
        Tue, 11 Oct 2022 12:52:25 +0000 (GMT)
From:   aakarsh jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, smitha.t@samsung.com, aakarsh.jain@samsung.com
Subject: [Patch v3 15/15] arm64: dts: fsd: Add MFC related DT enteries
Date:   Tue, 11 Oct 2022 17:55:16 +0530
Message-Id: <20221011122516.32135-16-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011122516.32135-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTdxTH87u37W0JZXeI8ScBZI26iQLtLN0PI8whY9eJhumMhmzD2t4A
        Utra2w4H2YDxyGRixM0HCNQIDMfbAh1jMLtSZGPI0oxJIBYr+IJ1DikyxI2sD9z++5xzvueR
        c34/Lu5v5wRy05VaWqOUKgQcH5axb9PL4eujE2TCxtnN6F5XORvZq40cVLP4AEO3a5wsZG7v
        JFDHyEUc1Q+Y2EhvGWajb36YZKGrD11Ra7mNhR7oWwCarpjgIMPUTTa6M3MQ/dpdyUEn2zrZ
        qNliI1DdqBVDXxn+xtDlznkCFfVaCGTrMQJUWGzBdkCqqboJUF22WkCN1s7h1LcVNoKq6ZnG
        KEPDCQ5162YPh2qvzaWK+pdY1KmOBkAtf1pFUCWWUQ7lNIRQg0+cRJJfcsb2NFoqpzWhtFKm
        kqcrU2MEu/en7EyJkghF4aJo9JogVCnNpGME8YlJ4QnpCtcaBKEfShU6lytJyjCCyNjtGpVO
        S4emqRhtjIBWyxVqsTqCkWYyOmVqhJLWbhMJha9GuYSHM9LMPzWz1Q6f44v5y0QeuMEtAVwu
        JMXQ+ufhEuDD9Se/A7B16RfgNeYAzLf2YV5jAcCZaxOcEsDzZBj/cawEegE8Oz9FeI0iDF4f
        +sOj4pDh8FqdycMBZD6AU59p3SKcLGBB29Azwh1YRSbAovEhtptZ5AZYP3zGk8AnY+HE8CLm
        bbcONraZcDfzXP7Hddc57kKQLODBgrlmwiuKh0uFP6/wKjgz0LHCgdD5qHdlbhmcujyNe1kB
        W3u+ZHn5dWgaqWS5t4GTm2Brd6TXHQzPDrZ4ZsBJP1j67O7KPHzYVf2cN8LKW4tsLwfBvsY6
        4GUKmhzdnvL+ZBmAg/o9p0FIxf8dLgHQANbSaiYzlWai1CIlnfXf1WSqTAPwPPWwXV3AZp+N
        MAOMC8wAcnFBAB/o42T+fLn0o2xao0rR6BQ0YwZRrv2V4YGrZSrXX1FqU0TiaKFYIpGIo7dK
        RII1/JoLYTJ/MlWqpTNoWk1rnudhXF5gHtYyvnXL/Q+M5fmnX7FrdtVeOtCf57hRejt4X35S
        5VW/vUfwY8fi5zdP1sUeMQVI9xIPtXmfBBteuDiWc/5t3+LSUsJvT+v6A/0NtnfurT4TuS7h
        /RjhE+5Czu+tPn9Fdk5INlq2XDgPftwXsuHzF7+vhecetWsLHMd5I7p4YwayW3u+NmV1+0ri
        jlLFL3083par/E2//JZ5hD+9cJRrW6ST03hZE7sdawfEY8ybp+6cY/S2bsWhWXtQ0BpQltg0
        95RqaZ6sOpiTfGUEe2+H7u7s/ceUX5VvjHM26oTIp1Av18j7Gt8odpZnxSVmZ5Ud0g4/fXem
        pH5nrq7ddyy78so2xf4vBCwmTSoKwzWM9F+rL0NMcwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRiA/c7OzcXkNIW+LroYXSjLNAs+rSyj4lQWUXSTbic9TGubc5ut
        AsnlpVq3OSjyNiunlWnqzGVlZGu1rJTEaJDNS6NMk25qmdQqJ/17eJ+H9/3x0gJxHj6JTlZq
        ebWSk0tJIW57KA2ZK5KtTAgf/D0OvavPI1CX2UaikuEeDHWWDODIXltHoZsvCwToirORQMWO
        FgLdevAWRzUf/tnWPDeOeopvANSb30Eiq+cVgbr7tqK2O4UkOlVdR6BKh5tCpa5WDJVZf2Ho
        ct0ghbLvOSjkbrABlJXjwJZBtsJcAdh6twWwLss3AXs7302xJQ29GGstP0Gyb141kGyt5Qib
        /WgEZ8/cLAes92gRxRocLpIdsIawT4cGqA0B8cLFibw8+QCvnhezR5hkb6okVP3Cg8N6L5UB
        mmkD8KchswDafvdjBiCkxcxdAFvdz/AxMQX+yXlMjXEgvObtocaiTAx67t4hRgXJzIX3SxvJ
        URHEZAPounbCt0rAFOBw2NToqwKZVTD79XMf48x0eKXFRI6yiImBHS3D2NgJCbxe3SgYZf9/
        86+lj32NmFkC9Z/PYUYQcBH4lYOJvEqjkCk0EaoIJa8L03AKTZpSFpaQorAC3/dmz6oHt8q/
        hNkBRgM7gLRAGiQCxcsTxKJE7tBhXp2yW50m5zV2MJnGpRNELwxNu8WMjNPy+3lexav/W4z2
        n5SBPasuUhxJ3CsxpYdPy1y/Iy0J7Y+c0IXNbOnq6zNTOTLzSOcuVPlk573VvQuzMr5e0ktM
        zsH0zbrm0FRF9M9QSunXRHwZ5BhnkyuLu7rFPl50SLd98+I0Y6ynrRLWLjrldx6vnyG2nNTa
        CkYkp4mapcZpxqfSmJCjO1IlG7+ZL0/dZNoXfz1dZ3shOWM0CPu4Y/rlZ9dVRJUpt2Z5Olas
        lfBBtvhg2cA8vT3Kq4tSOKIXOU+H0V3RNbkfStZ4l2YmtFeF9EemztkYF/snXOsJdBbLtUFV
        Qx9zY398/zQ/19Iul5TFBWM6bV6y8XhboVOzK/bCnoCzqm0N3YXvjVJck8RFzBaoNdxf4MS1
        ViwDAAA=
X-CMS-MailID: 20221011125229epcas5p434cecc44beb02450c876de71c0f06011
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221011125229epcas5p434cecc44beb02450c876de71c0f06011
References: <20221011122516.32135-1-aakarsh.jain@samsung.com>
        <CGME20221011125229epcas5p434cecc44beb02450c876de71c0f06011@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Smitha T Murthy <smitha.t@samsung.com>

Add MFC DT node and reserve memory node for MFC usage.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..b2f7345d2cba 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -340,6 +340,18 @@
 		#clock-cells = <0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mfc_left: region@84000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0 0x84000000 0 0x8000000>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -832,6 +844,15 @@
 			clock-names = "fin_pll", "mct";
 		};
 
+		mfc: mfc@12880000 {
+			compatible = "tesla,fsd-mfc";
+			reg = <0x0 0x12880000 0x0 0x10000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "mfc";
+			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
+			memory-region = <&mfc_left>;
+		};
+
 		ufs: ufs@15120000 {
 			compatible = "tesla,fsd-ufs";
 			reg = <0x0 0x15120000 0x0 0x200>,  /* 0: HCI standard */
-- 
2.17.1

