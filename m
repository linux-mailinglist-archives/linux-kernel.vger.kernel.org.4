Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B069473BE5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjFWSbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFWSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4217271E;
        Fri, 23 Jun 2023 11:31:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b52864b701so6976465ad.3;
        Fri, 23 Jun 2023 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687545077; x=1690137077;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etvwHw93jeX09fh7Psp+MWgh8tmLkuVBuaS2tcvanhY=;
        b=BuQVcaqJvv0/J6m17joRUMN7ckoozdcFXTHN0j+2ELV93sH2i/WKDUVwfFN3cApi1d
         a32sFjL/iUFhPLyifi8Uj3ZJ+hIOfbLcutzucU4AiZ025ee5McqYcbolVaIjwpaCLC8s
         SGC4dIQDfv0wumnkyYb0DZDpWx6emVROPswj5cLeQA8w+QSqPEuV2T3/T4SNPQukIWiM
         PMxMCsgDQfqKtxN8iIY7mL/o6A87npEo4CL63EifSvI32fGCe82ymZjadXJchnzO9d5W
         RPEQZ3Qlww2LZMdoZEcpP/xgwv460kDE8777A+6+V2fAX+E6TNyON9fFIp52WtT7hZRv
         lDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687545077; x=1690137077;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etvwHw93jeX09fh7Psp+MWgh8tmLkuVBuaS2tcvanhY=;
        b=EbXKj1pYntnVvPp9AOl34XbNbaSHFMZmGtYxLyS3FxWKmynu1SOiUoZIcHxRrFlYGW
         8KmzRtvuqwhVZFIF5L+j1d6Z9ge1evFq797JzRLereOHWy/giHvYTvTqtuA3A9J15tjE
         T6o5uvlU4AADPGecXx9YFi0IMdvmJPnGKiOIIbW3O/FLzvmMDKR/94C7Sni9J29EM71p
         4KSY3ai6bvs+N++dgQ8P+BKAGrMJFYOatSsF3f9txKzJzW3hUebYIC+7sdRlnOY1S1S9
         v0f0NuTBenWM8U4eBph+z4lytmVa0a6iVO08SfzbUohyPu14wXoZ2SEUHsqcbOK/IALL
         2SaA==
X-Gm-Message-State: AC+VfDw7GRF2XDA5n4MqztlXzV3CDaoR0Zjac8pANS73Z/z8EYwmdMCA
        e4yyeNYuKo6RN+xA/mmTEQxOlsLwhcw=
X-Google-Smtp-Source: ACHHUZ5E/Axb6rVM3MyZfQwfUtqn3LDwsQdJaVe/dkIgA8hADpjE3ab/qE4MgJSus+5UHkK5szpMsQ==
X-Received: by 2002:a17:903:187:b0:1b5:361:cefe with SMTP id z7-20020a170903018700b001b50361cefemr110120plg.52.1687545076986;
        Fri, 23 Jun 2023 11:31:16 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902a51800b001a6f7744a27sm7530001plq.87.2023.06.23.11.31.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:31:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] rcu: Add necessary WRITE_ONCE()
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <2fd1169a-a695-4bff-9611-a84dd02025b2@paulmck-laptop>
Date:   Sat, 24 Jun 2023 02:31:12 +0800
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C75370D0-3A0C-48AA-AF20-ABCD74969F11@gmail.com>
References: <20230620171346.207076-1-mmpgouride@gmail.com>
 <50c4aa37-388b-449c-8184-00a9d69471fc@paulmck-laptop>
 <B9A94CB4-DB9B-43D2-9D34-ADB4F7EA737D@gmail.com>
 <2fd1169a-a695-4bff-9611-a84dd02025b2@paulmck-laptop>
To:     paulmck@kernel.org, will@kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B46=E6=9C=8823=E6=97=A5 =E4=B8=8B=E5=8D=881:17=EF=BC=8CPaul =
E. McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 21, 2023 at 10:08:28AM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B46=E6=9C=8821=E6=97=A5 06:26=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On Tue, Jun 20, 2023 at 05:13:46PM +0000, Alan Huang wrote:
>>>> Commit c54a2744497d("list: Add hlist_unhashed_lockless()") and
>>>> commit 860c8802ace1("rcu: Use WRITE_ONCE() for assignments to
>>>> ->pprev for hlist_nulls") added various WRITE_ONCE() to pair with
>>>> the READ_ONCE() in hlist_unhashed_lockless(), but there are still
>>>> some places where WRITE_ONCE() was not added, this commit adds =
that.
>>>>=20
>>>> Also add WRITE_ONCE() to pair with the READ_ONCE() in =
hlist_empty().
>>>>=20
>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
>>>=20
>>> On hlist_nulls_add_tail_rcu(), good catch, thank you!
>>>=20
>>> On the others, are there really cases where a lockless read races =
with
>>> the update?  At first glance, that sounds like a usage bug.  For =
example,
>>> as I understand it, when you use something like hlist_del(), you are
>>> supposed to ensure that there are no concurrent readers.  Which is =
the
>>> point of the assignment of the special value LIST_POISON2, right?
>>=20
>> Do you mean there are cases where a lockless read races with =
hlist_add_head/hlist_add_before
>> hlist_add_behind/__hlist_del, but there is no real case where a =
lockless read races with the hlist_del_init/hlist_del
>> hlist_move_list?
>>=20
>> There may be no real case where a lockless read races with the =
hlist_del_init/hlist_del
>> hlist_move_list. But for the sake of completeness, I added those =
WRITE_ONCE, after all, if there is WRITE_ONCE
>> in __hlist_del, why not add WRITE_ONCE in its caller, like =
hlist_del()?
>=20
> You might well have located a larger issue.  We want to be able to use
> KCSAN to find unintended data races, but as you noted, there might
> be different requirements for RCU-protected linked lists and for
> lock-protected linked lists.  If there are, then there is probably
> existing linked-list code that is using the wrong primitive, for
> example, using (or failing to use) the one that Eric Dumazet provided.
> For example, mismatched API usage might be causing the differences in
> uses of _ONCE() primitives that you are calling out.

I noticed a thread:

https://lore.kernel.org/lkml/20200324153643.15527-2-will@kernel.org/

It seems like Will wanted to remove that hlist_unhashed_lockless()?
But I can=E2=80=99t find any further updates.

Will: Can you tell me what happened later?

>=20
> Would you be interested in digging into this?

I=E2=80=99d like to.

>=20
> You will of course need to be able to build and run kernels with KCSAN
> enabled, which is not hard to do given a laptop that can build a =
kernel
> and run a guest OS.

I=E2=80=99ll do that, :)

