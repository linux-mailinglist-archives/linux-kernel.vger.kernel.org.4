Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5672B4B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFKXFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKXFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6525FE47
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686524655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=11LmYFEb2txGYaQwbovbb9GnPZ2QfmpSTTWbszkY7ug=;
        b=BdNGJbUwzcEmoWNwTdnqSkWnyYeqOr8EZsAz/+bIbIDZ8m99z1r48+eFlmjGRhJRzMC7jx
        zH30MQHyDY2D5FTwsA0U5mfro3cWp7LFjnlCmxyDs0K/EnUPF5TzDbQQTKnZcLWKJ1QsZL
        6ZegHCtMsEiUKaMC6cQX51QUgILX16o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-kqJYrdwTOOqhtegdoOQAoQ-1; Sun, 11 Jun 2023 19:04:12 -0400
X-MC-Unique: kqJYrdwTOOqhtegdoOQAoQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C83E5101A52C;
        Sun, 11 Jun 2023 23:04:11 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-34.pek2.redhat.com [10.72.12.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6F78492B0B;
        Sun, 11 Jun 2023 23:04:07 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, will@kernel.org, Baoquan He <bhe@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] arm64: add kdump.rst into index.rst
Date:   Mon, 12 Jun 2023 07:03:58 +0800
Message-Id: <20230611230358.13635-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document kdump.rst was added into Documentation/arm64/, but not listed
in Documentation/arm64/index.rst. That triggers below warning when
executing "make htmldoc":

>> Documentation/arm64/kdump.rst: WARNING: document isn't included in any toctree

Fix it now.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arm64/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index ae21f8118830..e58391557f00 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -15,6 +15,7 @@ ARM64 Architecture
     cpu-feature-registers
     elf_hwcaps
     hugetlbpage
+    kdump
     legacy_instructions
     memory
     memory-tagging-extension
-- 
2.34.1

