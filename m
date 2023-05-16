Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B41705A03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjEPVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEPVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:55:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646786EA2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4627E63FD3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E88EC4339C;
        Tue, 16 May 2023 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684274028;
        bh=c2XN6cZstCHczarNlQBcFrj20ialrTX30SbvpFfFpPA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=CVWAx9v832/iGK/cokVtpSu11MPkJz0I0Pfc4Ch/61XeqUtJU2S4lRGhjGJBQdKWe
         VWmLe7/1D3FLyp+Jd4XT8Em05Rn6e2E1Mk0Zfh5FiZsg0jEtpvQpPrkHhacnzKWujA
         /U+mdYAIaPHWgtye6ksZGmnxMLEw/aOcs0Ar8Cv0iG+6tfRQ+BAKGm1B0waJLUANmS
         Gq4w8rgZqFlH4zjKwMQL2RkGtyoqc7aiM8RZWnBkGsO4wMGaceYEqAqz9qGatIQdPs
         LAssY3krj4b3kIfEAaEEjfxmriuc9BICRVGD29TmwIACowgNCCwdWc8Hu5OTenTjUR
         QYBzWBIYetZQA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id EEF2227C0054;
        Tue, 16 May 2023 17:53:46 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Tue, 16 May 2023 17:53:46 -0400
X-ME-Sender: <xms:avtjZE2ay_OOWan78jYX-5kEfhvelx64SJhb4VyhQ4i5U4aiIeKQGg>
    <xme:avtjZPH8QwdGO4_J7haAKUf4qxiCYHUKvx0oonQ6jCMhaL9KePs5DB3QyNjmG65_O
    NIH1akANXJeGbJfl4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehveelgedvvedtfeehvdeuieetvdeijeegieeivdffgeeukeff
    tdefuedvieejvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgvvhhilhdqtghloh
    gtkhdqthgvshhtrdgttgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqud
    duiedukeehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrghes
    lhhinhhugidrlhhuthhordhush
X-ME-Proxy: <xmx:avtjZM6Qv1CBQSQGkNJpPJzQ5AHORnY9pZIGTsjy0XkzvbLmg1kxoA>
    <xmx:avtjZN0ndeSJkPyWI8bpvIvhW7Kwk0pZzOem204_mTSA1LPI5ElGdw>
    <xmx:avtjZHFLsinqRNvZFgpvsJhxmolyyOhA5T8vYTthW9U1ehzn_CZAvg>
    <xmx:avtjZM4sOPSF30RNkDHpr6bJ-H0C13STsfXTS_5aiC-L80dUZYmTdg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E6A1531A0063; Tue, 16 May 2023 17:53:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <6d2cf767-a5bb-4df4-bf9c-dcbf3bf82722@app.fastmail.com>
In-Reply-To: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
References: <tencent_4DC4468312A1CB2CA34B0215FAD797D11F07@qq.com>
Date:   Tue, 16 May 2023 14:53:24 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Rong Tao" <rtoax@foxmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Rong Tao" <rongtao@cestc.cn>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/vdso: Use non-serializing instruction rdtsc
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023, at 11:52 PM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> Replacing rdtscp or 'lfence;rdtsc' with the non-serializable instruction
> rdtsc can achieve a 40% performance improvement with only a small loss of
> precision.
>
> The RDTSCP instruction is not a serializing instruction, but it does wait
> until all previous instructions have executed and all previous loads are
> globally visible. The RDTSC instruction is not a serializing instruction.
> It does not necessarily wait until all previous instructions have been
> executed before reading the counter.
>
> Record the time-consuming of vdso clock_gettime(), pseudo code:
>
>     count = 1000 * 1000 * 100;
>     while (count--)
>         clock_gettime(CLOCK_REALTIME, &ts);
>
> Time-consuming comparison:
>
>      Time Consume(ns) | rdtsc_ordered() |  rdtsc()  | Promote
>     ------------------+-----------------+-----------+---------
>     Physical Machine  |  1269147289     | 759067324 |   40%
>      Guest OS (KVM)   |  1756615963     | 995823886 |   43%
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Out of curiosity, what happens if you apply that patch and run this thing:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git/tree/evil-clock-test.cc

Build it with g++ -O2 and run:

./evil-clock-test -c monotonic

--Andy
