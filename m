Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B664166D80A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjAQIWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjAQIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:22:24 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE552B0A0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:22:18 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230117082217epoutp049f996e72d2087a09729303dbaabd7c37~7CvXIBhfr0924209242epoutp04I
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:22:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230117082217epoutp049f996e72d2087a09729303dbaabd7c37~7CvXIBhfr0924209242epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673943737;
        bh=q/tn14ZjbdXMf9MNwQsdbd5Z9hNIqD6iXxXoo6o434g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+uITiy/66qgUfdrSATbCg3Wm0vBKKWkJrbn2cjMsV+zztaLXcj/+WVMSBWzo4cLk
         ZvB1FnomH/fFN0Jt3OokXUrXNnXFwJWFdbHPR3VSP3d+Oru4SKAtUatQVEnweYnL5n
         rYXS0MM6EOGgSRGEyDyVhn3Z2S8EaL/S+gJlI3BY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230117082216epcas5p110925e685dd41bc42980301882e1f05c~7CvWgpFlU2934729347epcas5p1I;
        Tue, 17 Jan 2023 08:22:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nx21f4Rqbz4x9Pr; Tue, 17 Jan
        2023 08:22:14 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.89.02301.5BA56C36; Tue, 17 Jan 2023 17:22:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230116103908epcas5p49d65b8a38b8ecfeda508960a9543193d~6w9jzQ-v50449804498epcas5p43;
        Mon, 16 Jan 2023 10:39:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230116103908epsmtrp1db5d2d211fa7a780f87376ed80d70b17~6w9jyZEAd2177121771epsmtrp1a;
        Mon, 16 Jan 2023 10:39:08 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-21-63c65ab56ff6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.FC.02211.B4925C36; Mon, 16 Jan 2023 19:39:07 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230116103905epsmtip10b5473a5e0ad2423e42781f38d13466d~6w9hlHICO1258912589epsmtip1X;
        Mon, 16 Jan 2023 10:39:05 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v4 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Mon, 16 Jan 2023 16:08:22 +0530
Message-Id: <20230116103823.90757-5-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230116103823.90757-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhu7WqGPJBs17DCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyM0yfnMhYsYa9YuOggewPjD9YuRk4OCQETiWVHdrJ0MXJxCAnsZpR4d3o9
        I4TziVGire8xO4TzjVFiz9QpzDAtl2//ZIJI7GWUWHJmCVRLK5PEzedzwQazCZhKrJrTyAqS
        EBFoYpJoezMRbAuzwEZGidPHHjKBVAkLuEqcvDYJbC6LgKrEvi2fgRZycPAK2EgcbY6CWCcv
        sXrDAbASTgFbia97bzCDzJEQWMghcehPIxtEkYvE/rVroF4Slnh1fAs7hC0l8bK/DcrOl5j2
        sRmqvkKi7eMGJgjbXuLAlTksIHuZBTQl1u/ShwjLSkw9tQ6shFmAT6L39xOocl6JHfNgbFWJ
        9cs3MULY0hL7ru+Fsj0kWrv+sUFCZQKjRO/R2ewTGOVmIaxYwMi4ilEytaA4Nz212LTAMC+1
        HB5vyfm5mxjB6VTLcwfj3Qcf9A4xMnEwHmKU4GBWEuH123U4WYg3JbGyKrUoP76oNCe1+BCj
        KTD8JjJLiSbnAxN6Xkm8oYmlgYmZmZmJpbGZoZI4b+rW+clCAumJJanZqakFqUUwfUwcnFIN
        TIw3lNtnnJ5dqXIyzf9usE4La87Ud7E79M43+37eLXXZ5F4IU+ByeSf2dVk8OvOq4pYmfPjY
        xMOz+eSXY74TPj9dPU/ntFFb52nzwxtnCm6Q3nyCoTDxj2WQRPt8ZlHfKUcn/i0RrT3atWxf
        1w6RD/tP9KX33zkTLL34+nrp0zN2BmnHMJrN5lALyN1j7ryxQp/jWYO7NaeM3aKQWftm/5wR
        /XGmP49c+ZWJsxY3dD8Jj4j/9IBt0806M9Z1m39lHFt86PjCrCcbH2xewJeiHx1QXvj0WU/X
        h3iOuzEqzNw5B04qrOA0cNO68me5x5pe0fb3Isd/sylnKujtiH3i4FfQ1FS5YdfHr4XKNgeb
        2pVYijMSDbWYi4oTAaUouZIwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnK635tFkg5czrS0ezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEcUl01Kak5mWWqRvl0CV8bpk3MZC5awVyxcdJC9gfEHaxcjJ4eEgInE5ds/
        mboYuTiEBHYzSnzr28wMkZCWmN6/hw3CFpZY+e85O0RRM5PE7XutjCAJNgFTiVVzGllBEiIC
        E5gkTr47xgKSYBbYyigx9bMRiC0s4Cpx8toksKksAqoS+7Z8BprEwcErYCNxtDkKYoG8xOoN
        B8BKOAVsJb7uvQFmCwGVPJlwnnECI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5
        mxjBwa6luYNx+6oPeocYmTgYDzFKcDArifD67TqcLMSbklhZlVqUH19UmpNafIhRmoNFSZz3
        QtfJeCGB9MSS1OzU1ILUIpgsEwenVAPTeeG43fpztx8INlD+Nbsyd273XsnWP71sQVWfjK75
        vpHoWdEbJrND5k+alcPqa7K3FbL+iiwI3HL1pte1gAtC1Zu+s216JHReds6qjS3Mr4PuTr78
        5eSEiuCQJ5MPSWzcanNnz7TZT0Ud7GtXvXadePSbw/2v9xwEfjzaH8WcsmvNLEev8LVdor/W
        p3TOY9cKWn9rCts/KTvngv3P35907S3ZVNu4erHOH4uiFbPfvrsoutXd2oo16+lDocA74h1F
        T6d/POS8doekFaNAzbfIJ/9XC9jwmae9c9UpPyynlnk8/azalxpOsfjjxdbpAgy+5tujMn03
        7O28ftjEUu/YvzWrrofuMhR6dm6JQ9bkN0osxRmJhlrMRcWJAAVHpCHlAgAA
X-CMS-MailID: 20230116103908epcas5p49d65b8a38b8ecfeda508960a9543193d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230116103908epcas5p49d65b8a38b8ecfeda508960a9543193d
References: <20230116103823.90757-1-p.rajanbabu@samsung.com>
        <CGME20230116103908epcas5p49d65b8a38b8ecfeda508960a9543193d@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node support for codec on Tesla FSD platform.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 7650c20f02b4..2cd721564a4f 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -10,6 +10,7 @@
 
 /dts-v1/;
 #include "fsd.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Tesla Full Self-Driving (FSD) Evaluation board";
@@ -34,6 +35,17 @@
 	clock-frequency = <24000000>;
 };
 
+&hsi2c_5 {
+	status = "okay";
+
+	tlv320aic3x: codec@18 {
+		compatible = "ti,tlv320aic3104";
+		reg = <0x18>;
+		#sound-dai-cells = <0>;
+		reset-gpios = <&gpg1 6 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &i2s_0 {
 	status = "okay";
 };
-- 
2.17.1

