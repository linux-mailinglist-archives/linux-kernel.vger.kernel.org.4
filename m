Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABB25F57F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJEQEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJEQEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:04:40 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C921BC34
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:04:38 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id h1-20020a4aa741000000b004756c611188so11130418oom.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9ewqxyf2ZmVpWWvnv+mY4mZ0rYK7w7PalIIi7eYdNso=;
        b=ZpcEcQrKrrWI6iXE4vMdOBWvvIzkkJtpF6ClCIDTYzFqnwQ8DOYjt2VXxHTcyytwDp
         phn7aT6OFZVCEWJbMSwkzbHrB6IdlODe/j++NBas3VnhdUWSW72wj5jdjjjWFHafwvwQ
         +nO8BgW/Sj8ZM0Ru8F+LcA9Wkb1oQtZTBTU0IowH2mFZIxkBRDkcdLQCexin28p2+Dli
         Eh27IfqKTFXV/iDbu7AoS5SPTKHVraMUYMGeJnBniHOV3PlpOB/ujScMuEchvK9xPYSU
         rQqobaQgAT14LHF4QnaKdY5hI5Ihb+bHCBN4rgQDCdVUOHfp1Ame0os7ebPnrH6by0JM
         dATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9ewqxyf2ZmVpWWvnv+mY4mZ0rYK7w7PalIIi7eYdNso=;
        b=KGMPFyBHCML7eJaQ0hJP1ZulFmb4pdg4n5SM8KnYYIr/ZERjnXW6kmrE59gAgW5dPK
         g8y3mfXGCnGYO7S4cnH9LLLb94z42iDAYCZVb4/5zFfPbHWQPQoZeJ7DzKbXFcDvatSt
         AtR5J/CYM4mI1ABC85AKrRbtSrMGiHVI5K79tlS9rX+ycGfxTyu+lmBPokMh/0omS8U1
         I5WyKjzpmHkei7SoFC0Il+2SIqFWcg69bg/XVKfaqeF6zf4V8DwBmsw2Fa/MhrMyYcER
         2+Q/1ib2/dxIzOWYmNEseg2/+7oGM8lhJfPVuNCRtRcLft/+Cnq52Ap/rNcqbxEBk1wx
         y1dA==
X-Gm-Message-State: ACrzQf02uQtsW0xMpkc7MZejhzjq8rQZboeltzw75bEXcdMAXRO1sgzm
        LHZU2YFSVyPo4EYDDrZihHEKY2ciYehIQ4JyLaad
X-Google-Smtp-Source: AMsMyM5UR4zMUvddteicC06tlamEVGuwFvrvQKhe3N+dGLMqVUZFFitTPf6tetLUEIq6lvK+8CGG7zfSPnYPKhJ3Lds=
X-Received: by 2002:a05:6830:4096:b0:660:cb59:587b with SMTP id
 x22-20020a056830409600b00660cb59587bmr105125ott.34.1664985878106; Wed, 05 Oct
 2022 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
 <87sfk3mim9.fsf@email.froward.int.ebiederm.org> <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
 <87r0zmigx6.fsf@email.froward.int.ebiederm.org> <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
 <87a66ae15h.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a66ae15h.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Oct 2022 12:04:27 -0400
Message-ID: <CAHC9VhTmfRhYCJibpZ20ibH-JhVMrwbpFdCtKUz5tqFHsjLRiw@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 11:33 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Wed, Oct 5, 2022 at 8:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Linus Torvalds <torvalds@linux-foundation.org> writes:

...

> >> Effectively he said that where two or more out of tree LSM policies want
> >> something it makes no sense to discussion the actual reasons people want
> >> to use the hook.
> >
> > Runtime kernel configuration is inherently "out of tree", this
> > includes not only loadable LSM security policies (e.g. a SELinux
> > policy), the system's firewall configuration, things like sysctl.conf,
> > and countless others.  Please understand that "out of tree" in this
> > context is not the same as when it is used in the context of kernel
> > code; the former is actually a positive thing ("look we can configure
> > the kernel behavior the way we want!") while the latter is a
> > maintenance and support nightmare.
>
> Paul are you saying my experience with /proc/net pointing incorrectly at
> /proc/self/net instead of /proc/thread-self/net is invalid?

My comment was that runtime kernel configuration is always going to be
out of tree due to its very nature, and conflating runtime
configuration with kernel code is a mistake.

-- 
paul-moore.com
