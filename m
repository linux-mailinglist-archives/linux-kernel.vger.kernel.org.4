Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F5B6A9357
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCCJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCCJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:04:44 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC60231D3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:04:21 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id o6so1740617vsq.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz00Tqp2vtUy2svpLhqgrc/9lCdlqQYI0Iiyegg93jE=;
        b=CPHtp3vSrP26nALKHfQarED/kNETYNYUQLVL0PuetjPrAthBn7Olz9gyYat9XJ/Jbc
         uAqr5Q7NLdlz/6jnOJVPClXlOXQbDviCx0F+kz/x33pq/CXVGVylQGw6fOSmZk0nfpzy
         m8ISNfilFU1VM2OH4H97LLa9J007eW0otluW1FX92zhrenCzENHK77Nfg72xLps4N/Gl
         VTMVO+DpRHFMw+/Q1DfPq2YNddgxV+xRsrv/BL6PH+tg+WYErXo6SNVNs3OWtMQ1eVpg
         iZUvflKKGakgtBkgo970lb6MLsxBbs/QGM408DHoY+zDfcWlF2iNiSWfcvQV6Cea5Hem
         STYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tz00Tqp2vtUy2svpLhqgrc/9lCdlqQYI0Iiyegg93jE=;
        b=EOuUzni1rqiKrvsYXmLOxj15kCCywXPcuMtI06JqmpU0V5hL2Kzw+oKq1rJimL0cCV
         wBn86dtYktCG0zQACuuWeL3+FA4RvIlQ4XNFWh4/hRJ1hus416Q+5VMFSyK5o6o+a86m
         0yqQj5u39zrrVPPJ9rZ5hBrK3wqa8/PnPgv/tZP+SFQ7sDT6+IveUfhe+Jcn8h9LPvTv
         I+DD64b1+rzwoBPlKbBMtELNJRnlHiiyl4taaidl39Fj61cINkbceuXa01PanOxXOic2
         /d5NVQLW69D1Q342R30jZ7tGdQMe9D4lFOOKgjdnYYm4yJml3Wq/9glrapIjkMIyavKd
         7uPw==
X-Gm-Message-State: AO0yUKUzr2jov5QShNGO60BC5O+0ion1r6fOV4i2AbjH8QnXctBAK0Gi
        7BAk/VifLT0mUofIXRnfRbA4JzHR9zjwvU7wrIlUjg==
X-Google-Smtp-Source: AK7set8xJnpf1kTF5ZChezlWGbocRssXwa0E/otBhr1eDuSz97X8AuHW4Z/rfCNxFvtBeZ3CbxcRQAot48c8dRuVFmg=
X-Received: by 2002:a67:cfc6:0:b0:402:999f:51dd with SMTP id
 h6-20020a67cfc6000000b00402999f51ddmr683904vsm.3.1677834256581; Fri, 03 Mar
 2023 01:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20230301180657.003689969@linuxfoundation.org> <CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com>
 <ZAB6pP3MNy152f+7@kroah.com> <CA+G9fYsHbQyQFp+vMnmFKDSQxrmj-VKsexWq-aayxgrY+0O7KQ@mail.gmail.com>
 <CA+G9fYsn+AhWTFA+ZJmfFsM71WGLPOFemZp_vhFMMLUcgcAXKg@mail.gmail.com> <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com>
In-Reply-To: <9586d0f99e27483b600d8eb3b5c6635b50905d82.camel@redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 3 Mar 2023 14:34:05 +0530
Message-ID: <CA+G9fYuLQEfeTjx52NxbXV5914YJQ2tVd8k4SJjrAryujPjnqA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/42] 6.1.15-rc1 review
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 13:34, Paolo Abeni <pabeni@redhat.com> wrote:
>
> Hello,
>
> On Fri, 2023-03-03 at 01:32 +0530, Naresh Kamboju wrote:
> > On Thu, 2 Mar 2023 at 16:30, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > On Thu, 2 Mar 2023 at 16:00, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Mar 02, 2023 at 03:49:31PM +0530, Naresh Kamboju wrote:
> > > > > On Wed, 1 Mar 2023 at 23:42, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > This is the start of the stable review cycle for the 6.1.15 release.
> > > > > > There are 42 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.15-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > Regression found on Linux version 6.1.15-rc1 on 32-bit arm x15 and i386.
> > > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > ## Build
> > > > > * kernel: 6.1.15-rc1
> > > > > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > > > > * git branch: linux-6.1.y
> > > > > * git commit: b6150251d4ddf8a80510c185d839631e252e6317
> > > > > * git describe: v6.1.14-43-gb6150251d4dd
> > > > > * test details:
> > > > > https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.14-43-gb6150251d4dd
> > > > >
> > > > > Regression test cases,
> > > > > i386:
> > > > > x15:
> > > > >   * kselftest-net-mptcp/net_mptcp_mptcp_sockopt_sh
> > > > >
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > >
> > > > > test log:
> > > > > ----------
> > > > >
> > > > > # selftests: net/mptcp: mptcp_sockopt.sh
> > >
> > > ....
> > >
> > > > Nit, wrapping a log like this makes it hard to read, don't you think?
> > >
> > > Me either.
> > > That is the reason I have shared "Assertion" above.
> > >
> > > >
> > > > > # mptcp_sockopt: mptcp_sockopt.c:353: do_getsockopt_tcp_info:
> > > > > Assertion `ti.d.size_user == sizeof(struct tcp_info)' failed.
> > > > > # server killed by signal 6
> > > > > #
> > > > > # FAIL: SOL_MPTCP getsockopt
> > > > > # PASS: TCP_INQ cmsg/ioctl -t tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -r tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> > > > > # PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp
> > > > > not ok 6 selftests: net/mptcp: mptcp_sockopt.sh # exit=1
> > > >
> > > > Any chance you can bisect?
> > >
> > > We are running our bisection scripts.
> >
> > We have tested with 6.1.14 kselftests source again and it passes.
> > Now that we have upgraded to 6.2.1 kselftests source, we find that
> > there is this problem reported. so, not a kernel regression.
>
> I read the above as you are running self-tests from 6.2.1 on top of an
> older (6.1) kernel. Is that correct?

correct.

> If so failures are expected;

Thanks for clarifying this.

> please use the self-tests and kernel from the same release.
>
> Otherwise, could you please re-phrase the above?
>
> Thanks,
>
> Paolo
>

- Naresh
