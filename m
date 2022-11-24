Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A3637B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKXORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiKXORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:17:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2A10958C;
        Thu, 24 Nov 2022 06:16:27 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifGPZWbO1ewlaKX2cZyR+nYcHOFN7mKdQoTquUGhQfA=;
        b=1LvavnnmZtgr37icAv8wtiRncR7+K94N2iq1KPl4D5hjo+K58E5I/ULSHOB3PwcnjyKAfQ
        e8c/irey6AmzJP69VyKNXW7IyU14ckzMTF6yQLp608GkuudFpBLudlb78dhihEKXPSQcxd
        Od7VPWeQLkN9hnD70oYNbKbBsVbKuHcG5nTMRKHCZMwLSnH5BqPcsntJ6xkaAZh7Yc/ABz
        npwRQUoIaCuWfiVnt7Jd+yjETPtO/lxr8a5s0+yqKzCh7YpaZtigDV3pHFPHRvInE81Pzo
        Bg3x8HBF/VXbUh045wmXFST8bgVUrbQeNHc3S+R1lOWZ1hq3C53mtbvNnRTzeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ifGPZWbO1ewlaKX2cZyR+nYcHOFN7mKdQoTquUGhQfA=;
        b=f5pIUKmnQpXG2temsRv7TYzeiZQ14aYyQmp2zwZ3W2mcqnYAYQjtxmYHdjV+oS0nqY6GoY
        9STy8iU4phyvicDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Documentation: Remove bogus claim about del_timer_sync()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123201624.452282769@linutronix.de>
References: <20221123201624.452282769@linutronix.de>
MIME-Version: 1.0
Message-ID: <166929937874.4906.5556735136767567261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b0b0aa5d858d4d2fe39a5e4486e0550e858108f6
Gitweb:        https://git.kernel.org/tip/b0b0aa5d858d4d2fe39a5e4486e0550e858=
108f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Nov 2022 21:18:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:10 +01:00

Documentation: Remove bogus claim about del_timer_sync()

del_timer_sync() does not return the number of times it tried to delete the
timer which rearms itself. It's clearly documented:

 The function returns whether it has deactivated a pending timer or not.

This part of the documentation is from 2003 where del_timer_sync() really
returned the number of deletion attempts for unknown reasons. The code
was rewritten in 2005, but the documentation was not updated.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.452282769@linutronix.de

---
 Documentation/kernel-hacking/locking.rst                    | 3 +--
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index 6805ae6..b26e4a3 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -1006,8 +1006,7 @@ Another common problem is deleting timers which restart=
 themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
 use del_timer_sync() (``include/linux/timer.h``) to
-handle this case. It returns the number of times the timer had to be
-deleted before we finally stopped it from adding itself back in.
+handle this case.
=20
 Locking Speed
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index 51af37f..eddfba8 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -1027,9 +1027,7 @@ Un altro problema =C3=A8 l'eliminazione dei temporizzat=
ori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo =C3=A8 un problema abbastanza comune con una propensione
 alle corse critiche, dovreste usare del_timer_sync()
-(``include/linux/timer.h``) per gestire questo caso. Questa ritorna il
-numero di volte che il temporizzatore =C3=A8 stato interrotto prima che
-fosse in grado di fermarlo senza che si riavviasse.
+(``include/linux/timer.h``) per gestire questo caso.
=20
 Velocit=C3=A0 della sincronizzazione
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
