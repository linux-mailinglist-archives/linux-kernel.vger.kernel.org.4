Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65468E86D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBHGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBHGkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:40:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B516AD0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:40:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x40so25679104lfu.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 22:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rioQaHBJKgU5h2wt1ICSVdRiaXNLiRM7oRrhkkGAa5c=;
        b=isCFkc5u2uP2ClQCHSVxO+0KSCLP+cRrVZ52mMTmEbBq20Ijdy+nFlkUtWzi8WnCCT
         m0PyotMq0LIE7d9S1ePfQpOzGMQhEBLiWu1NIyq+GdbVF2xXwO7FRWkJcbnIV8mE2EQ2
         ebyK3MvjgII3onh9IHYOEUj4JBla6YzV3A/YB+P7bK6W2l5ar71HcPevB1NbAVlKvZCX
         jfFvrFygrMqIbxwaJ6TnpeMgDJQrYxWwvrTdF/taQgwy74UqwOfW1dstAJJ02PsbqszU
         tOMhn7vpAqrBvp5NKL0tM/MiqR0lKZYu7j6e0vrOBWbS76UlATnUw3DGi0p1QS5ZP01y
         g0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rioQaHBJKgU5h2wt1ICSVdRiaXNLiRM7oRrhkkGAa5c=;
        b=DDhYyAcLMXFz02ruAaau8W6KwzfYGS93u5XSc3uDjC16byuP6BtUdKE1K3Trq5fQ1u
         Ab+gT2ruozD/NPx3YvAuqbYFED6gllWclqVUuxV0ukLG0nmBT8sss+b1fv4A+8qOS/SS
         PAK9pQNhDuYYguXIg7jCYl4Ib6RGjN4c8Ojrnt2dPFecs5lN6R8QAA2BvvJi6ftF5EH3
         cwpet6RkmbiFIPEW18omvr6gsrmyfARwBAYYtZQHvF5EwTETleb77utt6hM/hCFtpkiJ
         aDg2prjagjFG2vIzk2/DDHkKKVIVcnx1NJ9Y9ZHllMHrMJmauOe+ykr12JRi1o3Mhg8S
         0Kqg==
X-Gm-Message-State: AO0yUKVDd2MCLa52bRMUrdhdOwvMmcu3StslpNAcaZrYG6CeQrtU5hRW
        NFr+YHKze5c3FHRVfQIb6dl1HjuRCnjk8xNDah0mDqzhaTc8FhSG
X-Google-Smtp-Source: AK7set/mqzkeoYr53Z7E6apC4zDRNLOyfSapa311XsyR+Gg5X+L4H2y1ooOKo08B740E4Ed6TWRdf9iF3s4MyaKiZgI=
X-Received: by 2002:ac2:5504:0:b0:4d8:5895:a6fd with SMTP id
 j4-20020ac25504000000b004d85895a6fdmr727477lfk.273.1675838408910; Tue, 07 Feb
 2023 22:40:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675734681.git.chenfeiyang@loongson.cn> <2d77fe4e895847ae1ea09088dcfa411ce2f57f5f.1675734681.git.chenfeiyang@loongson.cn>
 <Y+Mc37ACt0PUBRAQ@1wt.eu> <20230208043440.GA3164268@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230208043440.GA3164268@paulmck-ThinkPad-P17-Gen-1>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Wed, 8 Feb 2023 14:39:57 +0800
Message-ID: <CACWXhK=Jk+FsJ50mc2KFkFYMb9P1BXGv1D4dR=_M1gymqREpiA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/nolibc: Add support for LoongArch
To:     paulmck@kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Feiyang Chen <chenfeiyang@loongson.cn>,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arnd@arndb.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 12:34, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Feb 08, 2023 at 04:54:07AM +0100, Willy Tarreau wrote:
> > On Tue, Feb 07, 2023 at 10:09:42AM +0800, chris.chenfeiyang@gmail.com wrote:
> > > From: Feiyang Chen <chenfeiyang@loongson.cn>
> > >
> > > Add support for LoongArch (64 bit) to nolibc selftest.
> >
> > Please also mention in this one that the makefile was reindented with
> > no other change than adding entries for loongarch, this will save
> > those reading this patch later from checking that the rest was not
> > changed.
>
> I like Willy's suggestion, but even better would be to put the whitespace
> changes into one commit, and the code changes into another commit.
> This makes it a lot easier for reviewers and future nolibc developers
> to quickly and easily see exactly what changed.
>

Hi, Willy, Paul,

I get it now, thank you.

> And one of those future nolibc maintainers just might be you!  ;-)
>
>                                                         Thanx, Paul

Thanks,
Feiyang
