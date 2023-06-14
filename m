Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB0E730A84
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbjFNWUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFNWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC84F1FE8;
        Wed, 14 Jun 2023 15:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4413260AC7;
        Wed, 14 Jun 2023 22:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F89C433C8;
        Wed, 14 Jun 2023 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686781229;
        bh=CGoJR5QoDuxF4+t0XkFfc0TIwwZpz6fsFiOmDOmAl2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WLB6oY9a0TdDJHrxcNQGkB2vQsMUq+nd4wPcjt9UWLkPTrRzisVe9w+uAX4CIGcdP
         U2++w0xdpNj3H104y1hCxMW/B8FSU+fWXmI3qLGL66KQdPntONNBGk+cXbDRdaSDV/
         E+OwARJ7W8hRwhvUTMvjrH6gT82Y2t22Pm4yFrQ4QGNgfLFmrssqZk/oxrKTcJZk/D
         4T0UOuAYVTRF/LKzo1PH/veQY4nMM5asETESBISIL1NuZOu/FBoiKgt6wGWONlNM1Z
         wiIA4SwTM6NIjMhPVXqlGiBlZcOhxjzp0e4RoD9bQIIdlbu34tSqubcq2gxUWPBDYp
         jG408iDQ3fj+w==
Date:   Wed, 14 Jun 2023 23:20:24 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Hyunwoo Kim <imv4bel@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Thomas Voegtle <tv@lio96.de>, linux-kernel@vger.kernel.org
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <20230614232024.171130f8@sal.lan>
In-Reply-To: <8065316b-0a3a-e7d5-28de-cc9fc9210ce5@leemhuis.info>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
        <439d143b-1de7-6365-cf64-f1b44fd6d1cf@leemhuis.info>
        <20230605113727.69e7f309@sal.lan>
        <88d8a7c3-0018-cc9a-13aa-e3262e20e4aa@leemhuis.info>
        <20230605190046.63c98b3e@sal.lan>
        <8065316b-0a3a-e7d5-28de-cc9fc9210ce5@leemhuis.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 12 Jun 2023 17:10:06 +0200
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> escreveu:

> On 05.06.23 20:00, Mauro Carvalho Chehab wrote:
> > Em Mon, 5 Jun 2023 12:44:43 +0200
> > Thorsten Leemhuis <regressions@leemhuis.info> escreveu:  
> >> On 05.06.23 12:37, Mauro Carvalho Chehab wrote:  
> >>> Em Mon, 5 Jun 2023 11:38:49 +0200
> >>> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> escreveu:  
> >>>>
> >>>> On 30.05.23 13:12, Thomas Voegtle wrote:    
> >>>>>
> >>>>> I have the problem that sometimes my DVB card does not initialize
> >>>>> properly booting Linux 6.4-rc4.
> >>>>> This is not always, maybe in 3 out of 4 attempts.
> >>>>> When this happens somehow you don't see anything special in dmesg, but
> >>>>> the card just doesn't work.
> >>>>>
> >>>>> Reverting this helps:
> >>>>> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f  
> >>>>[...]
> >>>> Mauro: I wonder if this is something you or someone else has to look
> >>>> into, as Hyunwoo Kim posted a few times per months to Linux lists, but
> >>>> according  to a quick search on lore hasn't posted anything since ~two
> >>>> months now. :-/    
> >>>
> >>> Yeah, I was slow applying this one, as I was afraid of it to cause
> >>> troubles. The DVB frontend state machine is complex, and uses a
> >>> semaphore to update its state. There was some past attempts of
> >>> addressing some lifetime issues there that we ended needing to revert
> >>> or not being applied, as the fix caused more harm than good.
> >>> [...]    
> >>
> >> Thx for the update. That's unfortunate, but how it is sometimes. Which
> >> leads to a follow-up question: is reverting the culprit temporarily an
> >> option? Or did those old use-after-free problems became known to be a
> >> problem we can't live with anymore for another few months?  
> > 
> > Reverting the patch seems to be the way to proceed. Then, work on another
> > way to address UAF. 
> > 
> > I'm not aware of dvb users complaining about troubles due to UAF, although 
> > it seems that there's now a CVE for it. So, maybe someone complained against
> > a distro Kernel, which caused the CVE to be opened.
> > 
> > So, while it is nice to have the lifetime issues fixed, last time I checked,
> > the USB dvb-usb/dvb-usb-v2 have some logic that usually prevents it to cause 
> > real issues during device removal, and unbinding DVB PCIe devices is 
> > something that users don't do in practice.  
> 
> Thx for the explanation and handling this. I noticed you posted a
> revert, but it misses a fixes tag for the reverted commit and a Link: or
> Closes: tag to the report. 

