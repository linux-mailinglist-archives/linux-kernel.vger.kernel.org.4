Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D073C7392AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjFUWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:47:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087719AE;
        Wed, 21 Jun 2023 15:47:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0CCAF5C0140;
        Wed, 21 Jun 2023 18:47:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 21 Jun 2023 18:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687387642; x=1687474042; bh=odM0ROmmXZz2l
        qnANu3LwALHTxJMn1T0y9hAQX6H2Go=; b=Sg9BMqRxJUnOPiv9y19+LPVZVaK/q
        Z3Og1CSvcCuXsqewxRvOtPZ8alrojCSuBhYKJuHGYw8LUPYQa6Z906BQ/8YrnMju
        C+Ee1h0RDkyQVLzSOkfGqzYNMMlhdbb1AO4zA0gXt63qJRE7aSYFszAWGlyExDRa
        AnQrcggVSmg9mzb/REkGtJbEd498p0oPW3AwBpL3isMkf/3tF5Ct9T87eIQwT1dp
        7Iyho13g6PLs+ed+zqJ26BXsmOe0+8fEf4h3sgw/oY2zHqQI+EWneDqfRaRGNbXv
        qtsNfbUqsOELzz6YuXe6QPxGvRq4peEFGAtnciuRALb4lyLKGPHYWz3Iw==
X-ME-Sender: <xms:-X2TZPvKXx6GdqUas6473REtdUEw6hbJpIIGPGvZVbLO_1taQDL8ow>
    <xme:-X2TZAcLgRBLyX1ybxfpn1ZUY3raZRYjtlFuwSLMOL8qeIlTX39rC_mjKd_gpVCV4
    JQo83_xXlCvCK1zDdA>
X-ME-Received: <xmr:-X2TZCxUriqwAKsWFAHYdO7k_82YGisgJ2q8DRgEeheX-b5-yn3bv8ILY2U57cbC_naaWRTrMfLTfQ4reZOBevbXr8-4-DRqEgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:-X2TZOPKTNF0Qj87W-0pIjqB5k_HmgWJkzNsMjL1SAK4lW7Ayp-scA>
    <xmx:-X2TZP8YgjuTVRErgTQ5xNO-A6_KM9p5wubsfJDkuH5rxiRlwbe3Qg>
    <xmx:-X2TZOVa1ObslMSxcbwzejss75f_zDo3ZIhwHimHKt8Dd5-xp-zB6A>
    <xmx:-n2TZCZYlemx_nNz0y0BI7JcxD4RDfx1RZI4ls5aciiQm8vl4klXlg>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jun 2023 18:47:20 -0400 (EDT)
Date:   Thu, 22 Jun 2023 08:48:12 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     Theodore Ts'o <tytso@mit.edu>, linux-doc@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Tech-board-discuss] [PATCH] Documentation: Linux Contribution
 Maturity Model and the wider community
In-Reply-To: <20230621100845.12588f48@gandalf.local.home>
Message-ID: <1c3b8e4f-ac8f-1c79-387d-7b68b64ca645@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org> <20230621100845.12588f48@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023, Steven Rostedt wrote:

> 
> > 
> >   Making the maintainer role more lucrative will provide a 
> >   disincentive for more automation (with or without level 5 
> >   performance reviews) unless remuneration is tied to metrics that 
> >   reflect maintainer effectiveness.
> 
> I'm not sure I totally understand your point above. I do not think that 
> making the maintainer role more lucrative provides a disincentive for 
> more automation. 

You're right -- it's a moot point (whether paying people more will reward 
underperformers) since it all depends on the performance metric. I was 
assuming a metric that reflects my own bias.
