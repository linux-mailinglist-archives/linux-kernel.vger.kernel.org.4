Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D683672A940
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjFJFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFJFwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:52:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301923AA7;
        Fri,  9 Jun 2023 22:52:43 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-654f8b56807so2619157b3a.1;
        Fri, 09 Jun 2023 22:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686376362; x=1688968362;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRgmV2IZs4TvDybCRGo+p0nMuzbLZLONErtuLHAt0W8=;
        b=rUM+Nt1BI5exs0ACt/g7CJfrsg/UgrAs+xQ4PXOP16lbSa2oihB9w4uvPvfPK0yE63
         xVEhaai4CL/MxvSTWKW98CgsFHxef1ondIutOhhOOgqnV0Jq5Z97q6tt7E+g5AYwmKvY
         cHL3Lo62jscZRIw1I8CY7QnmrCt2r0i8N0h3xy4eDwO3/i+Sa1pG8m+ltk7s1XEdUwwG
         AIRKMHvjPLV6hE2p1N+q78TVGFyijYGVeEFhKCgy5sEIRYj4dvGv6MnCVTGiuhKa05c0
         /zmibrM723E7IHfJB/OjgSx9yibHXjkkX2miIplq86XqbSRGpjPbFiuW27DY1BGN3h+3
         Gl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686376362; x=1688968362;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRgmV2IZs4TvDybCRGo+p0nMuzbLZLONErtuLHAt0W8=;
        b=bbmkeM4YAtgvCVmgi2iMDBYD/ew0u3AIuz0SKQvQoUzVN8uBfUjVx3xTBhXU+eo8OL
         i4af5zGzjCW7JpK/pmE7HyrM+LLpXExV7hEGXDOpGo/v9ruPwmA4vKa8QngdIRgNuO8J
         3/aToS1EKbkna8QACfMIH/fMzwCuaZ8TMyU5r6hQC+mJju8oRD+zR0wWFG5POa6tLgYk
         N5wn7xtFCJCC6dUbWNp5weryzBnMj9NMJ5R/x83hhlmdRLBKjdjNq9K5RO9r0LaiVaP8
         4wbXctnxf3PnYNSxqu+M2jVhANQO15I5A6zERM8UP6DxnNcPoNZtU6kslrp8unkUMagy
         8UWA==
X-Gm-Message-State: AC+VfDyy9jB0t5XCUazvNTpoTskPrymkZp49CWhQeiNYsEC6CrEszzup
        qXhTLvUUhwNkapcQLgDz9Z6rTP5uwCDIcg==
X-Google-Smtp-Source: ACHHUZ7HcWWTWhlrzQ4ylzDwnMAxFrtlY4iUTKSgzNVHU9n/p/J8fugYbK2v/NOnzEx3npagdeZahw==
X-Received: by 2002:a05:6a00:180e:b0:656:e7a2:5322 with SMTP id y14-20020a056a00180e00b00656e7a25322mr4460309pfa.26.1686376362472;
        Fri, 09 Jun 2023 22:52:42 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id a10-20020aa780ca000000b00642ea56f06dsm3487739pfn.26.2023.06.09.22.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 22:52:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release'
 in insert function
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <20230610002024.80653-1-sj@kernel.org>
Date:   Sat, 10 Jun 2023 13:52:25 +0800
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C469091-6C20-4BBD-B503-F024021C8AE7@gmail.com>
References: <20230610002024.80653-1-sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SJ,

