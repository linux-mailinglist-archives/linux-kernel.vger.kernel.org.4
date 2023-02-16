Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C36995CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBPNaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBPNaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:30:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD82F552A6;
        Thu, 16 Feb 2023 05:30:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 227DE5C00E8;
        Thu, 16 Feb 2023 08:30:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Feb 2023 08:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676554203; x=
        1676640603; bh=VCwTn+DX7FOgrcyFSBKKl8KsdUvf32MRmMRF7YLkRhM=; b=B
        sZH3c3ea5agVWQzOugGWGW7D5w0wFVgE6VuNx4xeJUYYqRfp877LWS2FekXXo6+a
        lJFdAHXAr5jgbITO8SSbgtkTPvlb8PlDKUmltrRc53w0DtU1ku3NFmbJNH/E39uP
        wvU/y6vw/1eq/hDtv1RuH6gr1meC+YVFPkRb5LUZ2fDobS6viyOiLVojZLIkSnMm
        caLZ0JE5mHnKyKrTRiu1/0iQjuNUmgiGUkGiBfH7dRLpAdzHzubX6jQF00w6AqMi
        u8H2R47OgRBSCFK+QQiJ85CDpHNNBYhLqPR7DWqHJE/Zw2BgOfSNazWNbC/u1nEI
        VwEwIJFCbr2cOp9PI01Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676554203; x=
        1676640603; bh=VCwTn+DX7FOgrcyFSBKKl8KsdUvf32MRmMRF7YLkRhM=; b=Q
        6FGDKyxwrrW6LXonsCMsPD2K25PFqayi8xC0nLhaS+N3k2vUoJRZx3vLiqlNglVk
        1H1LN8vu9EbFuEn8IDC4eIShG1TXmsU/hJJNU8rymWq+OqQHytiX70+ijt0lSzdC
        ULm0e0B180iREwMOmLC1smbGsJMUY+QfwfLM1td1ggIHp4vNb2oxnEHWcmStp6mw
        FNRtZVAgdzxaYu+LGk237T+s+b82CSmALGrZ/mOfQPEfDCpahq+cnxSOK5v1sfQh
        /iOlpNIGblX1YBo8A0qj1JefjNIlfzoGERBbaGzjdW+U2goTnrLe5Bkb1qy1x5Jk
        6E56DR369x/aCU7h5HFzQ==
X-ME-Sender: <xms:2i_uY2bv-usC1z81ka94KEVxFAEV49Xxj77dVYlxA4lITAKT81BYWw>
    <xme:2i_uY5au61qE4B5P_xJTLCuxSdLybijeeiamQGycBYM2BHFDSnsrnBktBGAEVfWSm
    PLtzULCfwxf_Eu-VpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2i_uYw9y3HKMjHJMEVvbeMsN8wR1ZgSuy_p7I-fIxiikYWgNC5hOSg>
    <xmx:2i_uY4p2DWN1_lgH-argnXHwdGYTdjldRPSD8ZOBch7RFa8jbJb3SA>
    <xmx:2i_uYxo5t3Sy3Ek5-MAyb5kVaaonaFFLjmlRDfbf4LRwOM-4NnYx4A>
    <xmx:2y_uY46hCTyh8A9QQPc9k8r4-YFgSVoEfyyC46PO2X8rwg_sHGXKjg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 454F5B60086; Thu, 16 Feb 2023 08:30:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <ed5133d1-5592-4367-8919-4416be506455@app.fastmail.com>
In-Reply-To: <6FA7F803-1B4A-418E-9368-E205F3A6CF27@jrtc27.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
 <ded4018d-c90f-41c7-9e54-da954bdef49e@app.fastmail.com>
 <CALs-HsuwOqR+y-GriKOiRx068bgOv3qTOpsJTaA02htiiynWmw@mail.gmail.com>
 <6FA7F803-1B4A-418E-9368-E205F3A6CF27@jrtc27.com>
Date:   Thu, 16 Feb 2023 14:28:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jessica Clarke" <jrtc27@jrtc27.com>,
        "Evan Green" <evan@rivosinc.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-doc@vger.kernel.org,
        "Andrew Bresticker" <abrestic@rivosinc.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Celeste Liu" <coelacanthus@outlook.com>, slewis@rivosinc.com,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Tobias Klauser" <tklauser@distanz.ch>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Vineet Gupta" <vineetg@rivosinc.com>,
        "Dao Lu" <daolu@rivosinc.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Ruizhe Pan" <c141028@gmail.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Conor Dooley" <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>, guoren <guoren@kernel.org>
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023, at 23:43, Jessica Clarke wrote:
> On 15 Feb 2023, at 21:14, Evan Green <evan@rivosinc.com> wrote:
>> On Wed, Feb 15, 2023 at 1:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> Palmer can probably speak to this with more authority, but my
>> understanding about the motivation for an approach like this goes
>> something like:
>> * With the nature of RISC-V, we expect a lot of these types of bits
>> and bobs, many more than we've seen with the likes of x86 and ARM.
>
> We=E2=80=99re already at (I think) 51 standard user-level extensions t=
hat LLVM
> knows about.

Do you have an estimate of how many of these require kernel support
beyond identifying the extensions?

>> * We also expect in some cases these values to be inconsistent across=
 CPUs.
>
> That=E2=80=99s also true of some Arm SoCs.

Right, but it's also something that we should not encourage, or
need to make easy to use. On arm64, the kernel support for having
asymmetric aarch32 mode was kept to an absolute minimum, and an
application is expected to get the information from /proc/cpuinfo
before pinning down a task to the correct subset of all CPUs.

>> * So, a syscall with a vDSO function in front of it seemed like a
>> good combination of speed and flexibility.
>>=20
>> You're certainly right that HWCAPn would work for what we're exposing
>> today, so the question probably comes down to our relative predictions
>> of how this data will grow.
>
> The other big problem is vendor extensions.

My biggest concern is how this would be synchronized between the
interfaces that are available to users. What we have on other architectu=
res
is a set of string identifiers in /proc/cpuinfo and a bitmask in HWCAP.
Ideally these are added in pairs so the information available to shell
scripts in human readers is the same that is available in the auxvec
data.

Adding a third interface with the same information or a superset
requires more work in ensuring that each extension is available
in exactly the right places. Ideally I think there should be only
one table of possible CPU features so nobody has to make the
decision about which ones are important enough to add to one
interface or another.

     Arnd
