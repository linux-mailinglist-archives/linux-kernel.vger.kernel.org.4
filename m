Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1662B6F4F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjECDrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECDre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:47:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC82683;
        Tue,  2 May 2023 20:47:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1FFD13200B83;
        Tue,  2 May 2023 23:47:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 02 May 2023 23:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1683085651; x=1683172051; bh=V/d/3EsAUu
        tJ/zE1JIkDiyrgpJXuHYYJg8L0EWtFynU=; b=gCJbXru/26p0OFK/4+NzCBhVdo
        xJbP0QoYLpejtW1zZOmhAHbKibz6qBFPbOa7QrdF8dzzDbhPPXGH8UlKs8gMhl9F
        7q2IE0YjDLycq+3DnMq5jPolyMZ2TUOhntl9wUMohCT0oDXQVCbXyvRn3LgTp39e
        bQ0xqn3XfqZnYofss3F59UODL6qNJaj4Lx3mGvQbsf+4rzaVVJjCsxUxps5Y/e55
        uhKH+v/blGqW3VMWYZrWDAqsnP/l4ZY905zZa2Z8VDNMox8lXqIdikh/WlBeBEqq
        nu0EOX8mr9aaoSt93z4sK0RWvQr4jmbpMbaR8AzCR7Wb79lWRC0Uyau8KDbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683085651; x=1683172051; bh=V/d/3EsAUutJ/
        zE1JIkDiyrgpJXuHYYJg8L0EWtFynU=; b=dfWYp3WmDiJGciJ46jC2WrnAKwNcP
        mnSMy3XkPZ4uiRilU3Es4nZVHKa2usUqymbrO4CSdjoXYWLxt1FNIs/JFNuLsh//
        575I/trxL2CLuS3WJxoAMtRgfMB3ltGufSGicCcZ5M4gYLY6EBtDvtIPtJEgsEPC
        dmoWl4LymMYNC3suQUdiWhg1fFGznxyFREYmjC/jlgJFi6asc+auflOMimtoM+uv
        vFyD52fh17dme9WBWqLT+A2ss0H7z3rBBhZlWeDpnN8AtnVpOzheu/IHUQAnQOEB
        YvNL2Oe59KIfIOMmt6PiLKB0kNKwCDjSH8WX+UqAx1CncoNO34DgFoLoQ==
X-ME-Sender: <xms:U9lRZOPk0NUJsR71-vsDdyBJJ0POOGh60MyIVJVGWPkp7ab5TWGipw>
    <xme:U9lRZM-Cz9oG0Ph2caCsoaRtp9NiXskEpHZBj5Gi_Zr2nRAvZK8JnfUvGFvlVGe5C
    13Cgg2QnLkkWpgTmwc>
X-ME-Received: <xmr:U9lRZFQEFao6wEXjBVZNM0dqaUy_qTKaRl25Hl4cpmMPi8zCpztm653FPtzi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:U9lRZOu7KWc-XxugfhFgomFQv8M7M_X8l1HEm9lE-oOAm25EPpJ6eA>
    <xmx:U9lRZGfpga5fHjHhe2YBiiIqAL6s3vigo0dhrCpmBSPT_UdHy1A87Q>
    <xmx:U9lRZC2H3QLBEf6K3ORUm9r7YvtmbH_X0ZBPAVe6mlrd-CsOxkGQaw>
    <xmx:U9lRZG7FrFcwNOU-hgPpVhGwSYlKsslEXM_Ixy-Ug9BJky7k8ejeYw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 23:47:28 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-input@vger.kernel.org
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 1/3] HID: asus: Add support for ASUS ROG Z13 keyboard
Date:   Wed,  3 May 2023 15:47:09 +1200
Message-Id: <20230503034711.253439-1-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ROG Z13 keyboard. This is a variant of the last
few ASUS ROG keyboards and has much of the same functionality.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 3 +++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d1094bb1aa42..ac93f987d822 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1267,6 +1267,9 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
 	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
+	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3),
+	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 	    USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD),
 	  QUIRK_ROG_CLAYMORE_II_KEYBOARD },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c2e9b6d1fd7d..513290a2e91c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -207,6 +207,7 @@
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD	0x1866
 #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2	0x19b6
+#define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3	0x1a30
 #define USB_DEVICE_ID_ASUSTEK_ROG_CLAYMORE_II_KEYBOARD	0x196b
 #define USB_DEVICE_ID_ASUSTEK_FX503VD_KEYBOARD	0x1869
 
-- 
2.40.0

