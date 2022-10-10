Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6835F973F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 05:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJJDtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 23:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJJDt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 23:49:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773D73DF2C;
        Sun,  9 Oct 2022 20:49:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso4213078pja.5;
        Sun, 09 Oct 2022 20:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5uwdgwryFHFJzjWiH++bUzGyJn8a2qBYOFkqPQdUjA=;
        b=JiFdjcQkZ722P7s3iZCsJihWdE0H8Hb1Xp9mToLMy6UTMLVa1tCTeAPRwv7fmvPIq+
         8rvkFwCUxFcrDK+3fTfvaFaZAMEyltqjrDVz/PytWUer59eQV1Yyqgh50XgVXauL7Vog
         oGJr3dns0VUrublr5DdF0JtWb3Ga6TwT8XaZFY25dQ9QbyH1CVyrfzOBtJ3dDtFi+6bM
         4FaBnTDKc+z1tQ7omh/CnHGX6k/xaRAexHIyAFJH6zA+2/22JywqrL2DD4ZlGMSFimKp
         eCkRhSDSC5gVtOsYw2u/w2UPJ3VttbeIgjRY1oFln+qveMnci4poe3khwXzntilyOBUx
         hiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5uwdgwryFHFJzjWiH++bUzGyJn8a2qBYOFkqPQdUjA=;
        b=45XozZTSMTEGkmOhU8g7c2tFeJQx5G/A8ipc9WJu8r8Y1jW8NMClXXeJ22mNWDuBaB
         gR0xLLD8tG/hsPVmQHu/xqjUhu/CU/utendLtFacxwGytYiIa2iZm5/0WvQMXdpYI6j/
         tY7Tj7VsIPx5o3H1b5biuaoT8HlSYo0OWM5e3HCZ+YF44tWZXHapzH3K6ruc4tj5ONqw
         BCTl01tp38E3fvI81ZL4M9iraDbC3jztPJ9gVGKNC3Ech4/kML9zwVlAU6H1v7tx6PVg
         SGDxQbli+EK9eTCsft7AVJf938wT2Ynl6Z5M+LBOUB3lmt8obOAWlQhtHeuRCpP2ZIE0
         b/vA==
X-Gm-Message-State: ACrzQf3zcXVxzp72o6a1BsbtYWYwzSMm2OSzFaI96Fty6gW2nWyceUoq
        uTF5fsV9MhHuYy72ivtPZgI=
X-Google-Smtp-Source: AMsMyM7lHoI8Gy9V6tXanpM85kqRN40SxwDXKwUvcHAfUndnPhZXWSUKGr0roRcIdSUSsDrQ3lEemQ==
X-Received: by 2002:a17:902:7084:b0:181:5304:fef4 with SMTP id z4-20020a170902708400b001815304fef4mr8742887plk.57.1665373764964;
        Sun, 09 Oct 2022 20:49:24 -0700 (PDT)
Received: from localhost ([118.208.156.99])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001788ccecbf5sm5468419plf.31.2022.10.09.20.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 20:49:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 10 Oct 2022 13:49:18 +1000
Message-Id: <CNHXQ6R5IEHG.1D2WH96LGUA1I@bobo>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Zhouyi Zhou" <zhouzhouyi@gmail.com>
Cc:     <mpe@ellerman.id.au>, <christophe.leroy@csgroup.eu>,
        <atrajeev@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <lance@osuosl.org>,
        <paulmck@kernel.org>, <rcu@vger.kernel.org>
Subject: Re: [PATCH linux-next][RFC] powerpc: avoid lockdep when we are
 offline
X-Mailer: aerc 0.11.0
References: <20220927014823.11439-1-zhouzhouyi@gmail.com>
 <CN6WCMKCWHOG.LT2QV3910UJ2@bobo>
 <CAABZP2wYcNXkTo=tgX-ARziwgD2rng+-wCZ-qfQ6M30+vmLEug@mail.gmail.com>
 <CN7OZ6TMLLFS.2HER50Q3SO480@bobo>
 <CAABZP2xu5w9Ec8LmTUrF31KhY3HCcBjQYSk4xo14bdB9mxOz+A@mail.gmail.com>
In-Reply-To: <CAABZP2xu5w9Ec8LmTUrF31KhY3HCcBjQYSk4xo14bdB9mxOz+A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 29, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> On Wed, Sep 28, 2022 at 10:51 AM Nicholas Piggin <npiggin@gmail.com> wrot=
e:
> >
> > On Wed Sep 28, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > > Thank Nick for reviewing my patch
> > >
> > > On Tue, Sep 27, 2022 at 12:25 PM Nicholas Piggin <npiggin@gmail.com> =
wrote:
> > > >
> > > > On Tue Sep 27, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > > > > This is second version of my fix to PPC's  "WARNING: suspicious R=
CU usage",
> > > > > I improved my fix under Paul E. McKenney's guidance:
> > > > > Link: https://lore.kernel.org/lkml/20220914021528.15946-1-zhouzho=
uyi@gmail.com/T/
> > > > >
> > > > > During the cpu offlining, the sub functions of xive_teardown_cpu =
will
> > > > > call __lock_acquire when CONFIG_LOCKDEP=3Dy. The latter function =
will
> > > > > travel RCU protected list, so "WARNING: suspicious RCU usage" wil=
l be
> > > > > triggered.
> > > > >
> > > > > Avoid lockdep when we are offline.
> > > >
> > > > I don't see how this is safe. If RCU is no longer watching the CPU =
then
> > > > the memory it is accessing here could be concurrently freed. I thin=
k the
> > > > warning is valid.
> > > Agree
> > > >
> > > > powerpc's problem is that cpuhp_report_idle_dead() is called before
> > > > arch_cpu_idle_dead(), so it must not rely on any RCU protection the=
re.
> > > > I would say xive cleanup just needs to be done earlier. I wonder wh=
y it
> > > > is not done in __cpu_disable or thereabouts, that's where the inter=
rupt
> > > > controller is supposed to be stopped.
> > > Yes, I learn flowing events sequence from kgdb debugging
> > > __cpu_disable -> pseries_cpu_disable -> set_cpu_online(cpu, false)  =
=3D
> > > leads to =3D>  do_idle: if (cpu_is_offline(cpu) -> arch_cpu_idle_dead
> > > so xive cleanup should be done in pseries_cpu_disable.
> >
> > It's a good catch and a reasonable approach to the problem.
> Thank Nick for your encouragement ;-)
> >
> > > But as a beginner, I afraid that I am incompetent to do above
> > > sophisticated work without error although I am very like to,
> > > Could any expert do this for us?
> >
> > This will be difficult for anybody, it's tricky code. I'm not an
> > expert at it.
> >
> > It looks like the interrupt controller disable split has been there
> > since long before xive. I would try just move them together than see
> > if that works.
> Yes, I use "git blame" (I learned "git blame" from Paul E. McKenny ;-)
> ) to see the same.
> and anticipate your great works!

I was thinking you could try it and see if it works and what you find.
If you are interested and have time to look into it?

Thanks,
Nick
