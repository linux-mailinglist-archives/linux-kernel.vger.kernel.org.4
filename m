Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50806C3174
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCUMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCUMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:21:26 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DAC3B86C;
        Tue, 21 Mar 2023 05:21:24 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id w20so9471006vsa.8;
        Tue, 21 Mar 2023 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679401283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX/vC5ZRlMTylXo7eynFpDNeVQOHEdv7n3GHC+f0DhU=;
        b=HIoO4a4bg2p3PcEl23Uw0EH9ABnMLD86udUJVPvQikeoAUUwzaf3Z893G1dndMamS8
         hg2xvC0xR6dlfb/JFCyICf2ybHZAvIb/p1Osxz1a8FahPXiGe9PdtxH15m64iU01cZRM
         mSZ4XvVnaljcjDhJZ1U19ldJ3Hd8lW+tBUjPmCANSJUoEmBJbc20AeatzemXIYWEViHC
         UuQGLtijF3lZIbChozoyzSrfogrOwBhILJ0XRYsqMHdqWsBoXgiI+3nILbi4kbGLSZr2
         yDUI45EmtZXalB+FNcm32GowXkZ6nUISbHa2wYSYfldvcuCZJY4IFejjSF6atNnxEewy
         DtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX/vC5ZRlMTylXo7eynFpDNeVQOHEdv7n3GHC+f0DhU=;
        b=mSVpJvoXBTR0cxmS+Zpn3XvjiUGgWY/ctVn/AYL82P8g2C1mlajLt/01bd1OrdE+XW
         BtVHmWAcJLhBRNF4fygE/SoK3t62omBmhLRgTEl55qLQ/VgIaOhLWBEIdA3KNRfyBorc
         r2l7eIhZO20WhX8kULnyiWyoataDfLBCitPX9z7fKFzUZ/mlN5L9OjSrYiTnxZaGMrL0
         ZXo+wNu/d8JbvyiegQlJReDlA5sWw1/7a6628WdzOD0l34P+VEFklACyX5diK/rffJla
         /6X6yl+eQAWVnB/KoK19ts0qghtu8G0yoDFanOtF4IIEgVPolFVYM31U2qPfvmeHa3EG
         VUQQ==
X-Gm-Message-State: AO0yUKWn7lNh4N0HdPIZOy/lJAqIEYkN96nDmwbdK0P6X6yFJi0liMrP
        GG634yXclkSxuxuDtSeo1pmXq1gEncHIfdJlSQeDE2z1nPc=
X-Google-Smtp-Source: AK7set+6jWavUU7pP601xTA54dL3830yy/EdB0Hlf9ddJExK5Xk4/Azhlr/diamgbhzZ0QGJhxTx0gCgNilARqvl7tw=
X-Received: by 2002:a67:cc11:0:b0:425:d096:fd42 with SMTP id
 q17-20020a67cc11000000b00425d096fd42mr1340294vsl.5.1679401283321; Tue, 21 Mar
 2023 05:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
 <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com> <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
 <CAK7LNATGL4oBPO6s27Zp15-TvD=y4BuqD24YHzLMJxcbk_Ff3w@mail.gmail.com>
