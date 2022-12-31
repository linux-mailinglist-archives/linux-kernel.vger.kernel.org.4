Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091665A540
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiLaPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLaPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:06:44 -0500
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 31 Dec 2022 07:06:43 PST
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E2633D;
        Sat, 31 Dec 2022 07:06:42 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2BVF6OKl011333;
        Sun, 1 Jan 2023 00:06:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2BVF6OKl011333
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672499186;
        bh=cPtMT1ikPVY2628/xD0d9Qu971vGxgBBHmwX2fGx46Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qPAUxth/qw93T8XlinZlEZ+TtBTGrTRnuDsJdNUzVpdsp79Wj4a6z1A87z3mzozPt
         0UquscrCLavkcY+JH7G9wbZgurvCypaS+DZC5LhcsESGmZy7EcSXSyUD9wv5C7d5yj
         YtDFTO+wWVQ5GrXmObd4LFoaXqPX4u70KP8jc5f0pgnvS2mY/bZm+afIC8bD1lk2Ow
         ViS+oB1EV39yLPK/1q1ouLVUexfkn37JJmyWNSBKK64z4tt+/YiR4kCb6PHaXT1XJX
         dug5fLPI7Cv47T/mbXjN2okCfZbfOnMQSNrobrLFpaxPqf+OI4yNuFZO/rKCFz1zoo
         DECTpZM+99qww==
X-Nifty-SrcIP: [209.85.167.48]
Received: by mail-lf1-f48.google.com with SMTP id bt23so18879785lfb.5;
        Sat, 31 Dec 2022 07:06:25 -0800 (PST)
X-Gm-Message-State: AFqh2kpirrrAwdxsXfsI+/So7SN5rKV1l7Xca+SmhpO1HRA3evplFyP4
        S3gcF12J34MCvrI4XJz/Z5siN8+Y69YtLq1Qkek=
X-Google-Smtp-Source: AMrXdXtV2tGXh1jtska7YrD89aDiR/6tpAp7znMYCCa6K7MzJDPvlhi8f3ERlPs23u5zAoXo/qR0Ug1SeDa+LVKrW5E=
X-Received: by 2002:a05:6512:462:b0:4b5:706c:ab80 with SMTP id
 x2-20020a056512046200b004b5706cab80mr1681418lfd.226.1672499183563; Sat, 31
 Dec 2022 07:06:23 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <CANiq72m5E1MehfqdrkmJt43fAzUMc9kEKu7x4WaALdgDGJ30-g@mail.gmail.com>
In-Reply-To: <CANiq72m5E1MehfqdrkmJt43fAzUMc9kEKu7x4WaALdgDGJ30-g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 1 Jan 2023 00:05:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQOaLHizg24CrMUz7veX0fa0QYwgJzAi5tOT+-CDCmUzw@mail.gmail.com>
Message-ID: <CAK7LNAQOaLHizg24CrMUz7veX0fa0QYwgJzAi5tOT+-CDCmUzw@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix dep-file processing for rust
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 10:34 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Masahiro Yamada (6):
> >   kbuild: specify output names separately for each emission type from
> >     rustc
> >   fixdep: parse Makefile more correctly to handle comments etc.
> >   kbuild: remove sed commands after rustc rules
> >   fixdep: refactor hash table lookup
> >   fixdep: avoid parsing the same file over again
> >   fixdep: do not parse *.so, *.rmeta, *.rlib
>
> These cleanups are great, and it is a pleasure to see proper
> integration with `fixdep` -- thanks a ton! :)
>
> Will you want to take them through the kbuild tree? (I guess so, given
> the bulk of it is on `fixdep`)


Yes, my plan is to get it in the kbuild tree with your ack.




> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
