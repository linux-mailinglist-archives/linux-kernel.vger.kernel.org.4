Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3560E1F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiJZNUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiJZNTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:19:09 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC58FE91C;
        Wed, 26 Oct 2022 06:19:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4B7AC580613;
        Wed, 26 Oct 2022 09:19:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Oct 2022 09:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666790346; x=
        1666797546; bh=+V4TsO8tEqxe5KltQxNxTGX9CT79Zyq118K8riiTZ3A=; b=c
        RxWsOqEPEuxBkprD//jj/Oe1vsrreUBdl/EkJpsp58fNdP3RjvVGkuNVXKOyAcg+
        axZgm/4QBEm0JE+IM8n/FtC2IDXIpmOs4r9wIesUO9yeYtbYs+YUBwDvJP3eCK4I
        otim72RRWOqED29IFI4CV+qE2hrglqIf5zpMUAkq+8WJ5fODoUxMkagrRfTSQtIP
        ahH3FQsxXd+geoFEdWVa6HwbptuubYbqLhua1v1QLdES0n+yP6HuoVh2XjE7ly8H
        W/dCJIWvD05+DjcNM9zfFqndwf/pn7Wn0PCR3Li3hw8yKHkghKhX51jV2fTMWrED
        0X7RWfJZOWZv76NZLZOmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666790346; x=
        1666797546; bh=+V4TsO8tEqxe5KltQxNxTGX9CT79Zyq118K8riiTZ3A=; b=Q
        7WtlSYu3LRZ9mCMge9xj/cPHJuSf/i+BEQeei5VuhjZTtZEHQ0ihM7Z6EC+1LGe0
        eTHLqthLADFaZR53u1qHYBMhmwLCYE9u9aXdKjM/OY4sb9av3+9zsTYQxGNGh0er
        bcs4jX2EHaMhXHp0FuqCAMrZHUweaGqG8AddQuEnC6G/JpMTxFOLyZ7avbC+hVNk
        eafYSvDYK8GWmZp9DSHsgUATJ8CkwOVPl+QrSSRe9OPqzeGFh0p8kCb/bfkg8W2z
        YBrwcq2JfGUY8JG8cs3tmeqyd1/LvSMiuQv0J9VGFDT3NGMJelpuVQvbOOf4MDdF
        a4zD1rQUVXizkzlMjQwhA==
X-ME-Sender: <xms:yjNZYwFIhMXPkm6w2zW9IDK4l1r2Lt5VEMP9d8bA1YkRFHiSF3_IzQ>
    <xme:yjNZY5Wq5XiKSiaEIOOVLmb1UIWVcKv-szGT7sXtfRh89BrUTuT1CNshQMTQHwKpD
    9i7l5qNMlXRItrH2Ww>
X-ME-Received: <xmr:yjNZY6LXxz9pvKpmyvhytqBJSjJ8JfToHnhH18TkXM-PbnDlh-CNX6rzjmZDeuf6wiZ_CdOywY88Xyi5_VdC1RhZPPZNcGIjWSafyT014Ic_qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeefudfhgeevhefhfedtue
    evueeluddutdetuddtvddvgeekheelvefhteekteeihfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:yjNZYyHIDT5F63ttQJJPDc1j4oejVA-XMGe0pMoABWMk0ZxiauqdoQ>
    <xmx:yjNZY2WgWyYNlR0ETQnObYC1G_KA7fDco_jQPlxYUq9_B4zJ34PRoQ>
    <xmx:yjNZY1OlIJumS1_uPWO254ixQkjoiNzkJdkGJYTeh3wYIS7GeYDGCw>
    <xmx:yjNZY5oapD08GvuHRQr63vlkI9yXn0IkwEFeAr5eeW20njVzdoo01A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:19:05 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 15:17:38 +0200
Subject: [PATCH 1/2] ARM: dts: bcm283x: Remove bcm2835-rpi-common.dtsi from SoC
 DTSI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221026-rpi-display-fw-clk-v1-1-5c29b7a3d8b0@cerno.tech>
