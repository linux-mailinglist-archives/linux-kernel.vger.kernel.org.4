Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFA467D339
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAZRce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAZRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:32:32 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA408692
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:32:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id DFA615CBF58
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674754349;
        bh=6/90w43OAYgF0Bg+2eZ5gViTyRq0br/gZ7uEalJdF1o=;
        h=From:To:Cc:Subject:Date;
        b=qCPCV0jokQHH/m7KMbkFZ4Tv/3vbOCDOCP5qaRop4CLRe7AXOJic5ahtf9XVqvAqC
         RgTP1k7+sRvviYPJODQ8nnPpq1a6xHDmf0TcBH4TZEKtiA0D2RC3frPQWu+5DpKkjJ
         9QEaiCOwcYmTZ1Yx2oMO1E8CiXH0EorREk1jRZN4=
Received: from fx403 (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 9E9B45CC142;
        Thu, 26 Jan 2023 18:32:29 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <a0a7.63d2b92c.c999f.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx403.security-mail.net (Postfix) with ESMTPS id CBADB5CC1AF;
        Thu, 26 Jan 2023 18:32:28 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id A3E7727E0374;
        Thu, 26 Jan 2023 18:32:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 86ABF27E0431;
        Thu, 26 Jan 2023 18:32:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 86ABF27E0431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674754348;
        bh=RYbnzhQ3FDTjG3as2uuzmyoOHcgNTEdJzvexnfAGgVg=;
        h=From:To:Date:Message-Id;
        b=LLv+IgqaK+miDMpEVHbjdtnjfWQVHM8vtbW5GPTHxilCs8zaSHDBudM45kLJr5I9F
         B07p/DVVypogPpaRhh5djqAplUKJbLnR+nYpIdxZxlDG6ynEW4gFEEQbGoA70zamie
         q+2HEbPlkn9myc+QJ7vO36Hv4RpYetuAuivcnMxI=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gv4uQcdGM6F0; Thu, 26 Jan 2023 18:32:28 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 71D5527E0374;
        Thu, 26 Jan 2023 18:32:28 +0100 (CET)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jules Maselbas <jmaselbas@kalray.eu>
Subject: [PATCH] Documentation/mm: Fix typo emluation -> emulation
Date:   Thu, 26 Jan 2023 18:32:17 +0100
Message-Id: <20230126173217.12912-1-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo emluation -> emulation

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 Documentation/mm/numa.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/numa.rst b/Documentation/mm/numa.rst
index 99fdeca917ca..e1410974c941 100644
--- a/Documentation/mm/numa.rst
+++ b/Documentation/mm/numa.rst
@@ -64,7 +64,7 @@ In addition, for some architectures, again x86 is an example, Linux supports
 the emulation of additional nodes.  For NUMA emulation, linux will carve up
 the existing nodes--or the system memory for non-NUMA platforms--into multiple
 nodes.  Each emulated node will manage a fraction of the underlying cells'
-physical memory.  NUMA emluation is useful for testing NUMA kernel and
+physical memory.  NUMA emulation is useful for testing NUMA kernel and
 application features on non-NUMA platforms, and as a sort of memory resource
 management mechanism when used together with cpusets.
 [see Documentation/admin-guide/cgroup-v1/cpusets.rst]
-- 
2.17.1

