Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A053623A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiKJDSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKJDSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:18:05 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902462A95C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:18:04 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so101697oor.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui4nz+rk4+cy7iX09mK3SZJkU54S/hpyEMWrZ+RjI2M=;
        b=eC+RoKfhId/DMoP2yqdKWn4KQDV/bHSjRCDt/kWA5xOVi5nb2pPkI4mlgslo1JNknx
         Tbc3SQ7t4elqvdUA3nUUCKvQbTL7ks+AB1IJ5XhKa2/de9c1Udet2zrq/4jLZG7GTcyo
         qTJd5hnqSuyrRaevhIkhNKvsdvsYMK4tChfEz0tiplUuDiC5uC04CxKrOxSGi0hN2o+4
         CO0OjAnj9tnmtB5qAC9vFShPdrrfEgCzNnfwl/zNEBCkbuZ9vTypUAhuhzEGgjMN41/b
         UI8hKSlDuk0oJLzFvXx2H4VG88DRFWuETaRueen5S0NSNB5HmirGKvFdgsSm1yQjpbQW
         TSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui4nz+rk4+cy7iX09mK3SZJkU54S/hpyEMWrZ+RjI2M=;
        b=Za6A1pwa+xCpUpyoJrzjqeCpqIKqDHyZaKoVLoyVeqE4Jf3fnj97JFc5GeB7VSzr9h
         BJM2M5IynDjMKLaHpERr2dGNWmtAuYnLNKjgetMTKF91DjhTe4kypwEWBvarsR7LxTzf
         MaZRj1OcXqUZGwrRFGD6MCqoDqKx94Bfzjv1UPC9mfJdb31s1xMwNl97SNvSic2rOShd
         9lhfHDehalcFTTdhR5dj4dura2aMbU7T2TV60pIgcWNrzjlOqh59pWn+wGg4pss/e5fv
         EV52u9MTYSBNcTl2CJcrhm2e6sAkk3zQS+ynwFhKZskyGpYHbgsMqjcYO1XjnmC/l0Ft
         msgQ==
X-Gm-Message-State: ANoB5pnl5Qt9cyxA3FPd+fTGUAi6q5qVYgHkoEvNw1C8T30Y6oj6Qzvb
        2lxUAxmXY28krVbf/lIfxVyzWLa3/ciKdEygvwOO
X-Google-Smtp-Source: AA0mqf4jNyWHNPdiVFcHIrPF0+v2AoEgmnjHvVUr776+Z6yoxo2tMWAfX7sFLgPjynd2YPyaEA2X+YXWw2y/wJe591Q=
X-Received: by 2002:a4a:ca8f:0:b0:49e:f01a:feaf with SMTP id
 x15-20020a4aca8f000000b0049ef01afeafmr7560680ooq.81.1668050283850; Wed, 09
 Nov 2022 19:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-8-casey@schaufler-ca.com> <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
 <ea927e49-0099-df0a-d263-400782486b35@schaufler-ca.com>
In-Reply-To: <ea927e49-0099-df0a-d263-400782486b35@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 22:17:52 -0500
Message-ID: <CAHC9VhQMfAix=KqpWGNg_2cryBJHyiFTzURQ1YuD_0SY92ZHsA@mail.gmail.com>
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:35 PM, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call to report the list of Linux Security Modules
> >> that are active on the system. The list is provided as an array
> >> of LSM ID numbers.
> >>
> >> The calling application can use this list determine what LSM
> >> specific actions it might take. That might include chosing an
> >> output format, determining required privilege or bypassing
> >> security module specific behavior.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/syscalls.h |  1 +
> >>  kernel/sys_ni.c          |  1 +
> >>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 40 insertions(+)
> > ..
> >
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> index da0fab7065e2..cd5db370b974 100644
> >> --- a/security/lsm_syscalls.c
> >> +++ b/security/lsm_syscalls.c
> >> @@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
> >>         kfree(final);
> >>         return rc;
> >>  }
> >> +
> >> +/**
> >> + * lsm_module_list - Return a list of the active security modules
> >> + * @ids: the LSM module ids
> >> + * @size: size of @ids, updated on return
> >> + * @flags: reserved for future use, must be zero
> >> + *
> >> + * Returns a list of the active LSM ids. On success this function
> >> + * returns the number of @ids array elements. This value may be zero
> >> + * if there are no LSMs active. If @size is insufficient to contain
> >> + * the return data -E2BIG is returned and @size is set to the minimum
> >> + * required size. In all other cases a negative value indicating the
> >> + * error is returned.
> >> + */
> > Let's make a promise that for this syscall we will order the LSM IDs
> > in the array in the same order as which they are configured/executed.
>
> Sure. Order registered, which can vary, as opposed to LSM ID order,
> which cannot. That could be important to ensure that applications
> that enforce the same policy as the kernel will hit the checks in
> the same order as the kernel. That's how it is coded. It needs to
> be documented.

Yep.  One of the big reasons for documenting it this way is to ensure
that we define the order as part of the API.

-- 
paul-moore.com
