Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720315F3E50
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJDI2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJDI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:28:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA82F655
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:28:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6C2B2199B;
        Tue,  4 Oct 2022 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664872080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eqd3Ri4mZpgLeGrWTOEJxgTrX+NWYnUBQUp866XudKE=;
        b=sG/W0LBTWg5H3XxEAbtMRSLqr3qTWwlFyNWE4n8Y6X+N7Gj6Qs50q1vQabgGx3Mzuxn1fA
        DhNpgR/DuHhNlXUTuiq4N4DC3lEZkEVS2cw0CMW8ZJZ/SGPv67E4NF35gS6uY68OLiwfyV
        h9E7oJiFtpnpNBv+Hphzi1VWOACX0dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664872080;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eqd3Ri4mZpgLeGrWTOEJxgTrX+NWYnUBQUp866XudKE=;
        b=PiSe5b8vWEaoR8ypeOD+7BV38Kf1Ecanpj/FVaI9pikSRUvMd+Vr9zCinTBSQUfhsx4NCu
        L5TFUD8iZWHr2KCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC7F3139EF;
        Tue,  4 Oct 2022 08:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VJr6LZDuO2MWUAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 08:28:00 +0000
Date:   Tue, 4 Oct 2022 10:27:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/timers for 6.1
Message-ID: <YzvujLPJUr0bHW9y@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some x86 RTC cleanups for 6.1.

Thx.

---

The following changes since commit ffcf9c5700e49c0aee42dcba9a12ba21338e8136:

  x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments (2022-08-10 18:30:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_timers_for_v6.1_rc1

for you to fetch changes up to e1a6bc7c6969527dbe0afa4801a0237e41e26b1b:

  x86/rtc: Rename mach_set_rtc_mmss() to mach_set_cmos_time() (2022-08-14 11:24:29 +0200)

----------------------------------------------------------------
- Cleanup x86/rtc.c and delete duplicated functionality in favor of
using the respective functionality from the RTC library

----------------------------------------------------------------
Mateusz Jończyk (2):
      x86/rtc: Rewrite & simplify mach_get_cmos_time() by deleting duplicated functionality
      x86/rtc: Rename mach_set_rtc_mmss() to mach_set_cmos_time()

 arch/x86/include/asm/mc146818rtc.h |  2 +-
 arch/x86/kernel/rtc.c              | 63 ++++++--------------------------------
 arch/x86/kernel/x86_init.c         |  2 +-
 3 files changed, 11 insertions(+), 56 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
