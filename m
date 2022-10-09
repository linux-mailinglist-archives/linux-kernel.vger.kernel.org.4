Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1960E5F9764
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJJEZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJJEZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:25:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9D42AEA;
        Sun,  9 Oct 2022 21:25:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id l4so9340110plb.8;
        Sun, 09 Oct 2022 21:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vAH4rya06AUuc9cGIVqpG9iUHugeEm5tYJ/niYtbVRY=;
        b=MLxVgjqoSNusMoE1FuWBp1q556Q//9g3yq35wJGCKcTbRZz58TywpUOayoe9r+tXBw
         6h2JKPPCtaG41E6WtcFxo2hexOQFb3i/eS968uKnerE9TPzv1J6xW28Y93kuTCpIV3he
         nrTiA91WghpRf0uEuHTfpYggCKaaZh9iq0mHIqQu9S3xs8wRCA0mRVPiFPCcZzu3c2ug
         9idRwLBqTgyNVhSh9lrTU5BuxcqVFJdYKE/PGpRorh0rgG457xKEDiPt121LjCcQ1lhw
         HO7ptOLO/EAQKfoH9Z8Mcl9k+522j0CFRDVsWPSMnPGA7UkRUnhZ4O9HDdzVxpu6/mEp
         JhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAH4rya06AUuc9cGIVqpG9iUHugeEm5tYJ/niYtbVRY=;
        b=6cz8ISoGtNiUz0okpsOtMtwpfjAiapEH0sIjH8sLdojEcANmOZnPrEAARAJ9cEkZVp
         eULaTvI64moYve1LR13Px/n0thxv47YLMpxU71JfYiplCW5p65hhmgxmrH/tumuZRqPq
         B7buLJDoUmpvWfKV21gbHIO/vl/7UknFFhi/vjeIvxU9ZiXy/GpKTy5R748MJenluB/m
         rtcCckfKhY4qVkBRIhmVZS5L33iGmEpG4cSii/tVaP3xaJnapO0wb3BfaG34DgVaeu3S
         6+MxAPWuB+Sws0pmaxBxyVbqzipxel+tD79pRhlKCzfgCrsyjFaBvp65QmgFtHG5bA07
         WbVw==
X-Gm-Message-State: ACrzQf2Q3ATkZMzAxQgCWJ5sDqFc6ueyxF31iMaiTsNfDDdyRG9DlysZ
        ZtKHlWqoTjwG/95Klr/AFWI9t4eHPYvHiX/38+4=
X-Google-Smtp-Source: AMsMyM791DUqNXcf3i6ujvTKOJ/C4se8A3QyfbOhaEpB1pPQTDWb2jlQTE2LK/9Ih+qgalZofJvsvIMoB4YHVRaVP/g=
X-Received: by 2002:a17:90a:7305:b0:20a:6ffd:1f8e with SMTP id
 m5-20020a17090a730500b0020a6ffd1f8emr29173215pjk.69.1665375928676; Sun, 09
 Oct 2022 21:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220927014823.11439-1-zhouzhouyi@gmail.com> <CN6WCMKCWHOG.LT2QV3910UJ2@bobo>
 <CAABZP2wYcNXkTo=tgX-ARziwgD2rng+-wCZ-qfQ6M30+vmLEug@mail.gmail.com>
 <CN7OZ6TMLLFS.2HER50Q3SO480@bobo> <CAABZP2xu5w9Ec8LmTUrF31KhY3HCcBjQYSk4xo14bdB9mxOz+A@mail.gmail.com>
 <CNHXQ6R5IEHG.1D2WH96LGUA1I@bobo>
In-Reply-To: <CNHXQ6R5IEHG.1D2WH96LGUA1I@bobo>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 10 Oct 2022 04:25:17 +0800
Message-ID: <CAABZP2x7bc=fzEobjthMYYQcS2DsPtnyg0-rZLwVb-tYn0YDiw@mail.gmail.com>
Subject: Re: [PATCH linux-next][RFC] powerpc: avoid lockdep when we are offline
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On Thu Sep 29, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > On Wed, Sep 28, 2022 at 10:51 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On Wed Sep 28, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > > > Thank Nick for reviewing my patch
> > > >
> > > > On Tue, Sep 27, 2022 at 12:25 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > >
> > > > > On Tue Sep 27, 2022 at 11:48 AM AEST, Zhouyi Zhou wrote:
> > > > > > This is second version of my fix to PPC's  "WARNING: suspicious RCU usage",
> > > > > > I improved my fix under Paul E. McKenney's guidance:
> > > > > > Link: https://lore.kernel.org/lkml/20220914021528.15946-1-zhouzhouyi@gmail.com/T/
> > > > > >
> > > > > > During the cpu offlining, the sub functions of xive_teardown_cpu will
> > > > > > call __lock_acquire when CONFIG_LOCKDEP=y. The latter function will
> > > > > > travel RCU protected list, so "WARNING: suspicious RCU usage" will be
> > > > > > triggered.
> > > > > >
> > > > > > Avoid lockdep when we are offline.
> > > > >
> > > > > I don't see how this is safe. If RCU is no longer watching the CPU then
> > > > > the memory it is accessing here could be concurrently freed. I think the
> > > > > warning is valid.
> > > > Agree
> > > > >
> > > > > powerpc's problem is that cpuhp_report_idle_dead() is called before
> > > > > arch_cpu_idle_dead(), so it must not rely on any RCU protection there.
> > > > > I would say xive cleanup just needs to be done earlier. I wonder why it
> > > > > is not done in __cpu_disable or thereabouts, that's where the interrupt
> > > > > controller is supposed to be stopped.
> > > > Yes, I learn flowing events sequence from kgdb debugging
> > > > __cpu_disable -> pseries_cpu_disable -> set_cpu_online(cpu, false)  =
> > > > leads to =>  do_idle: if (cpu_is_offline(cpu) -> arch_cpu_idle_dead
> > > > so xive cleanup should be done in pseries_cpu_disable.
> > >
> > > It's a good catch and a reasonable approach to the problem.
> > Thank Nick for your encouragement ;-)
> > >
> > > > But as a beginner, I afraid that I am incompetent to do above
> > > > sophisticated work without error although I am very like to,
> > > > Could any expert do this for us?
> > >
> > > This will be difficult for anybody, it's tricky code. I'm not an
> > > expert at it.
> > >
> > > It looks like the interrupt controller disable split has been there
> > > since long before xive. I would try just move them together than see
> > > if that works.
> > Yes, I use "git blame" (I learned "git blame" from Paul E. McKenny ;-)
> > ) to see the same.
> > and anticipate your great works!
>
> I was thinking you could try it and see if it works and what you find.
> If you are interested and have time to look into it?
I am interested! and I have time ;-)
Thank Nick for your trust in me!
I am going to submit my babyish work in about a month (counting the
rcutoture tests time), and thank you in advance for your patience.

Cheers
Zhouyi
>
> Thanks,
> Nick
