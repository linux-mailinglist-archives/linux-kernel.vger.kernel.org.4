Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8F62CDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiKPWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiKPWkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:40:35 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1075B878
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:40:34 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j12so17787009plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UzcXa7T4go8BCZ2+JcH7BfafhKjaxvqL4Y0Iif9VmBU=;
        b=fqkVtQz/gr3HS43QqL9DzpRw5KfIi1/n2Lt2GXcxU27sq0kQ6olvv43ugUEA5x+air
         LNsipoZd+hKi0BZKehUp/QQED6nzJaO3k2zJtR/lQJdhcVPD1dYJfBSmK+SNjYU6vfK1
         Do7XnqngElmkoMJO2TD4a85yFfZIF4/1xv5JzrWoSmfYf1yl2HEoei9ulpTTlwyxdKEs
         IdzPwK9gjPXNG/DuTsjiJDnYv1dQfLRIcwjlVTNrS0AavS8zvzwp4Cf3Mulmor/47Sey
         9FNTo1SfeEs04H6Mdcr/3otLrP2fYxFhJIu1AsBM8yBemmsyJkb3QRHxb1uGepCQ8e21
         jG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzcXa7T4go8BCZ2+JcH7BfafhKjaxvqL4Y0Iif9VmBU=;
        b=12VR7eVuDhUj3C91GgMF8IEnHgUmH92yZ7DrHe1/trO/5m35fKRJ9l4xQSVoXTcU13
         HJp+3I7VLGn4N2qVa02QXPtTWUkqLmyjQGumKlGfvXaWNV8HG7yNQvKTQJYVFysvtjjq
         F7PbKusvaMPmVbVw14WAzu7eHv6+61/ujEucwqyzBMa99oh+fzRFxGu2RV73ehsBFQE0
         W4nAHeuYFQwbs/7Vl8OL8tIUkg5Ys6dsOHoGxI6mZnUd5JBgv5vDbZHq4tYMwf1Cf8Ai
         /jMlWH8kHmHMlfpNUpwHV3OKxGwrSd6GrsLOTwYM9FX5qvYUm+ug9G6KUmUhc2v3Sf9z
         wakA==
X-Gm-Message-State: ANoB5pkG955AwMbW+bqww65AhaX2rtiqVVC3F/bUoMyvq9yRQB9wzX8K
        I4oqsk/JGVQIgLcW7d+mHQy45PFP+rpD/swAF4/u
X-Google-Smtp-Source: AA0mqf54wnqdQbNLvtiVr7mBPZk009rq2BqN/X27wqSBJvGIvNiD6Qj6t52LWfa4miZTRM9kwnygUPM7bbvaFuw+alM=
X-Received: by 2002:a17:902:bf4a:b0:186:e568:3442 with SMTP id
 u10-20020a170902bf4a00b00186e5683442mr10969908pls.56.1668638433849; Wed, 16
 Nov 2022 14:40:33 -0800 (PST)
MIME-Version: 1.0
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
 <20221116154712.4115929-1-roberto.sassu@huaweicloud.com> <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
 <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
 <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com> <CACYkzJ6-zLNZhRmpaax+_ZywWLa5R2HwcxRke8hCHu_FgYceeA@mail.gmail.com>
In-Reply-To: <CACYkzJ6-zLNZhRmpaax+_ZywWLa5R2HwcxRke8hCHu_FgYceeA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 17:40:22 -0500
Message-ID: <CAHC9VhTWZAcTyhvX+dZGnoaymzhR0qE8gBZkeeqdjkNfyOa42w@mail.gmail.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed code
To:     KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 2:04 PM KP Singh <kpsingh@kernel.org> wrote:
> On Wed, Nov 16, 2022 at 6:55 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 16, 2022 at 8:41 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
> > > > On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> > > > > +{
> > > > > +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> > > > > +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> > > > > +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> > > > > +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> > > > > +               return false;
> > > > > +
> > > > > +       return true;
> > > > > +}
> > > > > +
> > > > >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> > > > >   * function where a BPF program can be attached.
> > > > >   */
> > > > > @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
> > > > >  #include <linux/lsm_hook_defs.h>
> > > > >  #undef LSM_HOOK
> > > > >
> > > > > +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> > > > > +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> > > > > +{                                              \
> > > > > +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> > > > > +}
> > > > > +
> > > > > +#include <linux/lsm_hook_defs.h>
> > > > > +#undef LSM_HOOK
> > > > > +
> > > >
> > > > because lsm hooks is mess of undocumented return values your
> > > > "solution" is to add hundreds of noninline functions
> > > > and hack the call into them in JITs ?!
> > >
> > > I revisited the documentation and checked each LSM hook one by one.
> > > Hopefully, I completed it correctly, but I would review again (others
> > > are also welcome to do it).
> > >
> > > Not sure if there is a more efficient way. Do you have any idea?
> > > Maybe we find a way to use only one check function (by reusing the
> > > address of the attachment point?).
> > >
> > > Regarding the JIT approach, I didn't find a reliable solution for using
> > > just the verifier. As I wrote to you, there could be the case where the
> > > range can include positive values, despite the possible return values
> > > are zero and -EACCES.
> >
> > Didn't you find that there are only 12 or so odd return cases.
> > Maybe refactor some of them to something that the verifier can enforce
> > and denylist the rest ?
>
> +1

I'm not sure we want to refactor the LSM hooks right now, we've got
too much stuff in-progress which I consider higher value/priority.
While I'm generally in favor of improving the sanity of interfaces,
I'd much rather we resolve the IMA/EVM special cases and land the
stacking changes before we start playing with refactoring the hooks.
I know this is a bummer for the BPF folks, but the IMA/EVM and
stacking patches affect everybody.

-- 
paul-moore.com
