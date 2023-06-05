Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F22872254B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjFEMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFEMMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:12:14 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F0A1;
        Mon,  5 Jun 2023 05:12:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E6735C081A;
        Mon,  5 Jun 2023 08:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Jun 2023 08:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1685967133; x=
        1686053533; bh=DWSWu94dr1jHfiTQumad+iUNToWy83h802e4hyartao=; b=P
        HLDE7bP1NZDGkaq7tGe8ksEh0mW7Ug/RtJz4earjCv/RfHRJpLoI/5AoQp1nPG3x
        u4z1uiAfLK/VGOx2Dur9ZVEBKWZLkWbpAncYrOecA+mAEvdsVJKAx08ekM5qxd2l
        683ANL5t9pgNlBdq2rOubPFPOScx8LYbH4qsFPY1tRGN5q3vvJ28ALF+5UENBW5g
        0bfqcLCx54mcY4mYRpjyOcXEk7S0SLxOG5pjhx26F1amkKAviip6Y+rPXXFlYwaV
        P+nrKMRCLVFDUy3kzKQlGOjNDw49t/bpSCTfFjDknulsnxN/nePOTWGOIpkvyZPI
        5xQQf+sdP/MQzWivIIhkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685967133; x=1686053533; bh=DWSWu94dr1jHf
        iTQumad+iUNToWy83h802e4hyartao=; b=Pl+HRVqEl9DF6SNJ+5g3QBhqpbyhf
        TSlL+eJg7lrd09673laDHH/IhZh1O7NVk2416N8+VE4XwTJenpv3yGmLLjO7EU24
        XloqxazyXc5Johp+nIPpK9WOEjj3eLikKDYcE1/dszqxVkAFz2BCEjPYUyzjMaNm
        RxvaF/nQeQvVCe3/d7buN6ul20M152IgnSLKckUtbBnhi780Iq3DIwNLXhzIK0yO
        W900DZ3DqB8sDRSvHpY+Ud3Zt/1/K2SBMrhSLlBEosHr4mVweNppl8HY1Wrqdi1y
        SRbzPgiWdZq6bUCXXT9GxtV1dwZftFR8GgxJCFWH60HU2Gj/gXKOYQPIg==
X-ME-Sender: <xms:HNF9ZF3LhRTiqsJmWqojTsd5Tlyx8O4j38lBcI_t3AQiHxe-t2JFiQ>
    <xme:HNF9ZMFAX1mR5XN2A9AvUKmqZ2ycfc5z10eCEu1Gv1-AenLOFPCi4RG9f9xe4BA-c
    4cmwgipA5ayriXSD8I>
X-ME-Received: <xmr:HNF9ZF5QCKlmhDqFB0JTT6sCEkY6uhHvtWKlJcNmItTHEIdYAhay_JYZmlj8TL4Onfd5VQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:HNF9ZC0YSlBZVxii2_aEPdjZJRhep4INCgXVyzCKDW0dEAO9ZqAIeQ>
    <xmx:HNF9ZIF9BE3cDR9gYYgyBYos2_oAMADKlWFHyRWEhq5NYJDy9QngYw>
    <xmx:HNF9ZD_yfeVE53niQXJYepGAwAXsLKDmlQ79Xh4joAfoHFa7yG8SYg>
    <xmx:HdF9ZPcYK94Xf1bhs-m1VkSw6P6kjNG-RT6Xm4N_T7DKQfI061w6qQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 08:12:12 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9B12F10CB17; Mon,  5 Jun 2023 15:12:10 +0300 (+03)
Date:   Mon, 5 Jun 2023 15:12:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCHv2 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Message-ID: <20230605121210.gv5n7swqzuwl4jv4@box.shutemov.name>
References: <20230526120225.31936-1-kirill.shutemov@linux.intel.com>
 <20230526120225.31936-3-kirill.shutemov@linux.intel.com>
 <19d9977f-bf07-2948-1b45-456af9c09e2f@linux.intel.com>
 <20230530005736.ndwza2i5n7wrki5h@box.shutemov.name>
 <9d679d3f-8db9-80ef-292a-9ca5b860579b@amd.com>
 <2d8ae093-dd9e-ea49-d6f9-3fdb2fb84e4d@linux.intel.com>
 <BYAPR21MB1688EF2A57E90FCE02B82F84D748A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <9fbc3760-7239-2323-ed90-210a0de9e286@amd.com>
 <BYAPR21MB168826D6C870542E5BD3372BD74EA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <d73d41cc-0578-7bf3-46a2-b47eea44bdd0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d73d41cc-0578-7bf3-46a2-b47eea44bdd0@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:42:33AM -0700, Dave Hansen wrote:
> On 6/2/23 09:11, Michael Kelley (LINUX) wrote:
> > Tom -- Does the above sequence *depend* on the hypervisor doing anything
> > to make it work?  I'm not clear on why KVM would automatically change the
> > page over to private.  If there's a dependency on the hypervisor doing
> > something, then it seems like we'll need to standardize that "something"
> > across hypervisors, lest we end up with per-hypervisor code in Linux to handle
> > this scenario.  And running SEV-SNP with multiple VMPLs probably makes it
> > even more complicated.
> > 
> > Kirill -- Same question about TDX.  Does making load_unaligned_zeropad()
> > work in a TDX VM depend on the hypervisor doing anything?  Or is the
> > behavior seen by the guest dependent only on architected behavior of
> > the TDX processor?
> 
> No, there's no active help from the hypervisor here.
> 
> Also, fwiw, the "architected behavior" here is really just the TDX
> module policy and _arguably_ the hardware Secure-EPT controlled by the
> TDX module.

Right. There's nothing VMM can do to change behaviour here. VMM can remove
private page, but it will lead to VM termination on access to the page,
but VMM controls VM lifecycle anyway.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