References: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
In-Reply-To: <20221026-rpi-display-fw-clk-v1-0-5c29b7a3d8b0@cerno.tech>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6723; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=CkGcM5PYhqsmo3Ibf0jbjJsLTCvop6ORqTYVt513GNA=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRxsWxlWcnnpZJWLvj8FcL9i2fWd53CVza1lnn9zBt9bni
 llSBjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEyE5QnDX4mP3y7UPWLbq/XeZv/SPm
 dRydn7As8Jl5hcYJvKNZXNvZnhD+f6Dc/Wbo9Ym8cgKnRW+UFnrfqcggkpa0Xk5HccM3VYzQoA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the commit log of the commit 3ac395a5b3f3 ("ARM: dts:
bcm283x: Use firmware PM driver for V3D"), the initial intent behind the
bcm2835-rpi-common DTSI was to share data between the RaspberryPies
based on the BCM2835, 36 and 37.

However, it was included by these SoCs' main DTSI. This is creating an
improper layering.

On top of that, bcm2835.dtsi is being included by bcm2711.dtsi, which
means that, even though the bcm2835-rpi-common DTSI wasn't actually
meant to contain data for the BCM2711, it actually leaks into the
BCM2711 DTSI.

In order to remove both issues, let's remove the include of
bcm2835-rpi-common.dtsi from bcm283{5-7}.dtsi and put them into the
bcm283{6,7}-rpi.dtsi.

BCM2835 has to be handled with special care due to the fact that
bcm2835.dtsi is being included by bcm2711.dtsi. Thus, we chose to
include bcm2835-rpi-common.dtsi directly into the board DTS. This will
be more error-prone, but given that it's a fairly old SoC by now, the
chance that we will get more BCM2835 boards is fairly low.

BCM2711 isn't modified since the content of bcm2835-rpi-common.dtsi was
only a power-domain for the v3d that was overridden anyway.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts      | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts      | 1 +
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi   | 1 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 1 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts   | 1 +
 arch/arm/boot/dts/bcm2835.dtsi           | 1 -
 arch/arm/boot/dts/bcm2836-rpi.dtsi       | 1 +
 arch/arm/boot/dts/bcm2836.dtsi           | 1 -
 arch/arm/boot/dts/bcm2837.dtsi           | 1 -
 12 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 9b9a18bbb20a..1470d2049f74 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index f664e4fced93..89be496f84f8 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index 248feb2ed23d..7f653f11788d 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-smsc9514.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index f5b66d3f4ff3..55e7cb0a242f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-smsc9512.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index f589bede2b11..3020c42ea8d7 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-smsc9512.dtsi"
 #include "bcm283x-rpi-usb-host.dtsi"
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
index e4e6b6abbfc1..f71d7e9e5895 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi
@@ -2,6 +2,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 
 / {
 	leds {
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
index 596bb1ef994e..9b3a2070a629 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-usb-otg.dtsi"
 #include "bcm283x-rpi-wifi-bt.dtsi"
 
diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero.dts b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
index a65c2bca69ea..f9359ac2bb92 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-zero.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-zero.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 #include "bcm2835.dtsi"
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 #include "bcm283x-rpi-usb-otg.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 1c90e5a44283..15cb331febbb 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
-#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2835";
diff --git a/arch/arm/boot/dts/bcm2836-rpi.dtsi b/arch/arm/boot/dts/bcm2836-rpi.dtsi
index c4c858b984c6..48b03b55ff56 100644
--- a/arch/arm/boot/dts/bcm2836-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2836-rpi.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm2835-rpi.dtsi"
+#include "bcm2835-rpi-common.dtsi"
 
 &vchiq {
 	compatible = "brcm,bcm2836-vchiq", "brcm,bcm2835-vchiq";
diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
index 534dacfc4dd5..db56a3443a4a 100644
--- a/arch/arm/boot/dts/bcm2836.dtsi
+++ b/arch/arm/boot/dts/bcm2836.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
-#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2836";
diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
index 5dbdebc46259..58b3efe483c3 100644
--- a/arch/arm/boot/dts/bcm2837.dtsi
+++ b/arch/arm/boot/dts/bcm2837.dtsi
@@ -1,6 +1,5 @@
 #include "bcm283x.dtsi"
 #include "bcm2835-common.dtsi"
-#include "bcm2835-rpi-common.dtsi"
 
 / {
 	compatible = "brcm,bcm2837";

-- 
b4 0.10.1
