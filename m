Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE762CD51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiKPWEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKPWES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:04:18 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14010657C9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:04:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w23so11284344ply.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC1O7rMTvmBYyn1/bWjYQvHGFZmpsPJOUhWzFJ+UDKE=;
        b=cU1BpRMccZjJWvhPtm4flkwG+K3w6bc1YRQscCaPiee03eI4FDk3Fo3AgHmFQyDtT4
         ec26P+NTHvD1Ip1nMyiSiaj/XicJI5pgds9PrvbUr+tLRLNZwpp0ozW+CYxq3xz7qVCQ
         lejMBtbs0AWGr3ApmLrjOFhxxTWjWvnfDPZCUyRyODysJNjbu/9zCAQR5bquDHfbnKHh
         m+Ht5F9u7ozOEuN012dNaZ+CxCMRNQ3a8IAHI7QQ+KXUKLdbfDNb3/08okbxXRe1uDz2
         IjS2PqgibVExxo7c2jeXgdgkHsI/vMNQ3z95d524hFGRBaTWye8XUkFoyy6GDQimGEdV
         qbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC1O7rMTvmBYyn1/bWjYQvHGFZmpsPJOUhWzFJ+UDKE=;
        b=2WE1W99LE96rBxD+6UEWRxl6oLNUTOhewysHrA/yTYiPh/kGGhu3qH2MJ2DRAkZlot
         smtfXTJRNK5nM2TGjnU/BI3/2++h1967Q4A4dYCPtgWQEM+DhUHaOBT3om1oEmd6xT4i
         lS1EUGs2PfKvqtjvco2+eCjT0km3udzX9SH+IntH/srV2c++qvmqZoTh+MJVRI5lrpJZ
         WGb54RS7ULAjacX/Bh3TG6a455QXzdcrJWXt2fq2bfL28xLLK4Da0jdi+fWXO40hctHz
         5XYc4qpffwoJwWrkudFBzqv6Srola95tPdSWpiikzwZKa1RPNGFpv0O1BF4XilOpCC0K
         T7xg==
X-Gm-Message-State: ANoB5pl1xXZIZUvRdbM670UtZikiT97JtTzZYWTNdDJYdT1YSJPvzEfV
        phefky9570+9iKVOnUlE6xkWNKgnlvCfJC+pUkvOuFVviw==
X-Google-Smtp-Source: AA0mqf5oXxU0ECvnjTunMRmFWA1TxmhY0Ow0+3ziM4fHMNKpMBbH7TE9PAAThMh3ftz2zdNo1g0IW0mEOYT4tG7RXWc=
X-Received: by 2002:a17:90a:4596:b0:1fd:5b5d:f09d with SMTP id
 v22-20020a17090a459600b001fd5b5df09dmr5820235pjg.69.1668636256527; Wed, 16
 Nov 2022 14:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-4-roberto.sassu@huaweicloud.com> <CAHC9VhTA7SgFnTFGNxOGW38WSkWu7GSizBmNz=TuazUR4R_jUg@mail.gmail.com>
 <83cbff40f16a46e733a877d499b904cdf06949b6.camel@huaweicloud.com>
In-Reply-To: <83cbff40f16a46e733a877d499b904cdf06949b6.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 17:04:05 -0500
Message-ID: <CAHC9VhRX0J8Z61_fH9T5O1ZpRQWSppQekxP8unJqStHuTwQkLQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/4] lsm: Redefine LSM_HOOK() macro to add return
 value flags as argument
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, revest@chromium.org,
        jackmanb@chromium.org, jmorris@namei.org, serge@hallyn.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 3:11 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Tue, 2022-11-15 at 21:27 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:58 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Define four return value flags (LSM_RET_NEG, LSM_RET_ZERO, LSM_RET_ONE,
> > > LSM_RET_GT_ONE), one for each interval of interest (< 0, = 0, = 1, > 1).
> > >
> > > Redefine the LSM_HOOK() macro to add return value flags as argument, and
> > > set the correct flags for each LSM hook.
> > >
> > > Implementors of new LSM hooks should do the same as well.
> > >
> > > Cc: stable@vger.kernel.org # 5.7.x
> > > Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/bpf_lsm.h       |   2 +-
> > >  include/linux/lsm_hook_defs.h | 779 ++++++++++++++++++++--------------
> > >  include/linux/lsm_hooks.h     |   9 +-
> > >  kernel/bpf/bpf_lsm.c          |   5 +-
> > >  security/bpf/hooks.c          |   2 +-
> > >  security/security.c           |   4 +-
> > >  6 files changed, 466 insertions(+), 335 deletions(-)
> >
> > Just a quick note here that even if we wanted to do something like
> > this, it is absolutely not -stable kernel material.  No way.
>
> I was unsure about that. We need a proper fix for this issue that needs
> to be backported to some kernels. I saw this more like a dependency.
> But I agree with you that it would be unlikely that this patch is
> applied to stable kernels.
>
> For stable kernels, what it would be the proper way? We still need to
> maintain an allow list of functions that allow a positive return value,
> at least. Should it be in the eBPF code only?

Ideally the fix for -stable is the same as what is done for Linus'
kernel (ignoring backport fuzzing), so I would wait and see how that
ends up first.  However, if the patchset for Linus' tree is
particularly large and touches a lot of code, you may need to work on
something a bit more targeted to the specific problem.  I tend to be
more conservative than most kernel devs when it comes to -stable
patches, but if you can't backport the main upstream patchset, smaller
(both in terms of impact and lines changed) is almost always better.

-- 
paul-moore.com
