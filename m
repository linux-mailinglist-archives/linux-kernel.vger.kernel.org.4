Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D217E73625A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFTDxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjFTDxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:53:38 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3089E6C;
        Mon, 19 Jun 2023 20:53:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E8955C011B;
        Mon, 19 Jun 2023 23:53:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Jun 2023 23:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687233215; x=1687319615; bh=Mn19YQ7R3+iim
        Mi/L2B59f0E2YcswbZeogtBkr71boI=; b=Idv6ckvZdPwpFDWeTp3yAegQHdieL
        EE2gGsKcShBST7ZG0/ddoW9tRA8ylCYwGkjSu8g89jEkNqfw/8nOgbTqK7NdExZ7
        1EQzbA3zt1m3z2G4BmytxAVTMb2U8KOr/kKzp2CLxvyEJak17o9Rs8F2GRXK8mw8
        TUWMw36SiEN+x4lJnO677pNqesSm443i9LH2t17MLpXrW+jDxjXT2iQklpywDTtJ
        AI6hvKChbmtpGnzrr2fE7oeujjawv1nkDMUe1H3hdQj+fV5yCFxbqIL8xpnAF5v1
        71vtLy5GGNAVhUmlAJIIMD+duP8s7HGmoHTPeLnjvMpMBtIEm/TNoYc+Q==
X-ME-Sender: <xms:viKRZFUHJNtLoii4I5XwpKHL3UM0DNoq7mHydHIkYkgLZLath-91DA>
    <xme:viKRZFmZP23-jILUHw6T5-f-Pb2OF4tWBtaae3SBcnNxyBmPhJsgeNQ7KCdfw6nJC
    iFJo1ICQQdqgku8hRQ>
X-ME-Received: <xmr:viKRZBaZRisGJStT7-XecS_wjKW-VOxxXwEvd5YdsnAIlSJbC2FSo821QAn7ZxrToV0YN1rV-O_WdUM8dzhxT_b43P4KKpbV4-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeklefhgeektefhtdfgvdeffeetudeutddufeelteeiffelkeegtdelfeev
    ueefjeenucffohhmrghinhepfihikhhiphgvughirgdrohhrghdpfhhinhhoshdrohhrgh
    dplhifnhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:vyKRZIVexFOsVPC1B2CMF7MOtqV8xPgoGzvv4Z7asMY3c4lRx7ActQ>
    <xmx:vyKRZPmAZ8xYfYT_t5DAgmhgtLz4B_r5OYVJfjaJFuThhmoegFKasA>
    <xmx:vyKRZFc8ZFop3g9xSg4RFQS3HkewGT5pQb9DVRbhNVDqzsnglg60mA>
    <xmx:vyKRZKuYEVT3x0kupb-2c2iXo44LgUvGW8-5j8MGbEzG-yxuuckg-Q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:53:33 -0400 (EDT)
Date:   Tue, 20 Jun 2023 13:54:23 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <20230619194216.GB286961@mit.edu>
Message-ID: <1dca9f44-3716-19b2-efc6-03aef5c22d74@linux-m68k.org>
References: <cd1786eadd1ff05d9ca053b72eb5f06ceb0c470d.1687167717.git.fthain@linux-m68k.org> <20230619194216.GB286961@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, Theodore Ts'o wrote:

> On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> > The Linux Contribution Maturity Model methodology is notionally based 
> > on the Open source Maturity Model (OMM) which was in turn based on the 
> > Capability Maturity Model Integration (CMMI).
> 
> So from a historical/factual basis, this is not true.  It was *not* 
> based on the Open Source Maturity Model; in fact, as the principal 
> author of this document, I wasn't even aware of the OMM when I wrote it.  
> The general framework of Maturity Models[1] is a very long one, and goes 
> back well beyond Dececmber 2022, which is when the folks in the banking 
> sector launched the OMM[2].
> 
> [1] https://en.wikipedia.org/wiki/Maturity_model
> [2] https://www.finos.org/blog/open-source-maturity-model-launch
> 

Thanks for that background, and thanks for your work on the Linux model. I 
appreciate the basic aim of the Linux model though I am highly skeptical 
of the relevance of a top-down goal-oriented methodology to a bottom-up 
compromise-oriented collaborative effort.

With regard to that mismatch, though somewhat off-topic, I'll note that 
the Linux model has departed quite a distance from the CMMI. E.g. CMMI 
level 5 is about continuous improvement, whereas Linux level 5 is 
basically level 4 "only louder". In the CMMI, the elements that make up 
the lower levels are strictly required by those of the upper levels; so 
it's not a question of degree but necessity.

> The reason why the language in the Linux Contribution Maturity Model 
> (LCMM) focused on companies was that was where the problem was perceived 
> to be.  That is, the *vast* majority of Linux Kernel contributors work 
> at companies, and because of many companys' focus on reducing costs and 
> increasing profits of their products which are part of the Linux kernel 
> ecosystem, some of them enagage in anti-patterns which are not healthy 
> either for their own role in the Linux Kernel ecosystem, and for the 
> Linux Kernel ecosystem at large.
> 
> For example, if you look at the 6.3 contribution report[3], you'll see
> that by changesets (git commits), 85.4% of the contributions came from
> companies, 6.6% were unknown, 4.8% were "None" (e.g.,
> hobbists/students), and 1.1% were from the Linux Foundation.
> 
> [3] https://lwn.net/Articles/929582/
> 
> In actual practice, we get *very* few commits from non-profit 
> organizations such as, say, the Mozilla Foundation, the Eclipse 
> Foundation, or even community distributions such as Debian or Arch. And 
> so the concerns around software engineers not getting the permission and 
> encourage they need so they can contribute to the Linux kernel community 
> at large, is primarily coming from companies.  The only non-profit 
> organization that even shows up at the contribution reports is the Linux 
> Foundation, and I'm pretty confident in how enlightened the LF 
> management vis-a-vis kernel contribution.  :-)
> 

I suspect that counting commits may be the wrong metric (I can think of 
better ones). But if that's what we have, the lack of commits from 
non-profit organizations is a situation that might actually be improved by 
changes like the ones I'm advocating.

> As far as individuals are concerned, things like performance reviews, 
> the ability for overly paranoid corporate Corporate General Counsel not 
> allowing their engineers from contributing to Open Source (in general) 
> and the Linux Kernel (in particular), yes, those things aren't really 
> applicable.  But again, there is a specific problem that we are trying 
> to solve, and it's not with individual contriduals.
> 
> > This patch addresses this bias as it could hinder collaboration with 
> > not-for-profit organisations and individuals, which would be a loss to 
> > any stakeholder.
> 
> I'm not sure how this document would "hinder collaboration" with 
> non-profit organizations and individuals.  Could you say more about your 
> concern regarding how this undesireable outcome would happen in 
> practice?
> 

I believe that I've now addressed this in my message to Greg.

> I'm not against making using wording which is more general, such as 
> perhaps "companies and organizations" instead of "companies", but it's 
> important that we don't dilute the message the primary audience --- 
> which is pointed-haired management types, who are familiar with the 
> Maturity Model framework, who are *primarily* working at for-profit 
> companies, and who could make it easier for those Linux developers whose 
> day job involves Linux kernel development.
> 

If employers are going to make those day jobs easier, IMHO it will be quid 
pro quo or not at all. That's why I am wary of bias.
