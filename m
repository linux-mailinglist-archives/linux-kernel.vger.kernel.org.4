Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5467E68F3E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjBHQ7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjBHQ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:59:15 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2C1CAD4;
        Wed,  8 Feb 2023 08:59:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h24so21530591qtr.0;
        Wed, 08 Feb 2023 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7H+/GICwV/V05esZScE/Prqpiew2ARhgCCv2xN08dwc=;
        b=W65/Gc7k7weum+eWfL3oTk0xiJPKfK+2PWgOz5E068twmIHpxcXc/Te37gb/vAdn+F
         PI8aYEQuH3TpiarlmzIRFL7ysSqhbICs4GDxKidpCiI2ubos6VCjdptbiAnHSOMALcnT
         WDT/c9jc8Yspy/xTkXqXZp9+nJtniMMqs/uI0neC48XxnpDSbsGwECT4u2fcnFXoOd2k
         MU0C6APCZHxd3ucx0/z2f49zeFqyJ5B6CnqYpxrrfbIn3fHB6S1uFCTzLE2DUBUyu5Cw
         vs75LFcF7lAMJPdQSHEgUkFfwQDGqjYCMvACUQsHuvLmX61uwipblfLghUWKVaX5m0z1
         6oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7H+/GICwV/V05esZScE/Prqpiew2ARhgCCv2xN08dwc=;
        b=3Dq1DTsKtM5Ld62GcUXpV9G6SVX5qy8PxLbrH+Zy0Sy29CWPfqukqULhCQieK6cE0N
         uTlrhnhn7nsB3S+F+E8u3/yYlxCY2cfcHspUMxCC2AfqWA3XK2mzUURqReHfGc6MyZaM
         zqGc2PxDrKTE0grQGnHDltetkt4h/ALCGzSvEqOfNHqgeObLkc8eVpxOG4sPxEyMTri1
         RrGIwxOJfFSh+rVWNqqyEI4fOdNgxggdzQvHxWqGiNf6ULnjG8+CVUFSNhF2XzO7A5g4
         WERt+K9X+Hn9eCLhgGeUrNqCOVyVu+e/5bGJORN102BOkg1rJfF/Lj8Xnce/gmVz75Dd
         wlgw==
X-Gm-Message-State: AO0yUKVyypv9LV500UC3Kz4uj39wklS0XzI0TbfCMNMel6eD34VvGo+g
        LI6Fp+Nyf0jmPl2FkG3Y+Yc=
X-Google-Smtp-Source: AK7set94/fD1lnodVmXxavvz8GXyFjHf0dpF7dsGIYaeBY4WR4izTfuU8z39cPTPsr3HaW0fxy6tCg==
X-Received: by 2002:a05:622a:1aa0:b0:3b8:6a9f:9144 with SMTP id s32-20020a05622a1aa000b003b86a9f9144mr14010379qtc.46.1675875551182;
        Wed, 08 Feb 2023 08:59:11 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s20-20020a05620a16b400b0071f40a59fe5sm11970713qkj.127.2023.02.08.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:59:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2BDB527C0054;
        Wed,  8 Feb 2023 11:59:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 08 Feb 2023 11:59:10 -0500
X-ME-Sender: <xms:3dTjY73nCjXNPvqJoJWGC6kxu2rM5t12e0JCHKM_CuqKAnCftLC9zA>
    <xme:3dTjY6GVCjKc0yY8qfEk1uaqFaHXsbVSmOoKQv1_Qe8fk6aKz2erl_K8ftC7TkcaT
    maCaG2Wsfm6tcKmyw>
X-ME-Received: <xmr:3dTjY76zvFYog0J0D8nEkj0WUhY-KEc1SbEv8KWenyzGpq9z7M8E-g9EfH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3dTjYw2o4DPSUk8FGBYze5nKny_BfPF6YzqlnRQH9-WFS607HwjmjQ>
    <xmx:3dTjY-H_4lvQKiDQPDm4rfwQ6mlV9poPrvg9s0BT_4H9rzAKMo5VyQ>
    <xmx:3dTjYx-13ZPLg2x7UbJFT-LUgoRHIMGpIlgrEY9-yGBfst33tuLb9A>
    <xmx:3tTjY7fndWKmJNNTILs9tKxOPuhWF0bweFWWJfPSweTPN3yIKM565w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Feb 2023 11:59:09 -0500 (EST)
Date:   Wed, 8 Feb 2023 08:58:44 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 2/2] sample: rust: print: Add sampe code for Arc
 printing
Message-ID: <Y+PUxC0ilJTpmA1+@boqun-archlinux>
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-3-boqun.feng@gmail.com>
 <CANiq72kyrz4efU5=MexgGNth1XxkU1z-GP6xVa7WxApB+PMdFQ@mail.gmail.com>
 <Y+PO9SXyQaWgbQlK@boqun-archlinux>
 <CANiq72kghG4i35Jt2cY0-2CJkzKe-jEfSyU2pJFFqKgfkV7CZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kghG4i35Jt2cY0-2CJkzKe-jEfSyU2pJFFqKgfkV7CZg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:56:43PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 8, 2023 at 5:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Hmm.. I'm OK with this change, but it's not a typo ;-)
> 
> By typo I meant the "sampe", not the other changes -- sorry, I should
> have been more clear.

Ah, good eyes! Sorry I missed that twice: one when submitting and one
you mention it's a typo ;-(


Regards,
Boqun

> 
> > 1)      capitalize the first letter after subsystem tags in the title
> >         since that's kinda the rule for a few subsystems I usually work
> >         on, I don't have my own preference, just something I'm used to
> >         ;-)
> 
> Yeah, I don't mind one way or the other (in fact, personally I prefer
> uppercase slightly because it is a bit easier to "scan" visually to
> see where it starts after the prefixes). The lowercase one is just the
> one we have used so far for Rust (which I picked looking at what Linus
> et al. usually do).
> 
> > 2)      avoid using "`" in the title to save space because title space
> >         is precious.
> 
> I see, makes sense, thanks!
> 
> Cheers,
> Miguel
