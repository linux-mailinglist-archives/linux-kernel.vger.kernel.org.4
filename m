Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840B26597FC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiL3MGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 07:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiL3MGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 07:06:35 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E84F4B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 04:06:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E38393200912;
        Fri, 30 Dec 2022 07:06:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 30 Dec 2022 07:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        kjtsanaktsidis.id.au; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1672401991; x=1672488391; bh=GmqhIuavwX6LlFt4Yk7GjW8qSEznSJaZ0L/
        fHDnQmy4=; b=FyawH4eSoU6ODOiarNMKMVxlR4/sjOuJWAoqAI401TNC+izcWWy
        v5OKg/h+wmUZ3rRvCUoV73b3JvMYgMCOjQ7HmhMTzvjxJuQKqTFAAdgvMPVMiReK
        l14IhxAXeIroVK2qKWJ6sXcFxw2mi7B8HiGo1CWNI/5bfJiRX0qo9FUeOF6KCnD3
        +v5u9GDNOG+Gunb2rAcFmZIJOGLzt9EE+sUzt8phD3kza+rdxOBWcjRV+YAimH5h
        I1c+lFIdENNkKODjzLmRPseJXo4UtYkG2vlDbWZPsp+yhiqg2JAWcYytsrK+e5Js
        DoeiW5t8OEE0PNyFmYD+Zrp3cLxXDASdMhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672401991; x=1672488391; bh=GmqhIuavwX6Ll
        Ft4Yk7GjW8qSEznSJaZ0L/fHDnQmy4=; b=Ova1S/ljFrqtH3OFMB2vG5K5hJfSZ
        B/9r4vgwXUTd0hwxAXTzO4oAMtkfTVHXaveNfPf567eh4dPfAqp/xrbY+QcaV+s5
        ZW3XsBpLslssd6iM/HhR8FTP312KT5dCOETyglIRvRLbat2P3BBVDdf2tQ3OTfDT
        TyxndncfLXx4Efql33fkMqsB86GnK/SSXCfPnHOSDG9CHYEBPA8QQe5hT4/L7GM2
        b5HZ5sj5u7doX7Hr7XVNEcWVNu+s6awwJxM0NbFOqHdQtW16wvjFA4aolEkXseLk
        uEdY8WozuQz05A8HYr/HaDcAn3yaud+wm8gHnV6DvSqnclcB9ycHtFJhQ==
X-ME-Sender: <xms:R9SuYyuOMlBOTCdMCRs8Dq0tHh36RMD7FGL3Q-bEHqcadH7Mr_seeA>
    <xme:R9SuY3dG2zJxh5jy2h-9--jz4TYC5W-JwcSJhuY8nP2XH8T4ITvg2pflqL2uUpUFL
    2eVzbwrNoLXmmMaWNk>
X-ME-Received: <xmr:R9SuY9xCwMfZzDcdyOX6XH00xG8uFwjGHIvZRE9CZj6L4RaSpHa2WLSF8VIEHWNU-_iQZYv8lA9kGqn_9GaTMIraTEKAlc7svFXZqdfocOKEYKGRVF5Ij-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeigdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvvefftgfgfgggsehtqhertd
    dtreejnecuhfhrohhmpefmlfcuvfhsrghnrghkthhsihguihhsuceokhhjsehkjhhtshgr
    nhgrkhhtshhiughishdrihgurdgruheqnecuggftrfgrthhtvghrnhepleduheefjedvvd
    duhfevgeefhfehjeefleffgfettdeihffgjefgueevfeelvedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhjsehkjhhtshgrnhgrkhhtsh
    hiughishdrihgurdgruh
X-ME-Proxy: <xmx:R9SuY9OLoXieLgxeU3W9B-9B09XOW2Cv6Pde7ObyG_Y1Deu6QsIK3Q>
    <xmx:R9SuYy_fL51dRk90_x9oHafFvGt33370H9V7dBYpcuwlm6g6nmnULA>
    <xmx:R9SuY1XdIPL8IlGMa7D12IrE4i1AHVoYH5IlRturXwgzCkYvY-UDWA>
    <xmx:R9SuY3FfaJ8K7H7zqV5ombyX7k3BBPGPooN9WmwYS43SJKaZwJzpgQ>
Feedback-ID: ibd1946f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Dec 2022 07:06:29 -0500 (EST)
Message-ID: <2595040c7aeb3f7332c9bd3d7421e16d9465c0a8.camel@kjtsanaktsidis.id.au>
Subject: Why no pidfd's for threads?
From:   KJ Tsanaktsidis <kj@kjtsanaktsidis.id.au>
To:     linux-kernel@vger.kernel.org
Cc:     christian@brauner.io
Date:   Fri, 30 Dec 2022 23:06:25 +1100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been working on some performance profiling tooling for Ruby with
eBPF/pref_event_open. I was hoping to be able to use pidfd's from my
profiler process to keep track of when threads from a Ruby program
being profiled had exited. Unfortunately, I was surprised to find out
that pidfd_open can't be used to get fd's for non-thread-group-leaders
(it just returns EINVAL).

The first version of the pidfd_open patch seemed to support this, but
the version finally merged in did not, and I couldn't see any
discussion about _why_ doing this for threads was blocked. It seemed
there were a few warts around pidfd_send_signal directed at threads,
but having the pidfd of a thread seems to be independently useful
without pidfd_send_signal (e.g. - I want to use it to be notified about
thread exits in my profiling tool in a race-free way).

Absent this functionality, I'll have to either live with the race
conditions or use ptrace. The profiler binary has CAP_HWMON and
CAP_BPF, but it having CAP_PTRACE too is substantially scarier!

I was mostly just curious to understand the rationale for why
pidfd_open can't work with threads?

Thanks,
KJ
