Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B5572A76A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjFJBV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjFJBVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:21:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A49830F9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:21:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A37AD3200914;
        Fri,  9 Jun 2023 21:21:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 09 Jun 2023 21:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686360082; x=1686446482; bh=6g
        2RVl+GpOZe2oQM/8nONsqThYPCh2VfCuomeQ/pDfE=; b=ixy4icfz8BrLovCkGr
        M+huV0302OV6wUxAHuOR+c8W7vhfc09wvPnQtzl/nyMMZlhikc0m2JllT/wBCSx2
        DJBNVVsDNBS3gHUHZKMqLwg2jxICrp1LeyH8cNponrqEcFay6AKG1VR0p0ZAlS+w
        PsgX8lv7a3kWeh8no10JKcbzUDAfMX3VPG44LwghwXywN1GQGuGPSKmX/0+/zTbD
        zl2S4VGjT1DEh8u6f++9vzvY/9zLESx9j27yQNmdW7GFwGyUcxvDDk2QahYmNfHI
        2Wjja2kUQaViuSVi2W767xTAmi7+eM4EEueTCOiFHA+FdYTj4WwcJjjZBL/xESP0
        Jw6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686360082; x=1686446482; bh=6g2RVl+GpOZe2oQM/8nONsqThYPCh2VfCuo
        meQ/pDfE=; b=PQOIbIq42EKpMxvSNOdVfZdzdFqzS422zwnuMhi1KtYihXf+HQB
        CDM/53QH55Z7zYu8XI9xwlYd4009UEIy2fa7ZYXyDh5RhrUJiUzu2ta760QrMh7T
        zDU5OpVdxL+pa0RhzeXRHZOb3h9sO6WGBnTNL68z7ytYOfl5gGhI4zN4lJcbg/7v
        +ozTSN6y1nQ22+30ITaBGSJJmLoIYYAPykTz3REh3f6TBbB+/fE8Ae0F5biK+DEN
        IU6PbJMMTItpt69RMEJsl9ihkzxsGKGug3zHQ2NndV0II610u0xINkHKFJTIiGVq
        YJogkUZEJuS1sUtoAP5RWW/algYrKYYW5iA==
X-ME-Sender: <xms:EdCDZEnuqTpMeXgN36L4Zpip7N2TkMj0AhVmial-eRuINCtTvEwqlw>
    <xme:EdCDZD0nsucEMJATGovBxCphseTFiBkD4EYRSPnnKGd03AcArxQvEbNAtXMmwjuLg
    xmPkZEEdvg7SllfXvg>
X-ME-Received: <xmr:EdCDZCrbt7-Xqe5cdGwbP1i45-TKH9bkp4oRMpfyse39EULVnc5-FV3wXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtledggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomheplfhoshhhucfv
    rhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeduvdelheettdfgvddvleegueefudegudevffekjeegffefvdeikeeh
    vdehleekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:EtCDZAl5y4vTebDsgAhVLsvibDfw1pcD7OXOOD3rzVRQKLUwOrQF6g>
    <xmx:EtCDZC1j8PKzdSj7JDVgKCIM82hJUX4RmDxmTx8nYeK3wqnFcZDJGQ>
    <xmx:EtCDZHtE1139yibXIvshqcC8i2L-6Zl2zQbSaB5zAAcEAKBJzKlegQ>
    <xmx:EtCDZFSCdQ3yO6YBH2yuChoDRmOHEYmXWmDVcenxHdmeBept6IKQtw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jun 2023 21:21:20 -0400 (EDT)
Date:   Fri, 9 Jun 2023 18:21:19 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm: hugetlb: Add Kconfig option to set default
 nr_overcommit_hugepages
Message-ID: <88fc41edeb5667534cde344c9220fcdfc00047b1.1686359973.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default kernel configuration does not allow any huge page allocation
until after setting nr_hugepages or nr_overcommit_hugepages to a
non-zero value; without setting those, mmap attempts with MAP_HUGETLB
will always fail with -ENOMEM. nr_overcommit_hugepages allows userspace
to attempt to allocate huge pages at runtime, succeeding if the kernel
can find or assemble a free huge page.

Provide a Kconfig option to make nr_overcommit_hugepages default to
unlimited, which permits userspace to always attempt huge page
allocation on a best-effort basis. This makes it easier and more
worthwhile for random applications and libraries to opportunistically
attempt MAP_HUGETLB allocations without special configuration.

In particular, current versions of liburing with IORING_SETUP_NO_MMAP
attempt to allocate the rings in a huge page. This seems likely to lead
to more applications and libraries attempting to use huge pages.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 mm/Kconfig   | 14 ++++++++++++++
 mm/hugetlb.c |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..32c13610c5c4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -824,6 +824,20 @@ config READ_ONLY_THP_FOR_FS
 
 endif # TRANSPARENT_HUGEPAGE
 
+config HUGEPAGE_OVERCOMMIT_DEFAULT_UNLIMITED
+	bool "Allow huge page allocation attempts by default"
+	depends on HUGETLB_PAGE
+	help
+	  By default, the kernel does not allow any huge page allocation until
+	  after setting nr_hugepages or nr_overcommit_hugepages to a non-zero
+	  value. nr_overcommit_hugepages allows userspace to attempt to
+	  allocate huge pages at runtime, succeeding if the kernel can find or
+	  assemble a free huge page.
+
+	  Enable this option to make nr_overcommit_hugepages default to
+	  unlimited, which permits userspace to always attempt hugepage
+	  allocation.
+
 #
 # UP and nommu archs use km based percpu allocator
 #
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f154019e6b84..65abbe254e10 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4305,6 +4305,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	mutex_init(&h->resize_lock);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
+	if (IS_ENABLED(CONFIG_HUGEPAGE_OVERCOMMIT_DEFAULT_UNLIMITED))
+		h->nr_overcommit_huge_pages = ULONG_MAX;
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-- 
2.40.1

