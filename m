Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696466A6950
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCAJBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCAJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:01:38 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF572B29C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:01:36 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 375B7C0021;
        Wed,  1 Mar 2023 09:01:33 +0000 (UTC)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>
Subject: [PATCH] .mailmap: Add Alexandre Ghiti personal email address
Date:   Wed,  1 Mar 2023 10:01:32 +0100
Message-Id: <20230301090132.280475-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>

I'm no longer employed by Canonical which results in email bouncing so
add an entry to my personal email address.

Reported-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 318e63f338b1..9a1050fac1a1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -26,6 +26,7 @@ Alexander Lobakin <alobakin@pm.me> <alobakin@dlink.ru>
 Alexander Lobakin <alobakin@pm.me> <alobakin@marvell.com>
 Alexander Lobakin <alobakin@pm.me> <bloodyreaper@yandex.ru>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electrons.com>
+Alexandre Ghiti <alex@ghiti.fr> <alexandre.ghiti@canonical.com>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
-- 
2.37.2

