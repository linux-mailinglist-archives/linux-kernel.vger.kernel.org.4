Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003B46EC767
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjDXHt0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 03:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjDXHtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:49:23 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0C10C8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:49:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-b951f5e1b3fso2693061276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322560; x=1684914560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhRZsU3OCwHhu2Y4xdvv6Apf1TI1FKu57DbzduNxVh8=;
        b=I/bROQd8s/p9euBciNfIUhtG5lPovgSquJXD5nYaWp+Bq34FO9OX1NVMSgtQOvtqvv
         ohXOGgzoKoM9/NGjIeqCBz1r9gI6kILqrgA/mHWd/ay767E/UTjY/7Du2f2s8431/hwI
         uicSi9DUSFdNk1WIKc6m/IPhCuSMwobU366iQSRRsoRrAj8Cwvm2dzIyYjRFYHTflJ4/
         knhO+ocligqmHlPy+G976yWGTHYsHQjAbANhVPOmpqFHXKHt7G7rfmjhJATzkg6l4E76
         cHKyB7boLyYdlMykLVAOGkhZLzdCXl01irt4ccz0UROPdEbJR6v0bAbXL8GRBueBeE67
         VuSg==
X-Gm-Message-State: AAQBX9eIS+1orH/uZNdPT3w86oXJ4jIW0PL49L5xgW/jIfcKWVwQPiUZ
        e3pxSVHScKYrYShgryCQ+75BRw2AVblpkQ==
X-Google-Smtp-Source: AKy350ahWCc8PC+tBtaOI0/sinqEGRUv0QEwRPLGTbkxat4ORXOwKcKOxSZ+KeYEY37R+D/lWvCMNg==
X-Received: by 2002:a25:508b:0:b0:b79:6c89:86c0 with SMTP id e133-20020a25508b000000b00b796c8986c0mr7572535ybb.42.1682322560540;
        Mon, 24 Apr 2023 00:49:20 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id c18-20020a25a292000000b00b8f6d69a631sm2734629ybi.27.2023.04.24.00.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 00:49:20 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54fb89e1666so25667147b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:49:19 -0700 (PDT)
X-Received: by 2002:a0d:d98f:0:b0:552:a306:5256 with SMTP id
 b137-20020a0dd98f000000b00552a3065256mr7246793ywe.18.1682322559690; Mon, 24
 Apr 2023 00:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <202304222120.WcBMaHXo-lkp@intel.com> <20230422135838.3rn67ky2p7jmdk3n@pali>
In-Reply-To: <20230422135838.3rn67ky2p7jmdk3n@pali>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Apr 2023 09:49:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8PP3gH_ctgZgXfV6Psu95eTuCh0MBsEQsRVG_6rEUVg@mail.gmail.com>
Message-ID: <CAMuHMdX8PP3gH_ctgZgXfV6Psu95eTuCh0MBsEQsRVG_6rEUVg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On Sat, Apr 22, 2023 at 4:03 PM Pali Rohár <pali@kernel.org> wrote:
> On Saturday 22 April 2023 21:53:23 kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   8e41e0a575664d26bb87e012c39435c4c3914ed9
> > commit: ff7c76f66d8bad4e694c264c789249e1d3a8205d powerpc/boot: Don't always pass -mcpu=powerpc when building 32-bit uImage
> > date:   3 months ago
> > config: powerpc-buildonly-randconfig-r006-20230422 (https://download.01.org/0day-ci/archive/20230422/202304222120.WcBMaHXo-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff7c76f66d8bad4e694c264c789249e1d3a8205d
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ff7c76f66d8bad4e694c264c789249e1d3a8205d
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202304222120.WcBMaHXo-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    {standard input}: Assembler messages:
> > >> {standard input}:924: Error: unrecognized opcode: `eieio'
> >    {standard input}:1094: Error: unrecognized opcode: `eieio'
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
>
> Hello! What is that? In this error report there is no compile log, nor
> any file / line. And "Link:" line from above error report does not work.
>
> Intel, can you look at your robot? This looks some bug in error reporting.

Looks fine to me: this is not a compile problem, but an assembler problem.
Presumably this is when building a kernel for a PPC platform that does
not support the eieio instruction?

The Link: works fine for me, sometimes you just have to be a little bit
patient for the archiver to catch up...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
