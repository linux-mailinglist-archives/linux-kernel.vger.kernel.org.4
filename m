Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB864E3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLOWWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLOWWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:22:35 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17200140D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:22:34 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id h26so659684vsr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6clAxsZStafJlycBrg0Ky96wQRhZ+hjCree5wij5Ncw=;
        b=N9Ka//VSuzCs5fpMDqj9Utl6+Iv91jDM0mgYOImXF4qYUKG3hOWMTiMYmaJUtxOPry
         18pgryV1J28q9L8AHmRlqs6fFb4ODew20pW1iixfh13jFI2hFNnEboMRb7ewZx3sAMgG
         WJcdHH0N9UIT5wVvk+U3yZDzWUzXzhypstvvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6clAxsZStafJlycBrg0Ky96wQRhZ+hjCree5wij5Ncw=;
        b=5DieTTCEiMbuj0BKTagRY5QhSlUzwGPH9Ls9lMZAp+QAhktWREChNmgyoe3yz5/3gr
         YR84eJG62EKJ6CrQVEj+GCZizMQyZQuPs+oL5AYbXkff/SQBlemqWr2fHQRf+IgVXMHm
         in1RDArjOjsWio6RXkbnVT9wcyPKdxdMtokC2Tgs++8lrwO2PoBrc91C2aNYPM39wZTi
         ox61+XTP0QEbkJxtRS8Z4gi7Nm9nXKqFXIe9v76EYgQZtGP3c5xwBOSn7ajrOpP+esII
         C6o/I/abNZ3jCzyQsKiifnCEPJBAqek1ZhrqIk3H7eZ34PL3H/kvkuupIyKOSGuJYNf5
         gytw==
X-Gm-Message-State: ANoB5pnlsEv5Cl9R/mnM0PmqTFtgbIfs2i73uiyMs0bXlZKI7mHQMm+K
        UmJs3pjiFkBzKG6hGDuX7fL/ww==
X-Google-Smtp-Source: AA0mqf5bqjEbkF2qYjJXpaPGw8I/HpJBkdJKb2G2f72/CvHdcOWfJaEpfTKG+wzrFJntTNtVfCh0uw==
X-Received: by 2002:a67:6f07:0:b0:3aa:5967:ec20 with SMTP id k7-20020a676f07000000b003aa5967ec20mr16157853vsc.3.1671142953035;
        Thu, 15 Dec 2022 14:22:33 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id br36-20020a05620a462400b006fed58fc1a3sm85123qkb.119.2022.12.15.14.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 14:22:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Thu, 15 Dec 2022 17:22:21 -0500
Message-Id: <07A65F0F-89CE-481B-BD6C-6D4946E70482@joelfernandes.org>
References: <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <EE4EC3CC-395E-475D-BEBE-545955AB97C8@joelfernandes.org>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 15, 2022, at 5:13 PM, Joel Fernandes <joel@joelfernandes.org> wrote=
:
>=20
> =EF=BB=BF
>=20
>> On Dec 15, 2022, at 3:13 PM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>>=20
>> =EF=BB=BFOn Thu, Dec 15, 2022 at 05:58:14PM +0000, Joel Fernandes wrote:
>>>> On Thu, Dec 15, 2022 at 5:48 PM Joel Fernandes <joel@joelfernandes.org>=
 wrote:
>>>>=20
>>>>>> On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org>=
 wrote:
>>>>>=20
>>>>>>> Scenario for the reader to increment the old idx once:
>>>>>>>=20
>>>>>>> _ Assume ssp->srcu_idx is initially 0.
>>>>>>> _ The READER reads idx that is 0
>>>>>>> _ The updater runs and flips the idx that is now 1
>>>>>>> _ The reader resumes with 0 as an index but on the next srcu_read_lo=
ck()
>>>>>>> it will see the new idx which is 1
>>>>>>>=20
>>>>>>> What could be the scenario for it to increment the old idx twice?
>>>>>>=20
>>>>>> Unless I am missing something, the reader must reference the
>>>>>> srcu_unlock_count[old_idx] and then do smp_mb() before it will be
>>>>>> absolutely guaranteed of seeing the new value of ->srcu_idx.
>>>>>=20
>>>>> I think both of you are right depending on how the flip raced with the=

>>>>> first reader's unlock in that specific task.
>>>>>=20
>>>>> If the first read section's srcu_read_unlock() and its corresponding
>>>>> smp_mb()  happened before the flip, then the increment of old idx
>>>>> would happen only once. The next srcu_read_lock() will read the new
>>>>> index. If the srcu_read_unlock() and it's corresponding smp_mb()
>>>>> happened after the flip, the old_idx will be sampled again and can be
>>>>> incremented twice. So it depends on how the flip races with
>>>>> srcu_read_unlock().
>>>=20
>>> I am sorry this is inverted, but my statement's gist stands I believe:
>>>=20
>>> 1. Flip+smp_mb() happened before unlock's smp_mb() -- reader will not
>>> increment old_idx the second time.
>>=20
>> By "increment old_idx" you mean "increment ->srcu_lock_count[old_idx]",
>> correct?
>=20
> Yes sorry for confusing, i indeed meant lock count increment corresponding=
 to the old index.
