Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F466438D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiLEXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiLEXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:00:12 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A441DF03;
        Mon,  5 Dec 2022 15:00:09 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 950E85C0284;
        Mon,  5 Dec 2022 18:00:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 05 Dec 2022 18:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1670281207; x=
        1670367607; bh=w+IeYZdl/jBckc+B8Ef5+2fkoYurFniYzp8I2WfjJAg=; b=v
        73bsI1Zzl+PrRrnFAe74z/P5X5Ye8j8fquNTyUc1qVnyF7vUs4SaArQhkKa6/u40
        gl3I2Oe2ZjAXjRPYigkM/gAutmcG/OkgrSq0BbQDxL0TF5ud1noUKQGJ2/UQrAUN
        G7/4aH3MHiGIYZ1XicYxUE1FKLGMX0F731YzNqw+2SgvQo8OftwhnPN6uGEw58QQ
        kKuXdsuCnziT1QqDvfyS9YCvHWTcmJgcVzANF4hwzSxvJn3dkKXDUhVsH37V1ZxM
        R0kZYKZCWuUVSp6XZ6cpgqr85LDVo4oAh9gR2C5TWr2THP0MktzjX2eB+9OzdOQD
        Ad+6Ix8I7wAzUum7qf6kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670281207; x=1670367607; bh=w+IeYZdl/jBckc+B8Ef5+2fkoYur
        FniYzp8I2WfjJAg=; b=E5jxSz6Mp7sHvXcwPtIZK90qQ/rR9TrWy5GoZL9q2tWn
        7M4PgrompkamBn8jUN0SEkyzp6cMUG7Q/qtEkO/O8O2ZsIiaPiocQXb/3fBYWKa/
        cdHMOAPgLFoUJ/Q2aHNnxSYGiXLqdGn2xHd18oMnVDR7OFtoqrkUsk32RAehRh+6
        kcM8Gzkxwe8Cax6J5MfF+8LH3vWz5Om6dsMjVl2RtnBjNhCB2blH78wBuIbo0Dd8
        vhH1LbPi1AkaTLAurbqaEXwJMFxgA5JAIMCpzfzysnwJgPV47o2ytUJ7ZatEXm4C
        S3fHTC7TJHVHB6w9OZQSHNTsC81UPptci5aqY14u5A==
X-ME-Sender: <xms:93eOY-XgHEH4OStt78DU6LtncQW-6XDp4dcS5-6VaXqitUP_B9g_8Q>
    <xme:93eOY6mba9x_zsOjqtL_YqNxgiDfLvKNdP40pSb9t0_CsQu9QEgPZV3UXpslQB_76
    pBUW5vx4CcvTn6WDtg>
X-ME-Received: <xmr:93eOYyZ114zmunMSvngDoZYf4axMPpk0EhoAhdTKPCq6Aoe---1gUAveRYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleefteet
    ledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:93eOY1Vx6MJGs8q8uEe49JfbFJ1flIIDKAPYgX_utf-_Cn3SQ7aIhA>
    <xmx:93eOY4ljaj-S5NWUuQTAOcIu9UDuU5sfQMgt618e06i_uBxt2Smelw>
    <xmx:93eOY6cT7KZhohQWLedDqhrmSJe6D0R6sjD-jC7ZG83fGk_gwJKjzw>
    <xmx:93eOYy7zhf6SFvROxdpaocRF1JPAsEMnaTsdu2PhxPbtwkPIMRtIEw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 18:00:06 -0500 (EST)
Date:   Mon, 5 Dec 2022 15:00:05 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, ojeda@kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 27/28] rust: types: add `Either` type
Message-ID: <Y4539anPZXLqekVb@localhost>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-28-ojeda@kernel.org>
 <Y4qNR+Nn9utDftHq@localhost>
 <20221204103153.117675b1@GaryWorkstation>
 <CANeycqpNW0E5fQqD1Qzqr0p-3cgs5k5KgLusragaSWbrmcx2Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqpNW0E5fQqD1Qzqr0p-3cgs5k5KgLusragaSWbrmcx2Nw@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 05:36:08PM +0000, Wedson Almeida Filho wrote:
> On Sun, 4 Dec 2022 at 10:31, Gary Guo <gary@garyguo.net> wrote:
> >
> > On Fri, 2 Dec 2022 15:41:59 -0800
> > Josh Triplett <josh@joshtriplett.org> wrote:
> >
> > > On Fri, Dec 02, 2022 at 05:14:58PM +0100, ojeda@kernel.org wrote:
> > > > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> > > >
> > > > Introduce the new `types` module of the `kernel` crate with
> > > > `Either` as its first type.
> > > >
> > > > `Either<L, R>` is a sum type that always holds either a value
> > > > of type `L` (`Left` variant) or `R` (`Right` variant).
> > > >
> > > > For instance:
> > > >
> > > >     struct Executor {
> > > >         queue: Either<BoxedQueue, &'static Queue>,
> > > >     }
> > >
> > > This specific example seems like it would be better served by the
> > > existing `Cow` type.
> >
> > We use `no_global_oom_handling`, which gates most `ToOwned`
> > implementations (e.g. `str` cannot implement `to_owned()` because it
> > cannot guarantee allocation success).
> >
> > So the Rust `Cow` is pretty much useless in the kernel.
> 
> It's also implemented in `std`, which the kernel doesn't include.
> (Which is actually good for us, since we can't really use it.)
> 
> Josh, how do you feel about adding a `TryToOwned` trait to
> `core::borrow`? This would be similar to the precedent of `TryFrom` in
> addition to `From` for the fallible case, and would be usable by the
> kernel.

I'd expect it to be in alloc rather than core (though I suppose it
doesn't *fundamentally* depend on an allocator itself), but I'd be happy
to see a fallible version proposed, yeah.
