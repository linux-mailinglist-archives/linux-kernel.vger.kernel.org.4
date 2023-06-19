Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46377350FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjFSJz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjFSJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:55:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E8128;
        Mon, 19 Jun 2023 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=6tdjUN64vUCYrK7fSaz6FoAbfxa1GAFbufR/hoALhss=; t=1687168548; x=1688378148; 
        b=FQBJ0cotwx07rA6rB4tgzTuOfudc5HHHeumWWrcDOCsdL/AjXdz1ZycrgP94d+DGgxgHOfpAXx7
        8jEP6oC+s9tC+YAWg6qv6IOTfTbxptlKhJHGSQBjM2WkjmTXYpNX4QHudqG/BRqsQHXsUgrO7wqhb
        NMUeQkSx3/kVJ5R486NU4ck1/RxCM1NxxZm4Q4u6zItP3WZuOIOlEFNILJuB5j2XfJk7gdpeMBqZD
        oagL2FXgNxDqouIZqW7EKLjoY5s/tRbA0nW0SQh75rPQRJAPzTHj1HSyAVq0F0oKxJMwSmyQXxrSq
        YOr4R1a2iQd2gy1YDLIw/fe0V8xGN0+oLQ4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qBBbt-00BHZj-04;
        Mon, 19 Jun 2023 11:55:45 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] Documentation: update git configuration for Link: tag
Date:   Mon, 19 Jun 2023 11:55:34 +0200
Message-ID: <20230619115533.981f6abaca01.I1960c39b1d61e8514afcef4806a450a209133187@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The latest version of git (2.41.0) changed the spelling
of Message-Id to Message-ID. Adjust the perl script here
to accept both spellings.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 Documentation/maintainer/configure-git.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index 80ae5030a590..ec0ddfb9cdd3 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -56,7 +56,7 @@ by adding the following hook into your git:
 	$ cat >.git/hooks/applypatch-msg <<'EOF'
 	#!/bin/sh
 	. git-sh-setup
-	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
+	perl -pi -e 's|^Message-I[dD]:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
 	test -x "$GIT_DIR/hooks/commit-msg" &&
 		exec "$GIT_DIR/hooks/commit-msg" ${1+"$@"}
 	:
-- 
2.41.0

