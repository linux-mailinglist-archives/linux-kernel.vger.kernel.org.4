Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5771F908
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjFBDyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:54:09 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86302180
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 20:54:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337a5861so3982212276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685678047; x=1688270047;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4rpaRYhp9pezQBgGgl7jQUhQdvTwr6KJlRlk+rOPp+4=;
        b=oy7uyJW5kSVKl5JSZ/Uud8NxX96LuyPz1MBYWsWFDACRtnYfZ1CykuEc2PuIU66iaC
         nPGpUMcz+eLB6jycjZt1gVbGp4FGxaTUDJbaAWFE9qLsiXIPMFlFNTs7ymDceTA3fszR
         T52SUG0LFVyp50KWfFp4BrB78tpk+y11glHpxWmJ0IOh6CcMCPlkb957vcAWhEs/KT3K
         cXrSV9Y4YNMOWee17PUB5H+ggHFhVEqXycwu25L/+KLR/bWyA1nqzOeG2rbG7Kvudu4s
         R5vrkEk5r6zFr9seW2+eyeZp/02I+rUHk8MMYmq11yLTl/47oyZCUKm68jpRxRlnCyis
         GFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685678047; x=1688270047;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rpaRYhp9pezQBgGgl7jQUhQdvTwr6KJlRlk+rOPp+4=;
        b=RMBxJOuXkXZcT/3U1MrlP41X5YQC+xby2K4pc8sJbvyAE3SLe4YGzqFThk92YhLZ9T
         MHEXHZNSpoUUier1JvT4L5AmRFVRuEcykfiv9f38mkPgktuxntS88jJotrVl1P1K+xAF
         P2jHt22YO8FeliSIuXSloC7dqQ2jT7UFwRelLi8qPbvW8+udu6WaDMP74hsfJF5QjEfC
         4vCdxDQtSaoSEJtUfrN33Ncc2wt6E5OXspZXejLupA1U537ITU7UV/0oc26WQQUM6Uog
         PVXsqS+gB3Y0X6oA6CPn1v0V+sKsaggCPUESAHBAcv/A3s9wWFSZdy6IYcMIpUvyAkfy
         0Utg==
X-Gm-Message-State: AC+VfDwF43umcuV2pCQLxPU2mfMEf7FauSZO5Gp+dW15TPeykByKceQb
        ABCrXngchbTwtFMRfiNuJC21ZGJ5L2TPAQ==
X-Google-Smtp-Source: ACHHUZ4kDJe2xZPeYgvJPMDUZ6UocdXCqm7Vq9ZTHKGva9YUiMBK+nsyd/mpj/y1ZSiphFIx6Cj3S9zv926dBQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:d404:0:b0:bad:2828:479 with SMTP id
 m4-20020a25d404000000b00bad28280479mr1058303ybf.6.1685678047749; Thu, 01 Jun
 2023 20:54:07 -0700 (PDT)
Date:   Fri,  2 Jun 2023 11:53:59 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230602035400.2333527-1-davidgow@google.com>
Subject: [PATCH] Documentation: kunit: Rename references to kunit_abort()
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Rae Moar <rmoar@google.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kunit_abort() function has been renamed __kunit_abort(), update the
references to it in the documentation.

Suggested-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/architecture.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
index e95ab05342bb..f335f883f8f6 100644
--- a/Documentation/dev-tools/kunit/architecture.rst
+++ b/Documentation/dev-tools/kunit/architecture.rst
@@ -119,9 +119,9 @@ All expectations/assertions are formatted as:
 	  terminated immediately.
 
 		- Assertions call the function:
-		  ``void __noreturn kunit_abort(struct kunit *)``.
+		  ``void __noreturn __kunit_abort(struct kunit *)``.
 
-		- ``kunit_abort`` calls the function:
+		- ``__kunit_abort`` calls the function:
 		  ``void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)``.
 
 		- ``kunit_try_catch_throw`` calls the function:
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

