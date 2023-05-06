Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF516F8D16
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjEFAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEFANv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:13:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E56E86;
        Fri,  5 May 2023 17:13:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6E1B232009C0;
        Fri,  5 May 2023 20:13:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 05 May 2023 20:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683332029; x=1683418429; bh=gDkdPLFGHEgwB
        a8neDNDtTbJzRE+q/3RtYLzD+Pf+P8=; b=Q8XG2AWQgyCMi09ZyMm+KsQ0hhprv
        mpooklDQKeung+QWuBSAj/oCp/IpivM2K7XnXh3Qvn8lhOiJOYAxClS/rU1xwfwl
        9dGWxnIg16hEvLdtmI/FetfUGGPZpda4XCQrrmaOZPxJfuDg9NuFQq3OY3pYceFb
        nSdkV0WKCNuVg1u7V5B8bZok6hBXsOVjmSxeze5cGpq0tN+o78IZzjqnxwqf04uy
        8EBcx3yLS09+94+6vwFIdokFBhtS+BY3E4hh2mxo7dOWvNWUOpIkEyXYg4VeQ46X
        auuC21N7RCmqsHgckHBJyd0kMyFOJaOhquTZCyFSFOXRUdQR9l9YL9Sjw==
X-ME-Sender: <xms:vJtVZBVPnIqEOgCqg_3spi5O9XaYxlINvSVNPFF-6wMKYr8Tw6NYvQ>
    <xme:vJtVZBmm7NgizshS73-0dCWFNwuHp4CDeHi5diuKl0O-TnpNZWTzKGPczmba8BN6G
    MGl9-c1RHZf7B1UFCY>
X-ME-Received: <xmr:vJtVZNaGab57ZUrcx3TfzKo09FoQAHfp3DD3zs27ubhW4Gei8IZbs_IOq3mhtMYPDq5FYqzPW1yyGuMo1U0xnqZ_K_yr-n0wzgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:vJtVZEUZPgiEpg2x6w3Azv88oWdLHzeSPodKg674KG6mwKHRCi23mA>
    <xmx:vJtVZLmEBKuMujz-5ZtXZOhtAcSnvFTfGlAeINZX6f1jUJCmS2fvdw>
    <xmx:vJtVZBdVnSljclkUTxiHxNm_nvOyJbxx-vRCuoAgJM7aubXmZK3AKQ>
    <xmx:vZtVZN7Qf7xlD-4-tjP1jkpQMKvw0AMBmVdG21SE5EYlSVA1Qa-i4w>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 20:13:45 -0400 (EDT)
Date:   Sat, 6 May 2023 10:17:44 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/3] Documentation: scsi: dc395x: Remove reference to
 2.4 driver
In-Reply-To: <87pm7enbpo.fsf@meer.lwn.net>
Message-ID: <3ad2962e-ff1f-4fe6-76e9-21c3936578a9@linux-m68k.org>
References: <20230505082704.16228-1-bagasdotme@gmail.com> <20230505082704.16228-4-bagasdotme@gmail.com> <d919a2e1-5749-13f8-7867-1f17277190f4@linux-m68k.org> <87pm7enbpo.fsf@meer.lwn.net>
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

On Fri, 5 May 2023, Jonathan Corbet wrote:

> 
> Most of the 2.4 code has indeed been deleted *from current kernels*. 

Is it okay to delete old code from -stable kernels?

> It's not clear to me why 2.4 documentation should be immune to that same 
> process.

My message argued for removing 2.5 documentation and retaining the link 
that gives credit to prior contributions.

> If we keep every 20-year-old reference, our docs will be even cruftier 
> and less useful than they are now.
> 

Since you're obviously being facetious, it's tempting to respond that 
"churn is good because it reduces the average age of the code". But that 
kind of exchange gets us nowhere.

I'd be curious to see an age histogram of the commentary in the source 
code in the mainline kernel repository (or any other long-lived project). 
I wonder if that has ever been measured.