I added a Fixed and a link (see patch enclosed).

If everything merges fine on linux-next, I should be sending a PR
upstream likely tomorrow.

Regards,
Mauro

[PATCH] Revert "media: dvb-core: Fix use-after-free on race condition at dvb_frontend"

As reported by Thomas Voegtle <tv@lio96.de>, sometimes a DVB card does
not initialize properly booting Linux 6.4-rc4. This is not always, maybe
in 3 out of 4 attempts.

After double-checking, the root cause seems to be related to the
UAF fix, which is causing a race issue:

[   26.332149] tda10071 7-0005: found a 'NXP TDA10071' in cold state, will try to load a firmware
[   26.340779] tda10071 7-0005: downloading firmware from file 'dvb-fe-tda10071.fw'
[  989.277402] INFO: task vdr:743 blocked for more than 491 seconds.
[  989.283504]       Not tainted 6.4.0-rc5-i5 #249
[  989.288036] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  989.295860] task:vdr             state:D stack:0     pid:743   ppid:711    flags:0x00004002
[  989.295865] Call Trace:
[  989.295867]  <TASK>
[  989.295869]  __schedule+0x2ea/0x12d0
[  989.295877]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[  989.295881]  schedule+0x57/0xc0
[  989.295884]  schedule_preempt_disabled+0xc/0x20
[  989.295887]  __mutex_lock.isra.16+0x237/0x480
[  989.295891]  ? dvb_get_property.isra.10+0x1bc/0xa50
[  989.295898]  ? dvb_frontend_stop+0x36/0x180
[  989.338777]  dvb_frontend_stop+0x36/0x180
[  989.338781]  dvb_frontend_open+0x2f1/0x470
[  989.338784]  dvb_device_open+0x81/0xf0
[  989.338804]  ? exact_lock+0x20/0x20
[  989.338808]  chrdev_open+0x7f/0x1c0
[  989.338811]  ? generic_permission+0x1a2/0x230
[  989.338813]  ? link_path_walk.part.63+0x340/0x380
[  989.338815]  ? exact_lock+0x20/0x20
[  989.338817]  do_dentry_open+0x18e/0x450
[  989.374030]  path_openat+0xca5/0xe00
[  989.374031]  ? terminate_walk+0xec/0x100
[  989.374034]  ? path_lookupat+0x93/0x140
[  989.374036]  do_filp_open+0xc0/0x140
[  989.374038]  ? __call_rcu_common.constprop.91+0x92/0x240
[  989.374041]  ? __check_object_size+0x147/0x260
[  989.374043]  ? __check_object_size+0x147/0x260
[  989.374045]  ? alloc_fd+0xbb/0x180
[  989.374048]  ? do_sys_openat2+0x243/0x310
[  989.374050]  do_sys_openat2+0x243/0x310
[  989.374052]  do_sys_open+0x52/0x80
[  989.374055]  do_syscall_64+0x5b/0x80
[  989.421335]  ? __task_pid_nr_ns+0x92/0xa0
[  989.421337]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421339]  ? do_syscall_64+0x67/0x80
[  989.421341]  ? syscall_exit_to_user_mode+0x20/0x40
[  989.421343]  ? do_syscall_64+0x67/0x80
[  989.421345]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  989.421348] RIP: 0033:0x7fe895d067e3
[  989.421349] RSP: 002b:00007fff933c2ba0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  989.421351] RAX: ffffffffffffffda RBX: 00007fff933c2c10 RCX: 00007fe895d067e3
[  989.421352] RDX: 0000000000000802 RSI: 00005594acdce160 RDI: 00000000ffffff9c
[  989.421353] RBP: 0000000000000802 R08: 0000000000000000 R09: 0000000000000000
[  989.421353] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
[  989.421354] R13: 00007fff933c2ca0 R14: 00000000ffffffff R15: 00007fff933c2c90
[  989.421355]  </TASK>

This reverts commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f.

Fixes: 6769a0b7ee0c ("media: dvb-core: Fix use-after-free on race condition at dvb_frontend")
Link: https://lore.kernel.org/all/da5382ad-09d6-20ac-0d53-611594b30861@lio96.de/
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index bc6950a5740f..9293b058ab99 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -817,26 +817,15 @@ static void dvb_frontend_stop(struct dvb_frontend *fe)
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
-	mutex_lock(&fe->remove_mutex);
-
 	if (fe->exit != DVB_FE_DEVICE_REMOVED)
 		fe->exit = DVB_FE_NORMAL_EXIT;
 	mb();
 
