Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5E8711963
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbjEYVnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbjEYVn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A21FB;
        Thu, 25 May 2023 14:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F189864B5E;
        Thu, 25 May 2023 21:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F02C4339C;
        Thu, 25 May 2023 21:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051005;
        bh=ajEgfoPi4mQLMDMHVEFRgzRHD6TvLlqgYGgpcmGScQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m66zBEyUfmCHCn8eqRJo7jy6hhFYE0z8qSqIKv/ocFre/3j2zl5dAs3Q+xajxI8Xc
         tn1D02jKcsAEw4JkGIcrrZwanKto7rchuYRxJZPQRgI2D75KsdZJF4gAS0w5P/yMjQ
         gZi6aD5/uwDKpNNfZuMeFBUYsE+40xXMBc8AleEf2Ugq4ZvcEyjNx0lejmzbQQB6hF
         VGQwiHmC1aruQ6iCJRhSpAR+J/LuCA3aWm3G7Iiq5o4kfPjbVQ1yVBKc4ItrzTpwNn
         TJpbfOOkBKWNXrJaJfS79kjCqRs1jkR9Q0LdkTMCJJBSz46ITvg+2Oatux3sBcFoGt
         ciBVpJ/GZEb3g==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] Docs/mm/damon/design: add a section for the relation between Core and Modules layer
Date:   Thu, 25 May 2023 21:43:10 +0000
Message-Id: <20230525214314.5204-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
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

Add overall desription of the interface and the relation between the
Core and the Modules layer under 'Overall Architecture' section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 4a22bab124cf..41abd0430dd7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -41,6 +41,16 @@ Also, if some architectures or devices supporting special optimized access
 check primitives, those will be easily configurable.
 
 
+Programmable Modules
+--------------------
+
+Core layer of DAMON is implemented as a framework, and exposes its application
+programming interface to all kernel space components such as subsystems and
+modules.  For common use cases of DAMON, DAMON subsystem provides kernel
+modules that built on top of the core layer using the API, which can be easily
+used by the user space end users.
+
+
 Operations Set Layer
 ====================
 
-- 
2.25.1

