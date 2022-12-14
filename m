Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6365664D316
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiLNXNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLNXNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:13:42 -0500
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBD13DF2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:13:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 2F7FC2B0675A;
        Wed, 14 Dec 2022 18:13:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 14 Dec 2022 18:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1671059616; x=
        1671066816; bh=GamDUxMfCcxUhpw7AJnuCcnm9cZ/4hV0cyPV3Md0rdQ=; b=D
        5HW2HwbhF70EXIzRaNwQhsmDXW1XvCWr7SLS7G5dSBF4xTd1jdTm1aLm6+RM4pSi
        zB2p2CQbX+lo5gnojfEznFFZIX7Lj0LizK+r2FedUj9A4IJJJa6LuK0AQdDlo3Zc
        PhGbpYN75y0IgzC4QpzueM5OhbfRVJICczND3mbKDspVuQ8NpSQzLe2vRC/MZjIc
        Y2bkZrRBKvvlBeWj4zTAun5ajZitlKAl1IhIp+BxRTSB1hO3aVrE/GJq8OJmllQN
        d2zTnFgHfGK7DJQS+5FymdTcHDg2+w0QXtMTNfHtNy7oCIs3G4f7hSL/1wpAhEnk
        DsKkdtBFaINSHODmlUAzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1671059616; x=1671066816; bh=G
        amDUxMfCcxUhpw7AJnuCcnm9cZ/4hV0cyPV3Md0rdQ=; b=q01ffg9i5eRCbyUoK
        y30YdEGAwazfSImLyyV8laZbCVSQ6MJSLoLW4qW0fDRXOgstIUg8QAojBX9g5B1J
        +eCkdQv58fSQJ+owTuzYcc57/DVFoztk0wxhf853TUGFnkiR8x0HmnfDHV1bF0u/
        QaCfGUuxxKas1JNnI0zG2bpXyfAbPejq5DsyTrwf1npnDzLxHkgYppgXe4E+H8GI
        CeRUh+FiBzlQXuGP02EVvO9ko+Elc3ExiUMRAReyIMMWv+okmXTxEDJncxQaGB88
        D1ap4r2YvTWDPiCw8+AHrFFTNxUXEFMVKCcEDpUnBovWesBK/BIpu2Q08SvNc9yZ
        i4qCw==
X-ME-Sender: <xms:oFiaYxYtcgXY-Awf5MlEZVOJHNWsjRlt2AEB7b9jR4WwUi-IqbZFPQ>
    <xme:oFiaY4YSXdIUuiBngoF7sCzduZqxb9XX14b5Du6Z_4yDp3SGDydbqAv6dCPhVy8Db
    Pv7gh17EqBe5IMG3Q>
X-ME-Received: <xmr:oFiaYz-fLW9rOmLB15zwME8Gc0X3UFjS3p-Zd71QQsbOByLPP1IJJQe4xsw3mKL_Nj_yREhxEH7O4Xqln8_WryKJRY3RAAIcUb3sTYniszi7x2Nr_ZA4bEbh1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeeltedutddukeffkeelfefffeeujeeludfgfeffffefteevuedtudet
    vdefgeetjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:oFiaY_rTdggPjuNnSTpw3QOisERiPJLF5vYP5e0tLHaYyvEb4hj4Zg>
    <xmx:oFiaY8qhxs8z-nafcqtRtM89vWj9duhniHKOqk57BsDmJqh_B0pMHQ>
    <xmx:oFiaY1T7DMCHLvHbVAFjwY-RSomc0Ob8066cKiW1ly6ZTQ2HN_l21w>
    <xmx:oFiaY_cqmD4ZU583KzK-15AAprUEiOLTAnt7rRobw1fXhe5vg4MVdEEFk00>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Dec 2022 18:13:35 -0500 (EST)
Message-ID: <5fbdfe75-bd68-007b-1b64-37334a10a8d1@sholland.org>
Date:   Wed, 14 Dec 2022 17:13:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Vineet Gupta <vineetg@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
In-Reply-To: <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 14:07, Vineet Gupta wrote:
> On 12/13/22 08:43, Darius Rad wrote:
>> On Fri, Dec 09, 2022 at 11:42:19AM -0800, Vineet Gupta wrote:
>>> If that is failing,
>>> the system is not doing well anyways. Besides it is not an issue at all
>>> since ENOMEM in clone/execve for the additional space should handle the
>>> failure anyways. Only very sophisticated apps would downgrade from
>>> executing
>>> V to Scalar code if the prctl failed.
>> This seems unlikely.  As vector support does not exist in any present
>> hardware, and the vector extension is only optional in the RISC-V
>> profiles
>> that include it, I would think that it is almost certain that any
>> application that supports V would have a fallback path for when the V
>> extension is not available.
> 
> For specialized cases sure we would expect fat binaries with IFUNC based
> dispatches (glibc mem*/str* are obvious examples). But with newer
> compilers autovec is increasing becoming default even at medium
> optimization levels such as -O2. So V code littered all over is just a
> matter of time for the profiles/variants which allow V. For less capable

Autovectorization is only possible where the profile *requires* V. And
no existing profile does that.

> systems w/o V this is all but moot discussion since kernel itself need
> not be built with V enabled.

Distro kernels will be built with V enabled, and will spend most of
their time running on systems without V.

>> Another motivation for requiring that user space request use of the
>> vector
>> extension is that the vector unit may be shared between multiple harts
>> and/or have power or performance implications in the system.  By
>> requiring
>> that user space request access, it allows the system to decline that
>> access, and user space can handle this gracefully.
> 
> But in this specific example won't the prctl cause more pain. So 2
> concurrent processes on 2 different harts with shared V unit. One sends
> prctl to enable and other wants to disable, what would the kernel do.
> Will it just be whoever ends up running later wins. Granted I'm not too
> familiar with how such a cross-hart sharing would work in a Vector
> instructions being part of ISA  (vs. Vector accelerator with job
> push/pull approach)

The vector execution unit can be shared between harts, not the vector
state. Think SMT.

> Honestly I'm sympathetic to your power concerns with keeping V enabled
> all the time. But the mechanics of implementing this prctl makes me
> wary. Assuming this is done from dynamic loader, it implies loader
> itself needs to be built with V disabled. This also leaves bunch of perf
> on table since loader does tons of of string and memory operations which
> could potentially benefit from V enabled code, granted it is not deal
> breaker.

The dynamic loader can do dynamic dispatch based on the result of the
prctl() just as well as any other library.

And the distro's dynamic loader can't be compiled with autovectorization
enabled anyway, because again the profiles support processors without V.

>> If we add a mechanism for user space to request access to the vector
>> extension, and it turns out that it was unnecessary, the worst that has
>> happened is a slight inconvenience.
>>
>> If we do not add such a mechanism, and later determine that it is
>> necessary, we have a much greater problem.  There would be backward
>> compatibility issues with the ABI, and such a mechanism could probably
>> not
>> be fully implemented at all due to the desire to support potential future
>> legacy vector code.
> 
> Very true, but this in itself is not sufficient of a reason to warrant
> adding it now.

It is, because changing the sigcontext layout without an opt-in is
already an ABI break (it completely blows past MINSIGSTKSZ).

Regards,
Samuel

