Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF592639A17
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 12:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK0LYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 06:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiK0LYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 06:24:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F29E080
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 03:24:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E60B1F8B0;
        Sun, 27 Nov 2022 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669548251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7uv1ccI+AAi044FZA47KB2MoMX8TyaRhVOAmJKgr8zM=;
        b=nIc1AZ8kXy6oz5299ka/D/VJlSog8BsRKNdUd36qL5wt0HfKY1ip/ulZj0cAuI+/ab0O6I
        J+jjp/iXKaMLO+yRKsaGDugh+3HvuKjomp8N0BwGzeG2a0DExRbnokL0OxoG7usFj8Q0OS
        ducTtbpYgbtnRihc3iU7ETDB/FElcuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669548251;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7uv1ccI+AAi044FZA47KB2MoMX8TyaRhVOAmJKgr8zM=;
        b=JpFN4c8IWtvcpAZJDM2KROUC0Z91ya49oJdXFo1nYht7Mh6Ek172ShuZZIC7uqA3c/BwVm
        71/Gz6tBck9Uu+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32CC813428;
        Sun, 27 Nov 2022 11:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tqxeDNtIg2OoewAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 27 Nov 2022 11:24:11 +0000
Date:   Sun, 27 Nov 2022 12:24:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for 6.1-rc7
Message-ID: <Y4NI1xw9d7E8O1Lf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull a single objtool fix for 6.1.

Thx.

---

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.1_rc7

for you to fetch changes up to 2d77de1581bb5b470486edaf17a7d70151131afd:

  scripts/faddr2line: Fix regression in name resolution on ppc64le (2022-11-16 10:42:10 +0100)

----------------------------------------------------------------
- Handle different output of readelf on different distros running
ppc64le which confuses faddr2line's function offsets conversion

----------------------------------------------------------------
Srikar Dronamraju (1):
      scripts/faddr2line: Fix regression in name resolution on ppc64le

 scripts/faddr2line | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
