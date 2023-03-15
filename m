Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5246BBD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjCOTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCOTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:19:15 -0400
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 12:19:12 PDT
Received: from zucker.schokokeks.org (zucker.schokokeks.org [IPv6:2a01:4f8:121:1ffe:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528BD26CCA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
        t=1678907641; bh=1DWkxK5CAV8IeLaaAvIOToX7szsnovvJb0D8dKIkFac=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=gO36HlPFwu3ZBeidjPBn6lfUUgqlJqUr+zD395USNW8jEzap1zRg9GQULfTTV3d/W
         U8/rxdK4RBN/1vZjD4nz6NAfr5fqJdipqxudOCRfmZRA5vAmX79N+s3A2cAzvlQj7F
         DnWKKMWYhhQaJwOBJd1L1iYYLWiDHzXMpDpP2RX6oN3mfu9huju4zjnvWqsB0HiR0m
         2fBXGY/rS0xdDWNtq0uM0oSJW9oEDqid+d/O8TPjjeJt+XW+etUtO+RmU44IX32MVi
         h1DqvgS/0wEvH5334ezG3RuQzfzaOX2wePGrUl0LNHCKJvfNr0sd1bgTcqtiP6T3QQ
         e2N8SdNKbfLrg==
Original-Content-Transfer-Encoding: 7bit
Original-Subject: [PATCH]Fix typo in LEGACY_TIOCSTI Kconfig description
Author: Hanno =?iso-8859-1?q?B=F6ck?= <hanno@hboeck.de>
Date:   Wed, 15 Mar 2023 20:14:00 +0100
From:   Hanno =?iso-8859-1?q?B=F6ck?= <hanno@hboeck.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH]Fix typo in LEGACY_TIOCSTI Kconfig description
Message-ID: <20230315201400.7bb07d47.hanno@hboeck.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a stray ' in the description before the Y. It appears this was
meant as a quote for the 'Y'. However, it is more common to use
unquoted Y in Kconfig descriptions.

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index d35fc068d..84caac32f 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -160,7 +160,7 @@ config LEGACY_TIOCSTI
 	  a dangerous legacy operation, and can be disabled on most
 	  systems.
 
-	  Say 'Y here only if you have confirmed that your system's
+	  Say Y here only if you have confirmed that your system's
 	  userspace depends on this functionality to continue operating
 	  normally.
 
