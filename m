Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1785F3CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiJDGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:46:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCAC27B1E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:46:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2896821901;
        Tue,  4 Oct 2022 06:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664866016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=22LqX3bXZjSUurBfdPLeCZ0WOJ5zDktslBqpxZ9yU6o=;
        b=K1WvH+shCaXCdqIbz0UkjrlMLfmyqFGTvOJz8ZUM/0pm/jdKo8GGck5q9akuMilzO8wef2
        /l1NAnAgTbl2OrWviRmnVYpH/++DLmh7QDpDvW/hG+/eh/5pZefA3S0HvVBbbjsHa24OVv
        zJrUNHSVOgd+OhbUXZA4iM/KVVrjYqg=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1F4372C143;
        Tue,  4 Oct 2022 06:46:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8038DA85B; Tue,  4 Oct 2022 08:46:55 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS update for 6.1
Date:   Tue,  4 Oct 2022 08:46:55 +0200
Message-Id: <cover.1664865843.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's one minor update for AFFS, switching away from strlcpy. Please
pull, thanks.

----------------------------------------------------------------
The following changes since commit 5abbb7b92820cf6ba9154a35cff6d64b62d7f273:

  affs: use memcpy_to_page and remove replace kmap_atomic() (2022-08-01 19:53:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-6.1-tag

for you to fetch changes up to 505ffcc852401aaac4dfb57c16bec0f7838c0e00:

  affs: move from strlcpy with unused retval to strscpy (2022-08-19 13:03:10 +0200)

----------------------------------------------------------------
Wolfram Sang (1):
      affs: move from strlcpy with unused retval to strscpy

 fs/affs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
