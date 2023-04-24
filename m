Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D06ED575
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjDXTnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDXTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:43:01 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541915B88
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:43:00 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-54fb8a8a597so57499447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682365379; x=1684957379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzv9DDy8KqR5toIcVytBQed/LqPBtxIbLra1+3vX+mg=;
        b=K3+Su5o6DkNEAZua8ZvusiHzdE9JlBrahC8JEOWgp+QC6+r9Rz5J10UhXyp7JrBQhw
         XY5OrGBm5JfmeCb8feP5qBoolPY1aihxtKFcbPp+R9Ynp6awL3FFbPQSkadb2U/JwRQR
         D/n2ARxlBVR3TxsFwM7QUEMUHwgpLqQb+o7utuP2OYRCuu6/YDUqHeRUzyyE8QeweJD4
         ekm04slxxtWskwgI/VFIy2O6ad6DmKVkO52F58X+xwoY1/LDBSVx9Nc6/zka8N8iotsI
         z2m+gh/+clV69W//G8NrS5ocFoqlQHNaKrpFQF3jrHcXplK6CTGCQHu6EUViwnv+B0Yl
         aM8g==
X-Gm-Message-State: AAQBX9fPHQMt9+PnwT3PL02VhS5FA7bNAs0FWBSRujArYMTfsrG7NOtt
        rmICj3qvjQ9cEdYKkVZQDXMmBYanhVDXpg==
X-Google-Smtp-Source: AKy350a0A1Mln01KPxOziFZQAhS68YPeBOJgj8tehPpFinVBrswI9aF3CM6Ednx7ZhZ8yYFraIkgXw==
X-Received: by 2002:a81:4849:0:b0:54f:b857:7fdc with SMTP id v70-20020a814849000000b0054fb8577fdcmr8989033ywa.17.1682365378260;
        Mon, 24 Apr 2023 12:42:58 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q189-20020a0dcec6000000b00555be5a354dsm3146677ywd.52.2023.04.24.12.42.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 12:42:57 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b9582901279so7218779276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:42:57 -0700 (PDT)
X-Received: by 2002:a81:5f83:0:b0:556:300c:d653 with SMTP id
 t125-20020a815f83000000b00556300cd653mr6938761ywb.40.1682365377354; Mon, 24
 Apr 2023 12:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <202304222120.WcBMaHXo-lkp@intel.com> <20230422135838.3rn67ky2p7jmdk3n@pali>
 <CAMuHMdX8PP3gH_ctgZgXfV6Psu95eTuCh0MBsEQsRVG_6rEUVg@mail.gmail.com> <20230424184941.44no7rkxjadnyojm@pali>
In-Reply-To: <20230424184941.44no7rkxjadnyojm@pali>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Apr 2023 21:42:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWG5uzQCA6TA9n8sNn=WYOyO++AgThADVbLD5z9AiSL5w@mail.gmail.com>
Message-ID: <CAMuHMdWG5uzQCA6TA9n8sNn=WYOyO++AgThADVbLD5z9AiSL5w@mail.gmail.com>
Subject: Re: {standard input}:924: Error: unrecognized opcode: `eieio'
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On Mon, Apr 24, 2023 at 8:49 PM Pali Rohár <pali@kernel.org> wrote:
> On Monday 24 April 2023 09:49:07 Geert Uytterhoeven wrote:
> > On Sat, Apr 22, 2023 at 4:03 PM Pali Rohár <pali@kernel.org> wrote:
> > > On Saturday 22 April 2023 21:53:23 kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   8e41e0a575664d26bb87e012c39435c4c3914ed9
> > > > commit: ff7c76f66d8bad4e694c264c789249e1d3a8205d powerpc/boot: Don't always pass -mcpu=powerpc when building 32-bit uImage
> > > > date:   3 months ago
> > > > config: powerpc-buildonly-randconfig-r006-20230422 (https://download.01.org/0day-ci/archive/20230422/202304222120.WcBMaHXo-lkp@intel.com/config)
> > > > compiler: powerpc-linux-gcc (GCC) 12.1.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff7c76f66d8bad4e694c264c789249e1d3a8205d
> > > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >         git fetch --no-tags linus master
> > > >         git checkout ff7c76f66d8bad4e694c264c789249e1d3a8205d
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> > > >
> > > > If you fix the issue, kindly add following tag where applicable
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Link: https://lore.kernel.org/oe-kbuild-all/202304222120.WcBMaHXo-lkp@intel.com/
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    {standard input}: Assembler messages:
> > > > >> {standard input}:924: Error: unrecognized opcode: `eieio'
> > > >    {standard input}:1094: Error: unrecognized opcode: `eieio'
> > > >
> > > > --
> > > > 0-DAY CI Kernel Test Service
> > > > https://github.com/intel/lkp-tests
> > >
> > > Hello! What is that? In this error report there is no compile log, nor
> > > any file / line. And "Link:" line from above error report does not work.
> > >
> > > Intel, can you look at your robot? This looks some bug in error reporting.
> >
> > Looks fine to me: this is not a compile problem, but an assembler problem.
> > Presumably this is when building a kernel for a PPC platform that does
> > not support the eieio instruction?
>
> What is fine on this report? There is completely missing command which
> generated this error; whole error message; input files which caused them

The file name is indeed missing.

> and also change or commit.

That is mentioned, and looks like a valid possible introducer.

> And what presumably happened? I'm really not going to spend more time on
> guessing what reporter could probably might wanted to write into the
> report and start looking into crystal ball what could be an issue.
>
> I can say that this issue presumably happened when email operator of
> this robot pushed incorrect button and instead of the real report, it
> sent test report with content of some random error line from the random
> log file.
>
> Are we on the technical discussion about exactness? Or are going to
> discuss what who think that what could happened?

It's randconfig, and the config is provided, incl. steps to reproduce.

> > The Link: works fine for me, sometimes you just have to be a little bit
> > patient for the archiver to catch up...
>
> Sorry, I do not have time to wait undefined amount of time to access
> additional resources which are based on reported details required for
> debugging.

The Link is just a reference to the email you received in your mailbox,
and to all follow-ups.

> Intel, could you please react on this issue? If not, I'm going to add
> your robot to my black list. It is not first time when I received such
> useless report from you and nobody reacted on it.

Well, you are the one who authored the offending commit, and at
first glance, it looks like a reasonable culprit that could introduce the
failure mentioned ;-)

Presumably you forgot to cater for a very specific combination of
config option values?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
