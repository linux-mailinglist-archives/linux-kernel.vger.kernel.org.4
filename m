Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187A45FD767
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJMJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJMJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:57:11 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF1118785
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:57:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0ED9C5C0153;
        Thu, 13 Oct 2022 05:57:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Oct 2022 05:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665655030; x=
        1665741430; bh=XGmWWgDw5WokLE0gsZ436DZNtPe1pLT1+ayIAvJ/eP0=; b=o
        LWy60b+YVF/i5xSdbi4PqitxsVAreY767A313vTjcPx3kfY6aeOunGRdNDY7M6O9
        Bh11nEts5BTds8EjhJIDqy7TifbVukZ45KyvwiBdEW13vv4A01BvNtpWKXMqa1CP
        4Ir+JynkzOnyW5XQmG+TODRwmOR0RCAPEpmVQAbjcogI76Zqe/pM88ulPNlOWNDI
        YBpbDR2SoNSGYKHOCl7oEJNtsDPJ1RrxMyzyCmQZPDB7wERnOm5YUDZGHYeL+oaW
        BoB6nUPMIveZCZ/avHYWl/Do6OcPEapOM6cIKbaH/XdINdJLMWii8krW9RxUIzrb
        nUg578teF9tRq2p8uJrvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665655030; x=
        1665741430; bh=XGmWWgDw5WokLE0gsZ436DZNtPe1pLT1+ayIAvJ/eP0=; b=A
        9ofJhQE/Jk8iIf+xr23lNd7TBMLZEM8qU3Vk+pP68HsJhEQE/t0OfiydLEZFWdGO
        gU7sv4ETDxgxNvv27pWU9y25E9HZY83v4iA8XMPMcOFIPOxm7Zq6JTBZQ7N5HZuB
        KNytf/EZRzL5KuNNoabu2Qwxo5nLwdqq3mjw4UQR/eRmFf3aJux5OqDNz7iOAnfp
        jxWHLYJf0JmL8bjR58iQ98uZHAbf2kgB9a/w3ZpHGtZurlev2NYajyevM41Sl/RP
        5icV9lBrYvs4MIi9XzuXSqvR705stbYCWmNJkPYYI4Jm3jK0Strp/i/8B/bBHstP
        We7Z0T8GgQlZmlaSaUNzQ==
X-ME-Sender: <xms:9eBHYzpNIIDA2mRP-FzYNgct6MkDuovJ7Ns20Vbx52xJdc7hzymh0Q>
    <xme:9eBHY9oZkViNKBJusKEDn6rXbtNCVKplFjnCjua9I7ggDtr-M2HbLSRioO1gMc2BY
    YLlfV85Ck1czI2y0Hc>
X-ME-Received: <xmr:9eBHYwM2WusVkrBBgXlpUufx1PG3uhFw5V1fiG6siQXupMB0LhlL4WBHy4_f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9eBHY24dl-vjFmMUS1YlRH4aGU6yE3k6Hsth2GmB4yA3xvkdhgk6aA>
    <xmx:9eBHYy4gdNUMfSUumx4KQ18r5jfSjH91DUjeiLaMT6kwLki8GeAVhA>
    <xmx:9eBHY-ijqUZMCEmlTU9dTmt__xKlwdrcj8UDnoWyfa66gz0UKv0m7Q>
    <xmx:9uBHY6iAEMis1J0JEq3I6lluVsfZkWKBaiOG8_671Eo6x3x_V-eo0w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 05:57:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 13 Oct 2022 11:56:47 +0200
Subject: [PATCH 3/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X24_CPADHI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v1-3-8a7a96949cb0@cerno.tech>
References: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
In-Reply-To: <20221013-rpi-dpi-improvements-v1-0-8a7a96949cb0@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>, Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh@kernel.org>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Joerg Quinten <aBUGSworstnightmare@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=0XY6F612UcTptE6B+KNZY6b+mxAKI6UoQCqYByTqpxI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMnuD94W//708kRG0vrHhkysSateuV96u+Xbw7o2R63uHwvv
 miXVd5SyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi+tYM/+yOSP7X8ulZsjBHyMtNuP
 nKoqcbr1kk2WcctXsc1Pum6RjD/9QyDRfGs9Vq/290px/yz27udJIpLv99kqd0Y1LVE712PgA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/uapi/linux/media-bus-format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
b4 0.11.0-dev-7da52
