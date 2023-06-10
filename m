Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43E72A92F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjFJFht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 01:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFJFhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 01:37:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BAC3A9E;
        Fri,  9 Jun 2023 22:37:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b034ca1195so11757465ad.2;
        Fri, 09 Jun 2023 22:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686375466; x=1688967466;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3d5ANAanSkcTLSLsdt6pgoF350ZTs91qimdsozi44Q=;
        b=C36H3GAdAT+/0SAEs+jCEjLM5cX+Y3I6LHJEBegbtRTvhR4DTL0qu+Gew2KR2KkJIc
         x/Me26A+2pGGG0TIUDFiNs5UG3yzHDrXJAWwRS6hc8cUyUlrHNLssj1tSfZPE9ly27Gi
         lHJETFPYpZiQoYpyI0n1OG0I53Ykr4Bvzu3sVmjxfIGfy5tQN+VnZKWHxL9PFJ16/Ba4
         Gn8rOZYQnCkhSqdnevLu1h2bW2vE6/jtwXJKTi4gpMGE15++1tVq5/V0waWOl4oGPRl4
         Opt4e0PkS+hcYjSBDoqeJFa4AClh8zR3jcrsSUSovW/r1zZoTsWq/3zWGomi+56s1Zbz
         UfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686375466; x=1688967466;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3d5ANAanSkcTLSLsdt6pgoF350ZTs91qimdsozi44Q=;
        b=X/Y5YiXEBYzS/MSESklAe0FdW4hElzlNBN7RxZfc6CQxflcpdBkvNwy2I3MpupJaXW
         /dHoBGNQp2kc9UQwUVja0sYmBqaetCJvxkPht5WmwyVVYAxHndJVsPD2LY5irMvb+ahZ
         B5AIKIOl1e/XTUfX8y4lU1SD/CoFAOvHCnneQjLFCWJdblKpo47AaYL/2nYJKiN9RMe1
         3bNU3Nvtd09JNPISfDUWUxHKaQO+od2FWaW0AAncIinTHEUlIpBH21qX4FR5pa7+DxXo
         vBYwovR4FTXjPUtNUiBFGNudKTveIuXW+5gdSEPmDAN5TZqrwcp2X3CVZ8UwMS8n9vh5
         l5AA==
X-Gm-Message-State: AC+VfDy8lXZhnUEZ/dbsOwPu5qnhc8D5n22gJY7ItY6wvENhDBU5R10T
        aF0Wscwa/w1KOmtmnzR6iLEqyncbHM6+oQ==
X-Google-Smtp-Source: ACHHUZ6zqdovUzQYtmhPX7phFAqiJfcXHIomoUmonlBVS5JvZ1kSE4OArDduvyGIT8Hk++1PFxzRqw==
X-Received: by 2002:a17:903:26c7:b0:1ab:1a73:7c7f with SMTP id jg7-20020a17090326c700b001ab1a737c7fmr891385plb.63.1686375465591;
        Fri, 09 Jun 2023 22:37:45 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001b176ba9f17sm4137078plg.149.2023.06.09.22.37.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 22:37:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release'
 in insert function
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <46440869-644a-4982-b790-b71b43976c66@paulmck-laptop>
Date:   Sat, 10 Jun 2023 13:37:28 +0800
Cc:     SeongJae Park <sj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4071FE01-BEB5-4BEE-A424-F50F0E0E3410@gmail.com>
References: <CAEXW_YQFqW2QcAuHZEhc_GaUaB-=QOS0WgUOizd=FYwtFQ8vag@mail.gmail.com>
 <20230609191206.30465-1-sj@kernel.org>
 <46440869-644a-4982-b790-b71b43976c66@paulmck-laptop>
To:     paulmck@kernel.org
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

Hi Paul,

