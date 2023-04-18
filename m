Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B66E6220
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDRMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjDRMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:30:18 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9C93D7;
        Tue, 18 Apr 2023 05:29:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C6495C00E8;
        Tue, 18 Apr 2023 08:29:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 18 Apr 2023 08:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681820956; x=1681907356; bh=VM
        wb91EjeaIIwMVJOlqozliVSEbH/Bchyh3fjPDYvkE=; b=fD2wHJI/bKnYdEKMvA
        OFP1OMUFa/DcdiSvEeS3jyc3fs7pYGjj2nPSJWceSFkyzBgWuYkUp1kM6gzuHeiC
        9ZIAxIZpZ6jMwkeMdWIPoht4kliqUH3+/QXsLdHCx8HsVa8PSNlCvAfOI2ndVMSm
        ODRKuMzne3ljJTZv7uka0cz7mwApFi/2JEvh5oF8dt3ZZ3EN4BFhT4kr8KbWzdlJ
        DuKPdGqHO+bmtVA0j93mpU0DDpPWhXPf0n4p6Kij+LAiVJhs7AzpKoDASbltxXfs
        6BLCMsyBPhzjx4zag9KGu1Hqv5fb4U0qdwU7rez+twDyaalpKTDspjQHB+9enARb
        8k4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681820956; x=1681907356; bh=VMwb91EjeaIIw
        MVJOlqozliVSEbH/Bchyh3fjPDYvkE=; b=fr585nbRin/G68HRrhwCE2ojOa/tv
        1zDamuBIAlzPSNcntpQrIdXZdKBfOTs7ToTHbB4pKSkqO3nUs6PBb1ImutS/yxBM
        2B4B5Uv7EnD+4OcebfIDM8WkEW91M8+0wiglGU5TGk07FiI9dPKIJjs2unCmyzgY
        lO4fyf/jbo7HoOXPTQ1BAztviLrtGglfSP+qqLAVRcveQPzjYxvrARefG0V+CP+M
        zlJD2N9wi+SZYY8AddLhOH0tEcSScD2tHUQoRnLHNHtkuo3i/eRBdmNAfLA/SqVj
        2cKnspDuPfPeAkz84iYpN/LzyZSfyfQcqNaJYxClK1/ZwGBAl82+OZUvw==
X-ME-Sender: <xms:G40-ZOECZtfLzU_dRwIEh_PFY0w4UQVr2KtuOtXeVZMJ48l5Uil3PA>
    <xme:G40-ZPV7Z2oMUqoPDeSe0vuHqjtC0mhP7wZz96tkK9zTbmTJHq0bX-JV4RbimIrOz
    eloZFjxTvpoONFCcd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelkedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:G40-ZII9qvrLW9EVD0ArNGrVCJfcHsQkE1vI1ulk9_FEwuyg7aPyTg>
    <xmx:G40-ZIFoemLCyuhosrpjJst5IN9jbd8FSAV4OJ54ri-kWgradjVBLg>
    <xmx:G40-ZEUpMllTfuXekGh_6pVCsNSv2cXoIj9asP96ZSLjiPVdvu_tWA>
    <xmx:HI0-ZAn8YOLM7OFf3Tw8Ff7KmWXEQWEZ5sdyUmu5c62ZBUETdz2YoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7D7BB60089; Tue, 18 Apr 2023 08:29:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <c28486a2-dc12-4613-abda-bdeace783d40@app.fastmail.com>
In-Reply-To: <CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com>
References: <20230414082943.1341757-1-arnd@kernel.org>
 <20230414162605.GA2161385@dev-arch.thelio-3990X>
 <CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com>
Date:   Tue, 18 Apr 2023 14:28:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marco Elver" <elver@google.com>,
        "Nathan Chancellor" <nathan@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Masahiro Yamada" <masahiroy@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Tom Rix" <trix@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for clang-14
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023, at 14:06, Marco Elver wrote:
> On Fri, 14 Apr 2023 at 18:26, Nathan Chancellor <nathan@kernel.org> wrote:
>> On Fri, Apr 14, 2023 at 10:29:27AM +0200, Arnd Bergmann wrote:
> It errors as expected. But with:
>
>> clang -Werror -mllvm -hwasan-does-not-exist -c -x c /dev/null -o /dev/null
>
> It ends up printing _help_ text, because anything "-h..." (if it
> doesn't recognize it as a long-form argument), will make it produce
> the help text.

Ah, that explains a lot. I think I actually tried a few other options, but
probably only edited part of the option name, and not the beginning, so
I always saw the help text.

>> >  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
>> > +ifeq ($(call clang-min-version, 150000),y)
>> >  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>> > +endif
>> > +ifeq ($(call gcc-min-version, 130000),y)
>> > +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>> > +endif
>>
>> I do not think you need to duplicate this block, I think
>>
>>   ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
>>   CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>>   endif
>
> We just need the clang version check. If the compiler is gcc, it'll do
> the "right thing" (i.e. not print help text). So at a minimum, we need
> if "clang version >= 15 or gcc". Checking if gcc is 13 or later
> doesn't hurt though, so I don't mind either way.

I've sent a v2 now, with an updated help text and the simplified
version check.

It might be possible to change the cc-option check in a way that
parses the output, this variant should do that, if we care:

echo "char *str = \"check that assembler works\";" | clang -Werror -mllvm -hwasan-does-not-exist  -S -x c - -o - | grep -q "check that assembler works"

      Arnd
