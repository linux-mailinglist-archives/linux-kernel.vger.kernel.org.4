Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4BF678A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjAWWJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjAWWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:09:07 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67192B45A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:08:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C9435C0056;
        Mon, 23 Jan 2023 17:07:35 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 23 Jan 2023 17:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674511655; x=1674598055; bh=bzt6HBHY2W
        W0HFYqCQFOTE9QfHZY1ZHvRae7g7Zbkv0=; b=K98haPcPjO7BuZA3/uPDh8HLvN
        TsGnvO/mP0QOn+3yqcn0ma3PO3RC1Ow0E7wKHstxsiTbZ5Q2xDfiezgp+fT0jEVB
        LL6e+ITEQiw/Ufnldv9IW4ALJgqGio5gyT2fAnBkuie/Hh6KEuwlBV+MEnjhBnZE
        aa81MdM0lE9XDCDkFFclYnAFre8QfvRt7BrwmXgfTcCQOgRtX8BdQ2OlK9fjUm+1
        4QMkwnz2Vv+KxYtFD8p3sCeFhMruZt8ndfplm9ct5/NUS9oWXejTo+40KMYWzAsD
        /dsBJcbJGpj1jhkp1EIDlhFGaqhgAnT30Gi2fYqf04N2FThTa0V1yrctgvuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674511655; x=1674598055; bh=bzt6HBHY2WW0HFYqCQFOTE9QfHZY
        1ZHvRae7g7Zbkv0=; b=Bn3t6iLTfiCj5bqaxUJh8p/pp3h0zt7oB4MZ5vTvDlLs
        CkyXKatPykCUXrQDGtWlna80+JBxJH7t3EJ470ykwl/G/a+wE5EmUpCttlefQzUh
        1FCEOieNOjF+52hua6HE6y7luosqhxKbWnMzGBiLTfa+Da8Ll3SCRw1G01GlM8Po
        6kztSt0kwkHVL2mdOIWBySwm5bVivIyBDdWRwbPWzKT2l5cqteQeAm7BJU3oDrei
        zC3ldKtED7d28N4ibmD+7sFCIERuuAMQiMDPCSqaY2pbKa4X1voGPWQvPLV0kT8r
        Vkhj1QeAmUV+LuUomduO9kRY8t69K4z68JCP1CVprA==
X-ME-Sender: <xms:JgXPY_bVVifwrdAwXRAnH_HI3ZpaxxE7_ctTK_98aTBqZ5GYSVqqfA>
    <xme:JgXPY-Y58p76t5KN2Ihx9zNFunKRGa45q9ugWzl19dtL_NVSpybwFW-4w_26Qlfet
    Kc-Ka9UYkzj-pgi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdev
    ohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqne
    cuggftrfgrthhtvghrnhepjeeutddttdehgefgteffjefgveevveeugeegtefgvdejfefg
    fffgffejlefhtdfgnecuffhomhgrihhnpehlfihnrdhnvghtpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrgh
X-ME-Proxy: <xmx:JgXPYx-jjxitHMaJkzDMDbl76NLn8dAsOTp1FF9meBqWcOmPT0Ffew>
    <xmx:JgXPY1q6LQkwomRvBKEZ-d7tAW16v-_hQ6GdYrtDX5TruM68Vvvheg>
    <xmx:JgXPY6r4IBHFvt2vh_7-kbx0yvZv1INsOvi8uKDtmS6DAjAuvXn27g>
    <xmx:JwXPY2eReR2oERBXQVNr6pW4OMJy9d1KDzULTSCR0rHa9XBOCM80EQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B87F02A20085; Mon, 23 Jan 2023 17:07:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <3839bced-74f7-4afb-8068-c1cdde7b61fe@app.fastmail.com>
In-Reply-To: <874jshdpl3.fsf@redhat.com>
References: <20230120102512.3195094-1-gscrivan@redhat.com>
 <db72efdd-5cb2-4578-a322-bf894fcf6066@app.fastmail.com>
 <874jshdpl3.fsf@redhat.com>
Date:   Mon, 23 Jan 2023 17:07:13 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "Giuseppe Scrivano" <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, "Kees Cook" <keescook@chromium.org>,
        bristot@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        brauner@kernel.org, "Aleksa Sarai" <cyphar@cyphar.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Alexander Larsson" <alexl@redhat.com>, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jan 23, 2023, at 2:21 PM, Giuseppe Scrivano wrote:
> "Colin Walters" <walters@verbum.org> writes:
>
>> On Fri, Jan 20, 2023, at 5:25 AM, Giuseppe Scrivano wrote:
>>> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
>>> processes to hide their own /proc/*/exe file. When this prctl is
>>> used, every access to /proc/*/exe for the calling process will
>>> fail with ENOENT.
>>
>> How about a mount option for procfs like `mount -t procfs procfs /proc -o rw,nosuid,nodev,magiclink-no-xdev`
>>
>> Where `magiclink-no-xdev` would cause all magic links to fail to cross a pid namespace or so?
>
> wouldn't that break also stuff like "/proc/self/fd/$FD" after you join a
> different PID namespace?

Ah, right.  Hmm.  But building on the reply to
https://lwn.net/Articles/920876/
maybe an opt-in flag like `-o magiclink-restricted=/proc/<pid>/ns/pid` that required callers to have CAP_SYS_ADMIN in the referenced namespace?  Then things like crun/runc would open a fd for `/proc/self/ns/pid` when they start (usually, this is the init ns), then pass the reference to that fd into magiclink-restricted.

There may be a more elegant userspace API here; I think my overall point is reiterating what I mentioned in 
https://github.com/containers/crun/pull/1105#issuecomment-1360085059

"A minor worry I have with both is that any namespacing-based approach that controls visibility in /proc runs the risk of someone adding a new way to get to the binary; maybe it's something like us having a fd for ourselves open under /proc/pid/fd/ or so."

So instead of hiding just /proc/self/exe, we add some sort of API that aims to restrict all other magic links that may be added in the future.

The history of map_files is interesting here; it looks like https://github.com/torvalds/linux/commit/bdb4d100afe9818aebd1d98ced575c5ef143456c introduces a comment that says

"* Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
 * symlinks may be used to bypass permissions on ancestor directories in the
 * path to the file in question."

yet isn't there an inconsistency here in not applying the same restrictions on /proc/self/exe?

Or another way to look at this is that if we were to add some sort of API like this on /proc, we'd also change the proc_maps code to also honor it *instead* if present instead of limiting to the init ns?

