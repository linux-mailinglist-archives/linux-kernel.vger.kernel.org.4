Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F6F68A71D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjBDAFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjBDAFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:05:32 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4E78AFC;
        Fri,  3 Feb 2023 16:05:31 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id x139so8192517ybe.13;
        Fri, 03 Feb 2023 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NWXwDNOya4kdsdCh7pC4XQ4wSo7oNJQdGNPn7Cg8eek=;
        b=p01UnsMGEc02PpErdtDhWQLXS9kGGzbxM0OZzFIQzvdBJuszoOAOgAbxH5LyMSS8IZ
         s4JAnmv2Sfa6OiqwjP39NYz81pf4TehcTP17pG2dAqTVcqX5UNw8BD/TPXuKQpuoB5GR
         TOqnHsThisS1jvVOOhbb0y0prhJ5exGyjY5BSSsuNmtNi25v9mROJzdrAv69BoJ0NOSM
         C0ktjQeaugKkw92z/BQ2Lsz/X1EX3pIqQZedEbqc6lx7wwM4paAlBAs1L437K8w5TB1Y
         eYI3NU5j5iE4ZgsBlv5HezY+M+YjJ+kUWQHqu4VfKpIy02I1cnU1oinSWT/I+krrSf0e
         Z2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWXwDNOya4kdsdCh7pC4XQ4wSo7oNJQdGNPn7Cg8eek=;
        b=LINVapFPg4iQk7USzFz5dqFONGVmHT7Go9x3226SxCjRmkFglcuua4t6Y/2IcOW2xN
         m+kXAJ/Igl3EIcPNsswYVXu/FA4qQoYB8w63OjonTqBEFoHAEkDoTcLCX2i2CN3yhN3c
         P2dpkA4dpjwR1zxAp4GqwEjkgE225cCYwvI4B1jyBvodKB/PncvHAwbs9BvGwmAHTufF
         +gj9wi0ncBTBsEjdvgf3mblz3qQfB0qiB0m9vaBdErnbk5ONJzLLu9MG9olAEVFF8A9u
         3t+0d87xaX4r4QZqTPmnLOyPIdBuqOh/5m7TMCBi8Xwxb/dbDt51g+IXygimC8PccMoS
         DhIA==
X-Gm-Message-State: AO0yUKVF4BbAUFmOplnMTjEP6xyJ7eaO5Vfr2JhNmwfQFsfWk6L4aSGt
        brCcFVIdkzV01emrQOUOumrIcLZWRS/i1x4llrV9IngGRVxp2S+w
X-Google-Smtp-Source: AK7set9dIro31EPZI9q8PtMD4viwjFAOxk2nHBAGaxtZCXS1jKTjuGzI8+AY55Wf3vd8Jr54nYGcL8gwY/nb7BKlEo0=
X-Received: by 2002:a05:6902:34b:b0:878:2679:8700 with SMTP id
 e11-20020a056902034b00b0087826798700mr231743ybs.328.1675469130436; Fri, 03
 Feb 2023 16:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20230127165728.119507-1-carlos.bilbao@amd.com> <87pmaqskf1.fsf@meer.lwn.net>
In-Reply-To: <87pmaqskf1.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 4 Feb 2023 01:05:19 +0100
Message-ID: <CANiq72=gpzQyh1ExGbBWWNdgH-mTATdG5F600jKD1=NLLCn7wg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] docs: Integrate rustdoc into Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>, ojeda@kernel.org,
        jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, bilbao@vt.edu
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

On Fri, Feb 3, 2023 at 6:55 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> - I dumped my Fedora toolchain and did the curl|bash ritual to set up
>   the proper versions with rustup.  It would be nice to have some better
>   documentation on how to do that ... *how* to install bindgen may not
>   be obvious to all users.  It also failed until I installed lld
>   separately.

Are you referring to the Quick Start guide? I am asking because the
guide has a one-line command ready for copy-paste to install
`bindgen`, so I guess you mean something else (?). It also notes that
there are standalone installers available (if you don't want `rustup`)
-- I will change the URL to point directly to the page with the
installers, though, since that should help.

The script behind `make rustavailable` is getting a bunch of
improvements (and tests) in an ongoing patch series -- I will check
the `lld` issue for v2 too. If you don't mind it, I will Cc you then,
in case you could give it a try and confirm it helped.

Thanks!

> I'd really like to see a solution that (1) doesn't kill the docs build
> process if the tool versions are wrong, and (2) doesn't force the
> creation of a kernel configuration.  What are our chances of getting
> there?

It may be quite involved, since a few artifacts from the normal build
would be needed [1]. Since some things in the build system will likely
change anyway, it is probably best to come back to this after that.
What do you think, Carlos? Or would you like to give it a try?

[1] https://lore.kernel.org/linux-doc/CANiq72mC+WzOxhZVtEvnsFYzuBPkd51=TYXK01ztcTZ-CAcUiw@mail.gmail.com/

Cheers,
Miguel
