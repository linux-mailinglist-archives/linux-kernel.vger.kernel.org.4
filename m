Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81986B3F40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCJMfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCJMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:35:12 -0500
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC410BA7E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:35:10 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4PY59S2RMvzvjhW; Fri, 10 Mar 2023 13:35:08 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add entry for Tobias Klauser
Date:   Fri, 10 Mar 2023 13:35:08 +0100
Message-Id: <20230310123508.22079-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map my old email addresses to the current address.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 .mailmap | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.mailmap b/.mailmap
index 94a4d32ccdf6..f7ad770c80f6 100644
--- a/.mailmap
+++ b/.mailmap
@@ -431,6 +431,10 @@ Thomas Graf <tgraf@suug.ch>
 Thomas Körper <socketcan@esd.eu> <thomas.koerper@esd.eu>
 Thomas Pedersen <twp@codeaurora.org>
 Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
+Tobias Klauser <tklauser@distanz.ch> <tobias.klauser@gmail.com>
+Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
+Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
+Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
 Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
-- 
2.39.1

