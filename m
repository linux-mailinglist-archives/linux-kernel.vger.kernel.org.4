Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B069485F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBMOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjBMOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:43:40 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC431B300
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:43:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c2so13915756qtw.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=supPlbRV+eXNOD5GvgOhEaREvhsUxhfFsRvEzRM91kg=;
        b=S3xs/YaUgwS/zqCeJq7rbhRz2wk3lUmqMIM1Q/usfQNjMiQ/rshmRjU0ibdxdhTSer
         X5k1idvLs+Pajtes+qGQzw+14FNhb4lj/8OoFTgPJRuGDWf2Pel/yVh+pviYxbu0SUQx
         1qns1ibC8ZBGZh9hJBrgppvKTq9/BKA3PdvEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=supPlbRV+eXNOD5GvgOhEaREvhsUxhfFsRvEzRM91kg=;
        b=ELOfAzeEST1lcbpl+dLyCS48QCNVBNt2uJnzgirK67UOivSv60HybGVmON19cwU+V5
         ETWafJP02lagcFW4FrJR/zfvwKd8UnlITuhuow/F0o1DRrSuKQoKdeuNx2k859aGRYII
         NCgZq4GI4vqdSCH/IvQbtDZztHB+Y6ANY4VF1MtblIWGAd77Hhcct7BV6bxTqRz1jEzU
         QajokhxjfkE/t64BNQBQKYuHzzOTb96GYOO8A0G5GGO079C5TOX9y5AH8OvGkpjYIz48
         Dmx8OBrDGGB8y6TflpzqYnAAY4G18qjPkV3wi4BTFO3TbUgUaHJyd455TTDzjWWbVS7P
         mMLw==
X-Gm-Message-State: AO0yUKX6vINxnPcrV9DDFtrS7p4kYV1fe7SGVBtWvF8ojSrAoQACRi1P
        WguaTPtdnNWJbTARqoti9Mq/Jg==
X-Google-Smtp-Source: AK7set8tQPTqBA0b25zIwUlADaTbPTHAEn0hgT04h88qEE/1sdpw3uPRL44ZZjt7skwz/IEpMJVHCA==
X-Received: by 2002:a05:622a:c2:b0:3b7:fafc:73e3 with SMTP id p2-20020a05622a00c200b003b7fafc73e3mr42607583qtw.41.1676299413429;
        Mon, 13 Feb 2023 06:43:33 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id l25-20020ac84cd9000000b003ba1428e8d8sm5480600qtv.20.2023.02.13.06.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:43:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Date:   Mon, 13 Feb 2023 09:43:22 -0500
Message-Id: <B0B5741B-2A89-4092-935B-39B23EFEDC27@joelfernandes.org>
References: <PH0PR11MB588015D6429D592BBD599733DADF9@PH0PR11MB5880.namprd11.prod.outlook.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
In-Reply-To: <PH0PR11MB588015D6429D592BBD599733DADF9@PH0PR11MB5880.namprd11.prod.outlook.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
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



> On Feb 11, 2023, at 6:18 AM, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:=

>=20
> =EF=BB=BF
>>=20
>>=20
>>> On Sat, Feb 04, 2023 at 02:20:50AM +0000, Joel Fernandes (Google) wrote:=

>>> Recent discussion triggered due to a patch linked below, from Qiang,
>>> shed light on the need to accelerate from QS reporting paths.
>>>=20
>>> Update the comments to capture this piece of knowledge.
>>>=20
>>> Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@=
intel.com/
>>> Cc: Qiang Zhang <Qiang1.zhang@intel.com>
>>> Cc: Frederic Weisbecker <frederic@kernel.org>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>=20
>>> ---
>>> kernel/rcu/tree.c | 13 ++++++++++++-
>>> 1 file changed, 12 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 93eb03f8ed99..713eb6ca6902 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>>>      } else {
>>>              /*
>>>               * This GP can't end until cpu checks in, so all of our
>>> -              * callbacks can be processed during the next GP.
>>> +              * callbacks can be processed during the next GP. Do
>>> +              * the acceleration from here otherwise there may be extra=

>>> +              * grace period delays, as any accelerations from rcu_core=
()
>>> +              * or note_gp_changes() may happen only after the GP after=
 the
>>> +              * current one has already started. Further, rcu_core()
>>> +              * only accelerates if RCU is idle (no GP in progress).
>>=20
>> Actually note_gp_changes() should take care of that.
>>=20
>> You are referring to  rcu_core() -> rcu_check_quiescent_state() ->
>> note_gp_changes() doing the acceleration prior to the  rcu_core() ->
>> rcu_report_qs_rdp() call, correct?
>>=20
>> Ah, but note_gp_changes() has an early return which triggers if either:
>> 1. The rnp spinlock trylock failed.
>> 2. The start of a new grace period was already detected before, so
>> rdp->gp_seq =3D=3D rnp->gp_seq.
>>=20
>> So I think it is possible that we are in the middle of a GP, and
>> rcu_core() is called because QS reporting is required for the CPU, and
>> say the current GP started we are in the middle off occurs from the
>> same CPU so rdp->gp_seq =3D=3D rnp->gp_seq.
>>=20
>> Now, rcu_core()'s call to note_gp_changes() should return early but
>> its later call to report_qs_rdp() will not accelerate the callback
>> without the code we are commenting here.
>>=20
>> My gut feeling is that the
>> acceleration in rcu_report_qs_rdp() only stands for:
>>=20
>> * callbacks that may be enqueued from an IRQ firing during the small wind=
ow
>>  between the RNP unlock in note_gp_changes() and the RNP lock in
>>  rcu_report_qs_rdp()
>=20
> For rdp which is in the middle of a de-offloading process, the bypass list=
 have been
> flushed, the nocb kthreads may miss callbacks acceleration.   invoke call_=
rcu()
> will also not use bypass list. if at this time a new gp starts, before cal=
l rcu_report_qs_rdp()
> to report qs,  even if rcu_core() invoke note_gp_changes() notice gp start=
, this rdp's callback
> may still miss acceleration if rdp still in de-offloading process, because=
 invoke rcu_rdp_is_offloaded()
> still return true.
>=20
> I think this is also a reason.

I tend to agree with you. I am wondering the best way to document all these r=
easons. Perhaps it suffices to mention a few reasons briefly here, without g=
oing into too much detail (because details may be subject to change).

I will look through this entire thread again and take a call on how to proce=
ed, but do let me know what you and Frederic think about the next steps. The=
 main benefit of commenting is we dont look at this in a few years and run i=
nto the same question=E2=80=A6

Thanks!

Joel

>=20
> Thanks
> Zqiang
>=20
>>=20
>> Sure, this also seems like a valid reason.
>>=20
>> * __note_gp_changes() got called even before from the GP kthread, and cal=
lbacks
>>  got enqueued between that and rcu_core().
>>=20
>> Agreed. In this case we will take the early return in
>> note_gp_changes() when called from the rcu_core(). So yeah, that was
>> kind of my point as well but slightly different reasoning.
>>=20
>> Let me know if you disagree with anything I mentioned, though.
>>=20
>> - Joel
