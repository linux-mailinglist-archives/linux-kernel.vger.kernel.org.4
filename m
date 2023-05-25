Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE84711966
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbjEYVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbjEYVn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571DA187;
        Thu, 25 May 2023 14:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FF3664B7B;
        Thu, 25 May 2023 21:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD41C4339C;
        Thu, 25 May 2023 21:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685051007;
        bh=ZSCtM5xpPfxl9ZcGY7kbIAlY3W8XFj4VJBVoZq5mrJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUwAJi3+gowT9HAFkMA0ZZUXqK2ioGmXpGUdjFB/arrg1Po32AkJnMJW3vr1F8fVE
         qRIBYNlqXONIP0Ej+C7cc/MCaVrcckNuW4yEzQ7sIBvgdjWCbVpn/lCXKn9b9fu0oI
         dnlfRUcIp1zYYpGfvXXb55umKr+yvpGgN6M8KjTixK6MXezkXnfeA8fDKIZecHpPWf
         LGfcobjbi87gaaplEvo3xfU+sQkC+jAp+vvInameYiGl+KrtIbhVILbRJUl+1HcQeX
         7mgDcXYZqiVLlOp1U/byyRYiOev/QYdoYXqSwsMA4SMhMeCfWNDbss1MhsUNGpdt+1
         8LcZKj9Jmx1eA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] Docs/mm/damon/design: add a section for DAMON core API
Date:   Thu, 25 May 2023 21:43:13 +0000
Message-Id: <20230525214314.5204-10-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525214314.5204-1-sj@kernel.org>
References: <20230525214314.5204-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a section covering the API of DAMON core layer on the design
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 706dbc17c6cb..0ccdd2f6af9f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -358,3 +358,15 @@ example, the memory cgroup filter type asks users to specify the file path of
 the memory cgroup for the filter.  Hence, users can apply specific schemes to
 only anonymous pages, non-anonymous pages, pages of specific cgroups, all pages
 excluding those of specific cgroups, and any combination of those.
+
+
+Application Programming Interface
+---------------------------------
+
+The programming interface for kernel space data access-aware applications.
+DAMON is a framework, so it does nothing by itself.  Instead, it only helps
+other kernel components such as subsystems and modules building their data
+access-aware applications using DAMON's core features.  For this, DAMON exposes
+its all features to other kernel components via its application programming
+interface, namely ``include/linux/damon.h``.  Please refer to the API
+:doc:`document </mm/damon/api>` for details of the interface.
-- 
2.25.1

