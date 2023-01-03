Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D465BAD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjACGmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbjACGlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:41:50 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5914D2E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:41:48 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230103064147epoutp039e0965c9b487b2f94cef71afaed1d91f~2uVnfvVk62514625146epoutp035
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230103064147epoutp039e0965c9b487b2f94cef71afaed1d91f~2uVnfvVk62514625146epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672728107;
        bh=nhdfKuY6VgLCY5Ul25sLP3BbNNJgGEW2tayYvQfRUgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ph+LWPskbfKUGO7UY177YNtMXlsarDPEKm0qoeptwGP03qRqOk1cIPs4aU9+Cn0Fw
         Z4WJeBcBUzT/fU335RV8+E9K91tKsQbCr0MtdufKkVIGq+g2eG0C0kdgLbdPiC832Z
         U9XmmXhK3PBZ+sY7XJIMRejShQFFHAriw9K7oUno=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230103064146epcas5p3421ed7c35cbbedafdc426bd54dfb8356~2uVm5944U0590305903epcas5p3g;
        Tue,  3 Jan 2023 06:41:46 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NmNS818Gcz4x9Q4; Tue,  3 Jan
        2023 06:41:44 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.E0.62806.72EC3B36; Tue,  3 Jan 2023 15:41:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b~2s6Of__Ck2038120381epcas5p1b;
        Tue,  3 Jan 2023 04:57:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230103045706epsmtrp21d91195338b2a9b7de0c58c4d8ae04ac~2s6Oak1wS0749107491epsmtrp2-;
        Tue,  3 Jan 2023 04:57:06 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-17-63b3ce27ec1d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.15.10542.2A5B3B36; Tue,  3 Jan 2023 13:57:06 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045704epsmtip27788c0c81554ab6969b69128dd45d984~2s6MNWlBL3215832158epsmtip2O;
        Tue,  3 Jan 2023 04:57:04 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
Date:   Tue,  3 Jan 2023 10:26:13 +0530
Message-Id: <20230103045613.100309-6-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103045613.100309-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmpq7Guc3JBttnMlk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZ02ZMYis4x1Wxpm8mWwPjAo4uRk4OCQETic1NLaxdjFwcQgK7GSU+PX3F
        BOF8YpRYN/k9O4TzmVHi/o4jrDAtX0+3QFXtYpSYMe8dE0hCSKCVSeLAqUQQm03AVGLVnEaw
        uSICTUwSbW8msoA4zAIbGSVOH3sI1iEs4CXx+cEaRhCbRUBVYsf6HWA2r4CtxN6FJ5gg1slL
        rN5wgBnE5hSwk/jTcQFstYTAXA6Jz6fXMUIUuUgs2PIF6j5hiVfHt7BD2FISn9/tZYOw8yWm
        fWyGsisk2j5ugFpgL3Hgyhyg6ziArtOUWL9LHyIsKzH11DqwEmYBPone30+gynkldsyDsVUl
        1i/fBHWCtMS+63uhbA+J7hePGSFBNJFR4vGWP4wTGOVmIaxYwMi4ilEytaA4Nz212LTAKC+1
        HB5vyfm5mxjB6VTLawfjwwcf9A4xMnEwHmKU4GBWEuGd9GJTshBvSmJlVWpRfnxRaU5q8SFG
        U2AATmSWEk3OByb0vJJ4QxNLAxMzMzMTS2MzQyVx3tSt85OFBNITS1KzU1MLUotg+pg4OKUa
        mDQ4TTevOt2g8bh04/tcSa39ERXvWnqtAjz3aLC7NNXPqvso/9K9by+zpznXP/kT6xoLblfN
        eady6tGn0ls+y85u+GsXUyB5VCgkxcTjeFn8rrmZvV6xvcerWe+re5S/y9pUV+az9smsiNWr
        f4Q5FK84E6CcURWu0uq6x2uHxWe2LpcZG8t5v2s7/I7fGa0r1SenKNPpoW785fgjpR+V53em
        X/zutjEocZa8Y0eLmMj/jN6zVw7131Mya41ma/wiYafwTriv/qnxsph7wXMTTh4rO8z7cv9j
        wVd3etTMT0q2le+qtio9dOHPPzOuM7OWJp21tc0Oeeunx5ImJz1f7+KfhfuuVR9jytbod5un
        xFKckWioxVxUnAgAoVMNajAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO6irZuTDd791rZ4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2RxdGOwxaKtX9gtOnf1s1rM
        urCD1aJ17xF2i8Nv2lktNnxfy+gg4LHhcxObx85Zd9k9Nq3qZPO4c20Pm8e+t8vYPPq2rGL0
        WL/lKovH501yARxRXDYpqTmZZalF+nYJXBnTZkxiKzjHVbGmbyZbA+MCji5GTg4JAROJr6db
        mLoYuTiEBHYwSjRuWc8CkZCWmN6/hw3CFpZY+e85O0RRM5PE1sZTYAk2AVOJVXMaWUESIgIT
        mCROvjsG1s0ssJVRYupnIxBbWMBL4vODNYwgNouAqsSO9TvAbF4BW4m9C08wQWyQl1i94QAz
        iM0pYCfxp+MCWFwIqGZ7wyfmCYx8CxgZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525i
        BIe7ltYOxj2rPugdYmTiYDzEKMHBrCTCO+nFpmQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6
        TsYLCaQnlqRmp6YWpBbBZJk4OKUamOaW1l0LXR7OxP7ssHXN05mCAl8+tjXWePuVu1oZF+jk
        mMtt/+Jjs2VDfOIkYb4v3jcqvPUe/Wef22jMwtw180eV09vY2dYPHxQp3WjJPL9LzlG6fL/E
        v6fu79QFDp21vDafSeOyR9jRwrCmmV+und+T1dB3bcWLt+su2V1SmLJXbgOHwtO7IZclHj14
        tOJK+2WmIvn792adzNeamrnY9XtW2Z19c+6sjy36fKVIwcKysd8toV++sjNi3+nrRy76My82
        mXhFJu3HRNWOlp3ntp3v4do47a9dvaGj16R7jXvTL6+VW2TRYLAkN6M+g3959M1bmf/c2jyr
        OVT5VAT9Vi2xPGIllBPm4B+5U2PfZyWW4oxEQy3mouJEAJT4uDvmAgAA
X-CMS-MailID: 20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node support for sound card on Tesla FSD board

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index e2fd49774f15..ce726bddfb50 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -29,6 +29,43 @@
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		simple-audio-card,name = "FSD Audio Card";
+		simple-audio-card,widgets =
+			"Line", "Line Out",
+			"Line", "Line In";
+		simple-audio-card,routing =
+			"Line Out", "LLOUT",
+			"Line Out", "RLOUT",
+			"MIC2L", "Line In",
+			"MIC2R", "Line In";
+
+		status = "okay";
+
+		simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "i2s";
+			bitclock-master = <&tlv320aic3x>;
+			frame-master = <&tlv320aic3x>;
+
+			cpu0 {
+				sound-dai = <&i2s_0 0>;
+			};
+			cpu1 {
+				sound-dai = <&i2s_0 1>;
+			};
+			codec {
+				sound-dai = <&tlv320aic3x>;
+				system-clock-frequency = <33000000>;
+			};
+		};
+	};
 };
 
 &fin_pll {
-- 
2.17.1

