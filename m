Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DA68B20F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBEWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 17:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 17:01:16 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FFAA240
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vtnGiw/Xit03DivfbgmKCfCj1CRgGdeC9EWPo8o2+Bo=; b=UMox6Rv3yD2GHm4YlY9rJAuzYU
        rmwcmiRd+J6KFyBxzf/0L/OiwyvGuwwOrOXoexXTVUzQZQJuGaGDROB4mhb6A13HqbpWCoJguS7I0
        XEDlKB4jc9AS/f/VS5s8jUQVQEjv2/mCq86QGS13DAsTAPJcuG18p02EpucA5Da6G5EUmpb2svEXP
        FBdSz0iuNvX0jjPgFSaitPbLKD/vtxIaWZ/9xDsdHSe2lKot/LaHN360H1XWa4q4NawQrrcZKPawJ
        QymH2RsPhk2wZehOx6yB610SQp/j5TymWcEGtxTgvSDwFlMjM617YZHAaFknZHK9TaYpWWBlyHBsp
        Cl/p5UPA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pOn4S-006Q8t-22;
        Sun, 05 Feb 2023 22:01:12 +0000
Date:   Sun, 5 Feb 2023 22:01:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] fixes
Message-ID: <Y+AnKB6wuL7NUFmi@ZenIV>
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

	One of the many equivalent build warning fixes for
!CONFIG_ELF_CORE configs; it's the earliest one I'd been able
to find.

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 9c7417b5ec440242bb5b64521acd53d4e19130c1:

  coredump: Move dump_emit_page() to kill unused warning (2023-01-10 21:03:01 -0500)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      coredump: Move dump_emit_page() to kill unused warning

 fs/coredump.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)
