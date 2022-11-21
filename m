Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0163253E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiKUONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKUOM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24DD10E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669039803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPJ5E7l4jJrNWCryX/q/ZcjaW73VrvghRDDiwoLs83Q=;
        b=Wrn/crxOUQMNJgTTLfbsY69QJciCZ17+sWqf9yO2tkuJ5TvX+zUP711Dov9E/QXoxUfFv7
        EHLh+tc37YRrmTizNZizHh8vTR8gNUt7Zu3bbLen+IC7+4B0c5Pna3sxufkakO63HfGcl3
        wVQg1PScVuy7oMfIQWudbshsgUji3eA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-7Jyxb0-nMIK7VOQ1mJhcyQ-1; Mon, 21 Nov 2022 09:09:55 -0500
X-MC-Unique: 7Jyxb0-nMIK7VOQ1mJhcyQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 486EE2A2AD7C;
        Mon, 21 Nov 2022 14:09:55 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.195.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B2D6492B06;
        Mon, 21 Nov 2022 14:09:53 +0000 (UTC)
Date:   Mon, 21 Nov 2022 15:09:48 +0100
From:   Philipp Rudo <prudo@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
Message-ID: <20221121150948.6f7c1f1f@rotkaeppchen>
In-Reply-To: <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
        <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
        <20221117160650.16e06b37@rotkaeppchen>
        <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, 17 Nov 2022 16:15:07 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Hi Philipp
> 
> Thanks for your review!

happy to help.

> 
> On Thu, 17 Nov 2022 at 16:07, Philipp Rudo <prudo@redhat.com> wrote:
> >
> > Hi Ricardo,
> >
> > all in all I think this patch makes sense. However, there is one point
> > I don't like...
> >
> > On Mon, 14 Nov 2022 14:18:39 +0100
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > Create a new toogle that disables LINUX_REBOOT_CMD_KEXEC, reducing the
> > > attack surface to a system.
> > >
> > > Without this toogle, an attacker can only reboot into a different kernel
> > > if they can create a panic().
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> > > index 97394bd9d065..25d019682d33 100644
> > > --- a/Documentation/admin-guide/sysctl/kernel.rst
> > > +++ b/Documentation/admin-guide/sysctl/kernel.rst
> > > @@ -462,6 +462,17 @@ altered.
> > >  Generally used together with the `modules_disabled`_ sysctl.
> > >
> > >
> > > +kexec_reboot_disabled
> > > +=====================
> > > +
> > > +A toggle indicating if ``LINUX_REBOOT_CMD_KEXEC`` has been disabled.
> > > +This value defaults to 0 (false: ``LINUX_REBOOT_CMD_KEXEC`` enabled),
> > > +but can be set to 1 (true: ``LINUX_REBOOT_CMD_KEXEC`` disabled).
> > > +Once true, kexec can no longer be used for reboot and the toggle
> > > +cannot be set back to false.
> > > +This toggle does not affect the use of kexec during a crash.
> > > +
> > > +
> > >  kptr_restrict
> > >  =============
> > >
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 41a686996aaa..15c3fad8918b 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -407,6 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> > >  extern struct kimage *kexec_image;
> > >  extern struct kimage *kexec_crash_image;
> > >  extern int kexec_load_disabled;
> > > +extern int kexec_reboot_disabled;
> > >
> > >  #ifndef kexec_flush_icache_page
> > >  #define kexec_flush_icache_page(page)
> > > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > > index cb8e6e6f983c..43063f803d81 100644
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -196,6 +196,10 @@ static inline int kexec_load_check(unsigned long nr_segments,
> > >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > >               return -EPERM;
> > >
> > > +     /* Check if the system admin has disabled kexec reboot. */
> > > +     if (!(flags & KEXEC_ON_CRASH) && kexec_reboot_disabled)
> > > +             return -EPERM;  
> >
> > ... Allowing to load a crashkernel doesn't make sense in my opinion. If
> > an attacker is capable of creating a malicious kernel, planting it on
> > the victims system and then find a way to boot it via kexec this
> > attacker also knows how to load the malicious kernel as crashkernel and
> > trigger a panic. So you haven't really gained anything. That's why I
> > would simply drop this hunk (and the corresponding one from
> > kexec_file_load) and let users who worry about this use a combination of
> > kexec_load_disabled and kexec_reboot_disabled.  
> 
> If for whatever reason your sysadmin configured kexec_reboot_disabed
> it can be nice that when a user try to load it they get a warning.
> It is easier to debug than waiting two steps later when they run kexec -e....

I'm having second thoughts about this patch. My main problem is that I
don't see a real use case where kexec_reboot_disabled is advantageous
over kexec_load_disabled. The point is that disabling
LINUX_REBOOT_CMD_KEXEC is almost identical to toggling kexec_load_disabled without
a loaded kernel (when you don't have a kernel loaded you cannot reboot
into it). With this the main use case of kexec_reboot_disabled is
already covered by kexec_load_disabled.

However, there are two differences

1) with kexec_reboot_disable you can still (re-)load a crash kernel
e.g. to update the initramfs after a config change. But as discussed in
my first mail this comes on the cost that an attacker could still load a
malicious crash kernel and then 'panic into it'.
 
