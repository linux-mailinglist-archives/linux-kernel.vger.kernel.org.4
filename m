Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C645ECE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiI0UM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiI0ULm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:11:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17251EAD44;
        Tue, 27 Sep 2022 13:10:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89EFFB81D31;
        Tue, 27 Sep 2022 20:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67611C433C1;
        Tue, 27 Sep 2022 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664309457;
        bh=GDU6ovrr2pSsr59p7jPLM3pt5taNbU6kNiIARZ8H3GQ=;
        h=From:To:Cc:Subject:Date:From;
        b=XrvUqTAHKWkv4uZMt7yQqOkZwo4yiCI5mC4JZqBAy2Mesg0rtuT3ktMwdAaK21umZ
         spLn1yRqYEkWBNlQ0BjpLUGgaw6MWEKutoNvDSoXYwmkHxZuNf31UXhrrZ+pAR/GCO
         EesmMA8ezNMda/GO+fEZrouKsLnI+tlUV6UWaW6e7TTGv9FaxDpwIzbQ3L+REcOhj5
         YhSJccu3RYB3CTCQYzJslcKe1pVwUHjlwObVfeP9RF5czmsy0iBVNoPUduUfLebyhl
         Ht5Vl6rxRXb5mASjcA0j7A3Q9rSjy3GYhz6MhkDquTVFq25Co52VafgR2sERA3Vhqj
         wb1z6DjP4/f8w==
From:   broonie@kernel.org
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 27
Date:   Tue, 27 Sep 2022 21:10:53 +0100
Message-Id: <20220927201053.518736-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20220923:

The vfs tree gained a conflict with the ext3 tree.

The bluetooth tree gained conflict with the net tree.

The various DRM trees gained even more conflicts with each other.

The drivers-misc tree gained a conflict against the jc_docs tree.

The drivers-misc tree gained a conflict against the drm tree.

The v4l tree gained a conflict with the v4l-dvb-fixes tree.

The net-next tree gained a conflict against the i2c tree.

The kspp tree gained a conflict against the arm64 tree.

The kspp tree gained a conflict against the arm64-fixes tree.

The kspp tree gained a conflict against the bpf-next tree.

The mm-stable tree gained a conflict against the bitmap tree.

Non-merge commits (relative to Linus' tree): 9849
 10393 files changed, 558039 insertions(+), 213574 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386,
arm64, sparc and sparc64 defconfig and htmldocs. And finally, a simple
boot test of the powerpc pseries_le_defconfig kernel in qemu (with and
without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 362 trees (counting Linus' and 100 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.
