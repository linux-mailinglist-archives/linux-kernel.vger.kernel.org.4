Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65AD64A1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiLLNoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiLLNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:43:42 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9A9F1B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:43:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 215DA5C010E;
        Mon, 12 Dec 2022 08:42:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 12 Dec 2022 08:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670852578; x=
        1670938978; bh=DkNW4V8tQGg7aDY4/ZlJfOGMMlsnuzkqumoKWw//sRY=; b=a
        vAtOmPGjYbPeaFyAwoj76FmxuujepRmktDUB+Z7V7ySQfh+6oXqaAnMENOAkIFxv
        4RNWTOzC5HpyG6E5DfPU01T0AJpPYtNAcIjTo6wme9RNF0sbjb916MoXf9rKjmRd
        YR+ov4upRwUuCquVDiQsPX7gPlIeG2os7KRnicFxEu+fr1S09t0YDUPGP2hlVJqy
        FqPADV1MtyqzgGBKZ368YDkL473c0BPzQLx02yqtWIxVlTZtjRa1PjqbVbFcJAku
        DxuZDk7pOmT2grE8qekhPt2D5VwFcVgp+8ugA8OvIKagTOkQhCxbwfqK56iW6NgF
        pjzYhQhks7B+F0+eSlMzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670852578; x=
        1670938978; bh=DkNW4V8tQGg7aDY4/ZlJfOGMMlsnuzkqumoKWw//sRY=; b=W
        Y4rfw1X7xJDZ5NdZczL4NxCktLEjvHX8Qz2uEQjgUb9woC/nciwYfifcxSLmrtfM
        RquLAmvszftUVHxQWe1n3C+vZJEGVYfmNT5c2/i1viIEN+mHpbTvKdUopmf7bV6j
        kFHDmorGzH/Gaxt5IxbBgtB/RSsuiSI+AwSL2Qt02e0OGe+EpAGTZzolhIEyj2Nb
        eZX5ums9U/vLdUYzL5QFL7pzX6RXl/wyI37z9ROZQpLEgK4taJ31KUJnqx/xHFgy
        gIEcHZ1j1or/VxROgCeRIg20j/k09zJUxIfYFT+RNyPKqkUJypLdn7ZuWmFMCqwi
        erk6pl/r3ASpxo9RNVtxQ==
X-ME-Sender: <xms:4S-XY_qqrTuWrAK_bzvhYWoBEgGg-04_pvSEAUtHhIJ0YFfP7aJreQ>
    <xme:4S-XY5qE_CIf2bO1EcW77kihwknmsjr83u9U5BgoH2L1ezvT15dlKyGyKlDukS3gt
    ArXFf-hGQwGQDnDmfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4S-XY8Mp_4VOxs_VSuTFxC00-P8UJeBREWDghnAch0kDCNUTGjMjkQ>
    <xmx:4S-XYy5m0SsgyWG4Dy2hIUMz5GVcBTVWNlQvxl_j1kZWwQlepVka0w>
    <xmx:4S-XY-6ZoRyMEmuuFAtRd52elFv5SL58ohJehJe_TbUF8cfFe3yHOw>
    <xmx:4i-XYxL6aGFRufoy1_os342RaTeJTkyNjLTU5nzoQJjvX5qWB2WHWg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 098D7B60086; Mon, 12 Dec 2022 08:42:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <8da67034-2073-4dce-8dc5-de5277bdf4b4@app.fastmail.com>
In-Reply-To: <Y5cH4I8XD8804hqa@leoy-yangtze.lan>
References: <20201228023941.E0DE2203B5@pchp3.se.axis.com>
 <20201229030933.GC28115@leoy-ThinkPad-X240s> <Y4Cspv98j8TqwCqZ@axis.com>
 <Y4C66dg+9wwiXdVs@leoy-yangtze.lan>
 <98978f82-eb78-4fa7-901e-76c3070362e3@app.fastmail.com>
 <Y5cH4I8XD8804hqa@leoy-yangtze.lan>
