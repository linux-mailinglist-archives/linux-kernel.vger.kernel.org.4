Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C76643BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbjAJOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbjAJOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:54:21 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB995C901
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:54:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z4-20020a17090a170400b00226d331390cso13705394pjd.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 06:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kTptdvz7E3mh/SgX4m2x0QW4MBFmz1fbNeK9CDXYIY=;
        b=o0JU90IbO+TsbjSQpRKrzKLDb8p6xKM4bghdMnJXoKYpCBRewhd7su40Y7lRvYhkjH
         +jgu07TI0NPlEQGa2mrStTj/ryPah867kP9I7ilV9PAb0xYvcpx+eBZPse+A2ZNFCu3f
         8c/PMcvICGm5ecfnpKdDG3/7G2w8+TC3nSf8/xRAeSMbCtZmqsoTdVNIbvUDcAdQ1sie
         uad5JeyM10RKiVphdYai4D/lPuMKfNeElfK7iSlq0MoPHIBUIxXvIVunO1Sjn6XNI/Ga
         ZFtiHd5lapItzLZBKUt2sBtM4b25Synievz0v221ZOgszf3meSw4J/I44dsxFK0JbljQ
         KBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kTptdvz7E3mh/SgX4m2x0QW4MBFmz1fbNeK9CDXYIY=;
        b=XFzDB8hRgAnZxJo2GN4+JFGgiqIqjuT9Hzp7Vm3MEZenneiRzszrrusA74OVmB24H9
         fhxNjZtdov4di5GZ8kFYt4eWcvH3y7ju0kW4WWktuBq2/xBymYxG7+DLOSX+swE5w35p
         nYn/NRaDWG/+7zS4Pq7nSRjLi/Ztp77ucA2X2Hb42iBnEKr4Aw7qfiRRp71Tdzj07//R
         CYbt0KYj5d0JqnbiXUq/rp3Vijwq3ugZ3qqIyJ1Dj6FHg2fYiVLxcV83qbB6+SXOX9yR
         YrIkYfXNvVvOM1oBn3y5BJ3z82KvTktuBdPjVDEph+fzySfaXaJwIdkHw4kNP0/OCHqX
         I24w==
X-Gm-Message-State: AFqh2kp7PuaiF8o5+fuuvRTaPeMGvB9a0cJ/nasF6b9gv/woriTpJ0Du
        Ks4+ZwbUk9a7jnxe6Q+KRudc25rdCjtSOg==
X-Google-Smtp-Source: AMrXdXu6C0M/LqAakB1235Xm0H5uscQnQaM0U31KwxWVj7ZkgZM7hjiVDL3sfNVrkp6ZCvUmKk2ZPA==
X-Received: by 2002:a05:6a20:9f85:b0:ac:16ae:f46 with SMTP id mm5-20020a056a209f8500b000ac16ae0f46mr85877690pzb.15.1673362441356;
        Tue, 10 Jan 2023 06:54:01 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79489000000b00574ab0e053bsm8176452pfk.187.2023.01.10.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 06:54:00 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] mm/mmap: fix typo in comment
Date:   Tue, 10 Jan 2023 22:53:53 +0800
Message-Id: <20230110145353.1658435-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make parital to partial word.

Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..c9da9119d7f2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2885,7 +2885,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 }
 
 /*
- * brk_munmap() - Unmap a parital vma.
+ * brk_munmap() - Unmap a partial vma.
  * @mas: The maple tree state.
  * @vma: The vma to be modified
  * @newbrk: the start of the address to unmap
-- 
2.34.1

