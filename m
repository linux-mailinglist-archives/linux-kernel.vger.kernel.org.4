Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0A61F5FC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiKGO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKGO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:28:26 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D5103E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:23:06 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id az40-20020a05600c602800b003cfa26c40easo2206817wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8RGh8EDyO4osN/zuXgwdm42OK5Fa8r6gvjPxQC6gE/Y=;
        b=VgwTO2WLIG/eNYpKhvHVsWOH1/2vXRWz1GBPQ2+DhvTTM0v0Uw6bmYoEH/VsZKKBJc
         6mdtXBQgUyCnKCG7gTTHe5XIRP088G78goMUw0LBr4bkpDKLPN9JIBuA69W7/NEycR+N
         H5unjWkIcLtBemlDT6L0bdfdf1xptjjMi/c+d/szx2vIrRB7IuhleiE6GVNekX/zPh18
         1xake7337x70KY8KTKx4wrTDraE4d0ZetccyrjzYPfd2Rd0qicc0697BXjcc7HUPomWL
         5ThYDGIQ/tvU38H5aLbJ38hMByTWpFXgYyKSfp0VyCIoB2gvQnkcQBNc/zviMST/iGXe
         Yxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8RGh8EDyO4osN/zuXgwdm42OK5Fa8r6gvjPxQC6gE/Y=;
        b=U+oEKn+9ivRHyXYkx7rwgfdsClOBXvlh5kMqVff7PS5boN6xqQlJyfUbZaB4topmzP
         eSKlYCsLgqUdkg7Cl6v4FUVFKwg0DiCiZXaiZyfdr73xK9f0559FCZKkvR8ZnlP73GK9
         i/957ZgLo3HOgwMM4tN/lmOXNQ2Xcuf5qH1uyQVDTfuZDQ/ESuULdxQtit+BrChRhONm
         ByE4If6KgzpltGFSNqg/vnow6kcR5y7MyM1N8Mp/pmCaipOFPFAJZJO2aXRZZUBBEoIr
         fWQqK+dlV31vm3TTq3wLafXZlDlJ77KMM23ZaaRK4646LnyeHNYnfc1Um4NEVqYmwyOb
         +VlQ==
X-Gm-Message-State: ACrzQf1qTaNAvQ/8/rMB1cXwaBDYp9MHQhrUUzLg5kDHYsH2d0Puj914
        vW9dkNTZLlNdspLPf8U6SW978hz5At0=
X-Google-Smtp-Source: AMsMyM4IhkSYiYM8vVqwDYha8HmlDgTkXxJ5kHYECa/1lQghvzAc8W/Eq0cUYfhcePBSnBP+qJTZ4HCZ2LA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4f3e:16fb:f499:bb9d])
 (user=glider job=sendgmr) by 2002:adf:e78d:0:b0:236:debd:f681 with SMTP id
 n13-20020adfe78d000000b00236debdf681mr23955346wrm.17.1667830984850; Mon, 07
 Nov 2022 06:23:04 -0800 (PST)
Date:   Mon,  7 Nov 2022 15:22:55 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107142255.4038811-1-glider@google.com>
Subject: [PATCH] docs: kmsan: fix formatting of "Example report"
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net,
        kasan-dev@googlegroups.com, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line to make the sentence before the list render as a
separate paragraph, not a definition.

Fixes: 93858ae70cf4 ("kmsan: add ReST documentation")
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 Documentation/dev-tools/kmsan.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
index 2a53a801198cb..55fa82212eb25 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -67,6 +67,7 @@ uninitialized in the local variable, as well as the stack where the value was
 copied to another memory location before use.
 
 A use of uninitialized value ``v`` is reported by KMSAN in the following cases:
+
  - in a condition, e.g. ``if (v) { ... }``;
  - in an indexing or pointer dereferencing, e.g. ``array[v]`` or ``*v``;
  - when it is copied to userspace or hardware, e.g. ``copy_to_user(..., &v, ...)``;
-- 
2.38.1.431.g37b22c650d-goog

