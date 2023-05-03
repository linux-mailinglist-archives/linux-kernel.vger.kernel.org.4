Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79586F4F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjECDro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjECDrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:47:40 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E22D69;
        Tue,  2 May 2023 20:47:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5ABCF3200B89;
        Tue,  2 May 2023 23:47:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 May 2023 23:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1683085657; x=
        1683172057; bh=GE4ZZwE36FI7n9XRr0c3ku1bZdvpZHi3wyNYWI2WMCQ=; b=A
        FRFP6BxEze6wYlk3J8FeRGTYFL8op0e4dFva7u2Sr/xhk0CBXtIW+0YL8NJ9l3Cl
        tOBlWdeM4H16kTrE55I+vNHzjwcLUDV5Mq61zDlzYNtsnNG/I2TtOufxj3sISNAe
        4RYIiIBoAM0pFR07izAB+ff9I4+qcB1Sg5QDsPLF9lMR302dbQzVEU65vGMvaUdN
        PcDyVne7e0TbBcQbncpoSqZ2Kx4OWK+vVhTe0yPJle6yiuzch3Q7X51chtIFWX8c
        ZiNqW3kJ+DXs2GSIICt9Ox+gzM83Eexcg/KuxaCko8zGmgNI/LFlSJWuo1wbhMrI
        Iz8SUwPT9bYLPm0H24rbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1683085657; x=
        1683172057; bh=GE4ZZwE36FI7n9XRr0c3ku1bZdvpZHi3wyNYWI2WMCQ=; b=U
        nnF2LAhzcWqFi/RWguKVR29vq6Vxd6svdqLPb5xLuPbJFVmpg1lyMXS+dycc5z+1
        ZlYadwGgA3UnfVQ7UVkVvq0F3QXpmHYdkmBTEe1qzsUELD+/lQ7BsxSQS8cQyLac
        btTmxk1+V+dGVMFZ8XezgmVlppZMZgrlELxxl7GGPGMZowBYPaYAQ/41BG70q3qz
        fn6HmZV6kbAhwRNpkdMHem8vRe5sjCgNfbqGAGbbfEQMntUC8VDMbCvOaGwQhCkk
        5IdFuk/2OVBsdbuMNOlZ+a6Er6CR6E28CdbowupITIMLUUVQpmkO+hjxqlqDJTaL
        M/vb+FEEg0FdZQXm/s/4w==
X-ME-Sender: <xms:WdlRZGtfMizRLs_73C4OM1Naa5eCAVeZyIRlLM7-ydwyAkr6FOWxdA>
    <xme:WdlRZLfexhvJEw7LywoT5Z1zwviurrqjX-3uxlbkLrXZwiuoehyfaeM3GL_Vw36KV
    WfgJOXnDqidUtPAxfk>
X-ME-Received: <xmr:WdlRZByW2XlGIS5g6uZ9PLrDvrkuiznGnlM1mevh6TR3T7za3uoflgolICme>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:WdlRZBN-NU2Uulee2KCSM36FggU5aTLJa21CxKAVf6Nz0C03ij2lzg>
    <xmx:WdlRZG-E097y17Ul1IqYDmi_yy6KjDrAX1wEMUbEXvJHZ0jeA0VpSA>
    <xmx:WdlRZJW5RcLyVC8kZ1Q60eypT5WlhY2NEFlC8iMhkurzoJlB3-0aoQ>
    <xmx:WdlRZNbccZwos_dyiVCUr0rIZsFHUQLbu-uG8ph0becs0n87CWDSug>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 May 2023 23:47:35 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     linux-input@vger.kernel.org
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/3] HID: asus: add keycodes for 0x6a, 0x4b, and 0xc7
Date:   Wed,  3 May 2023 15:47:10 +1200
Message-Id: <20230503034711.253439-2-luke@ljones.dev>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503034711.253439-1-luke@ljones.dev>
References: <20230503034711.253439-1-luke@ljones.dev>
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

These two keys are found on some models with dual display.
- 0x6a is intended for controlling the secondary screen brightness.
- 0x4b is intended for toggling the arrow keys between arrows and
  page up / page down.
This key is found on a slightly modified keyboard layout.
- 0xc7 is intended to cycle through keybvoard brightnesses (upwards) but
  there is not suitable existing code for this behaviour. Using
  `KEY_KBDILLUMTOGGLE` is different behaviour to Windows but at least
  is picked up by many desktops already.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/hid/hid-asus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index ac93f987d822..918d0d05ca88 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -883,6 +883,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
 		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
 		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
+		case 0xc7: asus_map_key_clear(KEY_KBDILLUMTOGGLE);	break;
 
 		/* ASUS touchpad toggle */
 		case 0x6b: asus_map_key_clear(KEY_F21);			break;
@@ -911,6 +912,12 @@ static int asus_input_mapping(struct hid_device *hdev,
 		/* Fn+Right Aura mode next on N-Key keyboard */
 		case 0xb3: asus_map_key_clear(KEY_PROG3);		break;
 
+		/* Screenpad toggle on N-Key keyboard */
+		case 0x6a: asus_map_key_clear(KEY_F13);		break;
+
+		/* Arrows/Page-up/Down toggle on N-Key keyboard */
+		case 0x4b: asus_map_key_clear(KEY_F14);		break;
+
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
 			 * as some make the keyboard appear as a pointer device. */
-- 
2.40.0

