Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92DC63B215
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiK1TTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbiK1TSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:18:42 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C112180;
        Mon, 28 Nov 2022 11:18:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EC595C01CE;
        Mon, 28 Nov 2022 14:18:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 14:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669663113; x=1669749513; bh=5KWIVqt9TJ
        GuD+cVVciSmLqFdiVm+k4C5GFJJ1JiWg4=; b=XHxhWqjoMQP1E0rqSXQy8qnlaJ
        6mMT28QC6GLbT7rJVoqflLXkINWGA6ngNCkggLnXGLIn1huqu1t+cRP0/dTfhzw3
        WGdBx9LZIfJzW++a6tM6I0vcvncNJLCroMdxddCiYeKmzIqnAD3RQg1jOgW2VnKE
        J0xcGJH1vbbMh2StlWvhL7JI+ejpdJ5GF49D9RgDOSOS1GKcwODHm6EdDFwjoJP0
        aa5h1B0mpgSKmSKoz+OXgtJTnJvyp31HrRWSC/GbNulCbkaxmQL9Xz0Yj3lwgr2G
        F4PixT4WMF0jsgLiqAzfuJ2WmV6+l+itf9Ff6GVJDiTm77ya+tNjUnXKzNmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669663113; x=1669749513; bh=5KWIVqt9TJGuD+cVVciSmLqFdiVm
        +k4C5GFJJ1JiWg4=; b=m/jrwwma6sCkBghxzm0WvcBZAZggmNBptQWON2KVOZEg
        YSvtG1D2CC+KC4NpndiCjbbduafioQPfi1wTCxKJXyNFju3bRVue6fwpreoJj8LQ
        YyPc/liNcfo1yoP5NtZ4OF1KNcwgsq4DlB/Ab3lhGtZOMGGqXEHZfmb0eqB+EpvC
        xU/zyR7xMe9EIiuFSrIwGsTTI1dt8Sitz8DJ6OlSmq32zqM9fqQGz9GQ2hGQBEYB
        hHoiTkJ68/x3pXCabqXyk+DLLDjXztpgLezCKI4LEcM17rwd3cL/0ZdRGF5uFGFJ
        PNLTGSSl8w2evdw7a1GMA+CEpdQPyqjkOe0PLX0yXw==
X-ME-Sender: <xms:iAmFY9L3gZ5qYQZCQSYaOGcLlG84W1UGN92sa0aAFQ8P-3giq91fMA>
    <xme:iAmFY5JMixsgMFvWGIPclkaz7WBg4pV1MdeuXP8Txzhw7yJuzMsx2J58AB3_L_glt
    MrHUYIFiwSZogq00N0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:iAmFY1seEws4hdlusCQAtcWGkYb3mJLBjAoDnrxSMFm7MdScwLRWNQ>
    <xmx:iAmFY-YaMQ8z56Sa1ffbb8FrSJ06ThPZFr20k_z3DadUH_Yc0Srp-Q>
    <xmx:iAmFY0bcXhL63fyEjoTBk20vNLL97NalqmyPY4SpM4kGHcgExf_oFQ>
    <xmx:iQmFYxQM7Qeho8G1_IvVlWMjRFw5PRh6fOm2bum4iI_zdX7I7fYtuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 83080B60089; Mon, 28 Nov 2022 14:18:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <8f9326ba-f879-4b9e-9e5d-b65cad7cd726@app.fastmail.com>
In-Reply-To: <20221128111829.2477505-4-Jason@zx2c4.com>
References: <20221128111829.2477505-1-Jason@zx2c4.com>
 <20221128111829.2477505-4-Jason@zx2c4.com>
Date:   Mon, 28 Nov 2022 20:18:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Christian Brauner" <brauner@kernel.org>,
        "Samuel Neves" <sneves@dei.uc.pt>
Subject: Re: [PATCH v8 3/3] x86: vdso: Wire up getrandom() vDSO implementation
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

On Mon, Nov 28, 2022, at 12:18, Jason A. Donenfeld wrote:
> Hook up the generic vDSO implementation to the x86 vDSO data page. Since
> the existing vDSO infrastructure is heavily based on the timekeeping
> functionality, which works over arrays of bases, a new macro is
> introduced for vvars that are not arrays.
>
> Also enable the vgetrandom_alloc() syscall, which the vDSO
> implementation relies on.
>
> The vDSO function requires a ChaCha20 implementation that does not write
> to the stack, yet can still do an entire ChaCha20 permutation, so
> provide this using SSE2, since this is userland code that must work on
> all x86-64 processors.
>
> Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/Kconfig                        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl  |   1 +

I see that this enables the syscall in x86-64, while patch 1
adds it to the eight architecures that use 
include/uapi/asm-generic/unistd.h (with the __ARCH_WANT_*
guard at the moment, but you already said that will be removed)

I think ideally the syscall.tbl and unistd.h changes should be done
in one patch for all architectures that doesn't mix it with
any other changes. In particular I think it should be separate
from the vdso changes, but could be in the patch that implements
the syscall.

      Arnd
