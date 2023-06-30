Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B01743595
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjF3HOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjF3HO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:14:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37B61FFA;
        Fri, 30 Jun 2023 00:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7263F616D4;
        Fri, 30 Jun 2023 07:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B117C433C0;
        Fri, 30 Jun 2023 07:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688109266;
        bh=PYqCnWF7IAzpYnZdeaPArwQn6IWMC08ErzlI9oBfh4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwAyH0cMXXytdhps+l+CZl8PsJ798gPS4pZvhgJ4u+vAZUoMt/ZKxX+EVJ7hSKAqf
         awolAd9LBvw+CZTVTNA5vb1Jczb+DNMAzV1pafEZ5x6HFBLCi+b2691QrrDta+BDEt
         2iJfpqDVugdnI8sZKiU2znS9a98WzWt0oPf81/NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] Documentation: security-bugs.rst: clarify CVE handling
Date:   Fri, 30 Jun 2023 09:14:21 +0200
Message-ID: <2023063022-retouch-kerosene-7e4a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023063020-throat-pantyhose-f110@gregkh>
References: <2023063020-throat-pantyhose-f110@gregkh>
MIME-Version: 1.0
Lines:  34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=PYqCnWF7IAzpYnZdeaPArwQn6IWMC08ErzlI9oBfh4o=; b=owGbwMvMwCRo6H6F97bub03G02pJDCnzGs7J7u3/x9SV/eDmvwqfk3NervP2496welGr/iX11 0/YCqbe6ohlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJPHJjmKf68PZKBpcOQ9s7 dVWrJWQTkk2StRkWbDdVEYt+WCh0bpussqXr7ap4Bwt2AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel security team does NOT assign CVEs, so document that properly
and provide the "if you want one, ask MITRE for it" response that we
give on a weekly basis in the document, so we don't have to constantly
say it to everyone who asks.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/process/security-bugs.rst | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index f12ac2316ce7..8b80e1eb7d79 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -79,13 +79,10 @@ not contribute to actually fixing any potential security problems.
 CVE assignment
 --------------
 
-The security team does not normally assign CVEs, nor do we require them
-for reports or fixes, as this can needlessly complicate the process and
-may delay the bug handling. If a reporter wishes to have a CVE identifier
-assigned ahead of public disclosure, they will need to contact the private
-linux-distros list, described above. When such a CVE identifier is known
-before a patch is provided, it is desirable to mention it in the commit
-message if the reporter agrees.
+The security team does not assign CVEs, nor do we require them for
+reports or fixes, as this can needlessly complicate the process and may
+delay the bug handling.  If a reporter wishes to have a CVE identifier
+assigned, they should contact MITRE directly.
 
 Non-disclosure agreements
 -------------------------
-- 
2.41.0

