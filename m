Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8417417E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjF1SSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1SSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:18:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0D1BC3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:18:35 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-c13280dfb09so33413276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687976314; x=1690568314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K9OS0zmztPbtY0PgdFfjCYBxDyy7aJx/bjVFEWW/zU=;
        b=581WkyNE3unzDgNYmmnMuhz9DPFGMaDG8zfvPvFTpQuAjINSYngeXP4UhZ8hqBx/+c
         FBq81FPsrzb47Zp3QB5HxpqS/oR1q15toQie6f+Vk5+LsWUiWzMadgauzQZ/ucTi65pA
         1UjENO+Fktt/FHXzaN01E1DE/M4GNO9pF3vMgdQzGFEm8O+RAgajutwOe3j5gLL8EW6q
         mMLClQugPV3+9irnbY9yyK+g8uInwDPPlISGXw2oaVrq9ojyIqPqeFuAl6tZpedC0Q4Z
         1l6ivjmficvNIra9S7wCin0ish9T9cq9as4OitA+p68B+VyO4uNW1/ZY7rn7UfMxQa+5
         HLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687976314; x=1690568314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K9OS0zmztPbtY0PgdFfjCYBxDyy7aJx/bjVFEWW/zU=;
        b=Za96AN0kWUi4dJgVaAvz7o9xFL9SOCmXQ5OomQxImBxOBRqHZpEYxXVNO+dxbkWoaU
         BTL2GBkU0pCRjwsvQ2t5hqxn3idtK+y/eVh28UoasIlX+VyMzn97xbyxjxTSKVqjImRr
         GgEICOhv6Q3y/ppeP/u24Vgr0IWsEgiGWvg+WjiU6iTNrfPwSc/ZOUlHWD3L3hRj+jbo
         OfASw7X8NiedwC5N8oQZDjCJw6omLYcDpfwA8gT2i/xjpZdWXflukxOkGaWhvbgu1fwv
         HaPRbgEpC3mxX5lW4UbxFTm3rRZJtbeUMOdZk7YZR3kwQGOeZniWJUYao+ChzOk7InAD
         XlLQ==
X-Gm-Message-State: AC+VfDwuE/ZnPLxxl4Yzcyt822O59cA9QcRTbi/Hf+Kwk+8FzMLOu1r2
        wVHgkkJx5cRkTGBSMhuuojTDljT50kNvnbaxU6wRSQ==
X-Google-Smtp-Source: ACHHUZ79l9ad3gdBVQUaVc8lzXfc9b5dm4VBH1fcUbHp2JNq0nr0Ghsfo6MDVCUkDHm48YsLbKxPx5Hi//4io1YwUGg=
X-Received: by 2002:a25:2f8f:0:b0:c1a:5904:fe8e with SMTP id
 v137-20020a252f8f000000b00c1a5904fe8emr10924745ybv.34.1687976314500; Wed, 28
 Jun 2023 11:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org> <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner> <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner> <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner> <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
In-Reply-To: <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 11:18:20 -0700
Message-ID: <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:02=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Jun 28, 2023 at 07:35:20PM +0200, Christian Brauner wrote:
> > > To summarize my understanding of your proposal, you suggest adding ne=
w
> > > kernfs_ops for the case you marked (1) and change ->release() to do
> > > only (2). Please correct me if I misunderstood. Greg, Tejun, WDYT?
> >
> > Yes. I can't claim to know all the intricate implementation details of
> > kernfs ofc but this seems sane to me.
>
> This is going to be massively confusing for vast majority of kernfs users=
.
> The contract kernfs provides is that you can tell kernfs that you want ou=
t
> and then you can do so synchronously in a finite amount of time (you stil=
l
> have to wait for in-flight operations to finish but that's under your
> control). Adding an operation which outlives that contract as something
> usual to use is guaranteed to lead to obscure future crnashes. For a
> temporary fix, it's fine as long as it's marked clearly but please don't
> make it something seemingly widely useable.
>
> We have a long history of modules causing crashes because of this. The
> severing semantics is not there just for fun.

I'm sure there are reasons things are working as they do today. Sounds
like we can't change the ->release() logic from what it is today...
Then the question is how do we fix this case needing to release a
resource which can be released only when there are no users of the
file? My original suggestion was to add a kernfs_ops operation which
would indicate there are no more users but that seems to be confusing.
Are there better ways to fix this issue?
Thanks,
Suren.

>
> Thanks.
>
> --
> tejun
