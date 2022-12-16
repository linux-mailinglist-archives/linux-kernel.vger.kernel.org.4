Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9117864EFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLPQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiLPQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:54:34 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BD389CD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:54:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id jr11so3132884qtb.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SU5Z/KiaXFmce3kuMWeEeLnco0PMLsZOUUzW/Vik9+g=;
        b=DQG3uAfmxLoNHwCKq1X/2aXOojYLsMQxXyBsvm86xcnPndHCB1G87yfSu5Yun39kGb
         R0JgymBx1ZaeXarwoYeGOtJoTsXymQHh2H1eyo3mJaqbj5pa6LGXRraKcji+gfSq/zJq
         9D3+IqxVgUmyEoZZdZO1JPb43Z1wgUy6ggJK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU5Z/KiaXFmce3kuMWeEeLnco0PMLsZOUUzW/Vik9+g=;
        b=XLquoJdKr8GKnIktW+TT+MJUrABiR5hANqEnJzTqfP2wevus/xWyjIN6PBgpXBKmxm
         jh12OY1mMfSW2lgLZczipm4vWZPovIODn0AKTgZPOtZ+vdZJeM8xxXpYdbVDmZVSW+wd
         rbe4z1Lpad+w1jo+Flvcvr9+3rvIPwNqcYUeFF6XZrc1oXXQtqN1xIXMnUFCIfbRKnqs
         AQNw3qDMi1rNcARbveHkTQ1RaU45EMkMJhirbl/hjdA+qvIK24uUfqeSq5N6wRRG47Gp
         Y0ECGtWE/Ad49xQ0w9L9Py/WsrdvGxLd00LNu5jOdcY5AxAc+ABiyk+R57gboCCl3T59
         xkYg==
X-Gm-Message-State: ANoB5pnfCRmNb4vYrX4aIJBwVowiyVCyOdbY/42k5hQObxjax4cRKMvm
        qVOIys8YOBzonP623WoN5T3Ppz2u/k2GZJ1owAs=
X-Google-Smtp-Source: AA0mqf4kEbRmKx0UN2D8mGGO561sa5ZlDZuo8ptaMT3qNbhm0Lhuwye8yNbLu3/CtTzbFYi16nzNvA==
X-Received: by 2002:ac8:5292:0:b0:3a7:f183:7f66 with SMTP id s18-20020ac85292000000b003a7f1837f66mr45207492qtn.22.1671209671201;
        Fri, 16 Dec 2022 08:54:31 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id x21-20020ac85395000000b003a50248b89esm1568333qtp.26.2022.12.16.08.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 08:54:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Fri, 16 Dec 2022 11:54:19 -0500
Message-Id: <54F1102C-2577-4238-83B3-D38BA7ED9087@joelfernandes.org>
References: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221216165144.GA4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrote:
>> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
>> [...]
>>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader=

>>>>>> has no new smp_mb() that happens AFTER the flip happened. So it can
>>>>>> totally sample the old idx again -- that particular reader will
>>>>>> increment twice, but the next time, it will see the flipped one.
>>>>>=20
>>>>> I will let you transliterate both.  ;-)
>>>>=20
>>>> I think I see what you mean now :)
>>>>=20
>>>> I believe the access I am referring to is the read of idx on one side a=
nd
>>>> the write to idx on the other. However that is incomplete and I need to=

>>>> pair that with some of other access on both sides.
>>>>=20
>>>> So perhaps this:
>>>>=20
>>>> Writer does flip + smp_mb + read unlock counts [1]
>>>>=20
>>>> Reader does:
>>>> read idx + smp_mb() + increment lock counts [2]
>>>>=20
>>>> And subsequently reader does
>>>> Smp_mb() + increment unlock count. [3]
>>>>=20
>>>> So [1] races with either [2] or [2]+[3].
>>>>=20
>>>> Is that fair?
>>>=20
>>> That does look much better, thank you!
>>=20
>> Perhaps a comment with an ASCII diagram will help?
>>=20
>>=20
>> Case 2:
>> Both the reader and the updater see each other's writes too late, but bec=
ause
>> of memory barriers on both sides, they will eventually see each other's w=
rite
>> with respect to their own. This is similar to the store-buffer problem. T=
his
>> let's a single reader contribute a maximum (unlock minus lock) imbalance o=
f 2.
>>=20
>> The following diagram shows the subtle worst case followed by a simplifie=
d
>> store-buffer explanation.
>>=20
>> READER                  UPDATER
>> -------------           ----------
>>                           // idx is initially 0.
>> read_lock() {
>>  READ(idx) =3D 0;
>>  lock[0]++; --------------------------------------------,
>>                           flip() {                      |              =20=

>>                              smp_mb();                  |
>>  smp_mb();                                              |
>> }                                                        |
>>                                                         |
>> // RSCS                                                  |
>>                                                         |
>> read_unlock() {                                          |
>>  smp_mb();                                              |
>>                              idx++;  // P               |
>>                              smp_mb();                  |
>>                           }                             |
>>                                                         |
>>                           scan_readers_idx(0) {         |
>>                               count all unlock[0];      |
>>                                   |                     |
>>                                   |                     |
>>  unlock[0]++; //X <--not-counted--`-----,               |
>>                                         |               |
>> }                                        V               `------,
>>                               // Will make sure next scan      |
>>                               // will not miss this unlock (X) |
>>                               // if other side saw flip (P) ,--`
>>                               // Call this MB [1]           |
>>                               // Order write(idx) with      |
>>                               // next scan's unlock.        |
>>                               smp_mb();                 ,---`
>> read_lock() {                                            |
>>  READ(idx)=3D0;                                           |
>>  lock[0]++; ----------------> count all lock[0];        |
>>  smp_mb();         |     }                              |
>> }     |             |                                    V
>>      |             `---> // Incorrect contribution to lock counting
>>      |                   // upto a maximum of 2 times.
>>      |
>>       `---> // Pairs with MB [1]. Makes sure that
>>             // the next read_lock()'s' idx read (Y) is ordered
>>             // with above write to unlock[0] (X).
>>                            |
>> rcu_read_unlock() {         |
>>  smp_mb(); <---------------`
>>  unlock[0]++;=20
>> }
>>=20
>> read_lock() {
>>  READ(idx) =3D 1; //Y
>>  lock[1]++;
>>  ...
>> }
>>                           scan_readers_idx(0) {
>>                               count all unlock[0]; //Q
>>                               ...
>>=20
>>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>                          }
>>=20
>> This makes it similar to the store buffer pattern. Using X, Y, P and Q
>> annotated above, we get:
>>=20
>> READER                    UPDATER
>> X (write)                 P (write)
>>=20
>> smp_mb();                 smp_mb();
>>=20
>> Y (read)                  Q (read)
>=20
> Given that this diagram is more than 50 lines long, it might go better in
> a design document describing this part of RCU.  Perhaps less detail or
> segmented, but the same general idea as this guy:
>=20
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst

Yes, this sounds like a good place to add it and perhaps we refer to it from=
 the C source file? I can take this up to do over the holidays, if you prefe=
r.

Thanks,

  - Joel


>=20
> Thoughts?
>=20
>                        Thanx, Paul
