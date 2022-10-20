Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0129605A35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiJTIvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJTIvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:51:05 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255F01781FF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:51:04 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D9CE532000D7;
        Thu, 20 Oct 2022 04:51:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 20 Oct 2022 04:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666255861; x=
        1666342261; bh=PKJ8/FJVazKu0rZJdSAHPWz1uZunYeVSN11ubuL5dWc=; b=V
        MzVtaUkg7Y3PWdnsLOiEmUAX0nF4RrS/0WEYbBy90H8KPh258WUpD6S/dRII4g09
        MupOIzPHfjlKOxZ/KX/kJhpjmP3hirvvsO2l/sKL6lgzBSO7boF8CaHdQd/HdBUQ
        E5dQawfdGa5Lxf1tfuEqceJ/fSrK4mmsBrt3ZVcTkCLcKDLUu7bwIp/hNXxweP3o
        eqkP6qxOcCqRhynQaLGSM+38GxwVxvCitTffMGdDcvdA0jOBsR/0Yx60QVkuYMfX
        ZHeZFV0iB0HKSv9Z9sgU1bDMGSrDmC58F5rJg27NZbFnPzEpJQvorJOEXEOYsTl3
        BUkDivw1T/bpDK4++i8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666255861; x=
        1666342261; bh=PKJ8/FJVazKu0rZJdSAHPWz1uZunYeVSN11ubuL5dWc=; b=J
        8j1JY2EpwA4+43ebhjFQT5/9ysUSeAmwUSZbwYVjAUn8yBEkT0ywh0EaT5/Wp0jo
        o6IqCDElU4x93hjtY1jZ81+POPy6pfoTCPftGbWcUERMh+pkFkyq4osNVaxGqZ7M
        Lqx1HN+Uujwf9teiq5NRThb+O0m3aQfXtOOyMLqEiJIGLE/16lw2LOmj168nmeKC
        QNj+T7JBRGa77tv1fRzEFB3YJav5fYY8787Zt7xWYbuSCRrZN+v+H4Vfl4DSdOU6
        7PYKmvC8v8EtTVBkV1/nTF8OCRDfKWaGMr4QdoHoFRTfTg4sKL3GVWp8fZyZdqGA
        Oty0FJ0ja0p9g8ysyfwDA==
X-ME-Sender: <xms:9QtRY7qW-a8Bwa6DqQoVyZvO8MCk_kbowaUZNsGpuMaNCi-RBxTzTA>
    <xme:9QtRY1plHrLjfmxi5mBpY9wDDmKaqTExgr9ntEO4gsgjZEoG0l_Vn02WuaLs9AK66
    XiTcUgT_Ab4PHUj9Nw>
X-ME-Received: <xmr:9QtRY4NbWJgRggijcjKCSI-Weq-nomy4Lu8Hh2IrkMWXPJ17c4tFxMndD0R5YGpB9maDpkWRy7CPb3gn9InaCewjL51L4qeHsQuG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9QtRY-4Ufnui3rHwASCMV6ucDZ8_RzXpDLM3VsCehUucTvHR6Is_Fw>
    <xmx:9QtRY66BKMcaE8uHzzbv6UWKLMEwC4cQhM4NcmNzFgeca6FnqgvS-A>
    <xmx:9QtRY2gnECL1_Kea9lWdoDAWJZuipX1ShQhJEc6NTnSFsL5QHyBugA>
    <xmx:9QtRYyo72gn4KV8mpy8Ocgk6pP2BEHaoqtWixl9sHowTagCPExWxmQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 04:51:00 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 20 Oct 2022 10:30:47 +0200
Subject: [PATCH v2 3/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X24_CPADHI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v2-3-7691903fb9c8@cerno.tech>
References: <20221013-rpi-dpi-improvements-v2-0-7691903fb9c8@cerno.tech>
In-Reply-To: <20221013-rpi-dpi-improvements-v2-0-7691903fb9c8@cerno.tech>
To:     Emma Anholt <emma@anholt.net>, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2458; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=sMF/6xWvN1j3OHomDCM8BkX4bvf8ec1/O5U3k7n2Q1s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmB7BZzTOs3/BBI4AjcGvPnxvYN0qft/rL/ruHtXvxiEkPK
 6obXHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZjI6SkMfyUk1isu553M2hF9pmtGTL
 h4+dHXqVuLg0yUit4aNorYPGVkmO1ktfr020lhC/6defthwqTH7Qt5Q87cKI32b3v5m1dpJjsA
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

From: Joerg Quinten <aBUGSworstnightmare@gmail.com>

Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X24_CPADHI supported by the
RaspberryPi.

Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 .../userspace-api/media/v4l/subdev-formats.rst     | 37 ++++++++++++++++++++++
 include/uapi/linux/media-bus-format.h              |  3 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/subdev-formats.rst b/Documentation/userspace-api/media/v4l/subdev-formats.rst
index 68f8d7d37984..604a30e2f890 100644
--- a/Documentation/userspace-api/media/v4l/subdev-formats.rst
+++ b/Documentation/userspace-api/media/v4l/subdev-formats.rst
@@ -1023,6 +1023,43 @@ The following tables list existing packed RGB formats.
       - g\ :sub:`2`
       - g\ :sub:`1`
       - g\ :sub:`0`
+    * .. _MEDIA-BUS-FMT-BGR666-1X24_CPADHI:
+
+      - MEDIA_BUS_FMT_BGR666_1X24_CPADHI
+      - 0x1024
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      -
+      - 0
+      - 0
+      - b\ :sub:`5`
+      - b\ :sub:`4`
+      - b\ :sub:`3`
+      - b\ :sub:`2`
+      - b\ :sub:`1`
+      - b\ :sub:`0`
+      - 0
+      - 0
+      - g\ :sub:`5`
+      - g\ :sub:`4`
+      - g\ :sub:`3`
+      - g\ :sub:`2`
+      - g\ :sub:`1`
+      - g\ :sub:`0`
+      - 0
+      - 0
+      - r\ :sub:`5`
+      - r\ :sub:`4`
+      - r\ :sub:`3`
+      - r\ :sub:`2`
+      - r\ :sub:`1`
+      - r\ :sub:`0`
     * .. _MEDIA-BUS-FMT-RGB565-1X24_CPADHI:
 
       - MEDIA_BUS_FMT_RGB565_1X24_CPADHI
diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index 2ee0b38c0a71..d4228d038b54 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x1024 */
+/* RGB - next is	0x1025 */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -49,6 +49,7 @@
 #define MEDIA_BUS_FMT_BGR666_1X18		0x1023
 #define MEDIA_BUS_FMT_RGB666_1X18		0x1009
 #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
+#define MEDIA_BUS_FMT_BGR666_1X24_CPADHI	0x1024
 #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
 #define MEDIA_BUS_FMT_RGB666_1X7X3_SPWG		0x1010
 #define MEDIA_BUS_FMT_BGR888_1X24		0x1013

-- 
b4 0.10.1
