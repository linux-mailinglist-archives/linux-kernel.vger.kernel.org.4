Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92C639FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1DA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1DAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:00:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AB7651
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:00:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so12641209pjk.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 19:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy6YGRvritBEn7bclT/hIoz2EnIirTxb7QGEsJahbiA=;
        b=gjKhbvfXQdlhbcWLdiqNKEw5y/kyA4/xTNlZENReDq9eIko0//yhBrdyjer64FZ4aB
         iedxGXaMsFDVarBgUflbjCuH4wB/DmofGZn5HETmQwuMlm44zG9BrXxwHdW8CQqDfD0N
         VHij7FAiJAnbRgQ6hSBc7n3X+1poQCjQEk35ZEx1F3A4Xix0nb/uJCLMpqYxKaN/YBS9
         A8/7q5zEwMRBMLv4ysZgIc0gFU4vo2wJbAG9T3TJuDnh4C30n5Xp6pc+KN9t9E0yRB21
         M5OrLd3zX91Y5RfwSOqRShPoldEPnTqNAf8BLrDSDrAkAzFDBknPgpK8BxYa+K4ROMxa
         wNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy6YGRvritBEn7bclT/hIoz2EnIirTxb7QGEsJahbiA=;
        b=yh6R+5NDinEZw1U89PGtynlk3PV2ctl/1HBWC5jMl9TMhnf6iGX5o4hAcZcCgdH9bb
         oWYknkcRYWrbnOv66nUqb2EMtpygVhv3QRFuTBVoKqJOe4yfWqT4P/KOIfCcRIH2/rUS
         feQGmU29NgsrgcoEpF5RXvm7Za1DoId0NC1cuUku6C+CymvTlrE4mmnIOG9ivma2pmoF
         KAVqOvUQR6v/FSGWqQQtc+KVUP88cIZtpCV/C/f5pvCsIK4VZc5wIhVX8DxDuvT6hkmT
         NX9ZT1bOwuZ0ZxHS8aWHDC22q3WW2/iPtzetOkvQUTW/iQz6xefgP1cMEEce8TNmnHX2
         jPXg==
X-Gm-Message-State: ANoB5plSyT8y19wS6h70aE4kkbgJw9ipOvWC4QsNeFqatXRErOcBfjqN
        IZHM2iL4E23FgXKV+qhF1cem5biiYpt2xuXw99I=
X-Google-Smtp-Source: AA0mqf5UceNhbskqkrInTTeM7JNyAeJ4fd1bbUXMgGB0F4x0sTmk0lrYfEl5b+pqU0vPJePueSwPdJjV36pzrHU/lIY=
X-Received: by 2002:a17:902:70c9:b0:176:a0cc:5eff with SMTP id
 l9-20020a17090270c900b00176a0cc5effmr38862278plt.128.1669604453468; Sun, 27
 Nov 2022 19:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20221121035140.118651-1-zhouzhouyi@gmail.com> <87y1rxwsse.ffs@tglx>
 <CAABZP2xNTbrx9iV+KH3VZx1c9Yi97+izNA=XSJQBuOJ4WENFZg@mail.gmail.com>
 <87v8n0woxv.ffs@tglx> <20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 28 Nov 2022 11:00:42 +0800
Message-ID: <CAABZP2zj4B4P4D+3g7M8jdKSaj5qBVHuGtGJcdmLAfzBZiva7g@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, fweisbec@gmail.com,
        mingo@kernel.org, dave@stgolabs.net, josh@joshtriplett.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
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

Thank you all for your guidance and encouragement!

I learn how to construct commit message properly and learn how
important the role
that the torture test framework plays for the Linux kernel. Hope I can
be of benefit to the community by my work.

I am going to continue to study this topic and study the torture test
framework, and wait for your further instructions.

Best Regards
Zhouyi
On Mon, Nov 28, 2022 at 1:53 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Nov 27, 2022 at 01:40:28PM +0100, Thomas Gleixner wrote:
>
> [ . . . ]
>
> > >> No. We are not exporting this just to make a bogus test case happy.
> > >>
> > >> Fix the torture code to handle -EBUSY correctly.
> > > I am going to do a study on this, for now, I do a grep in the kernel tree:
> > > find . -name "*.c"|xargs grep cpuhp_setup_state|wc -l
> > > The result of the grep command shows that there are 268
> > > cpuhp_setup_state* cases.
> > > which may make our task more complicated.
> >
> > Why? The whole point of this torture thing is to stress the
> > infrastructure.
>
> Indeed.
>
> > There are quite some reasons why a CPU-hotplug or a hot-unplug operation
> > can fail, which is not a fatal problem, really.
> >
> > So if a CPU hotplug operation fails, then why can't the torture test
> > just move on and validate that the system still behaves correctly?
> >
> > That gives us more coverage than just testing the good case and giving
> > up when something unexpected happens.
>
> Agreed, with access to a function like the tick_nohz_full_timekeeper()
> suggested earlier in this email thread, then yes, it would make sense to
> try to offline the CPU anyway, then forgive the failure in cases where
> the CPU matches that indicated by tick_nohz_full_timekeeper().
>
> > I even argue that the torture test should inject random failures into
> > the hotplug state machine to achieve extended code coverage.
>
> I could imagine torture_onoff() telling various CPU-hotplug notifiers
> to refuse the transition using some TBD interface.  That would better
> test the CPU-hotplug common code's ability to deal with failures.
>
> Or did you have something else/additional in mind?
>
>                                                         Thanx, Paul
