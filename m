Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7F6A1562
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 04:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBXDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 22:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:30:14 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18091632C;
        Thu, 23 Feb 2023 19:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WoGEh3GpgKr7pgT4O415W8h/g3kPJjv7hqWwOPUeUCw=; b=vCWhtk+KhDTKQiqUL4Y57ZVkGI
        tj2t0oIw6j8vberwOPeM/O41jl64O35gu+6ypR86v55330b4YJ+mOsomgT/9t3MC0wU39RRGnztwn
        vBfT88G2NhMYNOU4uxPSHv78AvXOum/fXVEADHnkpsjRzUpDeUcuhbmArrJ7TfBQ6IRy+D5ES9+/6
        FQtMRchhtvKUfID8vrjLU06fhkkBW3rS5dvWgqQywocNi74P6TRCaiwR/hcMAHyLrlhUmx/dfJqom
        arhQmucHPVfg8ERmn3tVsG4hRkUW/J3y8+kQc3UOdykqewrTvVLF3bgBJjb4tni+VG5vKKAjlQjVf
        1EWfmW3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pVOmg-00Bs95-1s;
        Fri, 24 Feb 2023 03:30:10 +0000
Date:   Fri, 24 Feb 2023 03:30:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: [git pill] vfs.git alpha fixes
Message-ID: <Y/gvQh5+4k8y+IdF@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	FEN fault fix deals with a really old oopsable braino, the rest
is alpha/boot compile fixes and minor cleaning up.

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.alpha

for you to fetch changes up to beb9797ee8b0c19598ffccdfae24afa6e0066f6a:

  alpha/boot/misc: trim unused declarations (2023-01-11 15:36:52 -0500)

----------------------------------------------------------------
Al Viro (4):
      alpha: fix FEN fault handling
      alpha/boot: fix the breakage from -isystem series...
      alpha/boot/tools/objstrip: fix the check for ELF header
      alpha/boot/misc: trim unused declarations

 arch/alpha/boot/bootp.c          |  2 +-
 arch/alpha/boot/bootpz.c         |  2 +-
 arch/alpha/boot/main.c           |  2 +-
 arch/alpha/boot/misc.c           |  2 --
 arch/alpha/boot/stdio.c          |  4 ++--
 arch/alpha/boot/tools/objstrip.c |  2 +-
 arch/alpha/kernel/traps.c        | 30 +++++++++++++++---------------
 7 files changed, 21 insertions(+), 23 deletions(-)
