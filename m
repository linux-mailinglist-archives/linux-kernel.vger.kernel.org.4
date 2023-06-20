Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B473624F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFTDtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFTDtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:49:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C0F10CF;
        Mon, 19 Jun 2023 20:49:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D9205C01B5;
        Mon, 19 Jun 2023 23:49:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Jun 2023 23:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687232974; x=1687319374; bh=uK8OHGMIlFmnJ
        LvVW0a3pMKfDOHLUDIq6unP7lOwbaE=; b=K7k6z/7kBm+2XX8J5xZJpPOm4KUIY
        SjAeNJLTn7VYVT0+Pma8pKRUP4DB5JRuqa0lsXpbHbNf6+7nrUmFksQhT6pyecn5
        wonDg5tnuqwrR+bkEWOm3PljmjYXxMZTpapoHXI60Dkf5a9iMRjup6XyD2ZkCV11
        OHBrNxCWFjH+c0vl49JtGPA1aXwbWb3GpfX/E3Wq8/60WJbng0jbgsSpflHOlUme
        iH0sExaGX9/sx2pib3vsdhiK0JrQfMfSXXAoejGBaeaj0Wt30cS2pqcvZwpJNIKr
        wI/Kv6LqxMlIxeCpgG4xQqW9KN+8VB9cp/QQwCDFVcMc8t/Di+wi+q+XA==
X-ME-Sender: <xms:ziGRZE3zP6vDASt-3BK_geM4FJVeZNNXB4XGci1-rZeX9YWQEl9PlQ>
    <xme:ziGRZPHhw7dHj160MLqHkkMg70aQOZB8Na-9oXsjUAXG67AO3RRb0hpEj_Ev86ecM
    Pds21g22TWQfwyqQlc>
X-ME-Received: <xmr:ziGRZM4R8nqJbvi7Tfqo8MXTdTmQK9kTRWWABy11LnKpefvz9i7FG0FCpcBXtED-Jjaj7X1s6y_l5Mt8yhlDbWTvNvCePBv59T0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:ziGRZN0U3CfXmvOhuzJG9fz88pkrWbA0Q-4MhRbUwRvhXpna_BSGSw>
    <xmx:ziGRZHE0c9HO1A55ihoFQBejQ9EOyd5LsHMCSHFdSlW6OSASVOQJug>
    <xmx:ziGRZG92PYbhWpOxOV7oP_qjPjOfNQZ2WJq-q4_7IEj0E1bNcbchpg>
    <xmx:ziGRZM7FdMWob6PRPKrHg_fPYKWs79e2Jq2JzsdbB1m2Avg4JIEHPA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jun 2023 23:49:31 -0400 (EDT)
Date:   Tue, 20 Jun 2023 13:50:21 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
cc:     corbet@lwn.net, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linux-foundation.org, tytso@mit.edu
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <e78eef83a50a558aae765baafcf9c571788a02a5.camel@HansenPartnership.com>
Message-ID: <7fef2bbb-4c5a-52b8-8e85-400a8fbb8786@linux-m68k.org>
References: <e78eef83a50a558aae765baafcf9c571788a02a5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2023, James Bottomley wrote:

> On Mon, Jun 19, 2023 at 07:41:57PM +1000, Finn Thain wrote:
> > The Linux Contribution Maturity Model methodology is notionally based 
> > on the Open source Maturity Model (OMM) which was in turn based on the 
> > Capability Maturity Model Integration (CMMI).
> > 
> > According to Petrinja et al., the goal of the OMM was to extend the 
> > CMMI so as to be useful both for companies and for communities [1][2].  
> > However, the Linux Contribution Maturity Model considers only 
> > companies and businesses.
> 
> That's not a correct characterization.  The model is designed to measure 
> and be useful to businesses, but it definitely considers the community 
> because it's progress is built around being more useful to and working 
> more effectively with the community.
> 

You're right, the characterization I gave does exaggerate the bias. I 
shall moderate that if I resubmit the patch.

> > This patch addresses this bias as it could hinder collaboration with 
> > not-for-profit organisations and individuals, which would be a loss to 
> > any stakeholder.
> 
> I don't really think changing 'Businesses' to 'Organizations' entirely 
> addresses what you claim is the bias because individuals would still be 
> excluded from the term 'Organizations'.  I also don't really think it 
> matters.  Part of the reason this whole thing doesn't matter is that 
> sometimes people do know who a contributor they work with works for, but 
> most of the time they don't.

This is not just about patches, it's also about incentives and influence.

> If you really want this to be inclusive, you could change it to 'other 
> contributors' but I'm still not sure it's worth it.
> 
> > 
> > Level 5 is amended to remove the invitation to exercise the same bias
> > i.e. employees rewarded indirectly by other companies.
> 
> I also wouldn't remove the bit about seeking upstream feedback on
> employees; I know from personal experience it happens a lot.
> 

If it happens a lot already, why compel employers to seek it?

It's worth noting that the model compels employers to seek "community 
member feedback" which is not the same as the "upstream feedback" that you 
describe.
