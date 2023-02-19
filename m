Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D9B69C0AB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjBSOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBSOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E33F77E;
        Sun, 19 Feb 2023 06:23:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92579B802C8;
        Sun, 19 Feb 2023 14:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF97C433D2;
        Sun, 19 Feb 2023 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816616;
        bh=MQPwLhQVlXZ/PebjafzmyOvJjnheR6D1KuR0ACQ0rxk=;
        h=From:To:Cc:Subject:Date:From;
        b=s5BJIbDwA5J+JFyS47jPSi7CbHebEdAKQ12u8E9ZQGWz8ZmSZ0E+qMmvOrU2aYEmZ
         Lck6bXxANmiip5OroBi2/rfbi7XE9VmipVE0k6bnc8tobv0KzWbUNx/BDrG6oBNIVJ
         QQUicV4iBv0E87eUn+7buB9/OLPmWGQdSYBjT+TW8tJlfm9QCZpXpJR7BBrMlrSAD/
         6d0FZawAoOYhkLZuwc8PIcOo5UskUPNDp2uWZgz4lwpP/bKd74yrb/JwDGSG0SIzYh
         2EV4VAVmmpeBgpUBD6FudVJxU9S4xoNUpWf6j49FzY4oppU5sd2HadZR805hx/ALpb
         ug+dxKHspI6oQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3] .gitattributes: use 'dts' diff driver for *.dtso files
Date:   Sun, 19 Feb 2023 23:23:27 +0900
Message-Id: <20230219142327.2309518-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have the third extension for DT source files (overlay).
Give the diff=dts attribute to *.dtso as well.

While I was here, I merged *.c and *.o into *.[ch] and added the
SPDX-License-Identifier.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v3:
  - Add SPDX-License-Identifier

Changes in v2:
  - Slightly shorten the code

 .gitattributes | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 4b32eaa9571e..c9ba5bfc4036 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,4 +1,4 @@
-*.c   diff=cpp
-*.h   diff=cpp
-*.dtsi diff=dts
-*.dts  diff=dts
+# SPDX-License-Identifier: GPL-2.0-only
+*.[ch] diff=cpp
+*.dts diff=dts
+*.dts[io] diff=dts
-- 
2.34.1

