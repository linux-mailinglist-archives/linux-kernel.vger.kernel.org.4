Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFB5F47FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJDQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJDQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:57:44 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C15F7C8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kX6pfwunDKBU5xYNmiqaMSslgSmz9tLuJs+X/fGfm1w=; b=uguPeF1zK2rDfOrqApbUTE+Dn2
        /j8qbCrEaZgUFtP21qt+jt2Xv6ooJagn0mnEaB8FQqIssA01wXuEPZ0sdB6C1CfQD8eqNjPOCF7Tm
        RegPWotnLfqzTx6FLubsZ+iH1l174oyp3D1Eo/vgGykDPP0WlGIzUFgCsOsyvc2cjNcXPTI7d6M2+
        WcNXCHASLlrPnPLVcVtCuYQ1mmV4P21ImoZ1uBdLDPBFF55TUExFRrclCnXSX8A251Si9oq5F1zoS
        9++QG78nv+2yS2dmh352RDy2h3enexa3aNTlrHGHJ1GHvLBWQXCKTA2P8LAKggwkhEwgAw3/aT9yk
        Fr9DbFdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oflEh-0072Nw-0t;
        Tue, 04 Oct 2022 16:57:39 +0000
Date:   Tue, 4 Oct 2022 17:57:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [git pull] vfs.git pile 5 (misc tomoyo)
Message-ID: <YzxmAydeCAIquyut@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-tomoyo

for you to fetch changes up to 467cf8ef88d3124c189e2ff4726fe5247a88fe46:

  tomoyo: struct path it might get from LSM callers won't have NULL dentry or mnt (2022-08-21 11:50:42 -0400)

----------------------------------------------------------------
a couple of assorted tomoyo patches

----------------------------------------------------------------
Al Viro (2):
      tomoyo: use vsnprintf() properly
      tomoyo: struct path it might get from LSM callers won't have NULL dentry or mnt

 security/tomoyo/audit.c    | 2 +-
 security/tomoyo/common.c   | 2 +-
 security/tomoyo/file.c     | 2 +-
 security/tomoyo/realpath.c | 9 ++-------
 4 files changed, 5 insertions(+), 10 deletions(-)
