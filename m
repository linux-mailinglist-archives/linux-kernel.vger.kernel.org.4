Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD46C7D40
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCXLfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:35:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244171CACA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:35:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D40F1FE1E;
        Fri, 24 Mar 2023 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679657751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xWc83XLUl9PJ7QiVshXSwTcQnyqEwM++XJAI9HPUk/s=;
        b=UHFHTfcEihfGAPO/fnNY6qr3FjRWSOFYD0i7rgHXpo8vQFZECiMTJBG2mEmwoeLuDSDQZx
        Fl9hzOQun6QljdjhpmpOLsFTdpYOmV+E5miLje2qvr8VhTt7EuwOq8vrr0RUBi19gd5MhS
        TqrIY3EXq1KfX6Ru6cET7Cs/8IuS4uU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EC61133E5;
        Fri, 24 Mar 2023 11:35:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ClvZFReLHWSCaAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 24 Mar 2023 11:35:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.3-rc4
Date:   Fri, 24 Mar 2023 12:35:50 +0100
Message-Id: <20230324113550.8218-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.3-rc4-tag

xen: branch for v6.3-rc4

It contains two fixes:

- a build warning fix for a patch which went into rc3
- a fix for avoiding concurrent accesses to the Xen PV console ring page


Thanks.

Juergen

 arch/x86/xen/enlighten_pvh.c |  2 +-
 drivers/tty/hvc/hvc_xen.c    | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

Jan Beulich (1):
      x86/PVH: avoid 32-bit build warning when obtaining VGA console info

Roger Pau Monne (1):
      hvc/xen: prevent concurrent accesses to the shared ring