In-Reply-To: <CAK7LNATGL4oBPO6s27Zp15-TvD=y4BuqD24YHzLMJxcbk_Ff3w@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Tue, 21 Mar 2023 06:20:57 -0600
Message-ID: <CAJfuBxy2w8g8yML=Lzc0RxiPb_QmD09wdmihHp60GvwO2pDXvA@mail.gmail.com>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in /proc/dynamic_debug/control
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:45=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Tue, Mar 21, 2023 at 5:00=E2=80=AFAM <jim.cromie@gmail.com> wrote:
> >
> > On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Jason Baron <jbaron@akamai.com=
> wrote:
> > >
> > >
> > >
> > > On 3/20/23 1:05 AM, jim.cromie@gmail.com wrote:
> > > > dynamic-debug METADATA uses KBUILD_MODNAME as:
> > > >
> > > > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > >          static struct _ddebug  __aligned(8)                     \
> > > >          __section("__dyndbg") name =3D {                          =
\
> > > >                  .modname =3D KBUILD_MODNAME,                      =
\
> > > >
> > > > This is going amiss for some builtins, ie those enabled here, by:
> > > >
> > > >      echo module main +pmf > /proc/dynamic_debug_control
> > > >      grep =3Dpmf /proc/dynamic_debug/control
> > > >
> > > > init/main.c:1187 [main]initcall_blacklist =3Dpmf "blacklisting init=
call %s\n"
> > > > init/main.c:1226 [main]initcall_blacklisted =3Dpmf "initcall %s bla=
cklisted\n"
> > > > init/main.c:1432 [main]run_init_process =3Dpmf "  with arguments:\n=
"
> > > > init/main.c:1434 [main]run_init_process =3Dpmf "    %s\n"
> > > > init/main.c:1435 [main]run_init_process =3Dpmf "  with environment:=
\n"
> > > > init/main.c:1437 [main]run_init_process =3Dpmf "    %s\n"
> > >
> > >
> > > Hi Jim,
> > >
> > > So if I'm following correctly, this is not a new issue, the 'module'
> > > name for dynamic debug has always been this way for builtin.
> >
> > It is not a new issue - both PM and init-main have been in [main] for s=
ome time.
> >
> > I believe that with
> > cfc1d277891e module: Move all into module/
> >
> > module's module-name joined them, changing from [module] to [main]
>
> Maybe more.
>
> We have almost 100 'main.c' files.
>
> $ find . -name main.c | wc
>      97      97    3473
>

yes.  I just picked [main] as the example cuz it was the biggest
bucket of unrelateds.

there are other oddities:

"power" module ( subsystem ?) has 2 names matching/picked-by basename

drivers/base/power/main.c:467 [main]dpm_show_time =3D_ "%s%s%s of
devices %s after %ld.%03ld msecs\n"
drivers/base/power/domain.c:582 [domain]_genpd_power_on =3D_ "%s:
Power-%s latency exceeded, new value %lld ns\n"

"power" also has 4 other "mod-names", all matching basename

kernel/power/suspend.c:580 [suspend]enter_state =3D_ "Preparing system
for sleep (%s)\n"
kernel/power/hibernate.c:691 [hibernate]load_image_and_restore =3D_
"Loading hibernation image.\n"
kernel/power/snapshot.c:1083 [snapshot]mark_nosave_pages =3Dp "Marking
nosave pages: [mem %#010llx-%#010llx]\n"
kernel/power/swap.c:1509 [swap]swsusp_read =3Dp "Error %d resuming\n"

others have distinct [modnames], where/how do they get set ?

drivers/base/firmware_loader/main.c:1442
[firmware_class]device_uncache_fw_images =3D_ "%s\n"
drivers/media/rc/rc-main.c:230 [rc_core]ir_create_table =3D_ "Allocated
space for %u keycode entries (%u bytes)\n"



>
>
>
>
> > We could do
> > > something simple and just normalize it when we initially create the
> > > table, but setting the 'module name' to 'core' or 'builtin' or someth=
ing
> > > for all these?
> >
> > core and builtin would both lump all those separate modules together,
> > making it less meaningful.
> >
> > having stable names independent of M vs Y config choices is imperative,=
 ISTM.
>
>
> I do not understand what you mean.
>

stable names   =3D=3D=3D    modprobe foo working whether module is builtin =
or loadable

>
> KBUILD_MODNAME is not affected by the y/m configuration.
>
>
>
>
> If an object is a member of a composite object, which
> does not necessarily be a real module, KBUILD_MODNAME
> refers to the name of the composite.
> Otherwise, the basename of the source file.
>
>
> Examples:
>
>
> obj-y +=3D alias-name.o
> alias-name-objs :=3D foo.o
>
>   -->  KBUILD_MODNAME is "alias-name"
>
>
>
> obj-y +=3D foo.o
>
>   -->  KBUILD_MODNAME is "foo"
>

taken-from-basename   correctly characterizes that.


>
>
> This is about how you write Makefile code.
> CONFIG options are unrelated.
>

in kernel/power/Makefile, there is:

     obj-$(CONFIG_HIBERNATION) +=3D hibernate.o snapshot.o swap.o

and those 3 objects each get their own [mod-name]

>
>
>
>
>
>
> > Also, I dont think "only builtins are affected" captures the whole prob=
lem.
> > I dont recall amdgpu or other modules changing when built with =3Dy
> >
> > Theres some subtlety in how KBUILD_MODNAME is set,
> > and probably many current users who like its current behavior.
> > A new var ?
> >
> > 1st, I think that anything tristate gets a sensible value,
> > but at least some of the builtin-only "modules" get basenames, by defau=
lt.
> >
> > arch/x86/events/amd/ibs.c:1398 [ibs]force_ibs_eilvt_setup =3D_ "No EILV=
T
> > entry available\n"
> > arch/x86/events/intel/pt.c:797 [pt]pt_topa_dump =3D_ "# table @%p, off
> > %llx size %zx\n"w=3D%16llx\n"
> >
> > kvm gets a solid name, because tristate ?
> >
> > arch/x86/kvm/mmu/mmu.c:6661 [kvm]kvm_mmu_invalidate_mmio_sptes =3D_
> > "kvm: kvm [%i]: zapping shadow pages for mmio generation wraparound\n"
> > arch/x86/kvm/hyperv.c:1402 [kvm]kvm_hv_set_msr_pw =3D_ "kvm [%i]: vcpu%=
i
> > hv crash (0x%llx 0x%llx 0x%llx 0x%llx 0x%llx)\n"
> >
> > kvm-intel and kvm-amd get their names elsewhere.
> >
> > arch/x86/kvm/vmx/nested.c:207 [kvm_intel]nested_vmx_abort =3D_
> > "kvm_intel: nested vmx abort, indicator %d\n"
> > arch/x86/kvm/vmx/nested.c:913 [kvm_intel]nested_vmx_load_msr =3D_
> > "kvm_intel: %s cannot read MSR entry (%u, 0x%08llx)\n"
> >
> > arch/x86/kvm/svm/avic.c:860 [kvm_amd]get_pi_vcpu_info =3D_ "SVM: %s: us=
e
> > GA mode for irq %u\n"
> > arch/x86/kvm/svm/avic.c:889 [kvm_amd]avic_pi_update_irte =3D_ "SVM: %s:
> > host_irq=3D%#x, guest_irq=3D%#x, set=3D%#x\n"
> >
> > iow, I dont know..
> >
> > >
> > > Thanks,
> > >
> > > -Jason
>
>
>
> --
> Best Regards
> Masahiro Yamada