>>=20
>> Again, the important ordering isn't the smp_mb(), but the accesses,
>> in this case, the accesses to ->srcu_unlock_count[idx].
>=20
> I was talking about ordering of the flip of index (write) with respect to b=
oth the reading of the old index  in the rcu_read_lock() and its subsequent l=
ock count increment corresponding to that index. I believe we are talking he=
r about how this race can effect the wrap around issues when scanning for re=
aders in the pre flip index, and we concluded that there can be at most 2 of=
 these on the SAME task. The third time, reader will always see the new flip=
ped index because of the memory barriers on both sides. IOW, the same task c=
annot overflow the lock counter on the preflipped index and cause issues. Ho=
wever there can be Nt different tasks so perhaps you can have 2*Nt number of=
 preempted

Sorry, to be more precise, I mean you have Nt preempted readers, which owing=
 to memory barriers, if you have at least Nt CPUs, and they each ran on thos=
e CPUs, then you can have 2*Nt increments on the lock count at the old index=
.=20

Or something.

Thanks.




> readers that had sampled the old index and now will do a lock and unlock o=
n that old index, potentially causing a lock=3D=3Dunlock match when there sh=
ould not be a match.
>=20
>>=20
>>> 2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
>>> has no new smp_mb() that happens AFTER the flip happened. So it can
>>> totally sample the old idx again -- that particular reader will
>>> increment twice, but the next time, it will see the flipped one.
>>=20
>> I will let you transliterate both.  ;-)
>=20
> I think I see what you mean now :)
>=20
> I believe the access I am referring to is the read of idx on one side and t=
he write to idx on the other. However that is incomplete and I need to pair t=
hat with some of other access on both sides.
>=20
> So perhaps this:
>=20
> Writer does flip + smp_mb + read unlock counts [1]
>=20
> Reader does:
> read idx + smp_mb() + increment lock counts [2]
>=20
> And subsequently reader does
> Smp_mb() + increment unlock count. [3]
>=20
> So [1] races with either [2] or [2]+[3].
>=20
> Is that fair?
>=20
>>> Did I get that right? Thanks.
>>=20
>> So why am I unhappy with orderings of smp_mb()?
>>=20
>> To see this, let's take the usual store-buffering litmus test:
>>=20
>>   CPU 0            CPU 1
>>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>>   smp_mb();        smp_mb();
>>   r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>>=20
>> Suppose CPU 0's smp_mb() happens before that of CPU 1:
>>=20
>>   CPU 0            CPU 1
>>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>>   smp_mb();
>>               smp_mb();
>>   r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>>=20
>> We get r0 =3D=3D r1 =3D=3D 1.
>>=20
>> Compare this to CPU 1's smp_mb() happening before that of CPU 0:
>>=20
>>   CPU 0            CPU 1
>>   WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);
>>               smp_mb();
>>   smp_mb();
>>   r0 =3D READ_ONCE(y);    r1 =3D READ_ONCE(x);
>>=20
>> We still get r0 =3D=3D r1 =3D=3D 1.  Reversing the order of the two smp_m=
b()
>> calls changed nothing.
>>=20
>> But, if we order CPU 1's write to follow CPU 0's read, then we have
>> this:
>>=20
>>   CPU 0            CPU 1
>>   WRITE_ONCE(x, 1);
>>   smp_mb();
>>   r0 =3D READ_ONCE(y);
>>               WRITE_ONCE(y, 1);
>>               smp_mb();
>>               r1 =3D READ_ONCE(x);
>>=20
>> Here, given that r0 had the final value of zero, we know that
>> r1 must have a final value of 1.
>>=20
>> And suppose we reverse this:
>>=20
>>   CPU 0            CPU 1
>>               WRITE_ONCE(y, 1);
>>               smp_mb();
>>               r1 =3D READ_ONCE(x);
>>   WRITE_ONCE(x, 1);
>>   smp_mb();
>>   r0 =3D READ_ONCE(y);
>>=20
>> Now there is a software-visible difference in behavior.  The value of
>> r0 is now 1 instead of zero and the value of r1 is now 0 instead of 1.
>>=20
>> Does this make sense?
>=20
> Yes I see what you mean. In first case, smp_mb() ordering didn=E2=80=99t m=
atter. But in the second case it does.
>=20
> Thanks,
>=20
> - Joel
>=20
>=20
>>=20
>>                           Thanx, Paul
