Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A3767297D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 21:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjARUfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 15:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjARUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:34:42 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E85EFBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 12:33:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D19EA5C00C7;
        Wed, 18 Jan 2023 15:33:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 15:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674073986; x=1674160386; bh=iJGSvZEAeF
        qQdWIKfDucEMI+v1mVjLVCzF+2CZKpJeQ=; b=n1grkTLPGuXJ92lFVLzwtmGUiD
        AaCT+aLgke39a0nSg6oN+pRuUvZtCv2K7n/AY/ThN+RikRcol73uQck0FG8A1rVc
        HVewAghVHGuN9XYXNLopg1a6JhodqWn4870pGvBZUAMMPi8TIQ3DD9gI6tyOg2L5
        b2im4ruMbFHq6XsnWVfxbpg4oqqej4tbF8n87acuuQsXsvqHBqaVb5Bs6GN71/2Q
        qM+bymsI8dh5dV0236/bLT2dWnWNSzIGNdYpS8zOZQtatz5G5nkjA2KwbdmKZNq+
        t65qCw/f6MSz3cBjPbTnCsp8VI/JGhNI8NOZVMoFZLXEhhBvCQ5h5ZxiaJQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674073986; x=1674160386; bh=iJGSvZEAeFqQdWIKfDucEMI+v1mV
        jLVCzF+2CZKpJeQ=; b=llRm8ihNth8j2k6V4srAwXuCkCSdbgrYZzX5/8CnZwKb
        zCoKqe5Pw8ISnzPkwEuob7YvppusejPLppS4TuzOV4b11nI87QSkO2+7iPFJBguF
        gIqUlZto9plzXz8eHV99pMFYU4Jyc4dnh96q/dgyj0/w+GtQZJGgDmrvctv0Kd1W
        DaySHfGXWF+qoz58CLfWrso9Py3NYdGqBfMLzNHkFeCfFD6lKWz9vOfwP99w+Qj+
        Uhr7J5uMiQjQOeOs824C1uN7BO7rsHffWUGI3o8bxRtrI9huEyL7AkoKqecRH2B3
        nT5qfQjeJc7ECSzCvRZGa2dOr1Gtr7S2xm6F5FyCAw==
X-ME-Sender: <xms:glfIY4Qq8Qwabt2MymKo8JlaPNsn8VzTHDfXC8ZC7htCZ7KozUA3fw>
    <xme:glfIY1zOhyDrk8afaG63g8qIWHO8ks8bTzG9FUPkOgTbyK9rhcl04bVezYMOF903I
    gP1CQzv5bonqUD6mM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtkedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeigfeiieeiheejjeeiudekleevvddvffetieehteeikeeigeeiffdttdef
    tdeggfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:glfIY13dadnqXoYDG2ao5SnYBVVAcs9x8SCNbNA5T4XiEIw9qPFm9A>
    <xmx:glfIY8A6lKsXwMbXc7cHIXyXemUhRvgDXEZ5h3Wgx57S0jejJYGZOg>
    <xmx:glfIYxhIKSDKXmYbycGBbQ0saCKAyBP7j6U3B52oEFAbTOcMDqanMA>
    <xmx:glfIY8U4zpqyskQs9S7WAdQLWf4GryEzXeXPfSwe1p1GzKis7O9k2g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A84CB60086; Wed, 18 Jan 2023 15:33:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <a1d48420-862e-47e6-9435-462e23bb6be3@app.fastmail.com>
In-Reply-To: <Y8ggiF+7k0rViXcY@slm.duckdns.org>
References: <20230117164041.1207412-1-arnd@kernel.org>
 <99ea6e86d2594b40a6de96cc821c447b@AcuMS.aculab.com>
 <Y8ggiF+7k0rViXcY@slm.duckdns.org>
Date:   Wed, 18 Jan 2023 21:32:45 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tejun Heo" <tj@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Richard Clark" <richard.xnu.clark@gmail.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Andrey Grodzovsky" <andrey.grodzovsky@amd.com>,
        "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-kernel@vger.kernel.org," <linux-kernel@vger.kernel.org>,
        "David Laight" <David.Laight@aculab.com>
Subject: Re: [PATCH] workqueue: fix enum type for gcc-13
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

On Wed, Jan 18, 2023, at 17:38, Tejun Heo wrote:
>> From: Arnd Bergmann
>> > Sent: 17 January 2023 16:41
>> > 
>> > In gcc-13, the WORK_STRUCT_WQ_DATA_MASK constant is a signed 64-bit
>> > type on 32-bit architectures because the enum definition has both
>> > negative numbers and numbers above LONG_MAX in it:
>> > 
>> ...
>> >  	/* convenience constants */
>> >  	WORK_STRUCT_FLAG_MASK	= (1UL << WORK_STRUCT_FLAG_BITS) - 1,
>> > -	WORK_STRUCT_WQ_DATA_MASK = ~WORK_STRUCT_FLAG_MASK,
>> > +	WORK_STRUCT_WQ_DATA_MASK = (unsigned long)~WORK_STRUCT_FLAG_MASK,
>> >  	WORK_STRUCT_NO_POOL	= (unsigned long)WORK_OFFQ_POOL_NONE << WORK_OFFQ_POOL_SHIFT,
>
> I have a hard time understanding why gcc would change its behavior so that
> there's no way to compile the same code in a consistent manner across two
> adjacent compiler versions. The new behavior is fine but it makes no sense
> to introduce it like this. If at all possible, marking gcc13 broken sounds
> about right to me.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=107405 has some more
information on the change. In short, the old behavior was a gcc
extension that was somewhat surprising and not well documented,
while the new behavior is consistent with C23 and C++ as well
as easier to understand: Any constant that is defined as part of
an enum now has the same type as the enum itself, even if it fits
within a shorter type. In a definition like

enum e {
   A = -1,
   B = -1u,
};

the enum type has to be compatible with 'long long' because
anything shorter would not fit both -1 and -1u (UINT_MAX).
A and B were both signed types to match the signedness of the
enum type, but A was actually a 32-bit integer since that is
sufficient, while B was also a 64-bit type since it exceeds
INT_MAX. Now they are both the same type.

I don't think there is a chance they will revert to the old behavior,
though we could try asking for an command line flag to warn about
cases where this changes code generation.

     Arnd
