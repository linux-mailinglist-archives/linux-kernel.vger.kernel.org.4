Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA875F55AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJENjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJENik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:38:40 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82907B286
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 06:38:38 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id m81so17634435oia.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eLyBMB6yHnJuM1wuhrmi38uVG38cVvSKyu3CMD+kIGk=;
        b=jB4BuUWAMxV5Pz+M+zm3P7spBoMjuZnE6GTMb1bkhG2K3moWiknwM4tcRXldqeAztY
         2xPwMo1iLvhXK+5Dh5LOwZDQIvBC10Pf1FXyI8Jx2VOTKWrRPl7Ojo9GXTlnv4WknYAX
         U9eeutFRYtQKkcHw6rxv6axJYIdktJwqO6GKlUBGsDIZ5nMwYXcNST9jmEskIquWkI4j
         7t0wZO0X7oIjpWAlB9nYT1X0N64A4SZKtaVP/B2SyMxb1cjU7e089YJvvGyeuutDLW30
         9Yi3c3OgWo539bDKaVnHC6QA2GNuHjVmEOszOgPICujoYEb8qp7m+K1HEzzjto1flkJf
         5Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eLyBMB6yHnJuM1wuhrmi38uVG38cVvSKyu3CMD+kIGk=;
        b=UOFyoCkYa7G0b60xB5La8owS3CVFqhgios82ZWAuiUModRv6cGFAb2l7GMoPeC8d6v
         prenRobQ8NTd+iU/7vt6H8+Rcg0qeQsXx3oWS3flXzP515Us7lGQcv8L4FMkd/D0yk9H
         /5sFXpoVM3FHcluBjbsWX6axMIX9Qh8bLZrZ/liAdAGiCShFGby6yuZk56JlYA7wsfO5
         m1JFHQ5xP6yedhdlo/L2AB3IKsXLWeIPLXJXfe+YtKle9thuS11GmZH+N9KmqSmqEhvz
         tGQOKReSYn8PwpqEslrK2yyLkVwV6bHmeFhVMzkBPO2Va/grsxvwKwEnK6YWlhMkgcMC
         c4tw==
X-Gm-Message-State: ACrzQf1JtjE9KTCcseCJdIV8PUx0BjuY2Gp3IifPJ+B2a9xPG3CMECR+
        TvBS403PqMUQ2PRTXe2hVApFBZLTMDOzeh4D0/4o
X-Google-Smtp-Source: AMsMyM45iIW1ttBLm+xHHC7ZQMYH2201BpoEt1tqbZIzyGTIAzUJRMEGrCJ8VzcycuVJYDauGtgSY4yhqsilx0U870U=
X-Received: by 2002:a05:6808:218d:b0:354:b8c:f47f with SMTP id
 be13-20020a056808218d00b003540b8cf47fmr26681oib.172.1664977118184; Wed, 05
 Oct 2022 06:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 09:38:27 -0400
Message-ID: <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 8:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:

...

> > I'm not saying that an LSM is the only place to do it, but I don't
> > think there have been any better suggestions either.
>
> I don't know.  I tried to have the conversation and Paul shut it down.

I would encourage anyone reading the above statement to look at the
previous discussion, links were provided at the top of this thread in
the original pull request.

> Effectively he said that where two or more out of tree LSM policies want
> something it makes no sense to discussion the actual reasons people want
> to use the hook.

Runtime kernel configuration is inherently "out of tree", this
includes not only loadable LSM security policies (e.g. a SELinux
policy), the system's firewall configuration, things like sysctl.conf,
and countless others.  Please understand that "out of tree" in this
context is not the same as when it is used in the context of kernel
code; the former is actually a positive thing ("look we can configure
the kernel behavior the way we want!") while the latter is a
maintenance and support nightmare.

-- 
paul-moore.com
