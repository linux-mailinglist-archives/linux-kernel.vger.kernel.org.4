Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9159A698D86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBPHBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPHBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:01:13 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CDD8A62
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:01:13 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id z15so954287vsj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676530872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiWCeaDHu0d2DzRL5Q2rZ6Kr6gE5UVc7HS7E+8OLbNo=;
        b=LXLuI0lukZpk+g+34EKNeybLCdvtI60f3JqDjW9eZwsuc8GRIV+jom5gw8fFiJfADo
         Jxm+4n3vY7Y+Jx82/QkJZEWa4JRyQdsZN2jw4XysXlCIKNQKyjX8HqhwVKfLnnxg410E
         CWDtNMB6D9/07yQnsCQPr4gEWqrI4GhFDZVjiNk3nMBAhIHIpBU2srKbNaED8HgkltG0
         zQfpf+naNmlc19OdXMwsCJrb4RFR457LAOZNCrY8eJkZE7UrGIspwj/v0AZFNiYlzslA
         hXpWXi33OmPBXaRZTyMKg4LgC2OcNdJFJvkt6GKabZRinmiwjcULHxSrkp15BNZAtnPO
         EGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676530872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiWCeaDHu0d2DzRL5Q2rZ6Kr6gE5UVc7HS7E+8OLbNo=;
        b=uqP519ZJr6YdculxwYqJuljeMHxyy1biZO5kC/Xz56JDtOXQ2P+R4qFIharn4guNSt
         8ihZ/bprgfagzwnNOTrBbHKlJ6YZbZLTKj7U4WHhOnLQG53kp1EC/fv/NxjykuDhXbCx
         DnCCjn7fXvTHF1L88udZiZNmTUzqgqL3AY5znSVK9m0ICQ5C13S5k7EPRRI9abIXkOHl
         Cz7gzRGTKKFcxLOc87Ovmr1qZl4O3n6JWZZ/28iQwKUMRL3cJrpWbx6m/sEq5SgKqkqV
         qij6WDAilmZK9BrOqg05VHno5K5EWYGWcX3lQEW2GzK0wvVEOCsPxrw8LGEFcG5rYOfj
         lolw==
X-Gm-Message-State: AO0yUKUIwqm3z9zcVbpbQcp6IEKB/UAl/AVM3SNGLPmg6scs7qCikU1k
        oxkSGD1ZuoAS/++qf87w3tjcuJ+3gdnAgkBQfnkqjw==
X-Google-Smtp-Source: AK7set/iZ9HDFoy3dkRKzNhXAalE4+M+T5REPdJmheDtz5Ua0bEUDb7IEvMbPkQ6G1arh9iIICsR9GlWSn3DLkw82UA=
X-Received: by 2002:a67:70c6:0:b0:412:2e92:21a6 with SMTP id
 l189-20020a6770c6000000b004122e9221a6mr913571vsc.13.1676530872160; Wed, 15
 Feb 2023 23:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20230215091503.1490152-1-arnd@kernel.org> <CANpmjNNz+zuV5LpWj5sqeR1quK4GcumgQjjDbNx2m+jzeg_C7w@mail.gmail.com>
 <78b2ed7d-2585-479f-98b1-ed2574a64cb8@app.fastmail.com> <20230215224218.GN2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230215224218.GN2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Feb 2023 08:00:00 +0100
Message-ID: <CANpmjNNz30RQMfX0Bv+hobdUp+k_jHwH2WniQj4g+b48tsoR9Q@mail.gmail.com>
Subject: Re: [PATCH] kcsan: select CONFIG_CONSTRUCTORS
To:     paulmck@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 23:42, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Feb 15, 2023 at 10:48:11AM +0100, Arnd Bergmann wrote:
> > On Wed, Feb 15, 2023, at 10:25, Marco Elver wrote:
> > > On Wed, 15 Feb 2023 at 10:15, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > Looks like KASAN does select CONSTRUCTORS already, so KCSAN should as well.
> > >
> > > Do you have a tree to take this through, or should it go through -rcu
> > > as usual for KCSAN patches?
> >
> > I don't have a tree for taking these build fixes, so it would be good if you could forward it as appropriate.
>
> Queued and pushed, thank you both!
>
> Is this ready for the upcoming merge window, or would you rather that
> I hold off until the v6.4 merge window?  (I am tempted to treat this
> as a bug fix, thus sending it earlier rather than later, but figured I
> should ask.)

I'd consider it a bug fix. If it survives the usual -next exposure, no
harm in sending it as a fix.

Thanks,
-- Marco
