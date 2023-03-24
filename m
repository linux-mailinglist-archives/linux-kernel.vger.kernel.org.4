Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBF66C7E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjCXMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCXMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:39:50 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A91499A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:39:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F3065C0061;
        Fri, 24 Mar 2023 08:38:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 24 Mar 2023 08:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679661535; x=1679747935; bh=91G2ItCs97Qpy8gY4/qyjWYaoAD0IfoIyzN
        jG0XLjQc=; b=MRJjzFP3cVZSc48Mh5ScjWFLeam2DKJM4gLRW4G9F+IMPl6zya5
        K3coHJbLu6GnswsR5dyO5zhXZ+9v3TgRMr0rVwQyaLHCTsipSBnVaVM9tJpINgfT
        qbBZk2KUvNSbrGwRNoHAvdCnGqSapa3y+ZV2qdkuSmmFtK1Zb3tQgcasngLBrC3R
        tNcMYczW9mllnYj0i81F4GSq4y1ZWN9TvdgyGa65g0FXFy2RBD7I7Pzlx8xZoT9C
        C3Wi9LcqloxYUpB0PNr4Tc7NSzCOC1v53bvO3IPMUHOI8bMyvflGC56o2ZJYqXGy
        lWgtYQR1xstLbWSYKrg0IzrDxhUZUcfhySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679661535; x=1679747935; bh=91G2ItCs97Qpy8gY4/qyjWYaoAD0IfoIyzN
        jG0XLjQc=; b=Bj1mHbw5gLqeoC4q3z64Q8Qcy4ziahYlbGZKElfACo6sbnoXDoX
        oV0/KhI7VefM1hjjAefhs4OaxjEsI1p5/FK0PTjvnXyUi7YDYiMtg/7qvclSyLBp
        d1G7sxRHjx3Y5yiOGrBnkUYrh10o2uBKS6wKbyKeVyx3XXr/oKbWCF7a6HnH01zh
        cuLEgfcFky772osA99HEsUFsKuvp5vri8mYxkmOdHfmAa7/kY2SDiFxVs4TCyVx7
        Q3BSnq8mbyhROHf6+Y0LO7d1bpptuUXJDaGY3bt+PIUzjQR1IsaAVCssFzwacX5b
        yxAam3022X+u1sADWlxGqwmMDCwEVsB8hgQ==
X-ME-Sender: <xms:35kdZDYa7Ysr3SaVr9MAdXSo8LYbC4c7Ys16qjb6YyrSBVieAS2a_A>
    <xme:35kdZCbJPt8IiLjFX4H_QMytpa-AEk49iKlmvsBDo4hgjF_Ku9o2EXRyCu36IUAmf
    PelyFFhW4I-cg>
X-ME-Received: <xmr:35kdZF8h3NCZjHH9B0Qryi1nW-_FeKWiqXFF63zfRH3C7oIOC77CNExmt7u8FjremjHbd-jKQOrwXKlkyvmHJ3u4eK0yaBjJHLl50w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpedfghhr
    vghgsehkrhhorghhrdgtohhmfdcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhephedvieegvdfguddvveetveejkeeluefhudekhfelhfdvteegjeethfff
    jeetjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:35kdZJr7LB4BKRnUXVMIeIEwIulbxRbwYlFOTZurlwsz4npQBmLiEQ>
    <xmx:35kdZOpAb_1qIczY1bqQm_sG8Ds0DEcz-eZjUlFz4AbwNbJKE_J3_A>
    <xmx:35kdZPR7TyGRZtLbH_q9E4gjRFlbZ_po5JkHWG4rNhzZhjlXzxWKFw>
    <xmx:35kdZPd4TS3r3BvM17OVIu76LFulnJgWLfSmo61BtC3O380apLBUJQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 08:38:54 -0400 (EDT)
Date:   Fri, 24 Mar 2023 13:38:52 +0100
From:   "greg@kroah.com" <greg@kroah.com>
To:     Gary Rookard <garyrookard@linuxmail.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: comedi
Message-ID: <ZB2Z3Ip+9bbhx0Pr@kroah.com>
References: <f3e94902-3e0c-5857-bf44-0e2c42de30a6@mev.co.uk>
 <2417949F-CC2C-49A8-8001-BACC1E8D27C2@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2417949F-CC2C-49A8-8001-BACC1E8D27C2@getmailspring.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't use html email (the mailing lists reject it) and don't
top-post (makes having technical discussions impossible.)

On Fri, Mar 24, 2023 at 08:25:38AM -0400, Gary Rookard wrote:
> Okay, somehow git cloned an old staging kernel version on me need to figure it out why
> so it doesn't happen again.
> Download date: Wed 22 Mar 2023 08∶59∶26 PM EDT
> Git source: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> File in question still had check patch warnings.

You are looking at the wrong branch, ignore the `master` branch in
there, use staging-next please.

thanks,

greg k-h
