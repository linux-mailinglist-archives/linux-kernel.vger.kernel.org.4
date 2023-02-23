Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA76A0007
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjBWAWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjBWAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:22:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093C2069C;
        Wed, 22 Feb 2023 16:22:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l15so12069865pls.1;
        Wed, 22 Feb 2023 16:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x45zCZuNSqGWyyurqnEe1pmzRFGmEAFztUpHGM0LbL4=;
        b=XKPG3fheY0kjCmkp46x2X5Pl477+6cV3W5fH4iJeevdF4SDDhj1PaZ0xteRmwjwX9/
         OZA1SFLKvuwbglylG1cZEtCCGiGh9XxewDnzJtXi+8lLb+vVWMkfgR3kn37LqvVJJVoQ
         YkdG9pKSyEjzS3C2N/hqwiIeO97+h1GkJTGC8jXahs2tpFEob9FUDePlS7kRvkJeN3W5
         DsFUQVZA1PfasPQSQE1K3SvfaQb9nV2IHtffxh17oL2SOe5QPkCZP5Zn6OQWFXQIcBlN
         wjE1/Px2CyUcp0QX/DXTeC+1FdmBwHSy0bGI+iVe9FjQuSuHFHjTxTb/lN47zIb98iOy
         rcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x45zCZuNSqGWyyurqnEe1pmzRFGmEAFztUpHGM0LbL4=;
        b=w0lf0LNcCJDg6pzxyWnGcK2detfo45+z9QcyzuSQ7LZTKsbEeSvgGLGDMpxy7n5yJY
         8sF7azlGIpqRtcX4S3HcXzdvbZHHw0CjM08MikV8InqOZTft4OCQDLk9DIQQNB2hsPhu
         DbpJHBwd1QkRWCKewPDJle1yEi0ZX6WwyXggLzdST291ph21/1EUed2h35Cb3/6o/U2u
         rqrfW1ZJwmt4ZUMqgj6Rz209Fcq4WqjilmFgPb4meYJKjswMc+qmZ6Q7S0C/QLsoboNA
         G4Df/QoWXdRp7Wc1myNgHzQ1pUi7JWkvc5HCXjtd4TeMhcoZnkm4V2yVibDYpmJTyPVQ
         JSiw==
X-Gm-Message-State: AO0yUKU/I/CdKBbunSTHXb/qc4RFKFkIDXhcy6h2BWbVf7d0rKgBVdPg
        TohKiJ2DUO/HQ7fSf2F8mZB36IH+KdVRCUcCSnvLpv/AHAI=
X-Google-Smtp-Source: AK7set8ESYkYPiG3+7YjN5q5Bn/hq+imYfa2djZtw3cdjvYOC4T5m5N43w/rRjSR32zmMrAmJ0wO9KRPlCkoJXOeWao=
X-Received: by 2002:a17:90b:1bca:b0:234:8e4:7a5e with SMTP id
 oa10-20020a17090b1bca00b0023408e47a5emr3554603pjb.128.1677111730658; Wed, 22
 Feb 2023 16:22:10 -0800 (PST)
MIME-Version: 1.0
References: <CAMr-kF1LxzoOShd7nkE1Pc0ZZgTusB42rDep5ROPirLK9xK55g@mail.gmail.com>
 <1c1c0a3b-10d0-ef9c-e96c-a415bbe0bf33@infradead.org>
In-Reply-To: <1c1c0a3b-10d0-ef9c-e96c-a415bbe0bf33@infradead.org>
From:   Hanasaki Jiji <hanasaki@gmail.com>
Date:   Wed, 22 Feb 2023 19:21:34 -0500
Message-ID: <CAMr-kF0rCQZ6OQkb5g5pAzWddFKDv4CGYLFzDQs=hYLjJMsuQw@mail.gmail.com>
Subject: Re: .config and "make" / turning off all debug
To:     LIST - Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you so much for helping out.

Might the below accomplish the task?

cat f | grep -v DEBUG| grep -v TRACE | grep -v TRACING > newConfigFileWithout

