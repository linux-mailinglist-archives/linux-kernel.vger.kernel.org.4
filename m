Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDE637B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKXOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiKXOQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:16:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF1E0B62;
        Thu, 24 Nov 2022 06:16:09 -0800 (PST)
Date:   Thu, 24 Nov 2022 14:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669299368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqujO4rYZqigQGWFDiVACoUNy9ibpZJ+guS7rMcbWaQ=;
        b=iashBbX7527t7ilCIzhSHjavLdNeHdu/d4rCTi8tbaZHmspEK247/FIaAbMbRRFpKSyF+V
        3I0E1lJGdEmpnr99Smz22jY7MNIvgSlGDLHQhCX/LIV26adTBqR+9irMDEK68Ud9dYIEYj
        ktrJJKmpKXC6Wmmaja/jl83PzuzFjBUdvoQBjLm10oiaviFq+ElwPukN25puCMnqDP6BQ/
        zs7Oj3FFFzdEVnm+dIDChZNsbzwdMPXvLcwpcYM5vEwQH1cKciVQsjJ4NKDtOjGZLSg7FP
        3heSH8B4yQ7PEAZ1gKiuYOCL+zJkaS8yJDsE88K9iUuR+lULvj8SouKJ5mu82Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669299368;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqujO4rYZqigQGWFDiVACoUNy9ibpZJ+guS7rMcbWaQ=;
        b=2QIqB5ssd9mNqLQCFFBSFVD0aAYEtDMFvo9c8pF9KICu0rtLWrpET+jL+/kvVKGme0Tu6k
        0i7chvXSAO+0dVAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Documentation: Replace del_timer/del_timer_sync()
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221123201625.075320635@linutronix.de>
References: <20221123201625.075320635@linutronix.de>
MIME-Version: 1.0
Message-ID: <166929936667.4906.14143095640946298807.tip-bot2@tip-bot2>
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

Commit-ID:     87bdd932e85881895d4720255b40ac28749c4e32
Gitweb:        https://git.kernel.org/tip/87bdd932e85881895d4720255b40ac28749=
c4e32
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Nov 2022 21:18:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 15:09:11 +01:00

Documentation: Replace del_timer/del_timer_sync()

Adjust to the new preferred function names.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201625.075320635@linutronix.de

---
 Documentation/RCU/Design/Requirements/Requirements.rst      |  2 +-
 Documentation/core-api/local_ops.rst                        |  2 +-
 Documentation/kernel-hacking/locking.rst                    | 11 +++----
 Documentation/timers/hrtimers.rst                           |  2 +-
 Documentation/translations/it_IT/kernel-hacking/locking.rst | 10 +++---
 Documentation/translations/zh_CN/core-api/local_ops.rst     |  2 +-
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documen=
tation/RCU/Design/Requirements/Requirements.rst
index a0f8164..546f23a 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1858,7 +1858,7 @@ unloaded. After a given module has been unloaded, any a=
ttempt to call
 one of its functions results in a segmentation fault. The module-unload
 functions must therefore cancel any delayed calls to loadable-module
 functions, for example, any outstanding mod_timer() must be dealt
-with via del_timer_sync() or similar.
+with via timer_delete_sync() or similar.
=20
 Unfortunately, there is no way to cancel an RCU callback; once you
 invoke call_rcu(), the callback function is eventually going to be
diff --git a/Documentation/core-api/local_ops.rst b/Documentation/core-api/lo=
cal_ops.rst
index 2ac3f9f..a84f8b0 100644
--- a/Documentation/core-api/local_ops.rst
+++ b/Documentation/core-api/local_ops.rst
@@ -191,7 +191,7 @@ Here is a sample module which implements a basic per cpu =
counter using
=20
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_delete_sync(&test_timer);
     }
=20
     module_init(test_init);
diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-=
hacking/locking.rst
index b26e4a3..c5b8678 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -967,7 +967,7 @@ you might do the following::
=20
             while (list) {
                     struct foo *next =3D list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list =3D next;
             }
@@ -981,7 +981,7 @@ the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
=20
 This can be avoided by checking the result of
