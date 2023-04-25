Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9876EDC92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjDYH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjDYH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:27:54 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF35CC0F;
        Tue, 25 Apr 2023 00:27:13 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3047ff3269aso997751f8f.0;
        Tue, 25 Apr 2023 00:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682407623; x=1684999623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anbzC7fpaMxRgKbGTHCf+Ypir7RbEsM4mAuu7bHFScU=;
        b=bgEl7WVxOhfc7V/EGpfWhH30TEreSYY9q/2hg7fBURjoHiiho7lr79vrO+0HOFsbr9
         MMBL97H69YVMQy1gps10Moucx1jEmNljRPX0R5e6dlP2CxaSp/s6sXxC331cz7U6Eqf7
         GakaR26Jd+9s5SYuO2/CfqhpyCv6RHqwLqp5XMc4JKr6ZxcXUMRXkETZ6tji3t2a7Lyq
         3r21n0FyNAPv1yQd+NpbCCE/w0hvpf3eR6vDHx3XSQMllSrP9fbUUFTgx4xZTi3fMNG/
         KzURjzrupc0978suMCqmqeF6hYCyA1/iRLV46AW0vIcBlJTZAFSX7esEfUXcSgKdq75j
         nhIA==
X-Gm-Message-State: AAQBX9cFptGHy+8Q36/gof+ncOA5dXDFd1s7VbD8q7cncI/sorMg6OEy
        FxRRlK5a+q8o+q/8Nkvt5aQ=
X-Google-Smtp-Source: AKy350biIUtO/kChzZEbsFdXOlPYfTzgcNJYccIpGUOz2HRwvvSh7SLB74CXnN+snvu/SLYpl1P5EA==
X-Received: by 2002:a5d:4c4d:0:b0:2d7:a062:ec8 with SMTP id n13-20020a5d4c4d000000b002d7a0620ec8mr11277270wrt.41.1682407623105;
        Tue, 25 Apr 2023 00:27:03 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id c16-20020a05600c0ad000b003f198dfbbfcsm8411489wmr.19.2023.04.25.00.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 00:27:02 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rong Tao <rtoax@foxmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: split subtitle of Submitting patches
Date:   Tue, 25 Apr 2023 10:26:43 +0300
Message-Id: <20230425072644.868535-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivation:

The original long page title in the left Content pane spans three lines:

Submitting patches: the essential
  guide to getting your code into
  the kernel

Issues:
- It is not readable.
- It further inflates already overpopulated Contents pane.

The solution:
- Split the long title to title and subtitle.
- Vertical bar '|' in Sphinx-doc introduces empty line to
  make the subtitle closer to the title than to the following text.


Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/process/submitting-patches.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 7a5619fecb38..051eba1bbc7f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -1,7 +1,10 @@
 .. _submittingpatches:
 
-Submitting patches: the essential guide to getting your code into the kernel
-============================================================================
+Submitting patches
+==================
+The essential guide to getting your code into the kernel
+
+|
 
 For a person or company who wishes to submit a change to the Linux
 kernel, the process can sometimes be daunting if you're not familiar
-- 
2.40.0

