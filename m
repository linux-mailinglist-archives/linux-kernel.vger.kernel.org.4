Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2E669846
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbjAMNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbjAMNQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:16:41 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C96B5E3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:06:58 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230113130655epoutp03054872880042ea50a02b6898effbd13d~54CvxsJMI3012730127epoutp035
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:06:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230113130655epoutp03054872880042ea50a02b6898effbd13d~54CvxsJMI3012730127epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673615215;
        bh=0NT9nwpPCCrvcsOIz2f7TUAYBNBwRv1azLoJ0Ig3cws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5WXmTdLJe2j9IutLysU9wQ7Kb4AqyI23OMSdbxP+Oas3vdVqjt+awvYXJa3X5Wmr
         2uod+vhDtNisXRSnSi6n9jK6usGh9XWX6UxYzTIfqUzo7VPnb9riVylbiJW0Wqiv4N
         sL6Ce+yNHg3pmZuV+LGhiFwTPVDat+MgFzC/X/JE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230113130654epcas5p16fb4f2abe73e55e20cd224bbfea39c17~54CuRnk_-1717817178epcas5p14;
        Fri, 13 Jan 2023 13:06:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NthWw4y0Mz4x9Pw; Fri, 13 Jan
        2023 13:06:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.A9.02301.C6751C36; Fri, 13 Jan 2023 22:06:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75~53YdkcNOw1715317153epcas5p4r;
        Fri, 13 Jan 2023 12:18:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230113121830epsmtrp2305904da1798fbfca6885b8d063f2365~53YdjkitZ1419914199epsmtrp25;
        Fri, 13 Jan 2023 12:18:30 +0000 (GMT)
X-AuditID: b6c32a49-201ff700000108fd-b9-63c1576c5047
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.65.10542.51C41C36; Fri, 13 Jan 2023 21:18:29 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230113121827epsmtip2fb0b57dd690f0eac5b1b8bcaaeb45162~53YbNu1PJ0851308513epsmtip2o;
        Fri, 13 Jan 2023 12:18:27 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v3 4/5] arm64: dts: fsd: Add codec node for Tesla FSD
Date:   Fri, 13 Jan 2023 17:47:48 +0530
Message-Id: <20230113121749.4657-5-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113121749.4657-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmpm5O+MFkg2f/VCwezNvGZnHl4iEm
        i0Obt7JbTH34hM1i/pFzrBZ9Lx4yW3y70sFkcXnXHDaLGef3MVkc3RhssWjrF3aLzl39rBaz
        LuxgtWjde4Td4vCbdlaLDd/XMjoIeGz43MTmsXPWXXaPTas62TzuXNvD5rHv7TI2j74tqxg9
        1m+5yuLxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0AdKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzU
        EitDAwMjU6DChOyMr/92MBUsZ6/Y8/4nUwPjb9YuRk4OCQETiXdH9zOB2EICuxklrl9X7mLk
        ArI/MUos+faMBcL5zChx8v8N9i5GDrCOH39zIOK7GCVOd+5ihnBamST2zWoGG8smYCqxak4j
        K0hCRKCJSaLtzUSwUcwCG4Fajj0EWygs4CqxbNclsA4WAVWJr5Pmgdm8AtYSEzrnsEMcKC+x
        esMBZpDVnAI2EkuP54LMkRBYyiHRdf0cM0SNi8SJK01QtrDEq+NboHqlJD6/28sGYedLTPvY
        DGVXSLR93MAEYdtLHLgyhwVkPrOApsT6XfoQYVmJqafWgZUwC/BJ9P5+AlXOK7FjHoytKrF+
        +SZGCFtaYt/1vVC2h8Skc/1skFDpZ5To+ruDaQKj3CyEFQsYGVcxSqYWFOempxabFhjmpZbD
        Yy05P3cTIziVannuYLz74IPeIUYmDsZDjBIczEoivHuO7k8W4k1JrKxKLcqPLyrNSS0+xGgK
        DL+JzFKiyfnAZJ5XEm9oYmlgYmZmZmJpbGaoJM6bunV+spBAemJJanZqakFqEUwfEwenVAOT
        7MesNJ5FfeqaOf8rPnfw2LxdNHn2T45JO3KvrgnfOO9ZhMZa2aRte247Pts+UUPIdbGy93LX
        oDclmeblvTdeln0wuzFt3ttksTt3nNL/PGp7fOnECvl29RSHvB0vFOLEP/a29gr+3u6yWlHP
        /0y49ouqr8k7w29lGrU9r1upsKs55s6PpacexETVlKldzgi1yzdfv+rfZXNJJXl34bPKp0r2
        f9mR3fVITiyM98m/UNd7/CGr8gsX5JuJJLxi/TCTPVDmaqTOzpccDyIuLnOa+oXL/YLek28T
        JMRVF26IrT+Qtba0NmrC7MthfYt3OvXOnWX9dPm170dr1KdN/XDT0Wc2s/r2z1NfGclkbFyq
        osRSnJFoqMVcVJwIANYEjR4uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvK6oz8Fkg/6nNhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK+Prvx1MBcvZK/a8/8nUwPibtYuRg0NCwETix9+c
        LkYuDiGBHYwStw4vBYpzAsWlJab372GDsIUlVv57zg5R1MwkcfTEE3aQBJuAqcSqOY2sIAkR
        gQlMEiffHWMBSTALbGWUmPrZCMQWFnCVWLbrEthUFgFVia+T5oHZvALWEhM657BDbJCXWL3h
        ADPIRZwCNhJLj+eChIWASva+fMw0gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4FDX0trBuGfVB71DjEwcjIcYJTiYlUR49xzdnyzEm5JYWZValB9fVJqTWnyIUZqDRUmc
        90LXyXghgfTEktTs1NSC1CKYLBMHp1QDk94UlZIDW9j/O3xpDJ7oedo1Rzjk7w9nR/E9yxft
        MznycWXHWaGv2wIc1BleygtL/55/WtKk4qTTuWQ5rsaNL0R/VbUf2sx8y55FO+/g1p2NPB5d
        7gcVWvR3REXu+9cSder1Befm8H1zzBZ9Pzz72+X1FhM3bb2oPbcgceUlk4MmD66LtbqJrZSw
        qfWbvur1qctnVksf9b5nzJDAaxSpsVdo1VcpuUlVW0/t7NJofM7LPzFb529PpYr7jYnWyvx2
        fzb2/nzGesz3DavpM4Enn58cy9teeqb6Wb7fkd+bJoT/3vfBNmuh4iohxncfo6/3ZKrYZTPZ
        lWXfC8lc89VcqkP+wZY5z+qdRA2Omd5aMUmJpTgj0VCLuag4EQAAOFis5AIAAA==
X-CMS-MailID: 20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75
References: <20230113121749.4657-1-p.rajanbabu@samsung.com>
        <CGME20230113121830epcas5p4cc336a48f4597ba84ab1352774242f75@epcas5p4.samsung.com>
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
index cf5f2ce4d2a7..2f211a1ad50d 100644
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
 &serial_0 {
 	status = "okay";
 };
-- 
2.17.1

