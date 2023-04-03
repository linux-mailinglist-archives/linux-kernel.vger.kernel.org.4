Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF506D3B83
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjDCBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDCBbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:31:34 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403135BB6;
        Sun,  2 Apr 2023 18:31:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0CBBD3200976;
        Sun,  2 Apr 2023 21:31:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 02 Apr 2023 21:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1680485491; x=
        1680571891; bh=vu5M9yMpN9Ov9B/2p2OZEU1hE+55vPvtCBpGCZL8hkw=; b=A
        XwQBcJcmi8a0ui0niLX3jNZbn+Rvb9Kq9Nd+KvOI4zPgFi6Z1u6SaeEXvRvmcu8S
        uUwwDhJPU9GDjiC9IFunUuIV58opsaahkKqG2z3e7vttkwOt1oRQLZpSxjL6VL7X
        y2tDiGZbnxc+3UX4GsjBGla9X2eD0W7e9rWyupgRJwW19rPD9YsgbDRX+lOz2R9S
        8K3nwRaJ1AhcBilXvxhsslZP1MQCiV2XBiIZXsfuOATtvKp2aw2n3pwHBnBByyCE
        CYVXhWCagdoCOtPG1pztL9zIPefYqmsgPYR7jcoRHLnOqAetA9IyQ6dr3f9+TC3I
        IgSSlDP3uy686P3UwY/pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1680485491; x=
        1680571891; bh=vu5M9yMpN9Ov9B/2p2OZEU1hE+55vPvtCBpGCZL8hkw=; b=u
        IAcb+n73tC4JPUY6bdmFy8v9FmWfFMWDzd1SzpY3DoCD/zqEPx+hjZnTn2uwhM7l
        Nri55HZYIhsYSX5ql5URF/y20eb97QyBIglpNztsd5rTPM5WEKrokG2TC5I2jALd
        cN3++e8HgCgLvMjng9bvfDmscTvt0ThXYjmH9FE7+wrtED20nlgoG0TeAmSbxWhj
        SIJEIjZPXZP6LAtoyOGjI1kbmS/7L6N8gGQ9io1y5iXht0UaqhMSL3tx02Oj1fkO
        syQbGa5QpR0NylQMh8ZalXp7bM2zMlf/fADfjsJ1SNM8upqjJwW8wq47As8BiPJE
        CrCdUYsPf5+ewnxdtT7vg==
X-ME-Sender: <xms:cywqZNWLjEULYjDM-sOZ2_Zlmck340YVu2L8hyWae9qVuePE-wB52Q>
    <xme:cywqZNkDy8gvLgrKYrrtVin4pbD5fRIK3Bd4GZYJiLgw3m4EA3bR0vfgytckb6vw8
    sIWWrcT_ghYsO16m2A>
X-ME-Received: <xmr:cywqZJbxUZX8DkRWxH9OSENbm2SbHzRDK3LzahQ9VSgDZ10FLAlt6A-AFo2pGL97CAt2Juhi98PcgycaMFv7F1qBHBqcIhrS6JGEqq8kpCI1QLffc7eaQqHuN5dxHhcoTx9RWzjcqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiiedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepvedtlefggefgjeettddvgfekhfeugfeutdekfeefudeuuddvieeutdel
    jedvhfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:cywqZAUNHEK-J3g_-AhkMLlL_FAbHOmJH-x09ICuucWuDObdKKeYBQ>
    <xmx:cywqZHnNg-z00QlY8szZJS1r74PrPuSPzkC0tzaZKMwVbibJ115pGg>
    <xmx:cywqZNfOK_mhA0l2dXx1ew7HTpS-m5SvgKw6n0RXE-mjQOw7o_bZcA>
    <xmx:cywqZFU2UaLcprAG6X65AnRXpgNf7znSGPMV8t2syTOUNEsWGu2L0A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Apr 2023 21:31:30 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, W_Armin@gmx.de,
        mirsad.todorovac@alu.unizg.hr, linux@weissschuh.net,
        Mario.Limonciello@amd.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: think-lmi: Fix memory leaks when parsing ThinkStation WMI strings
Date:   Sun,  2 Apr 2023 21:31:19 -0400
Message-Id: <20230403013120.2105-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Changes in v2: None, but rebased series because of issues with second
patch.

 drivers/platform/x86/think-lmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 6034df6d577d..87f832142d8d 100644
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

