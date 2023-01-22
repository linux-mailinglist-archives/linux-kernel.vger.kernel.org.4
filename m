Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C702167715D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 19:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjAVSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 13:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjAVSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 13:12:47 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F8D537;
        Sun, 22 Jan 2023 10:12:46 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 4120B60007;
        Sun, 22 Jan 2023 18:12:40 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: rv: Fix full name of the GPL
Date:   Sun, 22 Jan 2023 19:12:23 +0100
Message-Id: <20230122181224.53996-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 Documentation/tools/rv/common_appendix.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rv/common_appendix.rst b/Documentation/tools/rv/common_appendix.rst
index f4239192bee8..655e1bd9bbe4 100644
--- a/Documentation/tools/rv/common_appendix.rst
+++ b/Documentation/tools/rv/common_appendix.rst
@@ -13,4 +13,4 @@ COPYING
 =======
 
 Copyright \(C) 2022 Red Hat, Inc. Free use of this software is granted under
-the terms of the GNU Public License (GPL).
+the terms of the GNU General Public License (GPL).
-- 
2.39.0

