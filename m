Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8873A605A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiJTIv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJTIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:51:42 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E99618B768
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:51:19 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id s3so13275467qtn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIGBtbPruzJlMBMkLHhYfgDDKlOsvKaYN/HBxX+ekE8=;
        b=THp/Fj3oKJOe0UiELxK3MuxqFqgQq6TqrobKoqMR8YpnTutwX8f43asOS8z9RFfHUK
         YmzeBshE+dX0eWPFwbIg2nI82dN0/ovD5YpC5Vy4o4pjv+hMRkRTKjlAghLOA8/K3JN1
         H4OBa5NMuQIrkgd/qMk3VOHjzcovWsLL8CtN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIGBtbPruzJlMBMkLHhYfgDDKlOsvKaYN/HBxX+ekE8=;
        b=QqUV/gjB3tX6ITTjj0WDx58CdV3iWQPXJgbMuR2zfiUPTcL4Ak/LWRraa+8Q1VhGOr
         YaZXPRDUhFvRxwMT6W6SKKli0AyNACoaYqemQxZMenIRRPkwBgFFumOcPAjolzX0T9ya
         6d+/hcT89bgqxiIHaIDpF5WE3+VtZBJCyT+kUpUru9SFlSdFsgWVGwHixN5X07I04Vca
         o40vNJwmUHEtA0qxf6PZmryL8DHXanASk6UFf8rU2cB+Cxzu7gFx9121m1N//JLJYdo3
         6BtwlcerzHnGZEcSBr/eCVdfGxIhfEPv67h7mhHpogLr+YK0r4mcZVyOkJSlbHE3C6gZ
         hnCw==
X-Gm-Message-State: ACrzQf2uMPR+NunJEljVoaHv7Z/PLN2zsIO4TusTPKM2ztGV6npuwzok
        JcO6q6EETCkFadksjAz+RHKGbg==
X-Google-Smtp-Source: AMsMyM6Qnu/JnVFc9TAdakQTWhVfNxZ1g4zOW7JEVNB3rG+0sb88Zpn8lV/IvayOAXdTH1Qs3jI+Hg==
X-Received: by 2002:a05:622a:100e:b0:39c:e7d2:21d0 with SMTP id d14-20020a05622a100e00b0039ce7d221d0mr9992320qte.352.1666255878099;
        Thu, 20 Oct 2022 01:51:18 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id p6-20020a05620a132600b006ee7923c187sm6712956qkj.42.2022.10.20.01.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 01:51:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Date:   Thu, 20 Oct 2022 04:51:17 -0400
Message-Id: <158BE4D6-039A-4D0B-B4DA-0FF7E35BCA1A@joelfernandes.org>
References: <20221019193015.mczb4ew2m4h2qjjy@airbuntu>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
In-Reply-To: <20221019193015.mczb4ew2m4h2qjjy@airbuntu>
To:     Qais Yousef <qyousef@layalina.io>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2022, at 3:30 PM, Qais Yousef <qyousef@layalina.io> wrote:
>=20
> =EF=BB=BFOn 10/19/22 15:41, Juri Lelli wrote:
>>> On 19/10/22 08:23, Joel Fernandes wrote:
>>>=20
>>>=20
>>>> On Oct 19, 2022, at 7:43 AM, Qais Yousef <qyousef@layalina.io> wrote:
>>>>=20
>>>> =EF=BB=BFOn 10/17/22 02:23, Joel Fernandes wrote:
>>>>=20
>>>>> I ran a test to check CFS time sharing. The accounting on top is confu=
sing,
>>>>> but ftrace confirms the proxying happening.
>>>>>=20
>>>>> Task A - pid 122
>>>>> Task B - pid 123
>>>>> Task C - pid 121
>>>>> Task D - pid 124
>>>>>=20
>>>>> Here D and B just spin all the time. C is lock owner (in-kernel mutex)=
 and
>>>>> spins all the time, while A blocks on the same in-kernel mutex and rem=
ains
>>>>> blocked.
>>>>>=20
>>>>> Then I did "top -H" while the test was running which gives below outpu=
t.
>>>>> The first column is PID, and the third-last column is CPU percentage.
>>>>>=20
>>>>> Without PE:
>>>>> 121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C=
)
>>>>> 123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B=
)
>>>>> 124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D=
)
>>>>>=20
>>>>> With PE:
>>>>> PID
>>>>> 122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A=
)
>>>>> 121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C=
)
>>>>> 123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B=
)
>>>>> 124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D=
)
>>>>>=20
>>>>> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Ins=
tead I
>>>>> get 4 threads with 25% in the top. Ftrace confirms that the D-state ta=
sk is
>>>>> in fact not running and proxying to the owner task so everything seems=

>>>>> working correctly, but the accounting seems confusing, as in, it is co=
nfusing
>>>>> to see the D-state task task taking 25% CPU when it is obviously "slee=
ping".
>>>>>=20
>>>>> Yeah, yeah, I know D is proxying for C (while being in the uninterrupt=
ible
>>>>> sleep state), so may be it is OK then, but I did want to bring this up=
 :-)
>>>>=20
>>>> I seem to remember Valentin raised similar issue about how userspace vi=
ew can
>>>> get confusing/misleading:
>>>>=20
>>>>   https://www.youtube.com/watch?v=3DUQNOT20aCEg&t=3D3h21m41s
>>>=20
>>> Thanks for the pointer! Glad to see the consensus was that this is not
>>> acceptable.
>>>=20
>>> I think we ought to write a patch to fix the accounting, for this
>>> series. I propose adding 2 new entries to proc/pid/stat which I think
>>> Juri was also sort of was alluding to:
>>>=20
>>> 1. Donated time.
>>> 2. Proxied time.
>>=20
>> Sounds like a useful addition, at least from a debugging point of view.
>=20
> They look useful addition to me too.

Thanks.

>>> User space can then add or subtract this, to calculate things
>>> correctly. Or just display them in new columns. I think it will also
>>> actually show how much the proxying is happening for a use case.
>>=20
>> Guess we'll however need to be backward compatible with old userspace?
>> Probably reporting the owner as running while proxied (as in the
>> comparison case vs. rtmutexes Valentin showed).
>>=20
>=20
> Or invent a new task_state? Doesn't have to be a real one, just report a n=
ew
> letter for tasks in PE state. We could use 'r' to indicate running BUT..

This is a good idea, especially for tracing. I still feel the time taken in t=
he state
is also important to add so that top displays percentage properly.

 Best,

 -J

> Cheers
>=20
> --
> Qais Yousef
