Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684C870771A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERA4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjERA4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:56:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57031F9;
        Wed, 17 May 2023 17:56:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso1821920e87.0;
        Wed, 17 May 2023 17:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684371406; x=1686963406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYAbLlj9K3DHlnQr4F5J3fhYMxtcKiAU3j+LJPZgTsc=;
        b=HjnRBOmBniA5ZroFiH7G5ei82jsFBH8zuXNukbcW3ykgw5HCBtWFvs05a/wBoDaQ9C
         jSIPI9xuK49Nz8JNbZMWTKU2HyZxpP80ianyObRISb8Cb2Vm6V7u0+oUw6WzNFFW1kRU
         Udsvcu/mQVD48FkUMLHqAbsynYDPHRTb3k8vFlaJ38gd1GH/QvYpeI94YnFXvp0gUK40
         AEgwGlLY098gkuLReCxo9k6AzU445WrhZ6KpzA76T6+DzntDgDjpuQA5e0PQfXVH9xPW
         J+UlhrBJUVMR/ivzesVq5viG92tTMC2gaAPQ1a48xPHgVgYfF4OI8r0rsMlgZ2mqdi9p
         34uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684371406; x=1686963406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYAbLlj9K3DHlnQr4F5J3fhYMxtcKiAU3j+LJPZgTsc=;
        b=MGfjDRejrQJek90+dmBbr5HVWMDq13ch7n+JBw79+sYVLJDQBk+uBGgorOcklhn8hc
         AE0BZLMA9NNG9KvqLnXRVEVMHHuOnYKEDUmRZDCguBIla1jL+iE1TPwr0ZBZhmE6CaDw
         t49Ou3BnttT5KOT2j+xn3n90iBaN3o+VwLuupuFy1Wfrqfw1eRbliZ2dPQa1PNL0Qck0
         HMadiJXXZD+hh3gDrRrDlGCIsGjo5ms+2ihbZmRwdm9NWu3BoNVzduhmEyuT+jfBD8Kz
         +VHdkg836quE/8VUSFfOkJulWh5dr/rj1LxnUAYyQ87UtKCqq5Ja9o0KcEhontZJiLse
         ktNA==
X-Gm-Message-State: AC+VfDwz+UhOsZVoXgUYK/G9OQboj7H5/j0GIv12IZDmzMeQ2rbYJlYS
        uL7xf95ihJwlaCcQx39jy8yEsvqI1hH1udLvgIo=
X-Google-Smtp-Source: ACHHUZ6AclExJ4QITzvbvQkT4xYvBg/dOVirxtBe/EOeFTUpReY/OGf1jnxLWp+LyiwIpJhe9wLuAaiKk2HU45CoM9g=
X-Received: by 2002:ac2:558c:0:b0:4d1:3d1d:4914 with SMTP id
 v12-20020ac2558c000000b004d13d1d4914mr843380lfg.33.1684371406052; Wed, 17 May
 2023 17:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local> <20230516212658.2f5cc2c6@gandalf.local.home>
 <20230517165028.GA71@W11-BEAU-MD.localdomain> <CAADnVQK3-NBLSVRVsgArUEjqsuY2S_8mWsWmLEAtTzo+U49CKQ@mail.gmail.com>
 <20230518001916.GB254@W11-BEAU-MD.localdomain>
In-Reply-To: <20230518001916.GB254@W11-BEAU-MD.localdomain>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 May 2023 17:56:34 -0700
Message-ID: <CAADnVQJwK3p1QyYEvAn9B86M4nkX69kuUvx2W0Yqwy0e=RSPPg@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Thaler <dthaler@microsoft.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 5:19=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> On Wed, May 17, 2023 at 05:10:47PM -0700, Alexei Starovoitov wrote:
> > On Wed, May 17, 2023 at 9:50=E2=80=AFAM Beau Belgrave <beaub@linux.micr=
osoft.com> wrote:
> > > >
> > > > >
> > > > > Looks like user events were designed with intention to be unprivi=
leged.
> > > > > When I looked at kernel/trace/trace_events_user.c I assumed root.
> > > > > I doubt other people reviewed it from security perspective.
> > > > >
> > > > > Recommending "chmod a+rw /sys/kernel/tracing/user_events_data" do=
esn't sound like a good idea.
> > > > >
> > > > > For example, I think the following is possible:
> > > > > fd =3D open("/sys/kernel/tracing/user_events_data")
> > > > > ioclt(fd, DIAG_IOCSDEL)
> > > > >   user_events_ioctl_del
> > > > >      delete_user_event(info->group, name);
> > > > >
> > > > > 'info' is different for every FD, but info->group is the same for=
 all users/processes/fds,
> > > > > because only one global init_group is created.
> > > > > So one user can unregister other user event by knowing 'name'.
> > > > > A security hole, no?
> >
> > ...
> >
> > > Regarding deleting events, only users that are given access can delet=
e
> > > events. They must know the event name, just like users with access to
> > > delete files must know a path (and have access to it). Since the
> > > write_index and other details are per-process, unless the user has
> > > access to either /sys/kernel/tracing/events/user_events/* or
> > > /sys/kernel/tracing/user_events_status, they do not know which names =
are
> > > being used.
> > >
> > > If that is not enough, we could require CAP_SYSADMIN to be able to
> > > delete events even when they have access to the file. Users can also
> > > apply SELinux policies per-file to achieve further isolation, if
> > > required.
> >
> > Whether /sys/kernel/tracing/user_events_status gets g+rw
> > or it gets a+rw (as your documentation recommends)
> > it is still a security issue.
> > The "event name" is trivial to find out by looking at the source code
> > of the target process or just "string target_binary".
>
> I guess, if they have access to the binary, etc.
> So they need both access to the binary and to the tracefs directory.
> We would not give them access like this in any normal setup other than a
> developer environment.
>
> > Restricting to cap_sysadmin is not the answer, since you want unpriv.
>
> We do not need unpriv to delete events, only to write and create events.
>
> We allow unregistering call-sites, which would still work unpriv with
> this requirement.
>
> > SElinux is not the answer either.
> > Since it's unpriv, different processes should not be able to mess with
> > user events of other processes.
>
> How is this different than uprobes if we give a user access to
> /sys/kernel/tracing/dynamic_events? Users can delete those as well. I
> don't see a difference here.

Because kprobe/uprobe are root only.
No sane person will do chmod a+rw /sys/kernel/tracing/uprobe_events.
It's just like chmod a+rw /etc/passwd

Whereas this is your recommended approach for user_events.

> In our production environments we are not giving out wide security to
> this file.

Fine by me. Keep it insecure and broken. Do not send bpf patches then.
I refuse to have bpf callable from such subsystems.
Somebody will inevitably blame bpf for the insecurity of user_events.