>=20
> 							Thanx, Paul
>=20
>> Thanks,
>> Alan
>>=20
>>>=20
>>> Or is there some use case that I am missing?
>>>=20
>>> If I am not missing something, then switching the non-RCU APIs to
>>> WRITE_ONCE() would be a step backwards, because it would make it =
harder
>>> for tools like KCSAN to find bugs.
>>>=20
>>> Thanx, Paul
>>>=20
>>>> ---
>>>> Changelog:
>>>> V1 -> V2:=20
>>>> Add WRITE_ONCE in hlist_del_init to pair with READ_ONCE in
>>>> hlist_unhashed_lockless.
>>>>=20
>>>> include/linux/list.h          | 9 +++++----
>>>> include/linux/list_nulls.h    | 2 +-
>>>> include/linux/rculist_nulls.h | 2 +-
>>>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/list.h b/include/linux/list.h
>>>> index ac366958ea..3a29b95bfe 100644
>>>> --- a/include/linux/list.h
>>>> +++ b/include/linux/list.h
>>>> @@ -912,7 +912,7 @@ static inline void hlist_del(struct hlist_node =
*n)
>>>> {
>>>> __hlist_del(n);
>>>> n->next =3D LIST_POISON1;
>>>> - n->pprev =3D LIST_POISON2;
>>>> + WRITE_ONCE(n->pprev, LIST_POISON2);
>>>> }
>>>>=20
>>>> /**
>>>> @@ -925,7 +925,8 @@ static inline void hlist_del_init(struct =
hlist_node *n)
>>>> {
>>>> if (!hlist_unhashed(n)) {
>>>> __hlist_del(n);
>>>> - INIT_HLIST_NODE(n);
>>>> + n->next =3D NULL;
>>>> + WRITE_ONCE(n->pprev, NULL);
>>>> }
>>>> }
>>>>=20
>>>> @@ -1026,8 +1027,8 @@ static inline void hlist_move_list(struct =
hlist_head *old,
>>>> {
>>>> new->first =3D old->first;
>>>> if (new->first)
>>>> - new->first->pprev =3D &new->first;
>>>> - old->first =3D NULL;
>>>> + WRITE_ONCE(new->first->pprev, &new->first);
>>>> + WRITE_ONCE(old->first, NULL);
>>>> }
>>>>=20
>>>> #define hlist_entry(ptr, type, member) =
container_of(ptr,type,member)
>>>> diff --git a/include/linux/list_nulls.h =
b/include/linux/list_nulls.h
>>>> index fa6e8471bd..b63b0589fa 100644
>>>> --- a/include/linux/list_nulls.h
>>>> +++ b/include/linux/list_nulls.h
>>>> @@ -95,7 +95,7 @@ static inline void hlist_nulls_add_head(struct =
hlist_nulls_node *n,
>>>>=20
>>>> n->next =3D first;
>>>> WRITE_ONCE(n->pprev, &h->first);
>>>> - h->first =3D n;
>>>> + WRITE_ONCE(h->first, n);
>>>> if (!is_a_nulls(first))
>>>> WRITE_ONCE(first->pprev, &n->next);
>>>> }
>>>> diff --git a/include/linux/rculist_nulls.h =
b/include/linux/rculist_nulls.h
>>>> index ba4c00dd80..c65121655b 100644
>>>> --- a/include/linux/rculist_nulls.h
>>>> +++ b/include/linux/rculist_nulls.h
>>>> @@ -138,7 +138,7 @@ static inline void =
hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
>>>>=20
>>>> if (last) {
>>>> n->next =3D last->next;
>>>> - n->pprev =3D &last->next;
>>>> + WRITE_ONCE(n->pprev, &last->next);
>>>> rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
>>>> } else {
>>>> hlist_nulls_add_head_rcu(n, h);
>>>> --=20
>>>> 2.34.1

