Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155071F773
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjFBBCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFBBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:02:14 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAF19F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:02:07 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19a13476ffeso1717964fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685667726; x=1688259726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o3/2D9pqXQu0Kja08e1hU2rc3ztUxCY4Eps47VldFo=;
        b=KNkEPCsbkJxvJYdvTrUPo8kiFxyN3E0oTIVRNgXzBZ+/0ECQSM+jKwqtWrysFcjw6a
         DZyYom+T006pCCnXmWAqmmb2A5pJTinU18kAUM5QVhz+0QwucHpSGiqUt7p4K5CTp65m
         4/0oyu60fV247yyWntwJKLXfavATpkxPNIOeA9vbm7Wxr6sVcttB9XTUAb9aZebN9FK3
         Y8G09YaYrtHFLmhTVtOijFcYZkKUNBmR+hco1cQ/uP9eEQDxdmofwDaCkTgocKzFRW5Y
         ux4AIt4qlQGTwUnnRMG+GYwJ5Ssnwib6KYmA6fZphSCC2wT60LGkHKkIaq7Fn143dD5r
         X8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685667726; x=1688259726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o3/2D9pqXQu0Kja08e1hU2rc3ztUxCY4Eps47VldFo=;
        b=hTHrHKjFK+YIgK29VZyCmGJRfSRruiFO17f7GBBPZSwZVvserCaVJScsSfDWDevOSi
         tB7Zv+dPYOaeLx8vn9Bqqdtn0CcP32sEZlgOv/eF9ezlDzZYKo94ktWCmOUjDg/160Dq
         i4JBNRngw2JzXLZK85nNFn+6XhMD5sm8yhwKXVpl1WVypLajpVgTa8tAq+Ii+YnmwakB
         LKFsRcFjK6Zq88aVL2BqncLf2ieuo9MACg1J6OgFfFEmglvCC5HxSH/uLTVaKXdTJrU0
         YekaUXfV+FRw5ocWNYjPhUFAK2cVF1VdkiYohIliEfa8rGTY6jm49nHMLSwGsOCIKzsV
         8F2A==
X-Gm-Message-State: AC+VfDysAIKSpliUB2ODfpovnSi6Tl1tTezx9NgP5uVlMEtYtI/r14BX
        KrdlTrnfcuYn9ZQ2XtVrcNOiO0+uH+wEJMVk6gZIiUO/6OyRk3A=
X-Google-Smtp-Source: ACHHUZ6BFLtcpI/8pyU4ctzfJ+V7wPvO8tH2XND3faYj8YEVhBvhnKC7TofGwk7sr16sLm3J/vAdhLUnJrx8pfgPRGI=
X-Received: by 2002:a05:6870:3491:b0:19f:6711:8dfc with SMTP id
 n17-20020a056870349100b0019f67118dfcmr629339oah.31.1685667726423; Thu, 01 Jun
 2023 18:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <168547265011.24337.4306067683997517082-0@git.sr.ht>
 <CAHC9VhQhBBPyZE24LM6KvYrET2huW-W_YYsyPndpNkn70Mu3Ug@mail.gmail.com> <87fs7abu0f.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87fs7abu0f.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 21:01:55 -0400
Message-ID: <CAHC9VhRk3WhXh-GTDSKFW3PujXiQCDy3xk4Xb9_Lo4szgQ5G6Q@mail.gmail.com>
Subject: Re: [PATCH linux 0/3] [PATCH] userns: add sysctl "kernel.userns_group_range"
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "~akihirosuda" <suda.kyoto@gmail.com>,
        linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 8:14=E2=80=AFPM Eric W. Biederman <ebiederm@xmission=
.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, May 30, 2023 at 2:50=E2=80=AFPM ~akihirosuda <akihirosuda@git.s=
r.ht> wrote:
> >>
> >> This sysctl limits groups who can create a new userns without
> >> CAP_SYS_ADMIN in the current userns, so as to mitigate potential kerne=
l
> >> vulnerabilities around userns.
> >>
> >> The sysctl value format is same as "net.ipv4.ping_group_range".
> >>
> >> To disable creating new unprivileged userns, set the sysctl value to "=
1
> >> 0" in the initial userns.
> >>
> >> To allow everyone to create new userns, set the sysctl value to "0
> >> 4294967294". This is the default value.
> >>
> >> This sysctl replaces "kernel.unprivileged_userns_clone" that is found =
in
> >> Ubuntu [1] and Debian GNU/Linux.
> >>
> >> Link: https://git.launchpad.net/~ubuntu-
> >> kernel/ubuntu/+source/linux/+git/jammy/commit?id=3D3422764 [1]
> >
> > Given the challenges around adding access controls to userns
> > operations, have you considered using the LSM support that was added
> > upstream last year?  The relevant LSM hook can be found in commit
> > 7cd4c5c2101c ("security, lsm: Introduce security_create_user_ns()"),
>
> Paul how have you handled the real world regression I reported against
> chromium?

I don't track chromium development.

> Paul are you aware that the LSM hook can not be used to achieve the
> objective of this patchset?

/me shrugs

I thought one could look into a cred struct using a BPF LSM, which
would allow one to make access control decisions based on group ID,
but I will be the first to admit I'm not a BPF LSM expert.
Regardless, one could introduce a group ID check into a LSM if they
were so inclined.

I also find it slightly amusing that you are arguing against my reply
that was discussing *not* adding another userns control point; of all
people I thought you would be supportive of this ... /me shrugs again.

> > and although only SELinux currently provides an access control
> > implementation, there is no reason you couldn't add support for your
> > favorite LSM, or even just a simple BPF LSM to enforce the group
> > controls as you've described them here.
>
> Is there a publicly available SELinux policy that uses that LSM hook?

I have no idea, I don't track all of the publicly available SELinux
policies because frankly it doesn't matter; the SELinux feature
exists, and it is my role to support and maintain it.  There are
LSM/SELinux features which are not widely exercised in general purpose
SELinux policies for various reasons, but *are* used in specialized
environments that are not often discussed on public mailing lists.

--=20
paul-moore.com