-del_timer(): if it returns 1, the timer has been deleted.
+timer_delete(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
=20
@@ -990,7 +990,7 @@ do::
=20
                     while (list) {
                             struct foo *next =3D list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1005,8 +1005,7 @@ do::
 Another common problem is deleting timers which restart themselves (by
 calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use del_timer_sync() (``include/linux/timer.h``) to
-handle this case.
+use timer_delete_sync() (``include/linux/timer.h``) to handle this case.
=20
 Locking Speed
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -1334,7 +1333,7 @@ lock.
=20
 -  kfree()
=20
--  add_timer() and del_timer()
+-  add_timer() and timer_delete()
=20
 Mutex API reference
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimer=
s.rst
index c1c20a6..7ac4489 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -118,7 +118,7 @@ existing timer wheel code, as it is mature and well suite=
d. Sharing code
 was not really a win, due to the different data structures. Also, the
 hrtimer functions now have clearer behavior and clearer names - such as
 hrtimer_try_to_cancel() and hrtimer_cancel() [which are roughly
-equivalent to del_timer() and del_timer_sync()] - so there's no direct
+equivalent to timer_delete() and timer_delete_sync()] - so there's no direct
 1:1 mapping between them on the algorithmic level, and thus no real
 potential for code sharing either.
=20
diff --git a/Documentation/translations/it_IT/kernel-hacking/locking.rst b/Do=
cumentation/translations/it_IT/kernel-hacking/locking.rst
index eddfba8..b8ecf41 100644
--- a/Documentation/translations/it_IT/kernel-hacking/locking.rst
+++ b/Documentation/translations/it_IT/kernel-hacking/locking.rst
@@ -990,7 +990,7 @@ potreste fare come segue::
=20
             while (list) {
                     struct foo *next =3D list->next;
-                    del_timer(&list->timer);
+                    timer_delete(&list->timer);
                     kfree(list);
                     list =3D next;
             }
@@ -1003,7 +1003,7 @@ e prender=C3=A0 il *lock* solo dopo spin_unlock_bh(), e=
 cercher=C3=A0
 di eliminare il suo oggetto (che per=C3=B2 =C3=A8 gi=C3=A0 stato eliminato).
=20
 Questo pu=C3=B2 essere evitato controllando il valore di ritorno di
-del_timer(): se ritorna 1, il temporizzatore =C3=A8 stato gi=C3=A0
+timer_delete(): se ritorna 1, il temporizzatore =C3=A8 stato gi=C3=A0
 rimosso. Se 0, significa (in questo caso) che il temporizzatore =C3=A8 in
 esecuzione, quindi possiamo fare come segue::
=20
@@ -1012,7 +1012,7 @@ esecuzione, quindi possiamo fare come segue::
=20
                     while (list) {
                             struct foo *next =3D list->next;
-                            if (!del_timer(&list->timer)) {
+                            if (!timer_delete(&list->timer)) {
                                     /* Give timer a chance to delete this */
                                     spin_unlock_bh(&list_lock);
                                     goto retry;
@@ -1026,7 +1026,7 @@ esecuzione, quindi possiamo fare come segue::
 Un altro problema =C3=A8 l'eliminazione dei temporizzatori che si riavviano
 da soli (chiamando add_timer() alla fine della loro esecuzione).
 Dato che questo =C3=A8 un problema abbastanza comune con una propensione
-alle corse critiche, dovreste usare del_timer_sync()
+alle corse critiche, dovreste usare timer_delete_sync()
 (``include/linux/timer.h``) per gestire questo caso.
=20
 Velocit=C3=A0 della sincronizzazione
@@ -1372,7 +1372,7 @@ contesto, o trattenendo un qualsiasi *lock*.
=20
 -  kfree()
=20
--  add_timer() e del_timer()
+-  add_timer() e timer_delete()
=20
 Riferimento per l'API dei Mutex
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/translations/zh_CN/core-api/local_ops.rst b/Docume=
ntation/translations/zh_CN/core-api/local_ops.rst
index 41e4525..22493b9 100644
--- a/Documentation/translations/zh_CN/core-api/local_ops.rst
+++ b/Documentation/translations/zh_CN/core-api/local_ops.rst
@@ -185,7 +185,7 @@ UP=E4=B9=8B=E9=97=B4=E6=B2=A1=E6=9C=89=E4=B8=8D=E5=90=8C=
=E7=9A=84=E8=A1=8C=E4=B8=BA=EF=BC=8C=E5=9C=A8=E4=BD=A0=E7=9A=84=E6=9E=B6=E6=
=9E=84=E7=9A=84 ``local.h`` =E4=B8=AD=E5=8C=85=E6=8B=AC ``asm-g
=20
     static void __exit test_exit(void)
     {
-            del_timer_sync(&test_timer);
+            timer_delete_sync(&test_timer);
     }
=20
     module_init(test_init);
