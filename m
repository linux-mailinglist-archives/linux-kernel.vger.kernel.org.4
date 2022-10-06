Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9745F61B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiJFHfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiJFHfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:35:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B6F80EBE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:35:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id p5so1208283ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BUgO7Gn6HVGXmIvVSi76EssaR+MnNtPNxr+txyIXJQI=;
        b=ccopRKBGo9bGpf/7iufPjWYVdlsKtPQ7zcUNqcMpcos9T5NHbPlWq8so7iDOTjaNOc
         gIaSTFP7h/69QrayDSV8SFeydowsRoHjIo92O6VRdL1KCLojN23RefRvJ6LqtzWf+dCj
         RFM8EU5FcEMdVgLsa34eD82/KqEoVY3cV8njtGdLuP4cnbsvtLUGbWkj4Ecvk+KldZ/k
         PgS6H8NeJRI1iP4BzXvsCzRLLxTlzvTJWpemhVHZSIo2l7VB1ZBZ1xoFxa3eXQmcYgeD
         zXukIzPEmyNz2IwFjjcrxB1TdCdtrjFWPUlZzy38nUj/vwxj3DUotH1vHRbgF5AV3Lly
         lPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUgO7Gn6HVGXmIvVSi76EssaR+MnNtPNxr+txyIXJQI=;
        b=2X9lFPhOsOemcWYZuagRbXA+Y4VJS3yY54DJM08YSQVnuBBrbeWZRFvCitRlDkH9+V
         hbNbT8kS+7FcoryuNYOk1b3e655uG3lmTu/+OtfrSgqx+DlZEaEA8OBPtiaNhldZnz2k
         RXP1Y/emIXM2B8X1WMWbsZGKb+wcj3zrva6RyTphuT1gv1GcPEo08Mg6gFC4SG5kgT1O
         6VhGrmmC2lUt6BoH/2OLZR7cDuz5WZ4r+Gs1kWiIvVk9x3l9bpvPrVu40pjZuOmUXwXM
         mSr2F+Kbzt8oDBzDf9Z3+usHJr6gmdrTRzcuwn3ubwdBrWmoURIx+1/bYEOrZK6gMqEU
         zW3g==
X-Gm-Message-State: ACrzQf1YMJyjna7UsAxvZPbUWFkmdhul1sq2jsWQ/jt++GDJiQYwnJMS
        8DhnoQoM80/3ODs8bnGbwG/GDE3ekuhiVPxzuifXkg==
X-Google-Smtp-Source: AMsMyM4hW2xJKBoRlc2CjuPTMUiKPvR3WrNG+dw1Puc4847yKNeOsQ4MiYWzDDCtoRb1aZSdVlc5KSjaHClf3nk+AJk=
X-Received: by 2002:a2e:b0e6:0:b0:26e:4dd:16f5 with SMTP id
 h6-20020a2eb0e6000000b0026e04dd16f5mr157970ljl.268.1665041731050; Thu, 06 Oct
 2022 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f2b07b05d5dc87cc@google.com> <00000000000093aefb05e9b93343@google.com>
 <CAD-N9QWpDpP5YGwq363Z1jDOeEK+S1JjNGmiZsD4KimZSkowgw@mail.gmail.com>
In-Reply-To: <CAD-N9QWpDpP5YGwq363Z1jDOeEK+S1JjNGmiZsD4KimZSkowgw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Oct 2022 09:35:19 +0200
Message-ID: <CACT4Y+ZYSO4u2VteN0C83AnyFyvD2afL7wyk2K_Ps9hhLtq38w@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>,
        dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
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

On Wed, 28 Sept 2022 at 11:23, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Wed, Sep 28, 2022 at 5:15 PM syzbot
> <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com> wrote:
> >
> > This bug is marked as fixed by commit:
> > fscache: fix GPF in fscache_free_cookie
> > But I can't find it in any tested tree for more than 90 days.
> > Is it a correct commit? Please update it by replying:
> > #syz fix: exact-commit-title
> > Until then the bug is still considered open and
> > new crashes with the same signature are ignored.
>
> @Dmitry Vyukov Why syzbot continuously complains about this bug
> report? The fix commit looks correct.


git log --grep "fscache: fix GPF in fscache_free_cookie"
on the latest upstream tree gives me nothing.

Where is this commit present? What's the git tree and commit hash?
