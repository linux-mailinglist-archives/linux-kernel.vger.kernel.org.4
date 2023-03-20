Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDAA6C06D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCTAcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:32:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595F168B4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:32:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 776355C0084;
        Sun, 19 Mar 2023 20:32:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 19 Mar 2023 20:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679272352; x=
        1679358752; bh=/6Xha14LNcuPBWYFX7xY2TJKKvWGWGj521bnvzcA2FQ=; b=U
        dwlt9zEC4kxHPCywNbYy40UNnQmjcC9Nea46MeygdUOpGiJLSQ0b1oxBPO17LF+b
        +yaDSIKipKXb1ny4vVrlAFzPr1emVHVYwugHJJUlmv33TtR6Jz2EE60sjfzADKdH
        NbVcIev0+4yMpoKaitrtSwN44+HBJhBxyDyIVyyXEiXwzn3ecSS7fWQuvH7iofaA
        5hwcGfPQFclO4Lr3eNXJCrLcZU3J4geGeLXei8RaFwkAbvxN6aYhfFsHJHyYy3Ny
        u7zwBVB0dKhf5/fymeq0RutyTmCFUwud65dQ+h73znM5jovMIQNQCFNH/oI/LeUA
        qKK3FRaBMnAA8CPJxLDWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679272352; x=
        1679358752; bh=/6Xha14LNcuPBWYFX7xY2TJKKvWGWGj521bnvzcA2FQ=; b=W
        Pp3wqyHRhakjP+kFEaZXLuxdFiNIuYpLfe7hTHjBqRh+QSMlmM4kmv0PY577wHgr
        l1Ul/Y8Zkx1m0Y9bMSVkHC5a1PmYHzXNFc9hpgwiriZN+z6vlQJoaD4lh4M7DK33
        mtcbWYqJW+U+Wjhn6iAUP/FqghQKvBnClwD/G6NBOMiZ7tnA5WfaHE10mCV3bzE/
        LOcZDlZ/BfTsLPVaqSLO/ZrPNxOBlYD/Ul7GM7js85Z1Z9pSBXt5XE7lkZ0wHWY8
        M3s4eBAfUNxijiKgjZLVtp7meHvqCKiOdnLG95Zdz8vp7JwDteThnTPiNyHaeUwd
        vOpA1ugxC9KxLZ4QxVcxQ==
X-ME-Sender: <xms:n6kXZBaGiNu_Qdw7nDga3oL69REC1zj6L-v4ZqFNlQrUNttyss-ZvA>
    <xme:n6kXZIb31hnYdwh-evmzi1_rMBxCD_nGkm1alJgz397ptXSzWLZdfwCJiGRhFuHxG
    qHWQtLAz48AfoCyrY4>
X-ME-Received: <xmr:n6kXZD8g0n15Wk9j8JI-I_0VJDulK2ITD8DAsIplNaQuKuiO_mmSvvpKExXBf4WShiDz4WPzsBrDrCLHxkKBSWR7Nh2iMe0YueFFitvFyryjnVdBZILIQrhv5TdSfty-lT5JX_ulYu-5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepvedtlefggefgjeettddvgfekhfeugfeutdekfeefudeuuddvieeutdel
    jedvhfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:oKkXZPrAZ_ywKJB6DHftSWDXgZwtE3OdioH19fK5RxNc5RO5JSSqoA>
    <xmx:oKkXZMqKSZ6wag27nBRstZeXOwhl7QArX2cgA64sTYoz_J-dkD9NRg>
    <xmx:oKkXZFQwIBc1hb8qfoZvdmUnApWxvyasXt5V-wM8vl4PlFCz6oK1tw>
    <xmx:oKkXZBCB7nyzBAXRT452AnzwgJGLspXD_blXhby60jwDV08EAmr-oA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 20:32:31 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, markpearson@lenovo.com,
        thomas@t-8ch.de, pobrn@protonmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] platform/x86: think-lmi: add missing type attribute
Date:   Sun, 19 Mar 2023 20:32:18 -0400
Message-Id: <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was missing the mandatory type attribute...oops.

Add it in along with logic to determine whether the attribute is an
enumeration type or a string by parsing the possible_values attribute.

Upstream bug https://bugzilla.kernel.org/show_bug.cgi?id=216460

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4:
 - Unchanged. Sending to linux-kernel mailing list as recommended
Changes in v3:
 - Rebased on latest pdx86, review_hans branch
Changes in v2: 
 - Simplify the code and move type determination into show function
 - Don't use Fixes with URL in commit info

 drivers/platform/x86/think-lmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index cc66f7cbccf2..a765bf8c27d8 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -947,6 +947,20 @@ static ssize_t possible_values_show(struct kobject *kobj, struct kobj_attribute
 	return sysfs_emit(buf, "%s\n", setting->possible_values);
 }
 
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+		char *buf)
+{
+	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
+
+	if (setting->possible_values) {
+		/* Figure out what setting type is as BIOS does not return this */
+		if (strchr(setting->possible_values, ','))
+			return sysfs_emit(buf, "enumeration\n");
+	}
+	/* Anything else is going to be a string */
+	return sysfs_emit(buf, "string\n");
+}
+
 static ssize_t current_value_store(struct kobject *kobj,
 		struct kobj_attribute *attr,
 		const char *buf, size_t count)
@@ -1036,10 +1050,13 @@ static struct kobj_attribute attr_possible_values = __ATTR_RO(possible_values);
 
 static struct kobj_attribute attr_current_val = __ATTR_RW_MODE(current_value, 0600);
 
+static struct kobj_attribute attr_type = __ATTR_RO(type);
+
 static struct attribute *tlmi_attrs[] = {
 	&attr_displ_name.attr,
 	&attr_current_val.attr,
 	&attr_possible_values.attr,
+	&attr_type.attr,
 	NULL
 };
 
-- 
2.39.2

