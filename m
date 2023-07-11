Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025D74E5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGKE3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjGKE3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:29:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9617E51;
        Mon, 10 Jul 2023 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tEziXguEN5L4lHowsECMtwVynpESmDBqF0VPw7VUfqE=; b=YkXh957pJcOHQt+u8K6tk3Ljmc
        Uel26+f3o4MAGeqSoiMmqdx33ija6wyJqY+o48U45RtSIC6KY8WCu6BnhwjNcnMq+Pg1lb1Rox5DK
        1LIlaU32Gf2i4QP7IEitaitwLgYzTXScUk5tZH+VVH6jLLbbku62BYRdzPGIfTFPCD6INsPmYieoY
        BRdb0mxKRJe84OiAh+ZsSFH7KqQk8A9aeOpCKQn8gS7TSi9RObndD/lnx0YYJCHuWsVi4cp9iYLUm
        eURCGgA06IjmschhQp6LwA6LiZXL8c4FvG1LLwTGy6Y+InIdPRXwR5mEN2esqnnyBBwE9bkmMkhZO
        pp5OYp2A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ4zy-00Dcnq-2D;
        Tue, 11 Jul 2023 04:29:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] kconfig: gconfig: correct program name in help text
Date:   Mon, 10 Jul 2023 21:29:13 -0700
Message-ID: <20230711042913.21977-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "gkc" to "gconfig" in 3 places since it is called "gconfig" and
not "gkc". Add a period at the end of one sentence.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
 scripts/kconfig/gconf.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -636,7 +636,7 @@ void on_introduction1_activate(GtkMenuIt
 {
 	GtkWidget *dialog;
 	const gchar *intro_text =
-	    "Welcome to gkc, the GTK+ graphical configuration tool\n"
+	    "Welcome to gconfig, the GTK+ graphical configuration tool.\n"
 	    "For each option, a blank box indicates the feature is disabled, a\n"
 	    "check indicates it is enabled, and a dot indicates that it is to\n"
 	    "be compiled as a module.  Clicking on the box will cycle through the three states.\n"
@@ -664,7 +664,7 @@ void on_about1_activate(GtkMenuItem * me
 {
 	GtkWidget *dialog;
 	const gchar *about_text =
-	    "gkc is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
+	    "gconfig is copyright (c) 2002 Romain Lievin <roms@lpg.ticalc.org>.\n"
 	      "Based on the source code from Roman Zippel.\n";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
@@ -682,7 +682,7 @@ void on_license1_activate(GtkMenuItem *
 {
 	GtkWidget *dialog;
 	const gchar *license_text =
-	    "gkc is released under the terms of the GNU GPL v2.\n"
+	    "gconfig is released under the terms of the GNU GPL v2.\n"
 	      "For more information, please see the source code or\n"
 	      "visit http://www.fsf.org/licenses/licenses.html\n";
 
