Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F946095D0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiJWTYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:24:38 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AE71261E;
        Sun, 23 Oct 2022 12:24:35 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 29NJOFdc022332;
        Mon, 24 Oct 2022 04:24:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29NJOFdc022332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1666553056;
        bh=yAkzJfVFHOs64i0qA/NVMw3FlQylbkz13p0kK5P+1/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T/OxKpA5hrxX5KCPNv2UaYW8syXbQmfHCNVekRnkCZMtIvUK00bfxYl7hFGcF/bJn
         pMZysOBcHs4Dg4h8+CrR6ojb3+KhdG4EFRBhLyBOnOZh3lIZw819ja7FpCRM4LgCoD
         rJzCOthZgPzl78hvUDkoDJZEA1XaLXxhbgCZQKimq0oHwU4qIb6woSwfvcoAP2jOwu
         g2xoh6F4QNpFCB3InH6N8A/oMPkHsrfeNebnRzF42kLCALD8uZBwZcQIpW7k+kkW/w
         C5BlVdsYBk6sTyv+0LkQizaUeiFH++Ef6XKmKI1BI9feDiL67BFBart/527i+DqJlz
         PkMkkh724Qvag==
X-Nifty-SrcIP: [209.85.210.42]
Received: by mail-ot1-f42.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso4855448otb.6;
        Sun, 23 Oct 2022 12:24:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf3d4gawx82XZqDTgBiIBpOacOORtXeHXQy5FS7tlVYRa6dsU2zY
        iktZhKzoTu3XtGn3ZgOA1N1Atj2cWDmogGPe/5Y=
X-Google-Smtp-Source: AMsMyM7e46OF7JYHyjNWe11i4Yk4e9IZvfkHPe7CeJPj6isPSCJCGBQWL200mgRCJnoCplWSUOgiSiHLHdTTiFl3UKI=
X-Received: by 2002:a05:6830:6384:b0:661:bee5:73ce with SMTP id
 ch4-20020a056830638400b00661bee573cemr15103086otb.343.1666553055213; Sun, 23
 Oct 2022 12:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <33059074b78110d4717efe09b887dd28ac77fe7f.camel@pengutronix.de> <ba6223f9fcae7d27de439e75f93b3a1352a30890.camel@pengutronix.de>
In-Reply-To: <ba6223f9fcae7d27de439e75f93b3a1352a30890.camel@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 24 Oct 2022 04:23:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAThoCP3FWidnMt0h5y16VrNKKBum2NP3a=RgmaAAAdQGQ@mail.gmail.com>
Message-ID: <CAK7LNAThoCP3FWidnMt0h5y16VrNKKBum2NP3a=RgmaAAAdQGQ@mail.gmail.com>
Subject: Re: PROBLEM: Segfault in kconfig
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,


Sorry for the delay.

I took a closer look at this.


I submitted a patch, which I think is a more correct fix.

https://patchwork.kernel.org/project/linux-kbuild/patch/20221023191055.85098-1-masahiroy@kernel.org/



Thanks.


On Thu, Oct 6, 2022 at 10:15 PM Johannes Zink <j.zink@pengutronix.de> wrote:
>
> Hi everyone,
>
> On Thu, 2022-09-22 at 18:01 +0200, Johannes Zink wrote:
> > Hi everyone,
> >
> > [1.] One line summary of the problem:
> >      kconfig crashes with segfault under rare circumstances
> > [2.] Full description of the problem/report:
> >      Under certain circumstances jump keys are displayed on the
> > search
> >      results even if a symbol is deactivated by one of its
> >      dependencies. Using the jump keys then triggers a segmentation
> >      fault due to a NULL dereference. Perform the following steps to
> >      trigger the issue
> >
> >      1.: ARCH=arm64 make defconfig
> >      2.: ARCH=arm64 make menuconfig
> >
> >      3.: press '/' key to search for the string "EFI". Use jump key
> >          (1) to jump to search result. Press 'n' key to deactivate
> > the
> >          entry.
> >      4.: press '/' to seach for the string "ACPI". Use the jump key
> >          (1) to jump to the search result.
> >
> >      Menuconfig then crashes with a segfault.
> >
> > [3.] Keywords (i.e., modules, networking, kernel):
> >      kconfig, mconf
> > [4.] Kernel information
> > [4.1.] Kernel version (from /proc/version):
> >        v6.0.0-rc6
> > [4.2.] Kernel .config file:
> >        arm64 default defconfig
> > [5.] Most recent kernel version which did not have the bug:
> >      v5.15
> > [6.] Output of Oops.. message (if applicable) with symbolic
> > information
> >      resolved (see Documentation/admin-guide/bug-hunting.rst):
> >      not applicable
> > [7.] A small shell script or example program which triggers the
> >      problem (if possible):
> >      not applicable, please see description in [2.]
> > [8.] Environment
> > [8.1.] Software (add the output of the ver_linux script here):
> >        not applicable
> > [8.2.] Processor information (from /proc/cpuinfo):
> >        not applicable
> > [8.3.] Module information (from /proc/modules):
> >        not applicable
> > [8.4.] Loaded driver and hardware information (/proc/ioports,
> > /proc/iomem):
> >        not applicable
> > [8.5.] PCI information ('lspci -vvv' as root):
> >        not applicable
> > [8.6.] SCSI information (from /proc/scsi/scsi):
> >        not applicable
> > [8.7.] Other information that might be relevant to the problem
> >        (please look in /proc and include all information that you
> >        think to be relevant):
> >        not applicable
> > [X.] Other notes, patches, fixes, workarounds:
> >
> >      I found that the attached patch is a very hacky workaround to
> >      keep menuconfig from crashing, but I am pretty sure the jump
> >      keys should not have be activated for unaccessable entries in
> > the
> >      first place. I found it quite hard to find the corresponding
> > part
> >      in mconf, which is why I decided to send this bugreport instead
> >      of sending a patch. Maybe someone on this list either knows
> > mconf
> >      really well and can just fix it, or guide me to where I can dig
> >      around (though in that case I could really use some help on how
> >      to debug menuconfig, since I found it challenging to get it
> >      working with gdb)
> >
> > Best regards
> > Johannes
> >
> > ---
> > scripts/kconfig/mconf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> > index 9d3cf510562f..60a82f701bd3 100644
> > --- a/scripts/kconfig/mconf.c
> > +++ b/scripts/kconfig/mconf.c
> > @@ -447,7 +447,8 @@ static void search_conf(void)
> >                 again = false;
> >                 for (i = 0; i < JUMP_NB && keys[i]; i++)
> >                         if (dres == keys[i]) {
> > -                               conf(targets[i]->parent, targets[i]);
> > +                               if (targets[i]->parent)
> > +                                       conf(targets[i]->parent,
> > targets[i]);
> >                                 again = true;
> >                         }
> >                 str_free(&res);
> >
>
> Just a gentle ping and TL;DR on this issue:
>
> Menuconfig crashes with a segfault if performing the steps
>
> 1.: ARCH=arm64 make defconfig
> 2.: ARCH=arm64 make menuconfig
> 3.: press '/' key to search for the string "EFI". Use jump key
>     (1) to jump to search result. Press 'n' key to deactivate
>     the entry.
> 4.: press '/' to seach for the string "ACPI". Use the jump key
>     (1) to jump to the search result.
>
> For more details please see the detailed report in the original
> message.
>
> Has anyone any input on this?
>
> Best regards
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
>


-- 
Best Regards
Masahiro Yamada