Date:   Mon, 12 Dec 2022 14:42:36 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Leo Yan" <leo.yan@linaro.org>
Cc:     "Vincent Whitchurch" <vincent.whitchurch@axis.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Hans-Peter Nilsson" <hp@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "John Garry" <john.garry@huawei.com>,
        "Will Deacon" <will@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Kim Phillips" <kim.phillips@arm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl, don't lose syscalls due to sort -nu
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022, at 11:52, Leo Yan wrote:
> Hi Arnd,
>
> On Fri, Nov 25, 2022 at 02:56:31PM +0100, Arnd Bergmann wrote:
>> On Fri, Nov 25, 2022, at 13:54, Leo Yan wrote:
>> > On Fri, Nov 25, 2022 at 12:53:10PM +0100, Vincent Whitchurch wrote:
>>=20
>> >> It looks like this patch was never applied?  AFAICS it is still ne=
eded
>> >> on current HEAD and it still applies cleanly.
>> >
>> > Thanks a lot for bringing up this.
>> >
>> > Before there have a discussion [1] for refactoring Arm64 system call
>> > table but it didn't really happen.
>>=20
>> I actually worked on this last week and did a new series to convert
>> the old asm-generic/unistd.h header into the syscall.tbl format,
>> and change arm64 to use that.
>>=20
>> You can find my work in the 'syscall-tbl' branch of my asm-generic
>> tree [1]. This has only seen light build testing so far, and is
>> probably still buggy, but most of the work is there. The missing
>> bits are the Makefiles for the other seven architectures using
>> asm-generic/unistd.h, and checking the output to ensure the
>> contents are still the same.
>
> Thanks a lot for sharing the patch set.
>
> I went through the whole patch set, below are several things I observe=
d:

Thanks for the review!

> - I did a quick compilation but found building failure, this failure
>   is caused by the first patch "arm64: convert unistd_32.h to
>   syscall.tbl format", it removes the macro __NR_compat_syscalls.
>
>   In file included from ./include/vdso/const.h:5,
>                  from ./include/linux/const.h:4,
>                  from ./arch/arm64/include/asm/alternative-macros.h:5,
>                  from ./arch/arm64/include/asm/alternative.h:5,
>                  from ./arch/arm64/include/asm/lse.h:15,
>                  from ./arch/arm64/include/asm/cmpxchg.h:14,
>                  from ./arch/arm64/include/asm/atomic.h:16,
>                  from ./include/linux/atomic.h:7,
>                  from ./include/linux/refcount.h:95,
>                  from kernel/seccomp.c:18:
>   ./arch/arm64/include/asm/seccomp.h:27:33: error:=20
> =E2=80=98__NR_compat_syscalls=E2=80=99 undeclared here (not in a funct=
ion); did you=20
> mean =E2=80=98in_compat_syscall=E2=80=99?
>      27 | # define SECCOMP_ARCH_COMPAT_NR __NR_compat_syscalls
>         |                                 ^~~~~~~~~~~~~~~~~~~~
>   ./include/uapi/linux/const.h:34:40: note: in definition of macro=20
> =E2=80=98__KERNEL_DIV_ROUND_UP=E2=80=99
>      34 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>         |                                        ^
>   ./include/linux/types.h:11:28: note: in expansion of macro=20
> =E2=80=98BITS_TO_LONGS=E2=80=99
>      11 |         unsigned long name[BITS_TO_LONGS(bits)]
>         |                            ^~~~~~~~~~~~~
>   kernel/seccomp.c:168:9: note: in expansion of macro =E2=80=98DECLARE=
_BITMAP=E2=80=99
>     168 |         DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
>         |         ^~~~~~~~~~~~~~
>   kernel/seccomp.c:168:38: note: in expansion of macro=20
> =E2=80=98SECCOMP_ARCH_COMPAT_NR=E2=80=99
>     168 |         DECLARE_BITMAP(allow_compat, SECCOMP_ARCH_COMPAT_NR);
>         |                                      ^~~~~~~~~~~~~~~~~~~~~~

Sorry about that, I thought I had fixed it already. I'll need to
get back to the series and make sure this works.

> - The patch set breaks git bisection, when I use "git bisect" I can
>   find more building failures caused by middle patches.

Ok, I'll check these out as well.

> - The patch "arm64: generate 64-bit syscall.tbl" removes macros:
>
>   __ARCH_WANT_RENAMEAT
>   __ARCH_WANT_NEW_STAT
>   __ARCH_WANT_SET_GET_RLIMIT
>   __ARCH_WANT_TIME32_SYSCALLS
>   __ARCH_WANT_SYS_CLONE3
>   __ARCH_WANT_MEMFD_SECRET
>
>   Seems to me we still need to enable these macros so can enable Arm64
>   specific system calls?

The system call selection is now controlled with the line

ABIS_unistd64.h :=3D common,64,renameat,newstat,rlimit,mmu,clone3,memfd_=
secret

which picks the types of ABIs that are enabled when converting
the syscall.tbl file into the headers. Removing these was
intentional, but I now see that we still need to define __ARCH_WANT_NEW_=
STAT
and __ARCH_WANT_SYS_CLONE3 because those two are referenced not
just in unistd.h but also in fs/stat.c and kernel/fork.c.

I'll put this on the list of things to check for the other architectures,
in addition to comparing the resulting syscall table object and the
generated asm/unistd.h.

> - We also need to update the header files:
>   tools/include/uapi/asm-generic/unistd.h
>
> You are welcome to CC me when you send out formal patches to mailing
> list and I can test it (and look if can refine perf code for this).

Ok, thanks again.

    Arnd
