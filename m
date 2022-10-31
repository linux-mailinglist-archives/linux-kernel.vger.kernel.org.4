Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14007614076
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJaWKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJaWKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:10:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF45D46
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:10:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0AB395C015E;
        Mon, 31 Oct 2022 18:10:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 31 Oct 2022 18:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1667254215; x=1667340615; bh=P2
        To8pd8U1V8Fl4iGAG6PjXd2z9/oOB21lRwtDYJXYE=; b=AApxNhdrnS1G4ghZSF
        vMgogKKMEYRJyUXBm+X1ZAOgn4iVLYYc9DhpiDoM0gDP+VEKfjQyxjnzCOXDVoHe
        GhiRU0RulH1aLpOQPEgDaJofX8LuhSoLAVd0ivJ/034gDuGGW13nmAT2icnQetSf
        po1mTbrOR5D/6UmJ2hogFFjjDX+aLwu+k42E7VhfErSzRv3pTsekAstmdaI/NVdV
        4V/R4566NXcw1uLGPqOYCPCiPzxYlVhFJnQICDSTiQ2b6MqaihtGjPgHzhI7ZVb5
        a5QE2C9h5GEqSvlS71ez6geeu+ywwmXVATiNIlGaaCYsmZ3Bwtx7eBaGyJlvmbxQ
        S7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667254215; x=1667340615; bh=P2To8pd8U1V8Fl4iGAG6PjXd2z9/
        oOB21lRwtDYJXYE=; b=QovQ7ytSfiTGTMgM0KEw6Ys+gcWj21ujz/vyxzcJyyoX
        /8+WgRiIeLlj4RaoD49HoaUZufMUeGJ3a9k02deq4hVkVBYoi+CV5Ts1ROZ820zC
        3DfIg2I5ApeRH4TQS8DieelcbJ7LXkqiiPG3QSJ5RndE2oojlQt4ZFVLZ4wzCwk4
        yRFkEztYoV2BmblwMh/CG6uFFQ7QqyFJeIp0bNfZpKLOFmshAZtWiXGo6Bh3bNlE
        QusWlN/bA0RkvrFPB56MZ+90tpqJnBA3/WxmXI0UQkAt+UgQP3C2zu8bkdrIT1fY
        LDmIfDuHLRF4xsd4KDIIaRVTHN7h94MHWw3+8GqjZw==
X-ME-Sender: <xms:xkdgY1l3JuFr_4FSsh5K9WGymPT46iRiqlcGaHCIAOwZi90c3zt7og>
    <xme:xkdgYw3jnOj6L6FIqGdsdcD2iDmCz5EV_l5MxLRbPPYufWhxNTWm0LavybuUnW89k
    h7EiA9k1aYnBCWvUqE>
X-ME-Received: <xmr:xkdgY7qyJowmAKPxDOPvwQHLcKECg2Ci04LZZVJp9ieSu0z59PqlGSScARF6kJbYsJrFjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudefgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:xkdgY1mhaMV_LbbXRleLEcLZUM0u7XGxl30SEL31Wpfk1fTUDnDi4g>
    <xmx:xkdgYz1t0jZu6s57ZfiTMoK9imUKCNOSUqvxN-2TfXRLIvroBUqFjw>
    <xmx:xkdgY0vt34CyYKr-PZBAPtYN08TgIPzC7rZvVFlWkw4EuXijQuyJkg>
    <xmx:x0dgY62-CIXqGCbiy_Lf3_8A8az07_pSE9wLkC5PAQTB1QTtb4VLnQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Oct 2022 18:10:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 4DFB210444A; Tue,  1 Nov 2022 01:10:11 +0300 (+03)
Date:   Tue, 1 Nov 2022 01:10:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        seanjc@google.com, thomas.lendacky@amd.com,
        elena.reshetova@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/tdx: Extract GET_INFO call from get_cc_mask()
Message-ID: <20221031221011.maiizaqbo3x37n2b@box.shutemov.name>
References: <20221028141220.29217-1-kirill.shutemov@linux.intel.com>
 <20221028141220.29217-2-kirill.shutemov@linux.intel.com>
 <c97e9273-60b6-2ca7-1993-05bfbf471f3f@intel.com>
 <20221028235951.p2vdu7drbbf3ccg7@box.shutemov.name>
 <20221031041252.mdcjocqn6k4k4gvy@box.shutemov.name>
 <8887d182-a3e3-f62a-8b8f-36db1da75b19@linux.intel.com>
 <d3469e0b-32a5-d130-41b1-facdf0d91a92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3469e0b-32a5-d130-41b1-facdf0d91a92@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:44:15PM -0700, Dave Hansen wrote:
> On 10/31/22 12:27, Andi Kleen wrote:
> >> Moving panic() after earlyprintk working is not good idea as it exposes
> >> kernel more: by the time we already have full #VE handler.
> > 
> > It should be fine to move since there is no user land at this point (the
> > attack requires user land)
> 
> Maybe I'm misunderstanding the exposure.  A normal MMIO #VE goes
> something like this:
> 
> 	1. %rax points to some MMIO
> 	2. Kernel executes: mov (%rax),%rbx, trying to read MMIO
> 	3. #VE handler is triggered
> 	4. Handler emulates the 'mov' with instruction decoding
> 	5. Handler asks the VMM what the value of %rax should be
> 	6. Handler puts VMM value in %rax
> 	7. Return from #VE
> 
> I think the attack scenario subverts a normal MMIO to the following
> (changes from the normal flow are marked with *):
> 
> 	*1. %rax points to some private kernel memory, VMM removes
> 	    Secure-EPT entry for that memory.
> 	 2. Kernel executes: mov (%rax),%rbx as part of normal kernel
> 	    execution, not an MMIO read.
> 	 3. #VE handler is triggered, assuming a MMIO read
> 	 4. Handler emulates the 'mov' with instruction decoding
> 	 5. Handler asks the VMM what the value of %rax should be
> 	*6. Handler puts (malicious) VMM value in %rax
> 	 7. Return from #VE
> 	*8. Now the guest kernel is running with an attacker-controlled
> 	    %rax
> 
> This effectively gives the attacker the ability to override the contents
> of a memory read.
> 
> Am I misunderstanding the attack scenario?  I don't see guest userspace
> needing to be involved at all.

Looks correct to me.

I think Andi refers to attack against syscall gap that also addressed by
the patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
