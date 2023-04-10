Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727706DCC63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDJUze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDJUzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4D213D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA4B61F5A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC0FC4339B;
        Mon, 10 Apr 2023 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681160055;
        bh=Im283+1n2F0644CfqxJdlvAQcxh1Khixa5iXZ7xH5Bk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=hIUMfY86QAw8uRu7VwWJXmBmOIeEmJzINn0AOMbOJjVrIb8PvskwyrKSgPrjturmf
         FtrPD/kC6OjyQvYKx4FGd/vchEwx6sf5qa3Q0JjJ0JAQfpoXRkUCxOtO7rPzmAw0I2
         DkzxI1ZhGBOr7WcJo2BmD1m4WyBjYwOT2WskqjXYSHtI/25JVkSLkidyuw9KDpeekt
         DbsI1DqhlyghU5+InZGfr6CID2VWbTq9sLm97jIZEKz2qIrpxfmMZbAZoHWNMvxH91
         gDF2V4pJxUR1UzgdXwDTbwIRP5exFbIsZ3CpP3J+jcx9BklDadY4R6C8u/MYpNDimG
         c8T/XywxbUlrw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A720127C0054;
        Mon, 10 Apr 2023 16:54:13 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 10 Apr 2023 16:54:13 -0400
X-ME-Sender: <xms:dXc0ZAlQUHAJ8awdnEHis5JXHib9bjZhNqc-GJo2mW6IJaJx0bUaIg>
    <xme:dXc0ZP1FXNi-ZLTw0vZZJmyFQ7oFzG57sXV_EpFioF6zD6yx-FL8I11iZCTtVK3cy
    6qj9zInHy0Bdhyo3AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekvddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehnugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedv
    udeileeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudei
    udekheeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlih
    hnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:dXc0ZOpyx-jBWl-SnW4wkmgKjI7BzOCDg_su5aR6LQw9txc5L5BH1A>
    <xmx:dXc0ZMmVxW4yACPvU0d-xHYAhtCoKTiXLlqHiLiFRQ8jxzvBsR8pNg>
    <xmx:dXc0ZO0gQ05r_nNOw2n8HNNr1F2SaP7VlABKE25E0sNs4VCOIN_U2Q>
    <xmx:dXc0ZLvmIEWlAlcc1R30agkIuBmMkUMnPmz_4pVsSboUGqySKhuZFw>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 146FF31A006E; Mon, 10 Apr 2023 16:54:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <e962d5d0-e3be-495b-8718-db0123509acb@app.fastmail.com>
In-Reply-To: <CANaxB-wykCH+2fgrwBNe2BkTmEJpZjhsFBekiS_qaQHz4vYt8Q@mail.gmail.com>
References: <20230308073201.3102738-1-avagin@google.com>
 <20230308073201.3102738-5-avagin@google.com>
 <CALCETrUB_rCCBa9TPt+7x0MBfKP9L5e8JXva-rDzE3B-AGEzNA@mail.gmail.com>
 <CANaxB-wykCH+2fgrwBNe2BkTmEJpZjhsFBekiS_qaQHz4vYt8Q@mail.gmail.com>
Date:   Mon, 10 Apr 2023 13:53:52 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andrei Vagin" <avagin@gmail.com>
Cc:     "Andrei Vagin" <avagin@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Christian Brauner" <brauner@kernel.org>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Peter Oskolkov" <posk@google.com>,
        "Tycho Andersen" <tycho@tycho.pizza>,
        "Will Drewry" <wad@chromium.org>,
        "Vincent Guittot" <vincent.guittot@linaro.org>
Subject: Re: [PATCH 4/6] seccomp: add the synchronous mode for seccomp_unotify
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Apr 9, 2023, at 11:59 PM, Andrei Vagin wrote:
> On Wed, Apr 5, 2023 at 8:42=E2=80=AFPM Andy Lutomirski <luto@kernel.or=
g> wrote:
>>
>> On Tue, Mar 7, 2023 at 11:32=E2=80=AFPM Andrei Vagin <avagin@google.c=
om> wrote:
>> >
>> > seccomp_unotify allows more privileged processes to do actions on b=
ehalf
>> > of less privileged processes.
>> >
>> > In many cases, the workflow is fully synchronous. It means a target
>> > process triggers a system call and passes controls to a supervisor
>> > process that handles the system call and returns controls to the ta=
rget
>> > process. In this context, "synchronous" means that only one process=
 is
>> > running and another one is waiting.
>> >
>> > There is the WF_CURRENT_CPU flag that is used to advise the schedul=
er to
>> > move the wakee to the current CPU. For such synchronous workflows, =
it
>> > makes context switches a few times faster.
>> >
>> > Right now, each interaction takes 12=C2=B5s. With this patch, it ta=
kes about
>> > 3=C2=B5s.
>>
>> This is great, but:
>>
>> >
>> > This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag t=
hat
>> > it used to enable the sync mode.
>>
>> Other than being faster, what does this flag actually do in terms of
>> user-visible semantics?
>
> In short, the process handling an event wakes up on the same cpu where=
 the
> process that triggered the event has been running. Knowing this fact, =
the user
> can understand when it is appropriate to use this flag.
>
> Let's imagine that we have two processes where one calls syscalls (the
> target) and another one handles these syscalls (the supervisor). In th=
is case,
> the user should see that both processes are running on the same cpu.

So I think you're saying it has no semantic effect.  It's a performance =
thing.

>
> If we have one target process and one supervisor process, they synchro=
nously
> swap with each other and don't need to run on cpu concurrently.  But
> it becomes more
> complicated if one supervisor handles a group of target processes. In =
this
> case, setting the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag depends on t=
he
> frequency of events. If the supervisor often has pending events (doesn=
't sleep
> between events), it is better to unset the flag or add more supervisor
> processes.

ISTM the kernel ought to be able to handle this much more automatically.=
  The scheduler knows whether the target is running and how busy it has =
been.

I'm not sure what the right heuristic is in the kernel, but I'm also not=
 convinced that user code has any particular insight here.
