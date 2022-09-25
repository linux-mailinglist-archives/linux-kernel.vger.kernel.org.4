Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78D25E94F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiIYRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiIYRew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:34:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3726320
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:34:50 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e187so5774578ybh.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=n9PlaQOOKzBXBufnbzlBXwI7lSGQ9ax7LkG3qVTKbck=;
        b=AswNFAOs8gXUhgvwU31qgNkJDpBw3PVdxE9bvZtoIoujyVVRg9ydAtTlGVPpyKaENc
         jqta+SqwkR+V9ZyNdRFrOl4Pjoxots2V5dTFEsPcIwWWzMSH+ecE6u4+0EvXSaUJZRVS
         WSnr1rQW/Au9NudnzVFj96U45wOWJlNp6ucrZZQggj9FCudMj2UUjwcPVS+1eD5MQsdy
         UXgsS8nkVpW3dfyXvT7hfGFMA1AVD2WpdCCI7vLM62ahCQjNFL/1gKbPH5hrwIxyh2XZ
         8Q3vzpNKZ56pi8B6nQrjBjS7MnZ8rBI+Ldu58TY6WfSXdl6MzpAYuGfP+GIgnieWqMU2
         XyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=n9PlaQOOKzBXBufnbzlBXwI7lSGQ9ax7LkG3qVTKbck=;
        b=qbRcLeDUt7jvj0BC02q2u1wut/UEbupjtkS1RWjwI+VOEHwOkkqYgRNcSBQ6mjeMim
         qfSCe6sY3MzinmRBSI6IebCGTa7sl0SDJd3ySAIzwWpCzzLlFH6j4SSLURFukWRRXQs/
         y8K21Cx7pBVwUb34w6MRCSrOg8dstal1g3tdyfmmqGWSC9mN3/iSucRgVTjVHHEWHUlu
         Eim07mqoqb++iR79/qfcFiJ2VRrBqslp0SP9Ijj4Yq2v4HvC4J1nyXJ88ci6EXBy/h5T
         puudMyBIck+yFsDnVXjAbv5FSWplGFQt/oNJeYKnN/nl+Ng6zJHMcLohM6w+QcKSC65Z
         P1Cg==
X-Gm-Message-State: ACrzQf3LnCmVLWXp0hEx4Q0yxwgXIzj2TFOfL0z9ZeFKTjnG1y/10463
        L8WAhbTXGceZkTIjiv8U/sIoNQNUJb/Aw+SozeurKA==
X-Google-Smtp-Source: AMsMyM4Fjp6sUZCuxwCE/Pr6W2Ay9yKj6LMbJIhzi8XwIMqs0g0FEq6lNLhDBGX7wQ1tjKiCBJ0+qbYZbHSsQRCEjjA=
X-Received: by 2002:a25:80d0:0:b0:6b3:f287:93a4 with SMTP id
 c16-20020a2580d0000000b006b3f28793a4mr16906910ybm.427.1664127289111; Sun, 25
 Sep 2022 10:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a96c0b05e97f0444@google.com> <CAM0EoMnJ=STtk5BnZ9oJtnkXY2Q+Px2cKa4gowFRGpp40UNKww@mail.gmail.com>
 <CAM0EoMm9uBQQepMb5bda1vR-Okw-tPp2nnf6TvfA0FzPu_D_2A@mail.gmail.com>
 <CANn89i+4pgJe8M1cjLF6SkqG1Yp6e+5J2xEkMdSChiVYKMC09g@mail.gmail.com>
 <CAM0EoMkLdOUQ3yrBuYsLdZvqniZ_r0VoACzOzKCo1VVzYeyPbw@mail.gmail.com> <CAM0EoMmr8trH0EOtOfvTpYiTq1tt7RUamf1u_R0+USOU_gYUVg@mail.gmail.com>
In-Reply-To: <CAM0EoMmr8trH0EOtOfvTpYiTq1tt7RUamf1u_R0+USOU_gYUVg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 25 Sep 2022 10:34:37 -0700
Message-ID: <CANn89i+6NpmCyGdicmv+BiQqhUZ71TfN+P4=9NGpV4GxOba1Cw@mail.gmail.com>
Subject: Re: [syzbot] WARNING in u32_change
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     syzbot <syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kees Cook <keescook@chromium.org>
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

On Sun, Sep 25, 2022 at 10:13 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> To be clear, that splat didnt happen for me.
> Is there something else syzbot does to activate it?

Sure, please look at:

commit 54d9469bc515dc5fcbc20eecbe19cea868b70d68
Author: Kees Cook <keescook@chromium.org>
Date:   Thu Jun 24 15:39:26 2021 -0700

    fortify: Add run-time WARN for cross-field memcpy()


>
> cheers,
> jamal
>
> On Sun, Sep 25, 2022 at 1:08 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > Yes, after testing i realize there is nothing wrong here.
> > What warning was i supposed to see from running the reproducer?
> >
> > We will still add the test will multiple keys later
> >
> > cheers,
> > jamal
> >
> > On Sun, Sep 25, 2022 at 12:29 PM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > > On Sun, Sep 25, 2022 at 9:14 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > >
> > > > On Sun, Sep 25, 2022 at 11:38 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > > > >
> > > > > Is there a way to tell the boat "looking into it?"
> > > >
> > > >
> > > > I guess I have to swim across to it to get the message;->
> > > >
> > > > I couldnt see the warning message  but it is obvious by inspection that
> > > > the memcpy is broken. We should add more test coverage.
> > > > This should fix it. Will send a formal patch later:
> > > >
> > > > diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> > > > index 4d27300c2..591cbbf27 100644
> > > > --- a/net/sched/cls_u32.c
> > > > +++ b/net/sched/cls_u32.c
> > > > @@ -1019,7 +1019,7 @@ static int u32_change(struct net *net, struct
> > > > sk_buff *in_skb,
> > > >         }
> > > >
> > > >         s = nla_data(tb[TCA_U32_SEL]);
> > > > -       sel_size = struct_size(s, keys, s->nkeys);
> > > > +       sel_size = struct_size(s, keys, s->nkeys) + sizeof(n->sel);
> > > >         if (nla_len(tb[TCA_U32_SEL]) < sel_size) {
> > > >                 err = -EINVAL;
> > > >                 goto erridr;
> > >
> > > This patch is not needed, please look at struct_size() definition.
> > >
> > > Here, we might switch to unsafe_memcpy() instead of memcpy()
