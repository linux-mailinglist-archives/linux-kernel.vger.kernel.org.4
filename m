Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B647C5FD766
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJMJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJMJ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:57:09 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16561D317
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:57:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 561C75C00FD;
        Thu, 13 Oct 2022 05:57:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Oct 2022 05:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665655028; x=
        1665741428; bh=fzePJBfgekN27jwbUeNwvvkHu+S3PaZkEzmettXE8PQ=; b=J
        2Dv4VwaxOMaD9l8owZN6YIbOqIw6RawDF7G44tAA14XrhpISEb4M8OiWpGy0+RCx
        hnELAquLcAkCZBjVZvESwRYL0WEunxy8ndOt4r6JBtiULJp6F/zij4Mdo5f49R50
        8uycZDqJc7UfoSGcdiGFMJkydpeqArHygm+777FI1xC58xp+QlkP6jMIbAKNigHm
        ueUL+w11h9MUmti7CS3Oz9Q2J+IA9qGrhjhqY2aLMpJZHFsmm1E6ZCEHnzreLLCg
        cMOKREBksZ2diBOLCtZIx28zasElbGC0eafTRfa2F30ez0NSvI08Vh79yb5OeKtu
        fLBYakZnxVsBi9nacI+0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665655028; x=
        1665741428; bh=fzePJBfgekN27jwbUeNwvvkHu+S3PaZkEzmettXE8PQ=; b=l
        1gocYRau031QGq8M5inb5JYkWB7UCT/5+Rq2xgwe3YPeKjWGEuH34iHkSBhVbtMH
        QSF6msswuKIFV1ycV7qC1xH2IgEmu5kNjL5AZswbnqivz2h86Ckam8C1jYd+G8B2
        wsBXYitYHRM2JyIcrpzg8u6FEJfF39wGKH6yMzvA2vv6l6nfS1hF+vN9x7rDqaMu
        +uDG2kWk/u2so/I6WXHw/T5nR7G0p7Q9JwBi0WT0OqD/nkqwZw/7ylH8IOVABbUn
        TH+ZnXAEkg/udahPlRT1z2uHWas/LpSBFvzBA3tVeUDw/bicqdVZKAjf+Q74j49H
        iCcBxXDRxg3S9IrqoAtuA==
X-ME-Sender: <xms:9OBHY2UGzWjgxgNL4WNws_ZuWRkGE_-x_Ra8Gyi5b1NiF8S6Gd9BAg>
    <xme:9OBHYymTHJYclh9Mehc1F8sbOghcvMgSFzzphJjPenNvdhY0ig1YvPMcUXkoeTShS
    1ZGg2DgOftEvEPNSXk>
X-ME-Received: <xmr:9OBHY6bWjcVC1lohuC1XrSsPIDAezt368xKIVk3Ssg2PKDnDiQ0K-_q0PEp_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9OBHY9X0KKbP1rookKwv6eljyI9eibmNdTAraga7uz8dJgKUkw7NrA>
    <xmx:9OBHYwlhBzJ1x3ipKfWsB3G0yMlfNB-l0ecqArCmg5aHc6ZBP_3ljQ>
    <xmx:9OBHYycDhbHUGl1ZNzbUbgiZWpvDsUpXyMlfzSyH7uB0xOcqXYP-4w>
    <xmx:9OBHY6ctDmk146KV5vnU-CHg9ELRkQywztMZryCbtVKJ9sWV2vv8WA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 05:57:07 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 13 Oct 2022 11:56:46 +0200
Subject: [PATCH 2/7] media: uapi: add MEDIA_BUS_FMT_BGR666_1X18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221013-rpi-dpi-improvements-v1-2-8a7a96949cb0@cerno.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=/lJlArH50OghiguxY4jwNzQdKqp5YZ0WFt8xFs+ec9s=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMnuD97Gx/+Y+/DXFbfwWZbXVn0oiahdEGg58YTSPNbLe2yv
 THN+1lHKwiDGxSArpsgSI2y+JO7UrNedbHzzYOawMoEMYeDiFICJxJ5n+B+/P++49bbq13PPXFdhTO
 e7aTLp5NdrIZFHM8ye1jhVCYQyMvw+Wtf+PpSxyJu7yTaX08+mhvFF0fztMt+UKs4xqqxfwQcA
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

Add the BGR666 format MEDIA_BUS_FMT_BGR666_1X18 supported by the
RaspberryPi.

Signed-off-by: Joerg Quinten <aBUGSworstnightmare@gmail.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 include/uapi/linux/media-bus-format.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/media-bus-format.h b/include/uapi/linux/media-bus-format.h
index b0a945eb7040..2ee0b38c0a71 100644
--- a/include/uapi/linux/media-bus-format.h
+++ b/include/uapi/linux/media-bus-format.h
@@ -34,7 +34,7 @@
 
 #define MEDIA_BUS_FMT_FIXED			0x0001
 
-/* RGB - next is	0x1023 */
+/* RGB - next is	0x1024 */
 #define MEDIA_BUS_FMT_RGB444_1X12		0x1016
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_BE	0x1001
 #define MEDIA_BUS_FMT_RGB444_2X8_PADHI_LE	0x1002
@@ -46,6 +46,7 @@
 #define MEDIA_BUS_FMT_BGR565_2X8_LE		0x1006
 #define MEDIA_BUS_FMT_RGB565_2X8_BE		0x1007
 #define MEDIA_BUS_FMT_RGB565_2X8_LE		0x1008
+#define MEDIA_BUS_FMT_BGR666_1X18		0x1023
 #define MEDIA_BUS_FMT_RGB666_1X18		0x1009
 #define MEDIA_BUS_FMT_RBG888_1X24		0x100e
 #define MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015

-- 
b4 0.11.0-dev-7da52
