Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC174FFED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGLHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGLHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:14:06 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 036EC1736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 00:14:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id CEDF1606EE6FC;
        Wed, 12 Jul 2023 15:13:51 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     akpm@linux-foundation.org, zhou.kete@h3c.com, rppt@kernel.org,
        mgorman@techsingularity.net, zhao_lei1@hoperun.com,
        zhang.zhengming@h3c.com, surenb@google.com, xu.panda@zte.com.cn,
        wuchi.zero@gmail.com, Ilia.Gavrilov@infotecs.ru
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20relay:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20relay=5Fopen=5Fbuf?=
Date:   Fri, 14 Jul 2023 07:44:59 +0800
Message-Id: <20230713234459.2908-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buf is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index a80fa01042e9..83fe0325cde1 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -375,7 +375,7 @@ static struct dentry *relay_create_buf_file(struct rchan *chan,
  */
 static struct rchan_buf *relay_open_buf(struct rchan *chan, unsigned int cpu)
 {
- 	struct rchan_buf *buf = NULL;
+	struct rchan_buf *buf;
 	struct dentry *dentry;
 
  	if (chan->is_global)
-- 
2.18.2

