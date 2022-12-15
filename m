Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C764E150
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiLOSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiLOSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:51:52 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6511B37225
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:51:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D41925C0079;
        Thu, 15 Dec 2022 13:51:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 13:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1671130309; x=1671216709; bh=gh
        kLpsx4RVJFulZAnepSibSNEi4jgDCi32YDUQU5Qss=; b=O7iW25V/+pmJyCrBrm
        1Zy7RdjlXF/8i+lzOHGlppw2aHl8ur6WVcCumXltUv64PxqcGw1LsIgZYch/F2Z/
        q97kBphvczZK7+2wTuKzY0K+Jw6hsgcmNurBjFIEXvjCl0RGZ0ZQ+NTw3w97F/28
        N8s/pbxv0y/2fpoJnIomaxQKOLSRITKmDZdZ/pQy7Gk4Jni89ljFLPTJgTnClkOe
        FmMMzcWzIcr+8rA7McBerG1vjerIslOZHlQeqqZoluaYCIsiUyp/ufXBM05/uIzU
        nGqHXZJ6jQ3aRzyvrYth/sbF2wVhEZaLOsnIQzQh1eWwijCNavfB4Rp5Chc2ND+3
        9ltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671130309; x=1671216709; bh=ghkLpsx4RVJFulZAnepSibSNEi4j
        gDCi32YDUQU5Qss=; b=V0eOit6Getpt72uLPPaO8/T2U8uzlLzFkyQ1gZqd/y8h
        Gz04z3W9CC6PjEC/RPPcEuhTXpv5DGa6Hit70Acobyd2Q3+NMmeeh9OV1RpeY9Y3
        c2WsrQOT1niINSylO/6RLOg06WN1j/stOplZnwb4/fGJwERVy6qusW9n/3H9CRpo
        tRkU04G5Jmrnbb6nITJnOOboXzIv1sr1hUDhEKp4e8OW1TMHqJIemr8eLZpqh2ZD
        y+WRIdZbq06uBqHTgLl7e00f+vB52ZJzBsJDmiEmPT262qbWU9RBxcfgJKM4uBvu
        lOy78SFZCg078cDXRCmOQgQ+jWEw5UORDyqNgBMtfQ==
X-ME-Sender: <xms:xWybYzP_8dwpbAbTFbczqMI-MzZPj0bGfXciwt5gZEv9wtj4cgoUQg>
    <xme:xWybY9-WS0MvwMrnnXZ0PL7svt5Re0okRXNpAgRQml62QxM2rCA38OdBXRg-cSSst
    QcZCtFl62w0sjrFxFU>
X-ME-Received: <xmr:xWybYyTvr__tNV3f3gwCqW95EZbm_FNTd6bcqCbrBpteiuz7GlRwEuKYD16AlchbFA_EXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekvddvjeffheetgedtvdfgieejiedvgeejieet
    jeehieehveffueekfeehffdvveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:xWybY3uW1uDxH46W2sNUklEq8XydVdvvJTz5zUkwfNm9l1Evb6zZeA>
    <xmx:xWybY7dYOCbbZjAqQ5qiePRhvVOP2LNf5TKn5q23uj_yVY9-ayp18A>
    <xmx:xWybYz3MTOEEJDyP7c9dZT-SsOdr4eRadL6Hnvbd1sr7Qh74eIv9xA>
    <xmx:xWybY6zoiF9WqwHL2QXLrKSKaZnQt19eP8hCt2s5esIHa63fPDaW5w>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 13:51:48 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5074D109EB3; Thu, 15 Dec 2022 21:51:44 +0300 (+03)
Date:   Thu, 15 Dec 2022 21:51:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/tdx: Use ReportFatalError to report missing
 SEPT_VE_DISABLE
Message-ID: <20221215185144.tjctmkwp5vodep3u@box>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-3-kirill.shutemov@linux.intel.com>
 <3121847d-d334-67fc-43d8-0670c08c64b6@intel.com>
 <20221215171254.3v4maexfhkdnbfk2@box.shutemov.name>
 <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795d6e1d-c79c-b079-3412-69ca2f8ee874@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:18:24AM -0800, Dave Hansen wrote:
> On 12/15/22 09:12, Kirill A. Shutemov wrote:
> >> Getting *all* users of panic this magic ability would be a lot better
> >> than giving it to one call-site of panic().
> >>
> >> I'm all for making the panic() path as short and simple as possible, but
> >> it would be nice if this fancy hypercall would get used in more than one
> >> spot.
> > Well, I don't see an obvious way to integrate this into panic().
> > 
> > There is panic_notifier_list and it kinda/sorta works, see the patch
> > below.
> > 
> > But it breaks panic_notifier_list contract: the callback will never return
> > and no other callback will be able to do their stuff. panic_timeout is
> > also broken.
> > 
> > So ReportFatalError() is no good for the task. And I don't have anything
> > else :/
> 
> Do we *really* have to do a hard stop when SEPT_VE_DISABLE is missing?
> 
> Wouldn't it be simpler to just defer the check until we can spit out a
> sane error message about it?
> 
> Or is there too much security exposure by continuing?

Well, I guess we can. We always have attestation as a backstop. No
sensitive user data has to be exposed to the TD before it passed
the attestation.

Do you prefer to have a separate initcall just to check SEPT_VE_DISABLE?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
