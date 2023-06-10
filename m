Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870272AB0F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjFJLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:05:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115622D55;
        Sat, 10 Jun 2023 04:05:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-543a09ee32eso1240438a12.1;
        Sat, 10 Jun 2023 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686395101; x=1688987101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dBfYYGBslBF4bmtNYVdnpM97g0oABxKKJJ2EhyCgIc=;
        b=ClUo/umlDklAa2WkPhtQIVfQxie4UhuP+yU29/3nBXyslSFT/NMqkALeN2E5vb4Hpd
         z1yAUWR7RQvceJvv9Ls/PRdG3c/fJl5caZwSmflS0INPA6YZzGZHY8D6bGy5UcObbDLZ
         yRzASSDIgb76LkI5qykDIGzTIdoumee441eHZGDdpg/wfHvRHZ7bdGce/RrD1wS+N/Le
         UPSJotv3xnhrRa9ukMWO46Zcgxm/cIpVSxps8UqVB64Hsqw9lgD10jHiNsjsvNdKx+y1
         nwTqJ6Ok7wC+EpV65y+f6ussVrnfCFn0i7MyFjqeQQdXD9YB0UBcTVY6rlN2xJhe8CDT
         RHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686395101; x=1688987101;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dBfYYGBslBF4bmtNYVdnpM97g0oABxKKJJ2EhyCgIc=;
        b=e86yu/ZhCnizLg0VKByA7LD94OTQHlyzVGKT4E/Sn3WqVv9gUZy1OBCyNVoWXy9KWC
         u8fq0gCpx0LufZatWNYAHFja+IVg/DTszdHDsx310rutMHFfphxfTuJws5fK+ekCrVPn
         HCU/Df3uBm7DwuLuGj8AE3FHxXaPsHxNMgbSOtz+/o5BYl4Te9PZ9M/G4sRUuL3YiSDQ
         ujTRC8LlHEp3T02vNEiB/Fx6g53smKkznK4lpYMvOfkROoKY2KNS3fUedtCEnny1CVb0
         yP/KxbMFxhyrF5aLA8i/PJG6QGQdalhfVq7ZlZfJP2hgw9DEW9oEVvEdaBIIG3UPKruj
         rBww==
X-Gm-Message-State: AC+VfDyiJcDmveJHvj3mG6bMib1JDBAL/9k8qgP2Ho1nFjLlXfAlXTVU
        v5yASVl5FwbbgiLUu0oC068=
X-Google-Smtp-Source: ACHHUZ5SW6wDpsvTFfe6r3H/woWn1BXuXnXIr8wM3HUf02TTfApB95iqRZNOKPYHQ/ILteIP1oXnOQ==
X-Received: by 2002:a17:90b:3658:b0:256:28ab:de61 with SMTP id nh24-20020a17090b365800b0025628abde61mr8716106pjb.11.1686395101118;
        Sat, 10 Jun 2023 04:05:01 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090a154400b00256395cb599sm6420477pja.38.2023.06.10.04.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jun 2023 04:05:00 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release'
 in insert function
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <4071FE01-BEB5-4BEE-A424-F50F0E0E3410@gmail.com>
Date:   Sat, 10 Jun 2023 19:04:44 +0800
Cc:     SeongJae Park <sj@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F61F0ED7-D82B-412F-971F-691856539B6C@gmail.com>
References: <CAEXW_YQFqW2QcAuHZEhc_GaUaB-=QOS0WgUOizd=FYwtFQ8vag@mail.gmail.com>
 <20230609191206.30465-1-sj@kernel.org>
 <46440869-644a-4982-b790-b71b43976c66@paulmck-laptop>
 <4071FE01-BEB5-4BEE-A424-F50F0E0E3410@gmail.com>
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


> 2023=E5=B9=B46=E6=9C=8810=E6=97=A5 13:37=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi Paul,
>=20
>> 2023=E5=B9=B46=E6=9C=8810=E6=97=A5 07:42=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
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
>>>>>  obj =3D kmem_cache_alloc(cachep);
>>>>>  lock_chain(); // typically a spin_lock()
>>>>>  obj->key =3D key;
>>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
>>>>> +  atomic_set(&obj->refcnt, 1);
>>>>>  /*
>>>>>   * insert obj in RCU way (readers might be traversing chain)
>>>>>   */
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
> I totally agree, but only in the case of using hlist_nulls.
>=20
> That means, atomic_set_release() is not enough in the case without =
using hlist_nulls,
> we must ensure that storing to obj->next (in hlist_add_head_rcu) is =
ordered before storing

Typo: not before, but after.

> to obj->key. Otherwise, we can get the new =E2=80=98next' and the old =
=E2=80=98key' in which case we can=E2=80=99t detect
> an object movement(from one chain to another).
>=20
> So, I=E2=80=99m afraid that the atomic_set_release() in insertion =
algorithm without using hlist_nulls should=20
> change back to:
>=20
> smp_wmb();
> atomic_set(&obj->refcnt, 1);
>=20
> Thanks,
> Alan
>=20
>>=20
>> Or am I missing something subtle here?
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


