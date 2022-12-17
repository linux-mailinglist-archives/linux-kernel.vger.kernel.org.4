Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26864F7EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 07:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiLQGcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 01:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLQGcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 01:32:39 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD57248CB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:32:38 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a16so4424439qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 22:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF7B0ARRl+lb5m5FqHRPeUTxhDADJbbf7N7t8C12qSo=;
        b=U71cEmfEuci2Emp+/jsEWh2wxHVTqoDU5j+kNN1+RMTXphkEVBN8njuU6ERvMj5wwX
         /sU1SR/iY7L7VllGylhLAppHxoUtrQK0jNMTJjI0LMi7ot4xsH66a2Tdilhq9J5Z3rlD
         A8WauUF5bNZvzsIWcL+s6BFH802ugql7vK+58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF7B0ARRl+lb5m5FqHRPeUTxhDADJbbf7N7t8C12qSo=;
        b=oXi6jPi//5AsJH3nmpnb7XZkgPN4sZqNkydqozJaZaIkLDvnzY0/acOP7mwq9aYj38
         v/RIOIPST60lU1Zm7WBA8y8carKVgSHa3oPLVQyGfY8mogXyF0Fxqvh2ZoqaMgKpnSh7
         khJBQNIeGN3s6i173lck63M0m2kh892wCLP/49cG3DABxCeVfGtDnVo2/hJu3YdoqmJ5
         1FODTKViH5f65FN5I5NT4y549PLLGSos2VZKmzwsiylB3i0Cke88QTtMRSyXGKyh0hf3
         5Jn3AtcpUMsgMO7MYz+33YOABslfx6DnRFSNKn/j0sWHuBdO8FfaTLIi1/TzbMBMYkva
         oPzA==
X-Gm-Message-State: ANoB5pmWNdaaEHlwiWdHZsq+SdSzyRfEMPI20NBp79VPsC/ET8haupb6
        yaxMpdTBl6xu0IwykoyI/yUKaA==
X-Google-Smtp-Source: AA0mqf4a1Ppnx2bxq2P6kOE5kCJxQImOF8nqdP7G0GEm85lZATfwfM9mOuia4wTcivVkRBaFfdXjMA==
X-Received: by 2002:ac8:7c8:0:b0:3a7:ee95:cc37 with SMTP id m8-20020ac807c8000000b003a7ee95cc37mr46663329qth.14.1671258757011;
        Fri, 16 Dec 2022 22:32:37 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id fy21-20020a05622a5a1500b0039cb59f00fcsm2606290qtb.30.2022.12.16.22.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 22:32:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Sat, 17 Dec 2022 01:32:25 -0500
Message-Id: <BF7A41E0-883D-45BD-A214-A2444A913B47@joelfernandes.org>
References: <20221217051519.GI4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221217051519.GI4001@paulmck-ThinkPad-P17-Gen-1>
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



> On Dec 17, 2022, at 12:15 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Fri, Dec 16, 2022 at 10:21:25PM -0500, Joel Fernandes wrote:
>>> On Fri, Dec 16, 2022 at 10:19 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>=20
>>> Hi,
>>> On the related subject of this function, I drew a diagram for one of
>>> the reasons why per-CPU unlock counts have to be scanned first, for a
>>> particular index, before the per-CPU lock counts, and not the other
>>> way. Otherwise, a reader that got preempted after reading the index,
>>> can suddenly get scheduled during the inactive index's scan, and cause
>>> the total lock and unlock counts to falsely match:
>>> https://i.imgur.com/79fDWdQ.png
>>=20
>> Better diagram: https://i.imgur.com/PXKJnmW.png
>> (Added the preemption reasoning for Reader 0).
>=20
> Nice!!!

Thanks!

> The other way to look at this is using a memory-ordering viewpoint.
> This is a member of the message-passing litmus-test family, and the reader=

> must read the variables in the opposite order that the writer writes them.=


Exactly, thanks. If we read the unlock counts first, which includes the unlo=
ck count of that spurious reader 0 in my figure, then would have already see=
n the reader 0=E2=80=99s lock count when we sum up the lock counts, thanks t=
o MP pattern - so that spurious reader cannot do any damage or imbalance in t=
he delta between the lock and unlock counts.   In MP pattern, if we see the f=
lag, then we would have already seen the data (message). And on the other CP=
U the data is written first followed by the write to the flag. Which is exac=
tly what we do in the SRCU as you mentioned with the reversal of the orderin=
g of the variables we read. I will reason about it this way as well in my no=
tes, thank you!

The other way I reason is, during scanning, if we count unlocks first before=
 locks, it=E2=80=99s OK to miss some unlocks, as that just means we will fal=
sely delay ending of GP. However if we count locks first and then unlocks, w=
e are screwed if we miss counting a lock, because if we count the unlock cou=
nt for that missed lock, then we might end the GP sooner than we should!!!

Thanks,

  - Joel=20


