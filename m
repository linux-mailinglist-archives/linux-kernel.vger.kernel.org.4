Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C986D0EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjC3TgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjC3TgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:36:06 -0400
Received: from zucker.schokokeks.org (zucker.schokokeks.org [IPv6:2a01:4f8:121:1ffe:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E482F76B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hboeck.de; s=key1;
        t=1680204959; bh=gz4dynLO3rH0FAL7s4kLwfCnOG+WmAVVryNvnKXEKIU=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=KF744fzqR7DqsJCy9sPihqOR3c0dRSrcMJKCG5idEmSYRbQnq6KhLAgLmDdu3UB2a
         ray95v5qG2nWlsX72D9m24dnIUdSyKYuE5M8alKVqp2DDSC5BcyemuGmRaPSNG7B2z
         5DKJiXcgPBqrExJa7HgYF80ct+FJzRAoVFq763ZplnAqxkqCFZzhqKAPBdBBRFhvdY
         vH/c25JI7EwYCuEIB2lBBLFD44i2vFKeXSyNDa0D17iQLgs6jMbBu/Hbku+5uCg+wb
         KSmcXfVNRM7PJAQmdf6I6ZiUZYX7ml1yGszqu/jX11oxToXfi+ZvtjIM2xR3LSNFzy
         NdgDthYA9VbtQ==
Original-Subject: [PATCH] Fix typo in LEGACY_TIOCSTI Kconfig description
Author: Hanno =?iso-8859-1?q?B=F6ck?= <hanno@hboeck.de>
Original-Cc: Jiri Slaby  <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 30 Mar 2023 21:35:57 +0200
From:   Hanno =?iso-8859-1?q?B=F6ck?= <hanno@hboeck.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in LEGACY_TIOCSTI Kconfig description
Message-ID: <20230330213557.60cf1533.hanno@hboeck.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in LEGACY_TIOCSTI Kconfig description

There is a stray ' in the description before the Y. It appears this was
meant as a quote for the 'Y'. However, it is more common to use
unquoted Y in Kconfig descriptions.

Signed-off-by: Hanno B=C3=B6ck <hanno@hboeck.de>
---
 drivers/tty/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index d35fc068d..84caac32f 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -160,7 +160,7 @@ config LEGACY_TIOCSTI
 	  a dangerous legacy operation, and can be disabled on most
 	  systems.
=20
-	  Say 'Y here only if you have confirmed that your system's
+	  Say Y here only if you have confirmed that your system's
 	  userspace depends on this functionality to continue operating
 	  normally.
=20
--=20
2.40.0

--=20
Hanno B=C3=B6ck
https://hboeck.de/
