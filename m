Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270165B123
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjABLaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjABL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:29:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C468F6478
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:29:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g16so19650295plq.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 03:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAtfnehI+8rnCoBxh4RfuIlZeuy6v7+90sh8BNu0/0s=;
        b=XJvzkcjJYea83efZTaMs+qIbFQCP3ZqaH/iodQ4OBvcts+9G8H/fplhxapfgjBzvAB
         KmFuSnNwsYVKh1Cfxs0s6jgtblKgVe5ckwfOM6jjsLluJjiXTqT3PR+x2VMZkgM4E7zV
         7bDohX4lQPa8IYcGzhSSTB4ciDlrCzRgVbzfSxiQI/X4c9dUIVNsGPdJ6PsFUW6CknzN
         1JOXlqeNISoooH0Dc1Tow7YWmtCWzsNg3iwxtL/0WMOM5iK4VWbdRx0KU9lPlyqvsyai
         RZFfDDe/J1NNvJHYY0vczH0d75HnhYZlLvXh8KXR8nzdwOglx0zyCGQlgLcuaLava7Ym
         H9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAtfnehI+8rnCoBxh4RfuIlZeuy6v7+90sh8BNu0/0s=;
        b=MkIVkw/JzzY2V4ndtETI9lwYt6Zxag1JW3EuuzHxDYqv8yq6kqbUKmVP8t13BoMTdq
         YDiU0elOli9ylozelcf+zzGeLazX7EwPsca5bnmSv8bFXcFsndQw3ejQbBSIfH+l2kLe
         LnqHjtkHIY4by6QRRlA38L+LrOMbOk4/RwE2wkTKqQjH3fYPbeGmJuY2Q7enze+xmEBd
         gdL6e9NjhppBc5KK/z0icaCvQILiI5a9th+NOpWs7SXV1LP9BzprM9UdD7R7e+au9QOs
         O0K+7Irx3nal0HP/aUXfwi33Hw1msjMqTsECT62nOg05px5YgBVj5nloebcjyh4pCPlr
         nyEA==
X-Gm-Message-State: AFqh2kpEHYtReRxYgXYHYXP9ReR5xFeaLy5BWKCwO7pmr37BNnEx6oE5
        tvfWdL9BOwglYIWBgM8taH2V+w6eNKoWGQGtEJs=
X-Google-Smtp-Source: AMrXdXu2ujLJHIXjlsHhPgI1mXvTtkcY6fnA8K6//w0TeSuu931U/o/pTtHEVO3JWd/LtEMxvJwgYA==
X-Received: by 2002:a17:902:c401:b0:189:ba1f:b168 with SMTP id k1-20020a170902c40100b00189ba1fb168mr63898554plk.1.1672658974333;
        Mon, 02 Jan 2023 03:29:34 -0800 (PST)
Received: from localhost.localdomain ([114.249.235.208])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b00189a50d2a38sm17119993pla.38.2023.01.02.03.29.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jan 2023 03:29:33 -0800 (PST)
From:   wlfightup <wlfightup@gmail.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wangliang <wangliang40@baidu.com>,
        wlfightup <wlfightup@gmail.com>
Subject: [PATCH] Fixed code style, adding a blank line between functions
Date:   Mon,  2 Jan 2023 19:29:28 +0800
Message-Id: <20230102112928.12681-1-wlfightup@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

From: wangliang <wangliang40@baidu.com>

The code style must uniform, and the functions cannot be
separated without blank line

Signed-off-by: wlfightup <wlfightup@gmail.com>
Signed-off-by: wangliang <wangliang40@baidu.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db895230ee7e..4ad2be7f3b83 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3213,6 +3213,7 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 }
+
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 {
 	unsigned long i;
-- 
2.24.3 (Apple Git-128)

