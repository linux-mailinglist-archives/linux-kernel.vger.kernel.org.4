Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4792060459B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiJSMmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiJSMmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:42:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B93F5CD0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:25:10 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id i12so11233527qvs.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX+rOkD8xiyRrx474te3+Nur53Zz1oCFtNgi2XZ4aug=;
        b=w8SW2ygVI3hWLW5Pmjx6DvekATB7TTUUUVKrfq9vHYIsnChru1u6T9m27DmR2jWlfS
         QO/WEelth8HbM87OxEF7W6dtqVsck8OCfAbmDyGSQPM8iFdYti+xJphe+/0nGeCa8vLC
         OAT2HiOlw6hG+kRmXqZiRqXWKnPVmQncCn7zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX+rOkD8xiyRrx474te3+Nur53Zz1oCFtNgi2XZ4aug=;
        b=jllZmRCU1ictkuKENnJ25dCb/gucWY45hlK74cZk8tlFQ2Xk1Y8/Xe21hgu1bPm8Oz
         fjopxahT4rGhoNQGhuwut2M4fJ9NvpC7HLBny+pGMKxcc6zjYqVuNn0AdWKqTfwR285U
         w5pfGYxqhACGoyZSEAGbZDLpny6iBSSevHdjp1lkq1PfMu9/QZNyTZSkWp9rKe1Gss3b
         r2F7Dil1x3Io7tfaJCxAI4jiqpSBKnsCWsyr+SufLWjCDLAIhw0AOPq5bnwcY2CGzNtb
         WQRQQXnQ37+Xt1plAOGNEhIs+l2GLp7RX/YrmUxQRFW5zZfjEsIiPNmFoOTRrAxYneyy
         uflA==
X-Gm-Message-State: ACrzQf08xDd0e/KU4RdJ00AWhh+TlIeZZjQA/wyNjyVpm9BbRUNcyOJM
        RGj0+Bt4chaAKn+0w1AlD9MNOQ==
X-Google-Smtp-Source: AMsMyM6HNBTGsFU69pHyX6l5c9VBW2LIgK6+XPrK/paT5vUtfPci4KktmmgFZh+9zSKP4ammWlCuxQ==
X-Received: by 2002:a05:6214:29e7:b0:4b1:c8f7:5ec6 with SMTP id jv7-20020a05621429e700b004b1c8f75ec6mr6217576qvb.79.1666182220111;
        Wed, 19 Oct 2022 05:23:40 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006ed99931456sm4695240qkh.88.2022.10.19.05.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:23:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Date:   Wed, 19 Oct 2022 08:23:39 -0400
Message-Id: <F9BCD313-15BA-429C-B50C-1391DDC1239B@joelfernandes.org>
References: <20221019114357.yipijpetxz7ns5aq@airbuntu>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
In-Reply-To: <20221019114357.yipijpetxz7ns5aq@airbuntu>
To:     Qais Yousef <qyousef@layalina.io>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 19, 2022, at 7:43 AM, Qais Yousef <qyousef@layalina.io> wrote:
>=20
> =EF=BB=BFOn 10/17/22 02:23, Joel Fernandes wrote:
>=20
>> I ran a test to check CFS time sharing. The accounting on top is confusin=
g,
>> but ftrace confirms the proxying happening.
>>=20
>> Task A - pid 122
>> Task B - pid 123
>> Task C - pid 121
>> Task D - pid 124
>>=20
>> Here D and B just spin all the time. C is lock owner (in-kernel mutex) an=
d
>> spins all the time, while A blocks on the same in-kernel mutex and remain=
s
>> blocked.
>>=20
>> Then I did "top -H" while the test was running which gives below output.
>> The first column is PID, and the third-last column is CPU percentage.
>>=20
>> Without PE:
>>  121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C)=

>>  123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B)=

>>  124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D)=

>>=20
>> With PE:
>>  PID
>>  122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A)=

>>  121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C)=

>>  123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B)=

>>  124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D)=

>>=20
>> With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Instea=
d I
>> get 4 threads with 25% in the top. Ftrace confirms that the D-state task i=
s
>> in fact not running and proxying to the owner task so everything seems
>> working correctly, but the accounting seems confusing, as in, it is confu=
sing
>> to see the D-state task task taking 25% CPU when it is obviously "sleepin=
g".
>>=20
>> Yeah, yeah, I know D is proxying for C (while being in the uninterruptibl=
e
>> sleep state), so may be it is OK then, but I did want to bring this up :-=
)
>=20
> I seem to remember Valentin raised similar issue about how userspace view c=
an
> get confusing/misleading:
>=20
>    https://www.youtube.com/watch?v=3DUQNOT20aCEg&t=3D3h21m41s

Thanks for the pointer! Glad to see the consensus was that this is not accep=
table.

I think we ought to write a patch to fix the accounting, for this series. I p=
ropose adding 2 new entries to proc/pid/stat which I think Juri was also sor=
t of was alluding to:

1. Donated time.
2. Proxied time.

User space can then add or subtract this, to calculate things correctly. Or j=
ust display them in new columns. I think it will also actually show how much=
 the proxying is happening for a use case.

Thoughts?

Thanks.


> Cheers
>=20
> --
> Qais Yousef
