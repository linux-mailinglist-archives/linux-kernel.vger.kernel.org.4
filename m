Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527A8617821
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiKCH4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKCH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:18 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEBF5F46;
        Thu,  3 Nov 2022 00:55:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8DEC61D44;
        Thu,  3 Nov 2022 08:55:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1667462150; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=wUylA1v2L/wSVlQur6dot5LazixTY5ESTvRCKvYkbj4=;
        b=GFup15Q83mjohhnF3snQzlc6o1RBPDqeeHRFq2MTFBpyRL5eczSKLLr5rzcEzxXlunuwym
        JR9vhwYgPVNss12etNJg75ZOcvd/ZqjKXoGhCjsaX4WeQIn5jRv969QCGtlZFVa/nC83bk
        jjTyJfumCAwVCu9/SnwBziUMrXUROWFzQD7slLxnuG2oOQjLJNym685xa1YlWmhGrMwLVl
        /MJoT5KJOOb+UNdLsJTjjj2dd/nZHT2MkdemGf793Hst1z3rZTC9TFT9FmSvHtNuqdtEaQ
        Yj4fAaUuW1zZqeCAHXj8kVruX487IUUnJ3PvyIxAqCvjeoxoGQkS9HSAOpoiMA==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 0/4] Linux v4.19.255-rt114-rc2
Date:   Thu,  3 Nov 2022 08:55:44 +0100
Message-Id: <20221103075548.6477-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.255-rt114-rc2.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2022-11-10.

To build 4.19.255-rt114-rc2 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.255.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.255-rt114-rc2.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.255-rt114-rc1:


Anna-Maria Gleixner (1):
  timers: Prepare support for PREEMPT_RT

Daniel Wagner (1):
  Linux 4.19.255-rt114-rc2

Sebastian Andrzej Siewior (1):
  timers: Don't block on ->expiry_lock for TIMER_IRQSAFE timers

Thomas Gleixner (1):
  timers: Move clearing of base::timer_running under base:: Lock

 kernel/time/timer.c | 137 +++++++++++++++++++++++++++++++-------------
 localversion-rt     |   2 +-
 2 files changed, 98 insertions(+), 41 deletions(-)

-- 
2.38.0

