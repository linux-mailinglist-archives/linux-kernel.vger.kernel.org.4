Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DC47133BD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjE0Jd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0Jdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:33:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F2DE;
        Sat, 27 May 2023 02:33:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 624303200952;
        Sat, 27 May 2023 05:33:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 27 May 2023 05:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685180028; x=1685266428; bh=K5
        HSzSXgcT98s5lBDkCfWoTpmYhsHpXg6HrwUgDT17w=; b=TT7EEIyxeFeWNuLBVT
        yW32yXFDncBwoZWU3EymCA/AKmOIkj6LUWqmYTVPTxUMXf1232uP7Pj5iX/i4feg
        sBTIvlP8tvmGHyVo/LupLQ49LSIFr7HlWHBuVXZQ7tR8ib4ACs5+rNfB243xeN0z
        FwHF8XnOmvCBEH1osHTEzQGY4Ep5dCvIdkW3Vir3CzUaNcAQN5YDWF0K6eM9WRK1
        34tArmyNIlH2DCuPp3502I+N+BjxCMU4287xLVME5LtLDWc2uEJ+orKv/w0rm2yC
        54GoVGOa+Zo8pxKKT15z+LCAHcQJUtupPPz4l5MPj1ygmp5KrjemJDFUkWdlzM+B
        Saig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685180028; x=1685266428; bh=K5HSzSXgcT98s
        5lBDkCfWoTpmYhsHpXg6HrwUgDT17w=; b=rM1q1rcBDxeTqZMmlqXVSXMgkPcbr
        ZodW4gGD/nDBS6ste/jBse17h1XICdAud9JmPW8nDWTXO9MN/0iJrfTXKBfDbDIB
        XlCw40q8nLV9D112QCDsRdRMiBioszqlClt23GM77kVuPnsMAm+72+YBeU85/s7l
        QeauHWThHvgphCWpeXxX5XoitJ5vrnf9O0oWA1+o7e5Q7t755H0KkD0YhVq3gwuh
        FpzI77DogSNSnDMtyT9pBEgOJQJ1MCh5eDz9theV20t+oIrQnsZoxiuyXRXXKiXM
        TKrREGAJkvom4lxH6dmkyIsj8jIiDMII6+X+6sNbH8r9xbj0wctiNfltQ==
X-ME-Sender: <xms:fM5xZIfrpannk7OuaOWRnfYeHbGziUIZ8rHJ_jc38jXvMJ_cd3YZ3w>
    <xme:fM5xZKOuqsfbsPbzBodeWicTj9SMK7HOHnAwD8-RrBo9yK7GEMN6TPvBqwXPhkMbC
    FH-jsyYt5aagorCZNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:fM5xZJglN6zEfoim9oo81tFrVKSItNlwhUQC3HPidvkPIR-kHQScPA>
    <xmx:fM5xZN_9RJwuUa7Fgf5HczKXazCEoGAPNwSBT55iJa6fcYnismDRiQ>
    <xmx:fM5xZEs2Ti3DHKi-dMZQURU7iWmVfZvdPBRUysSgNsaZmK9TuKYp8w>
    <xmx:fM5xZFnxqmd_ESz3W7DqJHvfFiudTt-IMXoRbbfV0o1H0yqoLxPu8Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 941FBB60089; Sat, 27 May 2023 05:33:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <f0194cbe-eb5b-40ee-8723-1927ebddefc1@app.fastmail.com>
In-Reply-To: <20230527034922.5542-1-kuniyu@amazon.com>
References: <20230526201607.54655398@kernel.org>
 <20230527034922.5542-1-kuniyu@amazon.com>
Date:   Sat, 27 May 2023 11:33:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kuniyuki Iwashima" <kuniyu@amazon.com>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc:     "Jakub Kicinski" <kuba@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
        "Xin Long" <lucien.xin@gmail.com>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        Netdev <netdev@vger.kernel.org>, stable@vger.kernel.org,
        willemdebruijn.kernel@gmail.com
Subject: Re: selftests: net: udpgso_bench.sh: RIP: 0010:lookup_reuseport
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27, 2023, at 05:49, Kuniyuki Iwashima wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 26 May 2023 20:16:07 -0700
>> On Wed, 24 May 2023 13:24:15 +0530 Naresh Kamboju wrote:
>> > While running selftests: net: udpgso_bench.sh on qemu-x86_64 the following
>> > kernel crash noticed on stable rc 6.3.4-rc2 kernel.
>> 
>> Can you repro this or it's just a one-off?
>> 
>> Adding some experts to CC.
>
> FWIW, I couldn't reproduce it on my x86_64 QEMU setup & 6.4.0-rc3
> at least 5 times, so maybe one-off ?

This looks like one of several spurious reports that lkft has produced
recently, where an 'int3' trap instruction is executed in a function
that is live-patched, but at a point where the int3 is not expected.

Anders managed to get a reproducer for one of these on his manchine
yesterday, and has narrowed it down to failing on qemu-7.2.2 but
not failing on qemu-8.0.

The current theory right now is that this is a qemu bug when
dealing with self-modifying x86 code that has been fixed in
qemu-8.0 already, and my suggestion would be to ignore all bugs
found by lkft that involve an 'int3' trap, and instead change
the lkft setup to use either qemu-8.0 or run the test systems
in kvm (which would also be much faster and save resources).

Someone still needs to get to the bottom of this bug to see
if it's in qemu or in the kernel livepatching code, but I'm
sure it has nothing to do with the ipv6 stack.

      Arnd
