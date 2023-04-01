Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9586D333A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDASoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDASoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:44:03 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A857694;
        Sat,  1 Apr 2023 11:44:02 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6DF2F3200917;
        Sat,  1 Apr 2023 14:43:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 01 Apr 2023 14:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1680374639; x=
        1680461039; bh=NzdlQHPf2ubVQgJ2HZpDAwS0DtAbvUSrLwWN7up3J78=; b=K
        ZmKcnlKnb0ftNbtcdgOmgHNqT8d/XGAe2faoivoB1BBEy55hWKpJQuJoxH31Alm+
        xoRiATcwAFyAtjHFNqkw6o88CW/qvKOeqoqmzI0Rggdr3eeh++6oR2Lao+ZXT+v+
        jlv8KNKTW3/RRSd8UvNQwFmKWKo+qGoWOi04orMKzfGTCLSE0JdbElBjQBsI8LIe
        NwFH+tr4Wt6jCNuBzoPrlzby4MKM5Ea7GRLKpw7dK7QHsqenOKslXVXQSJQYUaGw
        R7JsJtLdTLssjuLgf3P+uuLfAfbRpsV3PgpUchlrhi/vp7x5pxV5VO95CmysCU4t
        8oNqCNzON6rEhz3xW89MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680374639; x=
        1680461039; bh=NzdlQHPf2ubVQgJ2HZpDAwS0DtAbvUSrLwWN7up3J78=; b=t
        2fNE5E2ltcsimc1VKb+onhUveuswjjEQU7FjkEr25UdU6EqTYBBELWlhJjbUWl48
        zgMEFep6KmlMU2afC8NyT6NzSs+AqMi5o/EEYJ0iypvs76sIv2y4grBveVCR/Pdl
        3k85sYzGmEsNsD0UB0xWmxLz1xSgOrLM8dSwzHbn5upYx8HkPiUnOJA/pE2D0VJi
        cyI6swUtjJLzXpQOQAqRjGvu/Y+ktHBHILX6OLVQ+UbcLaE5+Qy9qje2ILxERvfw
        3Jp+dfL20i2vx/ZifgC0X3lUOuiURBdM/gBPeVnQP+zblI4T/7iGPlYrzjWrrNAH
        uDYIidAjq8vseVdd+a36A==
X-ME-Sender: <xms:bnsoZP2z0bWNRqpQoUyvhsMxJieqMsSYhOXGXXJnsnQrkFBLzJB14A>
    <xme:bnsoZOEMMW0w_BNjol2trzUBmiiuN49OLdULd6iTJ-gX2BBZoD51t3ITB0SV4I38-
    bKJNhMKxw75SJ0ESWw>
X-ME-Received: <xmr:bnsoZP75QIRWD9ACwImVObEu7F3V7WDbIgGX-SNUEJ7ESUKWuy_qayjX9y3PU6T8BsttkxGaXmmBSEq1VFmSK7Z6I6z68FQgmUrqjOz0NK_Vh9lzJHZ91u_q5gDpwOTj4wVf4Dlbsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeevtdelgfeggfejtedtvdfgkefhuefguedtkeeffeduueduvdeiuedt
    leejvdfhvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:bnsoZE0RUK-n8PIfOEvzGusFjBuzRQjyOCmkPWTpR-RH_MOaXXx-MA>
    <xmx:bnsoZCFQ4okyi5UhpnAq2C3dgkHJVP4P3sgRn-4fAeZmQdkH6mfM3g>
    <xmx:bnsoZF9grAbxCRjFOnlAFwmrVj3BHwnuiIoJJwtpGuBZTs6zSRqXVQ>
    <xmx:b3soZF2R60Md8j-4HPGX53t6EWfjiR8p1cwvrApqOcdADoZZXl01-Q>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 14:43:57 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        Mario.Limonciello@amd.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: think-lmi: Fix memory leaks when parsing ThinkStation WMI strings
Date:   Sat,  1 Apr 2023 14:43:44 -0400
Message-Id: <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My previous commit introduced a memory leak where the item allocated
from tlmi_setting was not freed.
This commit also renames it to avoid confusion with the similarly name
variable in the same function.

Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values for ThinkStation")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccda7d8@gmx.de/T/
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
This patch series builds on top of the proposed patch from Armin Wolf
"platform/x86: think-lmi: Fix memory leak when showing current settings"

 drivers/platform/x86/think-lmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 88da7bcb6ce9..ad952b49617b 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1459,10 +1459,10 @@ static int tlmi_analyze(void)
 			 * name string.
 			 * Try and pull that out if it's available.
 			 */
-			char *item, *optstart, *optend;
+			char *optitem, *optstart, *optend;
 
-			if (!tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID)) {
-				optstart = strstr(item, "[Optional:");
+			if (!tlmi_setting(setting->index, &optitem, LENOVO_BIOS_SETTING_GUID)) {
+				optstart = strstr(optitem, "[Optional:");
 				if (optstart) {
 					optstart += strlen("[Optional:");
 					optend = strstr(optstart, "]");
@@ -1471,6 +1471,7 @@ static int tlmi_analyze(void)
 							kstrndup(optstart, optend - optstart,
 									GFP_KERNEL);
 				}
+				kfree(optitem);
 			}
 		}
 		/*
-- 
2.39.2