> 2023=E5=B9=B46=E6=9C=8810=E6=97=A5 08:20=EF=BC=8CSeongJae Park =
<sj@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, 9 Jun 2023 16:42:59 -0700 "Paul E. McKenney" =
<paulmck@kernel.org> wrote:
>=20
>> On Fri, Jun 09, 2023 at 07:12:06PM +0000, SeongJae Park wrote:
>>> On Fri, 19 May 2023 14:52:50 -0400 Joel Fernandes =
<joel@joelfernandes.org> wrote:
>>>=20
>>>> On Thu, May 18, 2023 at 6:40=E2=80=AFPM SeongJae Park =
<sj@kernel.org> wrote:
>>>>>=20
>>>>> The document says we can avoid extra smp_rmb() in =
lockless_lookup() and
>>>>> extra _release() in insert function when hlist_nulls is used.  =
However,
>>>>> the example code snippet for the insert function is still using =
the
>>>>> extra _release().  Drop it.
>>>>>=20
>>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>>> ---
>>>>> Documentation/RCU/rculist_nulls.rst | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>>>>> index 5cd6f3f8810f..463270273d89 100644
>>>>> --- a/Documentation/RCU/rculist_nulls.rst
>>>>> +++ b/Documentation/RCU/rculist_nulls.rst
>>>>> @@ -191,7 +191,7 @@ scan the list again without harm.
>>>>>   obj =3D kmem_cache_alloc(cachep);
>>>>>   lock_chain(); // typically a spin_lock()
>>>>>   obj->key =3D key;
>>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>>> +  atomic_set(&obj->refcnt, 1);
>>>>>   /*
>>>>>    * insert obj in RCU way (readers might be traversing chain)
>>>>>    */
>>>>=20
>>>> If write to ->refcnt of 1 is reordered with setting of ->key, what
>>>> prevents the 'lookup algorithm' from doing a key match (obj->key =3D=3D=

>>>> key) before the refcount has been initialized?
>>>>=20
>>>> Are we sure the reordering mentioned in the document is the same as
>>>> the reordering prevented by the atomic_set_release()?
>>>=20
>>> Paul, may I ask your opinion?
>>=20
>> The next line of code is this:
>>=20
>> hlist_nulls_add_head_rcu(&obj->obj_node, list);
>>=20
>> If I understand the code correctly, obj (and thus *obj) are not
>> visible to readers before the hlist_nulls_add_head_rcu().  And
>> hlist_nulls_add_head_rcu() uses rcu_assign_pointer() to ensure that
>> initialization (including both ->key and ->refcnt) is ordered before
>> list insertion.
>>=20
>> Except that this memory is being allocated from a slab cache that was
>> created with SLAB_TYPESAFE_BY_RCU.  This means that there can be =
readers
>> who gained a reference before this object was freed, and who still =
hold
>> their references.
>>=20
>> Unfortunately, the implementation of try_get_ref() is not shown.  =
However,
>> if ->refcnt is non-zero, this can succeed, and if it succeeds, we =
need
>> the subsequent check of obj->key with key in the lookup algorithm to
>> be stable.  For this check to be stable, try_get_ref() needs to use =
an
>> atomic operation with at least acquire semantics =
(kref_get_unless_zero()
>> would work), and this must pair with something in the initialization.
>>=20
>> So I don't see how it is safe to weaken that atomic_set_release() to
>> atomic_set(), even on x86.
>=20
> Thank you for the nice explanation, and I agree.
>=20
>>=20
>> Or am I missing something subtle here?
>=20
> I found the text is saying extra _release() in insert function is not
> needed[1], and I thought it means the atomic_set_release().  Am I =
misreading
> it?  If not, would it be better to fix the text, for example, like =
below?

The original text is:

	=E2=80=9CWith hlist_nulls we can avoid extra smp_rmb() in =
lockless_lookup()
	 and extra smp_wmb() in insert function.=E2=80=9D

We can avoid the extra smp_wmb(), but the _release is required,

As Paul said,

>> Except that this memory is being allocated from a slab cache that was
>> created with SLAB_TYPESAFE_BY_RCU.  This means that there can be =
readers
>> who gained a reference before this object was freed, and who still =
hold
>> their references.

Without the _release, we can get the old =E2=80=98key=E2=80=99 after the =
invocation of
try_get_ref (although try_get_ref noticed the effect of atomic_set).

Thanks,
Alan

>=20
> ```
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -129,8 +129,7 @@ very very fast (before the end of RCU grace =
period)
> Avoiding extra smp_rmb()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

>=20
> -With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
> -and extra _release() in insert function.
> +With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup().
>=20
> For example, if we choose to store the slot number as the 'nulls'
> end-of-list marker for each slot of the hash table, we can detect
> @@ -182,6 +181,9 @@ scan the list again without harm.
> 2) Insert algorithm
> -------------------
>=20
> +Same to the above one, but uses hlist_nulls_add_head_rcu() instead of
> +hlist_add_head_rcu().
> +
> ::
>=20
>   /*
> @@ -191,7 +193,7 @@ scan the list again without harm.
>   obj =3D kmem_cache_alloc(cachep);
>   lock_chain(); // typically a spin_lock()
>   obj->key =3D key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  atomic_set(&obj->refcnt, 1);
>   /*
>    * insert obj in RCU way (readers might be traversing chain)
>    */
> ```
>=20
> [1] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/RCU/rculist_nulls.rst#n133
>=20
>=20
> Thanks,
> SJ
>=20
>>=20
>> Thanx, Paul
>>=20
>>> Thanks,
>>> SJ
>>>=20
>>>>=20
>>>> For the other 3 patches, feel free to add:
>>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>=20
>>>> thanks,
>>>>=20
>>>> - Joel


