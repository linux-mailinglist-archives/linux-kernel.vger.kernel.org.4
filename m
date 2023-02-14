Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED31695583
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBNApV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBNApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:45:18 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1FD527
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:45:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 05AAD5C01B4;
        Mon, 13 Feb 2023 19:45:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 19:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1676335514; x=1676421914; bh=hI
        9/H5GdSVgaQFUGitMAPNmojGQjNuRA1r4Ss6CnjlY=; b=n1vq18dJqgqJTYGbxY
        WgRtHS9sccoeaUI1uLKCXEkrnti7H4huyQBS/xugygLZFy7syCNdJayGR+5yc4by
        QEBdx7PlLd5G9jZwgRhMTMsBZJp9LCRZSNAL5vJXG/S0S6xSkQ7MARcBuNyRRzy3
        /txHRSXCzYULiA8sDwGYklVs2wczsT356CplzPhLkg3vAwvCWASSINUycHZTxxS+
        myjJEf/OoBr+Y0nj/v6NhFpRh7gAFOmAANTQ+erxRwsgPtqg7bFXzKc/IsCoKwBA
        0z4Qu3ls1IHHJWeiT+cac2opU2yqY7pFTTLO1rMQ9ZeVyH3tSaiSc5EfinFbTX+m
        cVUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676335514; x=1676421914; bh=hI9/H5GdSVgaQFUGitMAPNmojGQj
        NuRA1r4Ss6CnjlY=; b=aXPFmS6ZYVWVosJ7oF/HNlr3MNdDBVtBqYf3FLecg+BN
        c7cK9xw9ucZXLIZWbh59Qj0l2yh3D2XL7P+gJT4Dn8d9C5fRS2HvQGkgdl1x5Hpd
        KtOza695tprwg7Ph2pgX1wBIgvHkATKexaOe1hs1aLAcu+Qizw3tirHmyPDftsto
        ho99T+NwcrZtV9ld7+ZqBYEU72RQuEiZBi2vppq+SvDWZWTm9nqc8W9A4ynp53FZ
        h1qJi4wvMAGx5R2z48fsukPBt/OkuhOUTlL3Dx3wiaVT9Mek73ymv4WaFY+9/giU
        MakwqWCt7jl8cdbUKul3m8ugmGiToAPb65ef3YOe/Q==
X-ME-Sender: <xms:mdnqY_avhzl3awLk09J1TeLUQ5U3ZGh9hOtTJFMO_z_9rD4KoTcOBw>
    <xme:mdnqY-YLmzkZGjEipZcT6cBx1yRAcZT2Knci9fCZlEVbXya_Ai9ZPMOjZ5bBqWX8U
    AUSYqOJI-s1ZvBgZ7w>
X-ME-Received: <xmr:mdnqYx8NHTcou49hY5mLf8qf6Jdek_th8QwBQpCm_qluh4tbhKGnqNnsghAf-rvE-QbI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:mdnqY1rcn9BcOy9y4EPRT85SSm_hC8uhSzgqP2LAMsddYEIl0aD64g>
    <xmx:mdnqY6pyRd-rp0jCXydHu-xrIM2VdghH2qlXaWB59JpaqTYh0pm_7w>
    <xmx:mdnqY7QqNRdIR4qUt4O6NprQB1NMQJi9UcGUU3CWYkUfqmfBl1iusw>
    <xmx:mtnqY53HLO7tlv2suJiDeJ2cyOYUvm4Z52huvHObriFfv7Vuka55Tg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 19:45:12 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 11B2D10BD99; Tue, 14 Feb 2023 03:45:10 +0300 (+03)
Date:   Tue, 14 Feb 2023 03:45:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Juergen Gross <jgross@suse.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <20230214004510.4qfcsxjy3sqbzl5z@box.shutemov.name>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <Y+ohfE/wICFKO/93@zn.tnic>
 <6257114d-a957-f586-145c-d2a885417360@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6257114d-a957-f586-145c-d2a885417360@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:07:07PM +0100, Juergen Gross wrote:
> > So this here needs to check:
> > 
> > 	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
> > 	    !(cpu_feature_enabled(X86_FEATURE_SEV_SNP) ||
> > 	      cpu_feature_enabled(X86_FEATURE_XENPV))) {
> > 		WARN_ON_ONCE(1);
> > 		return;
> > 	}
> > 
> > as we don't want this to be called somewhere or by something else.
> 
> Wouldn't !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) be enough?
> 
> I'm not sure we won't need that for TDX guests, too.

TDX guests are covered by X86_FEATURE_HYPERVISOR.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
