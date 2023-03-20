Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAFD6C0AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCTGh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCTGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:37:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC1126D3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:37:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eg48so42342410edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679294269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=043cJL8M7bmhja0804XphdavMgq23OL+4hcE4H+oIJA=;
        b=RlpKESwHE3eu8MkwEeNa/I+o0GrPq17cPNTpkDCW8pO25wB5GkuFfZguuIuqqu7W+2
         gp/ya3dM8CTaO/o9Xw1ivg63pEaKV8kKGrmU/eQ9uHblr9TWOJn3urlWsHpxQu9dB/W+
         Fl03xdyYZRQgBMNs8xThVa7P1sa79uwKd5BycLm8l7w+Rk2sAKG2G4kg4i9OfzruFkYh
         MLFdqO5RQfMlDEgi2jvFDE253red7ydcAbZ9RBfyynPDUpkUINUQ6qBgwidycel0n9Bp
         cdX3QLrBg/b/dvkigQPd4C7uTvypshpvS1Jc86//QDSNyf6qJjac+HTjKPtuTm9quAFj
         bOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679294269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=043cJL8M7bmhja0804XphdavMgq23OL+4hcE4H+oIJA=;
        b=LFdxgvR8xcaMcFDOv5VVq1Pj6KSam34rKd9YlfDj3moBqbpSrIM6a3ZbaKQVTTdrS5
         iGjQFAnrsf5oIgLIrYwXZOrHVj8EqUlrzVFfW+Fb9OYW74+BGEC9xUjGz7aVXHbP/7x1
         tTfmuHrLIfMIQ2JmueJTYhaeR8dMnDgihzh1TTGHlpzXkwAHVsU54RaHgVqyatzesCnT
         s8H4PcvAmRT/sa51EkdGnyQRvvaEWJf82XujOh2x8nfzaI1pi7ZYel9VtJGjLbq436hK
         ppSVIJ5F/u5bvA5iKicTQjaxmClpbFYp4lyKNJnX9o5i7WApvnxKgkPnx+KujYzWcMBs
         ln5w==
X-Gm-Message-State: AO0yUKXTqioDAwARDyzwZUjIDkEXqjiSvk/MwjaqjOe6SxEjV0/qsqNr
        bBlDR/xFLrONLqKbQ7GoDsTIaKNJg2RzPzFX
X-Google-Smtp-Source: AK7set87I0UPLQeLtuvVamN9YVClfZk/eJRdtJC6LAJX7LFhk7VmTloSaJI8JdCbscvOSwQf7usdvg==
X-Received: by 2002:aa7:c650:0:b0:4fd:14d5:bb47 with SMTP id z16-20020aa7c650000000b004fd14d5bb47mr9992523edr.38.1679294269298;
        Sun, 19 Mar 2023 23:37:49 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id f23-20020a1709064dd700b00931536d461fsm3983267ejw.20.2023.03.19.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:37:48 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:37:46 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBf/OuuUUeharrXp@khadija-virtual-machine>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
 <2162728.C4sosBPzcN@suse>
 <ZBNhXc3sVVLdibUF@khadija-virtual-machine>
 <2599595.k3LOHGUjKi@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2599595.k3LOHGUjKi@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:07:09PM +0100, Fabio M. De Francesco wrote:
> On giovedì 16 marzo 2023 19:35:09 CET Khadija Kamran wrote:
> > On Thu, Mar 16, 2023 at 05:17:47PM +0100, Fabio M. De Francesco wrote:
> > > On giovedì 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:
> 
> [snip]
> 
> > Hey Fabio!
> > 
> > Hope you are doing well. After  spending a lot of time on this I am
> > stuck now. Kindly help me resolve this issue or understand it better.
> > 
> > Following your instructions I deleted my config file and copied one from
> > the /boot/ directory. After that I enabled the dependencies(CONFIG_OF=y
> > and CONFIG_HAS_IOMEM=y). I was successfully able to enable axis-fifo as
> > a module.
> > 
> > I then ran the following commands:
> >  - make drivers/staging/axis-fifo/
> 
> No, this is not the right command... you are not invoking the linker to make 
> the .ko object.
> 
> Use "make M=drivers/staging/axis-fifo/"
> or "make M=drivers/staging/axis-fifo/ W=1 -j8" (the latter to enable level '1' 
> warning and run on your 2 * 4 logical cores).
> 
> >  - sudo make modules_install install(this command took hours) :'(
> 
> This is odd, it shouldn't :-/
> 
> As I said in another message, I'll set aside some time to help you check if 
> you need to fine tune your VM and Hypervisor configuration. 
> 
> I'm returning on the same subject we have been talked about because you said 
> at least twice that your builds and install are too slow. We'll try to 
> diagnose it in an IRC session on #kernel-outreachy (I'm pretty sure for the 
> first days of next week - I'll send an invite).
> 
> > > When you are done with build, install, and final reboot to test if your
> > > module can "modprobe" or "insmod" (i.e. link with the running custom 
> kernel
> > > you built, installed and boot), try to compare the output of the following
> > > commands:
> > > 
> > > # uname -a
> > > Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 UTC
> > > 2023 (44ca817) x86_64 x86_64 x86_64 GNU/Linux
> > 
> > The above command works
> > 
> > > AND
> > > 
> > > # modinfo <name of the module you are testing here>
> > 
> > On running 'modinfo axis-fifo' I get error saying module axis-fifo not
> > found.
> 
> Try again after building with "M=drivers/staging" (as said above). Don't 
> forget to run "make modules_install install" and then reboot into your custom 
> built Kernel, not the distribution's kernel.
> 
> While you are there, run "lsmod" to see all loaded modules. Pick one randomly 
> from the output list and run "modinfo name_of_the_module_you_want_info_about".
>  
> > > I'm running "modinfo kvm" (but showing only two of many lines):
> > > 
> > > # modinfo kvm
> > > filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/
> kvm.ko.zst
> > > vermagic:       6.2.2-1-default SMP preempt mod_unload modversions
> > > 
> > > Can you see that the kernel in "uname -a" and the filename and vermagic 
> have
> > > the same "6.2.2-1-default"? Well, so I'm sure I'm running the right Kernel
> > > and inserted the appropriate "kvm" module.
> > > 
> > > Furthermore, before rebooting your custom kernel, you may also look at the
> > > directory in the Kernel where you compiled your module and search for 
> "*.o"
> > > "*mod*" and "*.ko" files. If you have them, you built your module 
> properly.
> > 
> > There is a "*.o" file and "*.mod" file but there is no "*.ko" file in
> > the axis-fifo directory.
> > 
> > Kindly help me with this.
> > 
> > Regards,
> > Khadija
> > 
> > > Thanks,
> > > 
> > > Fabio
> 
> Let me know if this time it works.
> 
> Fabio
> 
> P.S.: Have you had time to read that "Linux Kernel Module Programming" guide I 
> sent you the link of? You can find a lot of information about modules there. 
> I'd strongly recommend you to read it. 
>

Fabio,

I have not read it yet. But it is in my mind and as soon as I get some
free time I will start reading it :)

Thank you!

> 
