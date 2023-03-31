Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7347F6D2167
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjCaNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjCaNVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:21:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0387DB2;
        Fri, 31 Mar 2023 06:21:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C023A5C00DE;
        Fri, 31 Mar 2023 09:21:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 09:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680268896; x=1680355296; bh=ovGzLmCRYBV+Fk+VtkV1DusgbzUNCjhBOgu
        eGJt1E/8=; b=khLHOepKtLXil1QvVmBA3JXD9wtQsSf0cBJ+mrHf5oL9PmEAjL/
        WVpQtfOzsR6aPxknWPv7ZE89f9qTiqEQg3ZgXBsH+1fmldBU0syAtomPeQ/M8KtF
        y8ydHdDN1zLNOQhzBz7fx7Wj981ct9AW6eLp9b5a51p3EMyTNkLPIfNJg1fppGuX
        zsbAgJ3UrB14XKDY5U9Y9Mr22wbGERxxla/oc5vDsUkGrAuh4U6PHLpGvow5oWe1
        LC9vG06Wj6bTUZ6hv/cRtHK79mhPfo2CwBUFM1kwr+oLLQ6ruSQ5U92dWbvBALGW
        r7CVi3SBYGvnAcypzGT9inr4OiWiUIgZRHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680268896; x=1680355296; bh=ovGzLmCRYBV+Fk+VtkV1DusgbzUNCjhBOgu
        eGJt1E/8=; b=CQvWK84Fn9nouXU6aTYtwXulujSysorotuAgKWMuGaXNXStqH1v
        rFYE0q7n5U4dGAlaF6kjDlC08vnB+PDDJxUzIXjcEe1SH4ZYVb3uJ1rY/DM+2fLZ
        l8QnbtPU5ULRi/ru+USclnnFwOiPYsvBO9rhZoLXJd7UZCsD3mHqfZUshItFmpYi
        ZVS7vmXKe9Q92UmHHnTy9xcAg1QQT9NmRr3USK2ziMtw/STs0bZcH0KsvDqkEjf6
        xZCA0KCtEtrgnFrRO23CtsCS0aDDbJ+b+FM5ZJWO/b+kKH99/g+h+QuJrUoRjGJB
        AJ2Ex/w1lXMsCiKzMUBGpvEMqB2F3B2dSyA==
X-ME-Sender: <xms:X94mZL9Ym39WBSyBfh1g0SRjLRCalx4op-MAUh9U5roJn_FeYGL04A>
    <xme:X94mZHt_6qAJQXsydcD34NHf98IjjOENci7qtPwPQ4Oq3FQ2-GqR9wuj59Ei-E_cS
    Cu-38MmxdCxJHqDKvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YN4mZJAhJVnAYtZTUN7-g0dZBBkGLUtNRIo0LNaxWgM7ytI00Rr7hA>
    <xmx:YN4mZHcWmmZEHu4IUF6Kt_RAEPLeZ3uSl-DukPDi8kcp0iJFd3LCHw>
    <xmx:YN4mZAM_wkOeO78T2JwfrQyPgjpulPVsbxPm8ZNUM4ukuPTh8zvASA>
    <xmx:YN4mZPPIw38AtrfICw7dFjCEq6HTcgeaZevW3fEznSQbBcI2Me8mhg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E38FFB6008D; Fri, 31 Mar 2023 09:21:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <d91ffb1e-261b-4b2f-a78f-f2846600a3e7@app.fastmail.com>
In-Reply-To: <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-3-evan@rivosinc.com>
 <605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com>
 <CALs-HstAKtvORKwRWeh97SuAuYR61aiR-3jA2_0JCZGAJXVHbg@mail.gmail.com>
Date:   Fri, 31 Mar 2023 15:21:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Evan Green" <evan@rivosinc.com>
Cc:     "Palmer Dabbelt" <palmer@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Conor Dooley" <conor@kernel.org>, slewis@rivosinc.com,
        "Vineet Gupta" <vineetg@rivosinc.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Andrew Bresticker" <abrestic@rivosinc.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Celeste Liu" <coelacanthus@outlook.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        guoren <guoren@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        "Niklas Cassel" <niklas.cassel@wdc.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Ruizhe Pan" <c141028@gmail.com>,
        "Sunil V L" <sunilvl@ventanamicro.com>,
        "Tobias Klauser" <tklauser@distanz.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 2/7] RISC-V: Add a syscall for HW probing
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 20:30, Evan Green wrote:
> On Thu, Feb 23, 2023 at 2:06=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> > +    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t
>> > pair_count,
>> > +                           size_t cpu_count, cpu_set_t *cpus,
>> > +                           unsigned long flags);
>>
>> The cpu set argument worries me more: there should never be a
>> need to optimize for broken hardware that has an asymmetric set
>> of features. Just let the kernel figure out the minimum set
>> of features that works across all CPUs and report that like we
>> do with HWCAP. If there is a SoC that is so broken that it has
>> important features on a subset of cores that some user might
>> actually want to rely on, then have them go through the slow
>> sysfs interface for probing the CPUs indidually, but don't make
>> the broken case easier at the expense of normal users that
>> run on working hardware.
>
> I'm not so sure. While I agree with you for major classes of features
> (eg one CPU has floating point support but another does not), I expect
> these bits to contain more subtle details as well, which might vary
> across asymmetric implementations without breaking ABI compatibility
> per-se. Maybe some vendor has implemented exotic video decoding
> acceleration instructions that only work on the big core. Or maybe the
> big cores support v3.1 of some extension (where certain things run
> faster), but the little cores only have v3.0, where it's a little
> slower. Certain apps would likely want to know these things so they
> can allocate their work optimally across cores.

Do you have a specific feature in mind where hardware would be
intentionally designed this way? I still can't come up with a
scenario where this would actually work in practice, as having
asymmetric features is incompatible with so many other things
we normally do.

- In a virtual machine, the VCPU tents to get scheduled arbitrarily
  to physical CPUs, so setting affinity in a guest won't actually
  guarantee that the feature is still there.

- Using a CPU feature from library code is practically impossible
  if it requires special CPU affinity, as the application may
  already be started on specific CPUs for another reason, and
  having a library call sched_setaffinity will conflict with those.

- Even in the simplest case of having a standalone application
  without any shared libraries try to pick a sensible CPU to
  run on is hard to do in a generic way, as it would need to
  weigh availabilty of features on certain cores against the
  number of cores with or without the feature and their current
  and expected system load.

As long as there isn't a specific requirement, I think it's better
to not actually encourage hardware vendors to implement designs
like that, or at least not designing an interface to make getting
this information a few microseconds faster that what already
exists.

      Arnd
