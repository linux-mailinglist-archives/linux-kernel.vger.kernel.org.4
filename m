Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898A07339BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346074AbjFPTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346134AbjFPTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16913448F;
        Fri, 16 Jun 2023 12:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B84163CB8;
        Fri, 16 Jun 2023 19:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C470C433C9;
        Fri, 16 Jun 2023 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943070;
        bh=aJtinuQE5hnsMJprwvOnjBhsLDj5P+RjjV73H7HUq2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxTPy+3OTB1zZ2p0KOifG1NKvCKG0RPDaSG85QRPUoigBNHlTUZu4IbuDIX1BN/r6
         0+nWVeeA4PP8KxacmnmdoMm28huF1hDRuC3xDPquhxJ9hgJhhpngED2RmZ6zH6kEyu
         vOm2l99AeV0gY6VxJKIc+q6c86nnHp8VLuRBybH05MJ14lf4M3Ud0Tplt+AhqMnPhH
         W71TKq1CqbVD8hCBBNAwHmx02Yp1kwjtV/BEnhE2hT4VQM2Wr+OsPXz5lUtKzPkY+A
         xFXbHLwoDdVbARv4s+MCH8i6Ft0nXc8fQ5morIYwX0LYBsCcf98vRU6AC9zqngPjCv
         nzMOLdQ3vE3iQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Docs/admin-guide/mm/damon/usage: remove unnecessary sentences about supported address spaces
Date:   Fri, 16 Jun 2023 19:17:39 +0000
Message-Id: <20230616191742.87531-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brief explanation of DAMON user space tool and sysfs interface are
unnecessarily and repeatedly mentioning the list of address spaces that
DAMON is supporting.  Remove those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d2435dcc22f4..82a79838a47d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -10,9 +10,8 @@ DAMON provides below interfaces for different users.
   `This <https://github.com/awslabs/damo>`_ is for privileged people such as
   system administrators who want a just-working human-friendly interface.
   Using this, users can use the DAMON’s major features in a human-friendly way.
-  It may not be highly tuned for special cases, though.  It supports both
-  virtual and physical address spaces monitoring.  For more detail, please
-  refer to its `usage document
+  It may not be highly tuned for special cases, though.  For more detail,
+  please refer to its `usage document
   <https://github.com/awslabs/damo/blob/next/USAGE.md>`_.
 - *sysfs interface.*
   :ref:`This <sysfs_interface>` is for privileged user space programmers who
@@ -20,10 +19,9 @@ DAMON provides below interfaces for different users.
   features by reading from and writing to special sysfs files.  Therefore,
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
-  <https://github.com/awslabs/damo>`_ is one example of such programs.  It
-  supports both virtual and physical address spaces monitoring.  Note that this
-  interface provides only simple :ref:`statistics <damos_stats>` for the
-  monitoring results.  For detailed monitoring results, DAMON provides a
+  <https://github.com/awslabs/damo>`_ is one example of such programs.  Note
+  that this interface provides only simple :ref:`statistics <damos_stats>` for
+  the monitoring results.  For detailed monitoring results, DAMON provides a
   :ref:`tracepoint <tracepoint>`.
 - *debugfs interface. (DEPRECATED!)*
   :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-- 
2.25.1

