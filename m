Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A16EE339
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjDYNi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjDYNi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6191A5;
        Tue, 25 Apr 2023 06:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FFC62534;
        Tue, 25 Apr 2023 13:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D7CC433D2;
        Tue, 25 Apr 2023 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682429902;
        bh=sBxg3yiwscxy+sEv9QHaSn2oXDmTpgkyyIKoxM0h5SQ=;
        h=From:To:Cc:Subject:Date:From;
        b=JsZ25L/7es4jTD7rcQshaIllWMui2LjrPEfktUzSQL19BdNq04RLuRpnAtTjKhbwI
         R3PVa3hq8rSy56grLJErbmIE+W006OnCaJU/i8rR5K9k12DzAghgTvnDPzDzp/v9YR
         VVvtrPAJD30S5Ej2x8EEdCBaatkeJKEn3tNNq/mSC5Xr6fVf3RTlsPTHlUfISO25yJ
         MrsbTaVh8os+A4Z1mj+A9eD4wFcgetf23n5UwrATggyEkDKaDMnEocCdVy5QV3BYTL
         xHRSwmFV1bLdLRLvzQpSL5Q2tfh4XbNUs6g4bDznO6mEpvpOQetPET7tRaDE07p+Ns
         E2AjCZCNYPvdg==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 25
Date:   Tue, 25 Apr 2023 14:38:18 +0100
Message-Id: <20230425133818.115716-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20230424:

Non-merge commits (relative to Linus' tree): 12443
 12443 files changed, 821593 insertions(+), 425356 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There is also the merge.log file in the Next
directory.  Between each merge, the tree was built with a ppc64_defconfig
for powerpc, an allmodconfig for x86_64, a multi_v7_defconfig for arm
and a native build of tools/perf. After the final fixups (if any), I do
an x86_64 modules_install followed by builds for x86_64 allnoconfig,
powerpc allnoconfig (32 and 64 bit), ppc44x_defconfig, allyesconfig
and pseries_le_defconfig and i386, arm64, s390, sparc and sparc64
defconfig and htmldocs. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 358 trees (counting Linus' and 102 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
