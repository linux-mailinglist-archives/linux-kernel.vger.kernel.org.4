Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A369329A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBKQv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBKQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:51:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8ED515
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:51:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg26so5974249wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3dLOUyD2qLLZeL+RCBFqBDU+r6K7Onh/Gy2tm5yVZc=;
        b=ER9ivdRQA46j70AsRtLo3uCWnNMEK1js+A1odjy8Q0Z3FMBTW+wMfXjciKmV+z6gW1
         k8VkV1E+uBYcsO8SvacDa6fyImvMFIzgtocB2MjOTLT0R0EaDu9jszSbGiTeXetIw81K
         yHCVKShSA2+RdAwVEqdQLXvrsVSYxRbps4YjQL3gFfW8Q12WxO1WoMpit3RYvCcLYLJw
         wd1I/Gd+PbRPUMBJ4svv5nAc4RiZRM74ZEd5KQyXsUAnhJ2KD1xN0Ya2j6VrIyGpXSy/
         9L/oFg6Smvz+NKUvzRDYsgn9WBqBhOUD2cfoTgFSfBopcysBA3dBAWTc77y6jTPjPvy4
         HueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3dLOUyD2qLLZeL+RCBFqBDU+r6K7Onh/Gy2tm5yVZc=;
        b=bBRjYB3sfBdKyqjOmtAjVHwdsm+Yf62H5hApngUTVb6UTfj37eZFb5NxW/wsCf2sNu
         ghB7ovYB9BuOuE9pp5a8SuYDqC2iADkfyo2CvY7vbdAJgctNmDLAYxlmbheax/tjtwgj
         +Lt3Vp2DiU6CRdMSwa2PF0j76SPaDnGRNmNXGL3iLXFTdh6o7Mwlxdc8yVvlas3zJz4A
         TcDhrFQWc2d0KQBS44PJKRUsrNQbhvhjz+K89Xh602Io0myo2Yip3CybTHH5KSFvc6BA
         9A2fGPQ5CvyjGlimSR4XglIFJlqpHMLD4No2Y7sHsyJ0TqL+v0Z7Y39UQKVP+A4lVpuk
         ofYg==
X-Gm-Message-State: AO0yUKWgkm/fcjWYBguKEr5zXP8157QKu72auQkf77zAaug8Dv3U7gT+
        tqXU15okx4lbOjUqb3iNi/HklQ==
X-Google-Smtp-Source: AK7set/CFEhOT8NQgm8Y1FA7us6RejO5nTqrWa3aLjIDDJhY7POSdEi1Rr+Jp4XzmhMfDx7bAQd+FA==
X-Received: by 2002:a05:600c:331c:b0:3df:ee43:860b with SMTP id q28-20020a05600c331c00b003dfee43860bmr15481946wmp.23.1676134282119;
        Sat, 11 Feb 2023 08:51:22 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003db03725e86sm9729083wmo.8.2023.02.11.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:51:21 -0800 (PST)
Date:   Sat, 11 Feb 2023 16:51:20 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        John Stultz <jstultz@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@google.com>,
        Daniele Di Proietto <ddiproietto@google.com>
Subject: Re: [PATCH v2 7/7] tools/testing/selftests/bpf: replace open-coded
 16 with TASK_COMM_LEN
Message-ID: <20230211165120.byivmbfhwyegiyae@airbuntu>
References: <20211120112738.45980-1-laoar.shao@gmail.com>
 <20211120112738.45980-8-laoar.shao@gmail.com>
 <Y+QaZtz55LIirsUO@google.com>
 <CAADnVQ+nf8MmRWP+naWwZEKBFOYr7QkZugETgAVfjKcEVxmOtg@mail.gmail.com>
 <CANDhNCo_=Q3pWc7h=ruGyHdRVGpsMKRY=C2AtZgLDwtGzRz8Kw@mail.gmail.com>
 <08e1c9d0-376f-d669-6fe8-559b2fbc2f2b@efficios.com>
 <CALOAHbBsmajStJ8TrnqEL_pv=UOt-vv0CH30EqThVq=JYXfi8A@mail.gmail.com>
 <Y+UCxSktKM0CzMlA@e126311.manchester.arm.com>
 <CALOAHbCdNZ21oBE2ii_XBxecYLSxM7Ws2LRMirdEOpeULiNk4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALOAHbCdNZ21oBE2ii_XBxecYLSxM7Ws2LRMirdEOpeULiNk4g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/23 23:37, Yafang Shao wrote:
> On Thu, Feb 9, 2023 at 10:28 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > On Thu, Feb 09, 2023 at 02:20:36PM +0800, Yafang Shao wrote:
> >
> > [...]
> >
> > Hi Yafang,
> >
> > > Many thanks for the detailed analysis. Seems it can work.
> > >
> > > Hi John,
> > >
> > > Could you pls. try the attached fix ? I have verified it in my test env.
> >
> > I tested the patch on my environment where I found the issue with newer
> > kernels + older Perfetto. The patch does improve things so that's nice.
> 
> Thanks for the test. I don't have Perfetto in hand, so I haven't
> verify Perfetto.

FWIW, perfetto is not android specific and can run on normal linux distro setup
(which I do but haven't noticed this breakage).

It's easy to download the latest release (including for android though I never
tried that) from github

	https://github.com/google/perfetto/releases

Kajetan might try to see if he can pick the latest version which IIUC contains
a workaround.

If this simple patch can be tweaked to make it work again against older
versions that'd be nice though.

HTH.


Cheers

--
Qais Yousef
