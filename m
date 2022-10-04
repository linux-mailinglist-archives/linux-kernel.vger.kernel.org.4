Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6E5F4550
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJDOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJDOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:20:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A5721E2E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:20:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1081F1F8E9;
        Tue,  4 Oct 2022 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664893229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jsyfQIbdBEtAvEnPAtc2R5Bhcz+2T4MUL9cWLpioO1U=;
        b=VsVxicOPSBJWX6p34gTQ3E6TaKyOqYprumTbjXZCvi9qlVaPW383VR6TPLA3lBs6s0NLIC
        KEhvhIFv+vJgldQZ+OXuw9zUmqIE2lEjlHeR5UIQtUC3OaFYVfOGWWMTWeYbac58vWQ4nv
        /yaz8HaSfqgV85e2V2zLHYO0f+Z9H8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664893229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jsyfQIbdBEtAvEnPAtc2R5Bhcz+2T4MUL9cWLpioO1U=;
        b=KomFnErIvo+JVVWevQ/jS+bqlQPMqTBE/yhWA9RuPGzhZWOVuHGhIXJp0uVcPi9LWRVSB2
        YJSGkI7Jr0U2lJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 037CF139EF;
        Tue,  4 Oct 2022 14:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gJjVAC1BPGPicwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 14:20:29 +0000
Date:   Tue, 4 Oct 2022 16:20:28 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for 6.1
Message-ID: <YzxBLFqmudOPYKY5@zn.tnic>
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

please pull a small bunch of x86 microcode loader improvements for 6.1.

Thx.

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.1_rc1

for you to fetch changes up to 712f210a457d9c32414df246a72781550bc23ef6:

  x86/microcode/AMD: Track patch allocation size explicitly (2022-09-23 13:46:26 +0200)

----------------------------------------------------------------
- Get rid of a single ksize() usage

- By popular demand, print the previous microcode revision an update
  was done over

- Remove more code related to the now gone MICROCODE_OLD_INTERFACE

- Document the problems stemming from microcode late loading

----------------------------------------------------------------
Ashok Raj (2):
      x86/microcode: Document the whole late loading problem
      x86/microcode: Print previous version of microcode after reload

Borislav Petkov (1):
      x86/microcode: Remove ->request_microcode_user()

Kees Cook (1):
      x86/microcode/AMD: Track patch allocation size explicitly

 Documentation/admin-guide/tainted-kernels.rst |   6 ++
 Documentation/x86/microcode.rst               | 116 ++++++++++++++++++++++++--
 arch/x86/include/asm/microcode.h              |   4 +-
 arch/x86/kernel/cpu/microcode/amd.c           |  10 +--
 arch/x86/kernel/cpu/microcode/core.c          |   5 +-
 arch/x86/kernel/cpu/microcode/intel.c         |  17 ----
 6 files changed, 119 insertions(+), 39 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
