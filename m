Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294D74E5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 06:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGKE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 00:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKE3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:29:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65DFE42;
        Mon, 10 Jul 2023 21:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mW7N0YhrzylXcrfqMfjApU7mfEYrVUHUJlt95bsUitU=; b=OqWi+UGYC5HZPpjSBD0gZksSuD
        OVDBGJaNUt1iGKG4+Qrt1VgqVODze1JQVzjASXXJFEi7pm0cc4NFKBJIkcF601fIX5fvuSn3qFq0L
        5avSMRwfHqEr8EOZMGBCHqQUe3dxR0NcTzAzhTPToEppwOJcAe/CRK9Dw51mem4GFLmYOy73BDU6+
        o0R9ZuhnVttdNEipNE27gS2/yBVw8Vi3lUwi53XmiHb8QDbwmrza1SlkWOqycDLC/re+iKSS26klo
        tFAtdpAgJSBo4t+DJ4svmd0Jymz+EpGyjSLq/xW3TObzdL3j78HGFP8LKg404LuFBOtVqUWJODbvS
        YJymTB0A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJ4zk-00DclO-2O;
        Tue, 11 Jul 2023 04:29:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/2] kconfig: gconfig: drop the Show Debug Info help text
Date:   Mon, 10 Jul 2023 21:28:59 -0700
Message-ID: <20230711042859.17927-1-rdunlap@infradead.org>
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

The Show Debug Info option was removed eons ago. Now finish the job
by removing the help text for it also.

Fixes: 7b5d87215b38 ("gconfig: remove show_debug option")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
---
 scripts/kconfig/gconf.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -- a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -647,10 +647,7 @@ void on_introduction1_activate(GtkMenuIt
 	    "Although there is no cross reference yet to help you figure out\n"
 	    "what other options must be enabled to support the option you\n"
 	    "are interested in, you can still view the help of a grayed-out\n"
-	    "option.\n"
-	    "\n"
-	    "Toggling Show Debug Info under the Options menu will show \n"
-	    "the dependencies, which you can then match by examining other options.";
+	    "option.";
 
 	dialog = gtk_message_dialog_new(GTK_WINDOW(main_wnd),
 					GTK_DIALOG_DESTROY_WITH_PARENT,