> 2023=E5=B9=B46=E6=9C=8810=E6=97=A5 07:42=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jun 09, 2023 at 07:12:06PM +0000, SeongJae Park wrote:
>> On Fri, 19 May 2023 14:52:50 -0400 Joel Fernandes =
<joel@joelfernandes.org> wrote:
>>=20
>>> On Thu, May 18, 2023 at 6:40=E2=80=AFPM SeongJae Park =
<sj@kernel.org> wrote:
>>>>=20
>>>> The document says we can avoid extra smp_rmb() in lockless_lookup() =
and
>>>> extra _release() in insert function when hlist_nulls is used.  =
However,
>>>> the example code snippet for the insert function is still using the
>>>> extra _release().  Drop it.
>>>>=20
>>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>>> ---
>>>> Documentation/RCU/rculist_nulls.rst | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/Documentation/RCU/rculist_nulls.rst =
b/Documentation/RCU/rculist_nulls.rst
>>>> index 5cd6f3f8810f..463270273d89 100644
>>>> --- a/Documentation/RCU/rculist_nulls.rst
>>>> +++ b/Documentation/RCU/rculist_nulls.rst
>>>> @@ -191,7 +191,7 @@ scan the list again without harm.
>>>>   obj =3D kmem_cache_alloc(cachep);
>>>>   lock_chain(); // typically a spin_lock()
>>>>   obj->key =3D key;
>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>> +  atomic_set(&obj->refcnt, 1);
>>>>   /*
>>>>    * insert obj in RCU way (readers might be traversing chain)
>>>>    */
>>>=20
>>> If write to ->refcnt of 1 is reordered with setting of ->key, what
>>> prevents the 'lookup algorithm' from doing a key match (obj->key =3D=3D=

>>> key) before the refcount has been initialized?
>>>=20
>>> Are we sure the reordering mentioned in the document is the same as
>>> the reordering prevented by the atomic_set_release()?
>>=20
>> Paul, may I ask your opinion?
>=20
> The next line of code is this:
>=20
> hlist_nulls_add_head_rcu(&obj->obj_node, list);
>=20
> If I understand the code correctly, obj (and thus *obj) are not
> visible to readers before the hlist_nulls_add_head_rcu().  And
> hlist_nulls_add_head_rcu() uses rcu_assign_pointer() to ensure that
> initialization (including both ->key and ->refcnt) is ordered before
> list insertion.
>=20
> Except that this memory is being allocated from a slab cache that was
> created with SLAB_TYPESAFE_BY_RCU.  This means that there can be =
readers
> who gained a reference before this object was freed, and who still =
hold
> their references.
>=20
> Unfortunately, the implementation of try_get_ref() is not shown.  =
However,
> if ->refcnt is non-zero, this can succeed, and if it succeeds, we need
> the subsequent check of obj->key with key in the lookup algorithm to
> be stable.  For this check to be stable, try_get_ref() needs to use an
> atomic operation with at least acquire semantics =
(kref_get_unless_zero()
> would work), and this must pair with something in the initialization.
>=20
> So I don't see how it is safe to weaken that atomic_set_release() to
> atomic_set(), even on x86.

I totally agree, but only in the case of using hlist_nulls.

That means, atomic_set_release() is not enough in the case without using =
hlist_nulls,
we must ensure that storing to obj->next (in hlist_add_head_rcu) is =
ordered before storing
to obj->key. Otherwise, we can get the new =E2=80=98next' and the old =
=E2=80=98key' in which case we can=E2=80=99t detect
an object movement(from one chain to another).

So, I=E2=80=99m afraid that the atomic_set_release() in insertion =
algorithm without using hlist_nulls should=20
change back to:
=09
	smp_wmb();
	atomic_set(&obj->refcnt, 1);

Thanks,
Alan

>=20
> Or am I missing something subtle here?
>=20
> Thanx, Paul
>=20
>> Thanks,
>> SJ
>>=20
>>>=20
>>> For the other 3 patches, feel free to add:
>>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>=20
>>> thanks,
>>>=20
>>> - Joel


