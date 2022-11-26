Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6297639374
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKZCkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKZCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:39:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9235BD6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:39:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23645B82C1E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A88C433C1;
        Sat, 26 Nov 2022 02:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669430394;
        bh=hNp6kkavaA4fFEtDxD/RPPtCE6oh1dDhusRYeGSmsy0=;
        h=From:To:Cc:Subject:Date:From;
        b=U6bj76mOt6z+WXCP4Na0X3vxR+JMS8DKAIInJnpun6dOoNU9YOVT1G+qRXDCjArvB
         XS4v0flEKV1+xaGhlhqNRLOjvFQ3fGVQFdDDTgKBaQJi8R3tcfqa6AEpKQf8rzKPm5
         yDdCtNjm28vj8egsYNA5ygpUkoRqBmJLoHPlz0EIOPtoLYLhYQyU6Yfshi0l1QrkiM
         PtycVjBVxPrCre5JhTGm4bgzmZLSsChVFmqAu5Fd1Y1u4jxsiAK/ryguCfSJOKiyFn
         IBZ+wRiUwIpT9Jz6cC3IWlBQmfD8dVyZjoAIOhesR5PRuULNfeCj6dBI/7aYZlsD1e
         NKcQyyYtj555w==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] MAINTAINERS: Add f2fs bug tracker link
Date:   Sat, 26 Nov 2022 10:38:07 +0800
Message-Id: <20221126023807.3490189-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As f2fs component in bugzilla.kernel.org was created and used since
2018-7.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..01fdbb592ea7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7828,6 +7828,7 @@ M:	Chao Yu <chao@kernel.org>
 L:	linux-f2fs-devel@lists.sourceforge.net
 S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
+B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	Documentation/filesystems/f2fs.rst
-- 
2.25.1

