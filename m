Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669ED72F7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbjFNI36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjFNI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:29:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0C11F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:29:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgzB12xxLzBQgny
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:29:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686731385; x=1689323386; bh=+1CZbpCrooYnxpWHG3ifhgX0usn
        zkdJe1tOdGeUaLK0=; b=vntr5gEJOOfA/q8gGNcFA19BCt7GwwuLXojwjbWSlQC
        ZqUGtuVGkxPBdDkzPO4f0CCRz/X7PoBZQoHP/N5lNL6Fe6dXYnuZQWcBVNyFRpmV
        DkfdXt1oCFHf0bMtg5SgHgbq3efbj9sI+lUH7E07IW+XhAbEGYeL4HM6nxAIFJTF
        Mub50Q3KaKFI9DOiyJZ3sKHbMzrVQhRcsQhkUZ513w8icU0xtG6/dJiU2sRS2/a1
        oFe/rrOnOw8TevYsUbe0tsD1B/OGxtn8dkd84Xz2FGvaw4Aeg3ssRuoZQkYcS8yj
        B6PGHlpfkO+WDeWthDU2f/Hpcivy1WjchtrAfNFOZmg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pJkeJ_4SVFiO for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 16:29:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgzB04kc1zBJJCt;
        Wed, 14 Jun 2023 16:29:44 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 16:29:44 +0800
From:   baomingtong001@208suo.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: zip: Remove unneeded semicolon from
 zip_archive_open()
In-Reply-To: <20230614082626.45467-1-luojianhong@cdjrlc.com>
References: <20230614082626.45467-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f629797b0b525095352acbf565b48481@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./tools/lib/bpf/zip.c:226:2-3: Unneeded semicolon

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/lib/bpf/zip.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/zip.c b/tools/lib/bpf/zip.c
index 3f26d629b2b4..88c376a8348d 100644
--- a/tools/lib/bpf/zip.c
+++ b/tools/lib/bpf/zip.c
@@ -223,7 +223,7 @@ struct zip_archive *zip_archive_open(const char 
*path)
      if (!archive) {
          munmap(data, size);
          return ERR_PTR(-ENOMEM);
-    };
+    }

      archive->data = data;
      archive->size = size;
