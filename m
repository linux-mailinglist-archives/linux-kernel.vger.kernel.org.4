Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6B687104
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBAWdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAWdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:33:39 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B4E04D;
        Wed,  1 Feb 2023 14:33:28 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 525263200945;
        Wed,  1 Feb 2023 17:33:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 01 Feb 2023 17:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1675290803; x=
        1675377203; bh=P1Rzs19z2xPSWbyW8Jp19iWQVFCDwTMdSBlmLIj8BXw=; b=D
        ERvao1/pTN8cUXZDx9SZdUk5w2Ejggx65+oxu2zMrfOoofqVL/hVC0vvFJhRAM0D
        6r8EhJwzYQQNWi08k7F++DWszbsEAu6Ztsi/vc+PnVT2rbWvqDZp52FMIxxIVsm1
        s0kCb2g7WVxpngVi7V1DlW609cXrokfNLi8ZDjOoj4MwGXeWe3sn46RyGBAV2oPB
        KSZpfUbJ/gRV4Gz1iQ/zdCk4+icp1jVDEFlNVENdb1PhXt9gkfjaf14GaxBB1wkz
        qLdPVtc1ybfaWAU/D0PKx2nqH3NIB0qlQejfCNU3X3k6tE8nvnRGn/kIuqZ7aZzU
        DeEJ7U5ELBE7mKaHDvWNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675290803; x=1675377203; bh=P1Rzs19z2xPSWbyW8Jp19iWQVFCD
        wTMdSBlmLIj8BXw=; b=FPQwU2dC3Y3pOIUy8DxxckbSVBQJaYNmYEDqSQbJTQgq
        fwHAkbGhADOlP1j++ouUPRQhPcpqjJLCvUu+fXEYXEt5dZOjvYZe1bChGYcsOPd5
        yxOQzjXn+5E85IW3YhUczFSNu1yykDJ2CrdqCdtioiATt/dpsJjMlWKoaiEbBp4d
        +DgmRYL7//2UPL8woGNwgGl3dXMrOb/aERk7MYEEuilUnz8yGk1jm/NX3lL1wVCW
        9QUPbqcMu59jnSNxe8FGpawQAaH6UcZXj5PmY3ncsFEmtzhmTbuAeL+Q0he/N/kB
        ORBdLKZw3HOwMbvaRQ2PaFZElYW5Vouj+FWwl872zw==
X-ME-Sender: <xms:sujaY1F0wor5ENGyiYO1DJsAEsFWiBN19IZR2HLp2gIoXJEL5xJLiw>
    <xme:sujaY6Vo7olOFLHE-1o6o3hL7Zdy3GsiG4tYXLY1dK8NwEnZOKNaEtfhBuxyfEY5b
    Ajs26USEZyFVdIcO44>
X-ME-Received: <xmr:sujaY3IkA3IrawyjN8yJW5ciQVa92HLFYdhu2ApJXLBV5YRIgjOtx_8nQuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleef
    teetledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:sujaY7FcEBgsGBaJWFC1lfdobSRoqalMCLtdnNSgHrb910PhY__Q2w>
    <xmx:sujaY7VBrh-d0Vrh47MjWWG-zzT-x-4_kx4bQSM6B2kBsnx4z433OQ>
    <xmx:sujaY2M0_RUXMMRgUcJiNXtrb8bhQWupZBmNyCejxkr1xaaKCxcI1A>
    <xmx:s-jaY0W1hXLOdvUxerttbgYsJt5hPlraI2I6xO7cSgPd7n6daMvb4Q>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 17:33:21 -0500 (EST)
Date:   Wed, 1 Feb 2023 14:33:20 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Message-ID: <Y9rosOyM+BgMqOzO@localhost>
References: <14506678-918f-81e1-2c26-2b347ff50701@intel.com>
 <CAG48ez1NaWarARJj5SBdKKTYFO2MbX7xO75Rk0Q2iK8LX4BwFA@mail.gmail.com>
 <394c92e2-a9aa-37e1-7a34-d7569ac844fd@intel.com>
 <CAG48ez0ZK3pMqkto4DTZPNyddYcv8jPHQDNhYoFEPvSRLf80fQ@mail.gmail.com>
 <e37a17c4-8611-6d1d-85ad-fcd04ff285e1@intel.com>
 <Y9MAvhQYlOe4l2BM@gmail.com>
 <8b2771ce-9cfa-54cc-de6b-e80ce7af0a93@intel.com>
 <16e3217b-1561-51ea-7514-014e27240402@intel.com>
 <Y9oMmYWzy7mlk3D9@sol.localdomain>
 <c5809098-9066-d90d-1bcc-108a11525cac@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5809098-9066-d90d-1bcc-108a11525cac@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:09:16AM -0800, Dave Hansen wrote:
> It was designed with the idea that timing-sensitive and *ONLY*
> timing-sensitive code would be wrapped with DOITM.  Wrapping that code
> would allow the rest of the system to safely operate with fancy new
> optimizations that exhibit data dependent timing.
> 
> But, first of all, that code isn't wrapped with DOITM-prodding APIs
> today.  That model falls apart with current software on current DOITM
> implementations.
> 
> Second, we consider the kernel in general to be timing-sensitive enough
> that we want DOITM=1 behavior in the kernel.
> 
> Those lead software folks to set DOITM=1 on all the time.  The fallout
> from that is that nobody will ever use those fancy new optimizations.
> If nobody can take advantage of them, silicon shouldn't be wasted on
> them in the first place.
> 
> Basically, DOITM was meant to open the door for adding fancy new
> optimizations.  It's a failure if it doesn't do that.

It seems like it still potentially accomplishes its intended purpose
even if it's opt-in. A prctl to turn it on for a particular process, or
a particular process and its children, could work if that process knows
it wants all the performance it can get and won't be handling data for
which privilege boundaries matter. If this actually has the potential
for substantial optimizations that would be worth it.

But yeah, opt-out seems like a non-starter, since it'd require fixing
all the cryptographic code in the world to request DOITM=1.
