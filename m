Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB836C06D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCTAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCTAcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:32:39 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C33316ACA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:32:36 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 73F235C0043;
        Sun, 19 Mar 2023 20:32:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 19 Mar 2023 20:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679272353; x=
        1679358753; bh=E20kcOAHoR630toJdoojlu/TxXA+HrtUu4ASqXD73nI=; b=l
        zDaJqir7vhE6PlOqrCgfAcYUrF4Vq6udjYtc1kdg6KSs58boJJovYhrqd3zE0IJo
        bX/fm9IyAfwMo7D5d4t5YLMmw102VpeJWCuhvHXNW1RkC72qzDMY69LaopILX7ER
        cKsvKE0fsyjuuGgChpPYwky2bn8i1V4dFqeOrw1QZhjhJ5HX0yrZvxv7rjmnnnYs
        Ev+dxEzRBJROW1WYM8CDgNQcv8GUgY/hRIIXgagXIeDyEt7pXJmeOKO2rahusgZr
        W63kRSMUSKFB9H+T82m/Xt5OKtyA6e6AOH/q2ngMOxA+J/OJSBB/iHEpmsksRsL7
        7BtUI9g9xP0l1U34gg58w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679272353; x=
        1679358753; bh=E20kcOAHoR630toJdoojlu/TxXA+HrtUu4ASqXD73nI=; b=Z
        5QQ/pPapDd5JNt3yg0ZLSLr18Xd93rxazF/yAA7zOdm0lpJyWtc72h9zv0jzhGnU
        zsPT1tyCPlJjMW6gzP76XhIJrmHwvyDKWQUiyP2QgaJ8kxBKnIkcq+1M9LpoL3eB
        P5Usw2N0wx/W6fzHGDjk8/UEUGhdg8kEFHy0Gt4mYjXxtyYud+iGcMISz6qYj6Dc
        Y/w64RqC35pCe9pkjexeRv/R+u6MZFLU3Jw/4NIy3tO9j5vYcBn4BiSmt+oJeXm8
        Q0Z88/+OXlkmAmAwlZTNxLf/w6llXkIUDX6y2s86AfErDqq1mjQ8mjDK/XpWzTo1
        sx4xLR0vHL1Slxxn93KdQ==
X-ME-Sender: <xms:oakXZMS3M3Ct8Sv5a3xtA-sEqWO2cvfh789hCy47i9JlrDHQlt89QQ>
    <xme:oakXZJxyxeXnu5u7BfP8tiYyQxlzXOVkjCYRETWy0atXPrqlvzQ7wEKFl6h3R5QRe
    ITOIYRllfLDvmHOw_0>
X-ME-Received: <xmr:oakXZJ1MOiFkmPOHadMiQN93wTeeSuMo-_ZCdY3WcMCaD0iZRFonTd75wJOLv4Tyc3giwWKCBtZpBtXoKoHh2N3tJbUIoIeBmcYO6K-lrRLFMNLgAN6yywCChXol27OFy276s94o9TAK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefjedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepfedtvdejfeelffevhffgjeejheduteetieeguefgkefhhfegjeduueet
    hefgvdffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:oakXZAAZR5L9bz4eP9I97obReWfTvNPhm3lZdWbgyXiuyp665U0drQ>
    <xmx:oakXZFhp_3BFx7NhqxmaSy4i1dJN5vYgQU0-RymIbXR1x0sgDhrFZA>
    <xmx:oakXZMqGa4OgXvdohjBqBe6_MkybbVN3O-5mhdvj-pKNPWeuReGPQQ>
    <xmx:oakXZDY6gzUXIXYUzkmPLu7B1cAsSce2JjefRgOyJ-Ay1BunPrBvAg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Mar 2023 20:32:33 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org, markpearson@lenovo.com,
        thomas@t-8ch.de, pobrn@protonmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] platform/x86: think-lmi: only display possible_values if available
Date:   Sun, 19 Mar 2023 20:32:20 -0400
Message-Id: <20230320003221.561750-3-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230320003221.561750-1-mpearson-lenovo@squebb.ca>
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

Some attributes don't have any values available. In those cases don't
make the possible_values entry visible.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4: 
 - Split out functionality in previous 'Add possible values for Thinkstation'.
 - No v1/v2/v3

 drivers/platform/x86/think-lmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 53f34b1adb8c..6f8c91716a95 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -941,9 +941,6 @@ static ssize_t possible_values_show(struct kobject *kobj, struct kobj_attribute
 {
 	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
 
-	if (!tlmi_priv.can_get_bios_selections)
-		return -EOPNOTSUPP;
-
 	return sysfs_emit(buf, "%s\n", setting->possible_values);
 }
 
@@ -1052,6 +1049,18 @@ static struct kobj_attribute attr_current_val = __ATTR_RW_MODE(current_value, 06
 
 static struct kobj_attribute attr_type = __ATTR_RO(type);
 
+static umode_t attr_is_visible(struct kobject *kobj,
+					     struct attribute *attr, int n)
+{
+	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
+
+	/* We don't want to display possible_values attributes if not available */
+	if ((attr == &attr_possible_values.attr) && (!setting->possible_values))
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *tlmi_attrs[] = {
 	&attr_displ_name.attr,
 	&attr_current_val.attr,
@@ -1061,6 +1070,7 @@ static struct attribute *tlmi_attrs[] = {
 };
 
 static const struct attribute_group tlmi_attr_group = {
+	.is_visible = attr_is_visible,
 	.attrs = tlmi_attrs,
 };
 
-- 
2.39.2