>=20
> (See the infamous test6.pdf file, "MP" pattern.)
>=20
>                            Thanx, Paul
>=20
>> thanks,
>>=20
>> - Joel
>>=20
>>=20
>>> Cheers,
>>>=20
>>> - Joel
>>>=20
>>>=20
>>>=20
>>> On Fri, Dec 16, 2022 at 11:54 AM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Dec 16, 2022, at 11:51 AM, Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>>>=20
>>>>> =EF=BB=BFOn Fri, Dec 16, 2022 at 04:32:39PM +0000, Joel Fernandes wrot=
e:
>>>>>> On Thu, Dec 15, 2022 at 05:09:14PM -0800, Paul E. McKenney wrote:
>>>>>> [...]
>>>>>>>>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the re=
ader
>>>>>>>>>> has no new smp_mb() that happens AFTER the flip happened. So it c=
an
>>>>>>>>>> totally sample the old idx again -- that particular reader will
>>>>>>>>>> increment twice, but the next time, it will see the flipped one.
>>>>>>>>>=20
>>>>>>>>> I will let you transliterate both.  ;-)
>>>>>>>>=20
>>>>>>>> I think I see what you mean now :)
>>>>>>>>=20
>>>>>>>> I believe the access I am referring to is the read of idx on one si=
de and
>>>>>>>> the write to idx on the other. However that is incomplete and I nee=
d to
>>>>>>>> pair that with some of other access on both sides.
>>>>>>>>=20
>>>>>>>> So perhaps this:
>>>>>>>>=20
>>>>>>>> Writer does flip + smp_mb + read unlock counts [1]
>>>>>>>>=20
>>>>>>>> Reader does:
>>>>>>>> read idx + smp_mb() + increment lock counts [2]
>>>>>>>>=20
>>>>>>>> And subsequently reader does
>>>>>>>> Smp_mb() + increment unlock count. [3]
>>>>>>>>=20
>>>>>>>> So [1] races with either [2] or [2]+[3].
>>>>>>>>=20
>>>>>>>> Is that fair?
>>>>>>>=20
>>>>>>> That does look much better, thank you!
>>>>>>=20
>>>>>> Perhaps a comment with an ASCII diagram will help?
>>>>>>=20
>>>>>>=20
>>>>>> Case 2:
>>>>>> Both the reader and the updater see each other's writes too late, but=
 because
>>>>>> of memory barriers on both sides, they will eventually see each other=
's write
>>>>>> with respect to their own. This is similar to the store-buffer proble=
m. This
>>>>>> let's a single reader contribute a maximum (unlock minus lock) imbala=
nce of 2.
>>>>>>=20
>>>>>> The following diagram shows the subtle worst case followed by a simpl=
ified
>>>>>> store-buffer explanation.
>>>>>>=20
>>>>>> READER                  UPDATER
>>>>>> -------------           ----------
>>>>>>                          // idx is initially 0.
>>>>>> read_lock() {
>>>>>> READ(idx) =3D 0;
>>>>>> lock[0]++; --------------------------------------------,
>>>>>>                          flip() {                      |
>>>>>>                             smp_mb();                  |
>>>>>> smp_mb();                                              |
>>>>>> }                                                        |
>>>>>>                                                        |
>>>>>> // RSCS                                                  |
>>>>>>                                                        |
>>>>>> read_unlock() {                                          |
>>>>>> smp_mb();                                              |
>>>>>>                             idx++;  // P               |
>>>>>>                             smp_mb();                  |
>>>>>>                          }                             |
>>>>>>                                                        |
>>>>>>                          scan_readers_idx(0) {         |
>>>>>>                              count all unlock[0];      |
>>>>>>                                  |                     |
>>>>>>                                  |                     |
>>>>>> unlock[0]++; //X <--not-counted--`-----,               |
>>>>>>                                        |               |
>>>>>> }                                        V               `------,
>>>>>>                              // Will make sure next scan      |
>>>>>>                              // will not miss this unlock (X) |
>>>>>>                              // if other side saw flip (P) ,--`
>>>>>>                              // Call this MB [1]           |
>>>>>>                              // Order write(idx) with      |
>>>>>>                              // next scan's unlock.        |
>>>>>>                              smp_mb();                 ,---`
>>>>>> read_lock() {                                            |
>>>>>> READ(idx)=3D0;                                           |
>>>>>> lock[0]++; ----------------> count all lock[0];        |
>>>>>> smp_mb();         |     }                              |
>>>>>> }     |             |                                    V
>>>>>>     |             `---> // Incorrect contribution to lock counting
>>>>>>     |                   // upto a maximum of 2 times.
>>>>>>     |
>>>>>>      `---> // Pairs with MB [1]. Makes sure that
>>>>>>            // the next read_lock()'s' idx read (Y) is ordered
>>>>>>            // with above write to unlock[0] (X).
>>>>>>                           |
>>>>>> rcu_read_unlock() {         |
>>>>>> smp_mb(); <---------------`
>>>>>> unlock[0]++;
>>>>>> }
>>>>>>=20
>>>>>> read_lock() {
>>>>>> READ(idx) =3D 1; //Y
>>>>>> lock[1]++;
>>>>>> ...
>>>>>> }
>>>>>>                          scan_readers_idx(0) {
>>>>>>                              count all unlock[0]; //Q
>>>>>>                              ...
>>>>>>=20
>>>>>>=20
>>>>>> thanks,
>>>>>>=20
>>>>>> - Joel
>>>>>>=20
>>>>>>                         }
>>>>>>=20
>>>>>> This makes it similar to the store buffer pattern. Using X, Y, P and Q=

>>>>>> annotated above, we get:
>>>>>>=20
>>>>>> READER                    UPDATER
>>>>>> X (write)                 P (write)
>>>>>>=20
>>>>>> smp_mb();                 smp_mb();
>>>>>>=20
>>>>>> Y (read)                  Q (read)
>>>>>=20
>>>>> Given that this diagram is more than 50 lines long, it might go better=
 in
>>>>> a design document describing this part of RCU.  Perhaps less detail or=

>>>>> segmented, but the same general idea as this guy:
>>>>>=20
>>>>> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
>>>>=20
>>>> Yes, this sounds like a good place to add it and perhaps we refer to it=
 from the C source file? I can take this up to do over the holidays, if you p=
refer.
>>>>=20
>>>> Thanks,
>>>>=20
>>>>  - Joel
>>>>=20
>>>>=20
>>>>>=20
>>>>> Thoughts?
>>>>>=20
>>>>>                       Thanx, Paul
