Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB8060E76C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiJZS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbiJZS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:29:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E8DCE9E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:29:06 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id t186so20008153yba.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8IiTfGeQB5Y3mkjoWFeOPnCtwqMovKFDnR4ImruD2M=;
        b=W4EMgsQMZ/YQdhAqr05QsRU2KXWsLprQ8IwBKTRTL/uUw/qJsSkHEJfFsr9trlTqQF
         aoTsxlqhWuv5/FMWyq1dJF5SF1Mr+xlcwIpcv48qaEU32MjOlY9kEmvG7WOmybgGafPT
         bbrJGDh4NsMjJr6i45qOBeGFu9hHWWj19Q4M4uZZMaUOrhiFq92bBtyzx7GDrGjW/IJw
         MUwus7v6x9k41Pe1sVHAKnGOET0BoRpv7TnL2ou1OoLH3F6cUEIO+ssUifOj7OHkRuzD
         LWhlMsJ0hqnyEy+Ch4DyBiyb9N4TBH+wlPp3GsoPR9OG5LT3uaE7rOfuDOYWKIZavh25
         fbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8IiTfGeQB5Y3mkjoWFeOPnCtwqMovKFDnR4ImruD2M=;
        b=Frwzu0i6rPugCP7otL1G13+RPwNPZT212OGXmgqg/aopAglh8vhLQvc1D+rh4nvIJ9
         O1BCXNcQxxyDk9JbGpVD8PT6r1qNO0UgpPNLmJ52KHO57e2l56FdorgG+FW1Z9j3TVSy
         K8ajxPiVuaMSwbiIH7d333PcMhwbvSEAXFJfdC8Hh54qe7/gntXET6IR5ct0qnjoUSDv
         OMKaulCvSEvtfGYe7ldWnlmlDpHPChI1yUohqfm2yGhROtQSOyzqnq1mwc/CeM8UbDH0
         VcjE9h9d6r1U4Pn0ZfZhm0Krums/6DWI4clBMkmqQlPhN/I0cT2B/HZaU9m2AU780hr6
         Osww==
X-Gm-Message-State: ACrzQf26Twdg4zvrbjWA9gv4hyEmLjyKlYz2H2W/mPMv8kDG7qkaj82v
        bjckp5zxUmwecp2O/apRMJV35RI5uSNkpTmVI3apzA==
X-Google-Smtp-Source: AMsMyM4S0R8IwLL6RX0ovQbPyD2cUFlpv46gno8czEJm63ie+RKRwg1ZzCo33Fg1nlz2h3r9YR7jCDA2jCIh/QPyfLw=
X-Received: by 2002:a25:3812:0:b0:6cb:446b:69fd with SMTP id
 f18-20020a253812000000b006cb446b69fdmr12824294yba.59.1666808945858; Wed, 26
 Oct 2022 11:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <202210260945.cCKjgJe3-lkp@intel.com> <Y1j8I2qf78jHfLWs@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1j8I2qf78jHfLWs@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 26 Oct 2022 11:28:54 -0700
Message-ID: <CAJuCfpHBMKbxWkJG4YRYvmaFPiXO42iVPZxgwUeWnKQb4CtDDg@mail.gmail.com>
Subject: Re: [peterz-queue:sched/core 16/18] kernel/sched/psi.c:983:35: error:
 too few arguments to function call, expected 3, have 2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 2:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 26, 2022 at 09:58:58AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> > head:   7005e3c43be6b6297440e85cb7d8c12a94540b49
> > commit: 95a70934458341dc43db09be8e7b88c98fba9b89 [16/18] psi: stop relying on timer_pending for poll_work rescheduling
> > config: i386-randconfig-a004-20221024 (attached as .config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=95a70934458341dc43db09be8e7b88c98fba9b89
> >         git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
> >         git fetch --no-tags peterz-queue sched/core
> >         git checkout 95a70934458341dc43db09be8e7b88c98fba9b89
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    In file included from kernel/sched/build_utility.c:97:
> > >> kernel/sched/psi.c:983:35: error: too few arguments to function call, expected 3, have 2
> >                            psi_schedule_poll_work(group, 1);
> >                            ~~~~~~~~~~~~~~~~~~~~~~         ^
> >    kernel/sched/psi.c:568:13: note: 'psi_schedule_poll_work' declared here
> >    static void psi_schedule_poll_work(struct psi_group *group, unsigned long delay,
> >                ^
> >    1 error generated.
> >
> >
>
> Droping for now; Suren could you fix up and repost please?

Sorry, I missed the report. Will post a fix by EOD. Thanks!
