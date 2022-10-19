Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BE660514C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJSU3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJSU2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:28:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAFC1C8106
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 907F5619C2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9F7C433D6;
        Wed, 19 Oct 2022 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666211331;
        bh=u83e/tAeEj/i+VC3hmO8X6CBG1Ga+kJc8l/dPOEqfKI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ys10kToSr0KK7GNR5ge5kSEIIrV7ZkV+/vgIC6dtbhfAIzFwkjQV+loQuZFu1Bl9Y
         j+6V0d3MFg9iYQ35eXsWxATV+Wdvx2GdJWG/WHMgq+dZ/DpQqNkWwURRKE1yKfYwvi
         5ePv9snJK8beFvMLJpQU8ycYqSIhT+wkJZmTMnstTeMJbDR9zFPDHHDjorBikogaPg
         Ms8jDc6oPc5VN9v+wRR+6keUe/icOJYIu4EzMedju+Dxv/7xIOWCh6miCFQW47apgj
         OQa/Kfrrsp6VDqrmt/vFSsiXGcPDoR8brZA1DY5nCNG64gTLFypQgCi5qjq/1XHOpq
         ILF0jxC50bD/w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] checkpatch: add warning for non-lore mailing list URLs
Date:   Wed, 19 Oct 2022 15:28:43 -0500
Message-Id: <20221019202843.40810-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
as lore.kernel.org because they use different styles, add advertising, and
may disappear in the future.  The lore archives are more consistent and
more likely to stick around, so prefer https://lore.kernel.org URLs when
they exist.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

Sample commits for testing with "checkpatch -g":

  bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
  fdec2a9ef853 www.spinics.net/lists/kvm-arm
  1cdca16c043a www.spinics.net/lists/linux-mmc
  48ea02184a9d www.spinics.net/lists/linux-pci
  f32ae8a5f131 www.spinics.net/lists/netdev
  b7dca6dd1e59 lkml.org
  265df32eae58 lkml.org/lkml/
  4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
  c03914b7aa31 marc.info/?l=linux-mm
  f108c887d089 marc.info/?l=linux-netdev
  7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
  dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
  b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
  5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
  3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
  a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html

Previously posted:
  https://lore.kernel.org/all/20201217235615.43328-1-helgaas@kernel.org/
  https://lore.kernel.org/all/20220401201417.126664-1-helgaas@kernel.org/
---
 scripts/checkpatch.pl | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1e5e66ae5a52..4e187202e77a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -702,6 +702,17 @@ sub find_standard_signature {
 	return "";
 }
 
+our $obsolete_archives = qr{(?xi:
+	\Qfreedesktop.org/archives/dri-devel\E |
+	\Qlists.infradead.org\E |
+	\Qlkml.org\E |
+	\Qmail-archive.com\E |
+	\Qmailman.alsa-project.org/pipermail\E |
+	\Qmarc.info\E |
+	\Qozlabs.org/pipermail\E |
+	\Qspinics.net\E
+)};
+
 our @typeListMisordered = (
 	qr{char\s+(?:un)?signed},
 	qr{int\s+(?:(?:un)?signed\s+)?short\s},
@@ -3324,6 +3335,12 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check for mailing list archives other than lore.kernel.org
+		if ($rawline =~ m{\b$obsolete_archives}) {
+			WARN("PREFER_LORE_ARCHIVE",
+			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.25.1

