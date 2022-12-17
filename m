Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1665864F840
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 09:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLQI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 03:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 03:28:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B82ADD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:28:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o12so4581436pjo.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAebNvJ4WphOa2lvNv3u/NYDcRIgbAo0wg9/gk0i0Ag=;
        b=dOe+JvNeC/Pf9hqX0lLdDosaMGUdIAbmiN/FmgKLeEMvyd4LPPZxpywQ9220+G8qDO
         dTkWhi61mtYj/nlSSXhjLFj6r2zYm6GnfiN8TLEhUPDtFlKBUQCTXildvB6stA1GjfCs
         RDQjWQpzFxKgszMF+yZY2/giKr37vToCznzhc5kVgYAE8XBr/ByiWDkJxgq1YotwFq+m
         jrqL6tjQcPEZXg4Iq3OnG5ztqSFJE6Vupy5k7PXWMWpJo1W8vSMOgBPrbVqnqlI7ffyl
         st8F7ieMpoe9zBHIZa5cmftMkqoZTW8G5bZrNh6tQaAO53X9XMe8oB1uuBB/5n4aRdDv
         ynWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAebNvJ4WphOa2lvNv3u/NYDcRIgbAo0wg9/gk0i0Ag=;
        b=FJhmX83JoovtL95tqalB8VrkY/9DxXv7gk0wZ3KCXKIwmx/mGt+Lmw7PYCn5+wuhEN
         jYkwkui78mUnLzzb/64eyqUfM2MFXYb9O3CwC7msVlCoZDMBGweUMAGyVClZ/uko0evj
         S8htRT3yP1tsk2TD2fnj1dKSX0UM8X1HmT7d3Em2BE6NHhWKEbywLELFGzCPeMNdDPAB
         KeY1zrYx7SGuYng+qGhHUS9Xble0xRZgIZPQkBnici1tA3Nc+GfAJEepe+YQzc4QS46t
         3QvwV0r7QpDPwJVSsjGFqjPjWJ16uGlSsYwaidlSjYOj+7kcEDKx2qV52uNiAfbDCKbe
         Ighg==
X-Gm-Message-State: AFqh2ko6x/MiQyKEe1U43/NqUdwd0ZgPX30Z0OZqVqsluEKLrjtHLz2u
        kKR4l93IpkT8iPklNg3cFdSg31RRUbC+ddEZZik=
X-Google-Smtp-Source: AMrXdXtGVjZ01qV580Yo99F7bPb6P/X/FNtB4YAhAD3gjfENaB0qn5wgLvvNF4En+nclglJ0eSmNwVgCuHF+wjd15AU=
X-Received: by 2002:a17:90a:71c3:b0:220:1e2b:d0d7 with SMTP id
 m3-20020a17090a71c300b002201e2bd0d7mr1287008pjs.56.1671265691054; Sat, 17 Dec
 2022 00:28:11 -0800 (PST)
MIME-Version: 1.0
References: <20220819032706.695212-1-xiehuan09@gmail.com> <20221017154057.78babf40@gandalf.local.home>
 <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com> <20221129113006.0d745fae@gandalf.local.home>
In-Reply-To: <20221129113006.0d745fae@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sat, 17 Dec 2022 16:27:59 +0800
Message-ID: <CAEr6+EArZtwJPwZnKAB_61a=khPpC1=6ogqEC8r4npaaX0WvjA@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 30 Nov 2022 00:09:51 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > > Now instead of searching the function arguments for "obj", we should just
> > > read the obj value at every function and report when it changed, as well as
> > > the last function it was still the same. The report will be like the
> > > "func_repeats" entry. And instead we can print when the object changes,
> > > something like this:
> > >
> > >               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)
> >
> >
> > I'm just curious if we'll see this rewritten version in the next merge
> > window  ;-)
>
> Unfortunately, this ended up getting dropped in priority, as my workload
> increased internally. :-/

Hope you have multiple trips to London and more time on the plane to
get this done  ;-)

>
> -- Steve


-- 
Thanks,
JeffXie