2) kexec_load_disabled also prevents unloading of a loaded kernel. So
once loaded kexec_load_disabled cannot prevent the reboot into this
kernel.


For 1) I doubt that this is desired at all. My expectation is that on
systems where a sysadmin restricts a user to reboot via kexec the
sysadmin also wants to prevent the user to load an arbitrary crash
kernel. Especially as this still keeps the loophole open you are trying
to close.

So only 2) is left as real benefit. But that is an extremely specific
scenario. How often does this scenario happen in real life? What
problem does kexec_reboot_disable solve different implementation
(also in userspace) cannot?

Sorry about being this pedantic but you want to introduce some new uapi
which will be hard if not impossible to change once introduced. That's
why I want to be a 100% sure it is really needed.

Thanks
Philipp


> That is why I added it. But i am also ok removing it
> 
> >
> > Thanks
> > Philipp
> >  
> > > +
> > >       /* Permit LSMs and IMA to fail the kexec */
> > >       result = security_kernel_load_data(LOADING_KEXEC_IMAGE, false);
> > >       if (result < 0)
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index ca2743f9c634..fe82e2525705 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -929,6 +929,7 @@ int kimage_load_segment(struct kimage *image,
> > >  struct kimage *kexec_image;
> > >  struct kimage *kexec_crash_image;
> > >  int kexec_load_disabled;
> > > +int kexec_reboot_disabled;
> > >  #ifdef CONFIG_SYSCTL
> > >  static struct ctl_table kexec_core_sysctls[] = {
> > >       {
> > > @@ -941,6 +942,16 @@ static struct ctl_table kexec_core_sysctls[] = {
> > >               .extra1         = SYSCTL_ONE,
> > >               .extra2         = SYSCTL_ONE,
> > >       },
> > > +     {
> > > +             .procname       = "kexec_reboot_disabled",
> > > +             .data           = &kexec_reboot_disabled,
> > > +             .maxlen         = sizeof(int),
> > > +             .mode           = 0644,
> > > +             /* only handle a transition from default "0" to "1" */
> > > +             .proc_handler   = proc_dointvec_minmax,
> > > +             .extra1         = SYSCTL_ONE,
> > > +             .extra2         = SYSCTL_ONE,
> > > +     },
> > >       { }
> > >  };
> > >
> > > @@ -1138,7 +1149,7 @@ int kernel_kexec(void)
> > >
> > >       if (!kexec_trylock())
> > >               return -EBUSY;
> > > -     if (!kexec_image) {
> > > +     if (!kexec_image || kexec_reboot_disabled) {
> > >               error = -EINVAL;
> > >               goto Unlock;
> > >       }
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 45637511e0de..583fba6de5cb 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -333,6 +333,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >       if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > >               return -EPERM;
> > >
> > > +     /* Check if the system admin has disabled kexec reboot. */
> > > +     if (!(flags & (KEXEC_FILE_ON_CRASH | KEXEC_FILE_UNLOAD))
> > > +         && kexec_reboot_disabled)
> > > +             return -EPERM;
> > > +
> > >       /* Make sure we have a legal set of flags */
> > >       if (flags != (flags & KEXEC_FILE_FLAGS))
> > >               return -EINVAL;
> > >  
> >  
> 
> 