-	if (!fepriv->thread) {
-		mutex_unlock(&fe->remove_mutex);
+	if (!fepriv->thread)
 		return;
-	}
 
 	kthread_stop(fepriv->thread);
 
-	mutex_unlock(&fe->remove_mutex);
-
-	if (fepriv->dvbdev->users < -1) {
-		wait_event(fepriv->dvbdev->wait_queue,
-			   fepriv->dvbdev->users == -1);
-	}
-
 	sema_init(&fepriv->sem, 1);
 	fepriv->state = FESTATE_IDLE;
 
@@ -2780,13 +2769,9 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_adapter *adapter = fe->dvb;
 	int ret;
 
-	mutex_lock(&fe->remove_mutex);
-
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
-	if (fe->exit == DVB_FE_DEVICE_REMOVED) {
-		ret = -ENODEV;
-		goto err_remove_mutex;
-	}
+	if (fe->exit == DVB_FE_DEVICE_REMOVED)
+		return -ENODEV;
 
 	if (adapter->mfe_shared == 2) {
 		mutex_lock(&adapter->mfe_lock);
@@ -2794,8 +2779,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			if (adapter->mfe_dvbdev &&
 			    !adapter->mfe_dvbdev->writers) {
 				mutex_unlock(&adapter->mfe_lock);
-				ret = -EBUSY;
-				goto err_remove_mutex;
+				return -EBUSY;
 			}
 			adapter->mfe_dvbdev = dvbdev;
 		}
@@ -2818,10 +2802,8 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 			while (mferetry-- && (mfedev->users != -1 ||
 					      mfepriv->thread)) {
 				if (msleep_interruptible(500)) {
-					if (signal_pending(current)) {
-						ret = -EINTR;
-						goto err_remove_mutex;
-					}
+					if (signal_pending(current))
+						return -EINTR;
 				}
 			}
 
@@ -2833,8 +2815,7 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				if (mfedev->users != -1 ||
 				    mfepriv->thread) {
 					mutex_unlock(&adapter->mfe_lock);
-					ret = -EBUSY;
-					goto err_remove_mutex;
+					return -EBUSY;
 				}
 				adapter->mfe_dvbdev = dvbdev;
 			}
@@ -2893,8 +2874,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
-
-	mutex_unlock(&fe->remove_mutex);
 	return ret;
 
 err3:
@@ -2916,9 +2895,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 err0:
 	if (adapter->mfe_shared)
 		mutex_unlock(&adapter->mfe_lock);
-
-err_remove_mutex:
-	mutex_unlock(&fe->remove_mutex);
 	return ret;
 }
 
@@ -2929,8 +2905,6 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	int ret;
 
-	mutex_lock(&fe->remove_mutex);
-
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
@@ -2952,18 +2926,10 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
 #endif
+		if (fe->exit != DVB_FE_NO_EXIT)
+			wake_up(&dvbdev->wait_queue);
 		if (fe->ops.ts_bus_ctrl)
 			fe->ops.ts_bus_ctrl(fe, 0);
-
-		if (fe->exit != DVB_FE_NO_EXIT) {
-			mutex_unlock(&fe->remove_mutex);
-			wake_up(&dvbdev->wait_queue);
-		} else {
-			mutex_unlock(&fe->remove_mutex);
-		}
-
-	} else {
-		mutex_unlock(&fe->remove_mutex);
 	}
 
 	dvb_frontend_put(fe);
@@ -3064,7 +3030,6 @@ int dvb_register_frontend(struct dvb_adapter *dvb,
 	fepriv = fe->frontend_priv;
 
 	kref_init(&fe->refcount);
-	mutex_init(&fe->remove_mutex);
 
 	/*
 	 * After initialization, there need to be two references: one
diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
index 367d5381217b..e7c44870f20d 100644
--- a/include/media/dvb_frontend.h
+++ b/include/media/dvb_frontend.h
@@ -686,10 +686,7 @@ struct dtv_frontend_properties {
  * @id:			Frontend ID
  * @exit:		Used to inform the DVB core that the frontend
  *			thread should exit (usually, means that the hardware
- *			got disconnected).
- * @remove_mutex:	mutex that avoids a race condition between a callback
- *			called when the hardware is disconnected and the
- *			file_operations of dvb_frontend.
+ *			got disconnected.
  */
 
 struct dvb_frontend {
@@ -707,7 +704,6 @@ struct dvb_frontend {
 	int (*callback)(void *adapter_priv, int component, int cmd, int arg);
 	int id;
 	unsigned int exit;
-	struct mutex remove_mutex;
 };
 
 /**




