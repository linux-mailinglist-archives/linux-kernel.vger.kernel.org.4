Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C0574C134
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 08:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjGIGJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 02:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjGIGJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:09:15 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6300F1BB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 23:09:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C8295C0036;
        Sun,  9 Jul 2023 02:09:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 09 Jul 2023 02:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1688882950; x=
        1688969350; bh=pPdLijZo5YvkYklYqDw+g+ZwYxPYEuyuuGc/M0fbO6o=; b=K
        wI3l0mWx0DCcBihyCYr4x4jVzIdXe+kpfIxdnaOEHcxvjkEvi8Ga7vIYYq/KQbmt
        40cNytK7MUjxr9N7tMGfDzE2RnEUvgnpvQVa2GJefRI5vVwz+C9nhhxlz1xNKoJ2
        o9WXwPQHjuMfWW5EZ2Mh1KdQNz42WcAMZIfN0kysBDHZwT0DWlHxFNxUEKMDb4aA
        ozYwZAqEa8n6MVKrEuMFUNu2bgYIdhOh7Kw1aRLtWUZ6mg9Y9MiwYavgUKq9f9xn
        B0YD8FEz90qRuxHMCIRmVHAsWwEtjNwujcRCzn8taxyCXgs6apnSMK0WkyaxFAWL
        juYGETygDMGiVZFl6phqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688882950; x=1688969350; bh=pPdLijZo5YvkY
        klYqDw+g+ZwYxPYEuyuuGc/M0fbO6o=; b=orKcJBrSJlBmSjLkbwdXXCI4GCASx
        BNYlrmlOcqs0XjVKRbWMCU3ji4bflkojbEZ2x/d28qYM2G3Efc4mZJidtXTwd3Xe
        dIC+Bnci9Kl/NtWqZqKigZH8TmJ3ye5krD8udnYcA1SKe+R1wPTWbHTUlRlP4CPF
        2bc8mF2bUHVJgPHUkUdhejX0Jq5+GGfgFIJhPz2V5jYUPBY02KeIKkw3QitJQH65
        8KSa/2eB2TXHsar2sHX+A4dBWbY06LQ8C5T58BR64Uf7zD6bg7LTWRgzTwA8Evev
        h0tvRoIeBgUlGrcjBjMYLiBVRZHHJbSZsxbw9XEVY9y8BQ2pSLz04pPZA==
X-ME-Sender: <xms:BU-qZB5I6Ou1pxJilBTxaajumTOLrpEHNVfXkPmn8wAc6rHmf6-b1Q>
    <xme:BU-qZO7ET-oTAEMUffYGpOcA5ZBzfjrxagYlZ7BzdMXNpREbsTQ7hlKNgIMxtu2Pq
    Yo1T_OnWJuHHi2IZPw>
X-ME-Received: <xmr:BU-qZIcFrVXf4m6jpMtQlcTfI6wW2itSQ3DQTz20aYilT-WG6X2apF81JJSZIgtZakt_Qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdeggddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:BU-qZKIQ-lxD-UjWvOq3OEhHYpkEXINPyV5518DZ4VNXE12T5AgIPQ>
    <xmx:BU-qZFJlBk8g-_79GvFRJ_M0cdDkGAndl-UcFKT6958ksipjSZB_Uw>
    <xmx:BU-qZDxsP2myZ3wc7VEV7PttR6A0a9D3dLpuPX9moVTUTJ5EWbQJPQ>
    <xmx:Bk-qZPwFuQGfEI6eszW_54MRos9lV-JtUgNqDdOkwvQ3JHDE8tDE-A>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jul 2023 02:09:09 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D4271104B02; Sun,  9 Jul 2023 09:09:04 +0300 (+03)
Date:   Sun, 9 Jul 2023 09:09:04 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Message-ID: <20230709060904.w3czdz23453eyx2h@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
 <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 11:53:08PM +0000, Michael Kelley (LINUX) wrote:
> From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2023 7:07 AM
> >
> > On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
> > > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesday, June 6, 2023 2:56 AM
> 
> [snip]
> 
> > 
> > It only addresses the problem that happens on transition, but
> > load_unaligned_zeropad() is still a problem for the shared mappings in
> > general, after transition is complete. Like if load_unaligned_zeropad()
> > steps from private to shared mapping and shared mapping triggers #VE,
> > kernel should be able to handle it.
> 
> I'm showing my ignorance of TDX architectural details, but what's the
> situation where shared mappings in general can trigger a #VE?  How
> do such situations get handled for references that aren't from
> load_unaligned_zeropad()?
>

Shared mappings are under host/VMM control. It can just not map the page
in shared-ept and trigger ept-violation #VE.

> > Any comments?
> 
> This looks good to me.  I applied the diff to a TDX VM running on
> Hyper-V.  When a  load_unaligned_zeropad() occurs on a page that is
> transitioning between private and shared, the zeropad fixup is now
> done correctly via the #VE handler.  (This is *without* my RFC patch to
> mark the pages invalid during a transition.)

Great.

I am at vacation for the next two weeks. I will prepare a proper patch
when I am back. Feel free to make patch yourself if you feel it is urgent.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
