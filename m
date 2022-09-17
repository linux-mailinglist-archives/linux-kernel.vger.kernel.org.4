Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060885BB79A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIQJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIQJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:44:36 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C509F2606
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=C7Cbw
        EuGKtlGhYsSPX/C/ArYLUtlHFH+6AySyJyV0Tg=; b=BOXR/iVCJm6u9M2LPceA4
        OpGvRtsmpL2i+ZSjbjPVllu69Im+XkvbC4pzrbCVPXIWjBP96t3up25bO0Rl++uo
        aDnHwhXtKwTuzuOSU9d776fKrxkM7IDnpyLgEgz7xH+HUuSc76i4ssgpTQv9d3Rh
        qTz3r4V7BJLpkiYjnJEzAA=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp4 (Coremail) with SMTP id HNxpCgDHeN_9liVjqKMmdw--.4980S2;
        Sat, 17 Sep 2022 17:44:29 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com, William Dean <williamsukatube@163.com>
Subject: [PATCH -next] fscache: Remove duplicate include
Date:   Sat, 17 Sep 2022 17:44:27 +0800
Message-Id: <20220917094427.4665-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDHeN_9liVjqKMmdw--.4980S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAr18XrWrtry3uw4UJF4kCrg_yoWxGrXE9w
        n7Cr4kurW5JFyxua4ftFs2q3Wjgw18Zr90vFs5tw1akFnxJa1xKanxJ345CF4ag3s7CFy8
        XFyrtFyj9wnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAxhd3UUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbBSR1-g1aEEv4ynQAAs5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@163.com>

In file: fs/fscache/io.c,
'#include <linux/uio.h>' has included at line: 9,
now it is duplicated include at line: 12, so delete duplicated include.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 fs/fscache/io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 3af3b08a9bb3..a67c50efc133 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"

 /**
--
2.25.1

