Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786706DFDC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDLSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjDLSia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:38:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217230E5;
        Wed, 12 Apr 2023 11:37:45 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j8so10920566pjy.4;
        Wed, 12 Apr 2023 11:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681324664; x=1683916664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1XECP8wQGmDTAyM5631GbSa3D6PGwx6DxzWPpofMRU=;
        b=C3eItOqtkLxgsOp+Tp65SbnO8LqInhzF9vSwarsWOUXRY+YIvmlljgxRS/MtqfKMVe
         YKAH1NwIfJVHnB/i/i+3aS3Fn6F+cx8JzaFIAOFrW5GoegvrBUst6nz+RXx35yk5Sgt5
         iet1kFIBAlLEPNbIEwuH1Z6GdACz0uxS4VMq7l/N4rGAgyGW3+00nH+jWdj/ZyNJHqBT
         1M+tmuzK246KI8uRqEVDqQK19GXujPFF+kU6a2C8+WncdFjfLNv3velvfFWY82WVJHU2
         jjl4oH5Tbd0f/JQ8tPCXMvVh4zk0KqMVbNPAa8vklfV6MTYF7uLANaIhJzZkyFPl0fMw
         ga3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681324664; x=1683916664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1XECP8wQGmDTAyM5631GbSa3D6PGwx6DxzWPpofMRU=;
        b=U74KpVvIhaRE3o/HeXmhTxfEakqVdO6T7t/w6I3TJ+bhycJUMJ8FhcdBvf0MbMjOXt
         WbNv+JmUfc9DcSD6/bJcVOQHlNgnKpdZRmOJqY9rhct3JwpvHTyfFWP0kWh4e+7ieaVI
         IM2wNMe8bEca/p15LIp5HRERmB01OT0hTnGhvWAR5q3VCrESYclnFLGiX6sw8c/+s3aD
         cJjxXFtYWDrf561qmYOW0xD7QsvqCrxjMHWACy3GiogBOuS8UsUS2Kcqsj5aJLfARv52
         XN3md8wk26OsSxfUv4HJ4lMkQEKIHwmljWE0NcvuEAoX8e2uf4idnU/Uv+gtPtMbOCGF
         kwSw==
X-Gm-Message-State: AAQBX9ej3jzkwaRnzbkQznuIl1anrA8FCNsN2J6qDLuFv4nTYdUWncRM
        C411GbINdcAonmDKMnS0Elw=
X-Google-Smtp-Source: AKy350bBBZ0QYRKRh2qu1ggHSIBgOofz7rkL37srMW6LcxOvnaYjKyjoeqbGRZYyGwYwZfoLPpGE4A==
X-Received: by 2002:a17:90a:b004:b0:246:fdcc:f84c with SMTP id x4-20020a17090ab00400b00246fdccf84cmr148220pjq.35.1681324664310;
        Wed, 12 Apr 2023 11:37:44 -0700 (PDT)
Received: from ubuntu.localdomain (36-229-229-178.dynamic-ip.hinet.net. [36.229.229.178])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a5a4900b00246ea338c96sm1724272pji.53.2023.04.12.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:37:44 -0700 (PDT)
From:   Lin Yu Chen <starpt.official@gmail.com>
To:     corbet@lwn.net
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Lin Yu Chen <starpt.official@gmail.com>
Subject: [PATCH] docs: trace: Fix typo in ftrace.rst
Date:   Wed, 12 Apr 2023 11:37:39 -0700
Message-Id: <20230412183739.89894-1-starpt.official@gmail.com>
X-Mailer: git-send-email 2.25.1
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

There is a typo in the sentence "A kernel developer must be
conscience ...". The word conscience should be conscious.
This patch fixes it.

Signed-off-by: Lin Yu Chen <starpt.official@gmail.com>
---
 Documentation/trace/ftrace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b927fb2b94dc..e8bca5fea7cc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3510,7 +3510,7 @@ directories, the rmdir will fail with EBUSY.
 Stack trace
 -----------
 Since the kernel has a fixed sized stack, it is important not to
-waste it in functions. A kernel developer must be conscience of
+waste it in functions. A kernel developer must be conscious of
 what they allocate on the stack. If they add too much, the system
 can be in danger of a stack overflow, and corruption will occur,
 usually leading to a system panic.
-- 
2.25.1

