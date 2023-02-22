Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02FE69F217
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBVJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjBVJqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:46:45 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82623C7BD;
        Wed, 22 Feb 2023 01:44:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id ACD3B32007E8;
        Wed, 22 Feb 2023 04:43:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 Feb 2023 04:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canishe.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1677059034; x=
        1677145434; bh=VCMoJbjvZg10keVee9p0giqEJ7Kc4L7pxVFap9ybfZA=; b=y
        CGVI2lgePlD/1NBruHBn3wL4lzzTzWTTNX7Jat5egzFIBzBXbo9V9VIZvTDVmuAz
        uhONZpVSltUQfcLmQ+4UvryHdKPh3mWbCbSYX3BInJgGfAMuHArK3DNvyaKNp96Z
        QPYIp46enPGM9eJJaCO83ONVXIrjxFTigWlJeNxAIB856NwHHmJI/u677DDOa4c9
        H4gWFE9Jw+y9xhTT7OgBeopSssxL1GFcVQ6ml8uxsjbBUTwS51CPCwTDOKQfPj6t
        VK8aX02ZvkBfCVd3ZLut+aPDPXbDpxN+JAYftfgXDo2sEAJXC13DhNaScQPX/cWg
        bOHe2FZiWEHoab+ajfuBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677059034; x=
        1677145434; bh=VCMoJbjvZg10keVee9p0giqEJ7Kc4L7pxVFap9ybfZA=; b=r
        ynIIcEjXhd9PuHRDDK/dtkcnvQ5NYUiWJeqWCWyxjzDa1qpEdOHI2S6EyECWWaMA
        auwovef0BikLJ4Yj3yHjwCQZuzwQ9Qr13mLCN1S8Z4ctGmH7wu+/HkVApsE40nbi
        iZILcoRRcpthVJfkNLK1EjF0liofL3xT9CoFu7ceAOF6odRnKNM+3MonPlDWNZim
        jbGgvE/6d8FZPaJzCgQBiBbl/QnAs5aIqhXpVxgzCjp6F5CT/PKV9gqmBSo49Vd0
        LNGJx7XBvrY6t4VX9fnvOZtUxh11cl7D2KfP+JPboZGlac0UgRjHJA8keD9OBxH7
        4YRd0sI2xR9l+2LbacKqQ==
X-ME-Sender: <xms:2eP1Y1y6L604NRigCI4Y9OXZoh1ntdn2BTJhzZEC8nAT7Z7XmHvujA>
    <xme:2eP1Y1Qdh3sBiZk16m-4Zwyq25KWpUth3eLBVl1areL4EVLpskPxnu12cROhNIcNC
    n6R4V95oPfRsexu6Q>
X-ME-Received: <xmr:2eP1Y_VMsdUgngQLvTh68LDzaBuyF_ibp1532O-EWq7QEEg8t5sSDbGkTgaE2rOkwkiDq6rod-ZjZNmXrSu-MpR1MDJuaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpefirggv
    lhgrnhcuufhtvggvlhgvuceoghgsshestggrnhhishhhvgdrtghomheqnecuggftrfgrth
    htvghrnhepheefvedtuedugeefhfeihffgvddvtefgffeuuddvheefffetleevteekgeff
    vedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    gsshestggrnhhishhhvgdrtghomh
X-ME-Proxy: <xmx:2eP1Y3hOYfRg4NqEaOCGSnCe69lYgQ7hHJg9Iz_aU4VzoneQrnxozQ>
    <xmx:2eP1Y3D90RyXt0wiwIaq5Wp88sBwPXaJS9xUvj9ZyoBZTDX0LVUOUw>
    <xmx:2eP1YwIlQjOugwokx7omOhMmhy0h33CEBXi52MyNAP4WiTWrD7bb0Q>
    <xmx:2uP1Y0J8k0vNIH0pb0He4D3sOj2eGnKpZ9Fi_L4_UpseJZ7ZOtTWzg>
Feedback-ID: i57a145e2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 04:43:52 -0500 (EST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
From:   Gaelan Steele <gbs@canishe.com>
In-Reply-To: <87zg96n12k.ffs@tglx>
Date:   Wed, 22 Feb 2023 09:43:39 +0000
Cc:     Josh Stone <jistone@redhat.com>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <EE0C3422-B908-4263-B0E8-27B6DFFCF306@canishe.com>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx> <65ab5cb1-2dbe-e853-48ea-d1df87706cf0@redhat.com>
 <87zg96n12k.ffs@tglx>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 21, 2023, at 9:46 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>=20
> On Tue, Feb 21 2023 at 09:13, Josh Stone wrote:
>=20
>> On 2/21/23 4:32 AM, Thomas Gleixner wrote:
>>> Now the problem is that 'Instant' in it's specification is bound to
>>> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
>>> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
>>> completely. IOW, that's also a problem for user space.
>>=20
>> That's not exactly *specified* -- it's meant to be opaque time. It is
>> documented that this currently uses clock_gettime monotonic on unix
>> targets, but "Disclaimer: These system calls might change over time."
>> CLOCK_MONOTONIC isn't even consistent across unix targets whether =
that
>> counts suspended time. It's been debated if we should switch to
>> CLOCK_BOOTTIME on Linux, but for now we're sticking to monotonic:
>=20
> You'll need both when you want to implement substantial parts of the =
low
> level user space stack in Rust. Same for CLOCK_TAI.
>=20
> Thanks,
>=20
>        tglx

std isn=E2=80=99t really designed to provide full coverage of any =
particular OS
interface - it has to provide concepts that map cleanly onto Windows and
every flavor of Unix.[1] Low-level Unix Rust code typically uses the =
libc
crate, which just exports everything from libc as an unsafe function, or
one of several safe wrappers (nix is the most popular one, I=E2=80=99m =
partial to
rustix), alongside std.

[1]: std does in cases provide OS-specific functions - for example,
std::fs::Metadata (~=3D struct stat) has Unix-specific ways to get the
mode - but again, the goal here is to be broadly useful, not full
coverage.

Best wishes,
Gaelan


