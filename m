Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDE6005DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJQD4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJQD4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:56:41 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C3552830
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:56:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g11so7046513qts.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPAgj+vQBUgtAEZ05Og6RBNbVrmwiiKfNndLC91Ofe4=;
        b=aKF+NIFp8iQhYp9KwMr7u9QPvH7jtKxrN7XT4Ap68ObKzh8CrUJtE6qxjGD05IgLbp
         7fFTV9Gnx5fngaWdSCzg3evkegJW1EUYd8AWW17QND45Ql+MRRAxbEQxihFVByfzQJs1
         HuMKX6vuYUgfyDDFj/J7awjsnQuR1+IzKoTO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPAgj+vQBUgtAEZ05Og6RBNbVrmwiiKfNndLC91Ofe4=;
        b=N7mclU4B4zUxSiJc5lxoZE2oMPKHPMjTQon6P97T0nTVsws2+MFd6O1c8XYoVmAIL1
         AMZD4P8PMVi2n4zZoGNgQxZJecPHobaXMGwNN3DIG9EMCfqqrvVmvjmTRO4ukqUC3yFl
         OjNIBjcYQMTzjUz3+DlUtr0vs3lRSomkZU+a7g+4wtXv8cbnmf+WdaRhzc99sOVHL8i6
         nawZZUIOVYefsmDfxTWSO/zY3QWw1B0y4Q7vDVzkyfsv5eeJNT6APSI59I00Zhd26vYM
         7Ri/SXG3NxHGdUIt0Ut1z1IgQ59MMGSZAjoJcp9sup1rwZPhkMjJP0+KUxDBiPsf2jmA
         u4dA==
X-Gm-Message-State: ACrzQf0zJ91462G/6ox+2dD2Rmtulbe5zDZyb19Qf5TgXrUsqBNHZwy/
        M/pzm3e2gjhRcYykry360TcuWQ==
X-Google-Smtp-Source: AMsMyM6qPpJEGagGz+bg5D2Srb4pJVFuqcg/A1sW/sWy4JWxh8Vg9ydVlbX+sNKpzRxV1tnZxkDTwA==
X-Received: by 2002:ac8:5b87:0:b0:39c:b5a6:193b with SMTP id a7-20020ac85b87000000b0039cb5a6193bmr7320221qta.461.1665978999439;
        Sun, 16 Oct 2022 20:56:39 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v6-20020ac87286000000b0038b684a1642sm6996917qto.32.2022.10.16.20.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 20:56:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Date:   Sun, 16 Oct 2022 23:56:38 -0400
Message-Id: <802E39EA-7444-4B33-AB95-594A600FE404@joelfernandes.org>
References: <d5d72856-417a-0fe7-4b1d-3e27c64c1a85@linux.dev>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
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
In-Reply-To: <d5d72856-417a-0fe7-4b1d-3e27c64c1a85@linux.dev>
To:     Chengming Zhou <zhouchengming@bytedance.com>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2022, at 11:25 PM, Chengming Zhou <zhouchengming@bytedance.com>=
 wrote:
>=20
> =EF=BB=BFHello,
>=20
>> On 2022/10/4 05:44, Connor O'Brien wrote:
>> Proxy execution is an approach to implementing priority inheritance
>> based on distinguishing between a task's scheduler context (information
>> required in order to make scheduling decisions about when the task gets
>> to run, such as its scheduler class and priority) and its execution
>> context (information required to actually run the task, such as CPU
>> affinity). With proxy execution enabled, a task p1 that blocks on a
>> mutex remains on the runqueue, but its "blocked" status and the mutex on
>> which it blocks are recorded. If p1 is selected to run while still
>> blocked, the lock owner p2 can run "on its behalf", inheriting p1's
>> scheduler context. Execution context is not inherited, meaning that
>> e.g. the CPUs where p2 can run are still determined by its own affinity
>> and not p1's.
>=20
> This is cool. We have a problem (others should have encountered it too) th=
at
> priority inversion happened when the rwsem writer is waiting for many read=
ers
> which held lock but are throttled by CFS bandwidth control. (In our use ca=
se,
> the rwsem is the mm_struct->mmap_sem)
>=20
> So I'm curious if this work can also solve this problem? If we don't deque=
ue
> the rwsem writer when it blocked on the rwsem, then CFS scheduler pick it t=
o
> run, we can use blocked chain to find the readers to run?

That seems a lot harder and unsupported by current patch set AFAICS (my expo=
sure to this work is about a week so take it with a grain of salt). You coul=
d have multiple readers so how would you choose which reader to proxy for (r=
ound robin?).  Also, you no longer have a chain but a tree of chains, with t=
he leaves being each reader - so you have to track that somehow, then keep m=
igrating the blocked tasks in the chain to each readers CPU. Possibly migrat=
ing a lot more than in the case of a single chain. Also it=E2=80=99s not cle=
ar if it will be beneficial as proxying for one reader does not mean you=E2=80=
=99re improving the situation if it is another reader that is in need of the=
 boost.

Thanks.

>=20
> Thanks!
>=20