On Tue, Feb 21, 2023 at 7:17 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 2/21/23 08:16, Hanasaki Jiji wrote:
> > Is there a command line parameter to Make that will disable anything
> > that results in a debuggable kernel?
>
> No.
>
> > Is there a tool that will modify .config removing anything that will
> > result in a debuggable kernel?
>
> We don't have a nice, clean, packaged way to do this.
>
> It also depends on what you mean by DEBUG. I would first disable
> CONFIG_COMPILE_TEST, then decide if you want TRACE/TRACING features
> disabled or enabled.  Also decide whether you want DEBUGFS
> options enabled or disabled.
>
> There are a couple of things that you can try. YMMV.
>
> Neither of these is a complete solution; option 2 requires
> the user to update the list of config options that should be disabled
> as needed.
>
> (1) Use a script to convert all occurrences of
> /CONFIG.*DEBUG=y/ to /# CONFIG.*DEBUG is not set/.
>
> This misses a few CONFIG options where "DEBUG" is toward the middle
> of the CONFIG option, like CONFIG_DEBUG_RSEQ, CONFIG_DEBUG_TEST_DRIVER_REMOVE,
> CONFIG_C710_DEBUG_ASSUMPTIONS, CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING,
> CONFIG_DRM_DEBUG_xyzzz (a few like this), CONFIG_DEBUG_KERNEL_DC,
> CONFIG_NOUVEAU_DEBUG_xyzzz (a few), CONFIG_DRM_I915_DEBUG_xyzzz (a few),
> CONFIG_SND_SOC_SOF_xyzzz (several), CONFIG_HFI1_DEBUG_SDMA_ORDER,
> CONFIG_AFS_DEBUG_CURSOR, CONFIG_DEBUG_NET, lots of entries in the
> Kernel Hacking menu. Then there are several SELFTEST config options,
> but they are not always spelled "SELFTEST"; they might just be spelled
> TEST or TESTS.
>
> I'll attach a Perl script (from 2009) that begins the work on option 1,
> but I haven't used it since forever.
>
> (2) Make a "mini.config" file that contains a list of all the options that you
> want to have set in a certain way (can be either enabled or disabled).
> Then use
> $ KCONFIG_ALLCONFIG=your.mini.config make allmodconfig
>
> This is the documented and supported way. It is documented in
> Documentation/kbuild/kconfig.rst:
>
> <begin quote>
>
> KCONFIG_ALLCONFIG
> -----------------
> (partially based on lkml email from/by Rob Landley, re: miniconfig)
>
> --------------------------------------------------
>
> The allyesconfig/allmodconfig/allnoconfig/randconfig variants can also
> use the environment variable KCONFIG_ALLCONFIG as a flag or a filename
> that contains config symbols that the user requires to be set to a
> specific value.  If KCONFIG_ALLCONFIG is used without a filename where
> KCONFIG_ALLCONFIG == "" or KCONFIG_ALLCONFIG == "1", `make *config`
> checks for a file named "all{yes/mod/no/def/random}.config"
> (corresponding to the `*config` command that was used) for symbol values
> that are to be forced.  If this file is not found, it checks for a
> file named "all.config" to contain forced values.
>
> This enables you to create "miniature" config (miniconfig) or custom
> config files containing just the config symbols that you are interested
> in.  Then the kernel config system generates the full .config file,
> including symbols of your miniconfig file.
>
> This 'KCONFIG_ALLCONFIG' file is a config file which contains
> (usually a subset of all) preset config symbols.  These variable
> settings are still subject to normal dependency checks.
>
> Examples::
>
>         KCONFIG_ALLCONFIG=custom-notebook.config make allnoconfig
>
> or::
>
>         KCONFIG_ALLCONFIG=mini.config make allnoconfig
>
> or::
>
>         make KCONFIG_ALLCONFIG=mini.config allnoconfig
>
> These examples will disable most options (allnoconfig) but enable or
> disable the options that are explicitly listed in the specified
> mini-config files.
>
> <end quote>
>
> Note that this only works with "make allyesconfig/allmodconfig/allnoconfig/randconfig"
> variants.  You could try it and see if it works for you.
>
> I'll also attach a sample "disable.all.debug.config" file for this option.
> You will need to update this CONFIG options list continually.
>
> HTH. Good luck.
>
> --
> ~Randy
