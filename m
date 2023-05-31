Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9B717DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjEaLIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjEaLIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:08:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3C126;
        Wed, 31 May 2023 04:08:05 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D0625C00F1;
        Wed, 31 May 2023 07:08:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 May 2023 07:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685531284; x=
        1685617684; bh=aeL29fTibpX7OH1ns9iCpikawL6pyGgQIxFzUFIJ5mE=; b=x
        UDCGtesaL634GL9eXdFKoKL1s1Tz9Ll4uk1Af1BMnvQGH4j9+1PhPANaEaVE379R
        CdP85tpEg9YcUW2h5dFDnyNMAmMCkYWCYlWHtfBYAhuz7I36GZhVasYeXJhtrGKQ
        9Lrd5hHztASe4grn656Fm1LxjoNjOG1JM3Ad9/lCi0sHtpjyf+ptypYz5yGO613d
        qh8+Kv3Y5LpM1E1ielOLRn5Ok/JsogZMAHdTruPsKoySspbI4+TYmoxqI/VIiBEP
        9NSI/2t5My7odxwCZX0DKZDp9MOjZtjLzlE2tfb83C3rAyCOX0y3uoPoI2tB10/o
        jG1KAHIWcun/pGj4MxlRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685531284; x=1685617684; bh=aeL29fTibpX7O
        H1ns9iCpikawL6pyGgQIxFzUFIJ5mE=; b=CKpieIWYKmOkyyCDiuZP8D+PUVECt
        T2ErndCGQJp98RFqZNoUkT/fLhMhJ/86fqOlgcQFwHL1AieUk9bVGqVQwn4r+E2W
        f0BdsMG0bUxMm93eQ9DkRhxUnn/i/uxmRKJyngDMg7NgPssfHdpcqc4Ji8JdwWKu
        KcmycyZC8ziSkBHUUx0EKF81JTIo9p1nky54jRBkScT+6/Vtg8YxhCTisfVZ1PtQ
        DxAb3nZ6wlHPyxA4NCng2CaUSohgQo62Msc4qWAgBMoDuT6fhd6tjX3xJipyPlE8
        6WncsmBPKzOXGkMG97UzW0dluJcZkHMNBSKLi7gH8TFXTIx7+dO3jVsvQ==
X-ME-Sender: <xms:kCp3ZGhTVDV0DVu7dmcXkuzxkpXwEA9IwCIFbDRZWqgyIv8wnEJkFQ>
    <xme:kCp3ZHAPrdO9QnDydIYpePwNPqTvQeT4rDLRRhSWppJUEyVQkKccYZjgigzReTWrC
    K0XSDatK5L73o__kNY>
X-ME-Received: <xmr:kCp3ZOGKLu-mTkNtzCsjRFXSA0mPL0O0V-GjwUeK0cpeJiwxiYZ1sNPmsq0FoVcs2JuCqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:kCp3ZPSz5hGKt8pyGe8Ue_MUxG7I7-LMRL0S8Maei_bY-CtDzDeDqg>
    <xmx:kCp3ZDybG56imlj3lotFSk424EAyO4S3ZalWSFbkTcroWC2CEkq-8g>
    <xmx:kCp3ZN6cb8NiInnM6MmJJINWLXlxFmXCECS2-MdbyVDlBUBQ7WTXsw>
    <xmx:lCp3ZIQZa_9Yhyap2wMrdMHayAKX3jfVOiYwSdewsO8ergavPjSuDQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 07:08:00 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D69A310BD95; Wed, 31 May 2023 14:07:56 +0300 (+03)
Date:   Wed, 31 May 2023 14:07:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/smpboot: Fix the parallel bringup decision
Message-ID: <20230531110756.g4cz2tjnc7ypskre@box.shutemov.name>
References: <87jzwqjeey.ffs@tglx>
 <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
 <87wn0pizbl.ffs@tglx>
 <ZHYqwsCURnrFdsVm@google.com>
 <87leh5iom8.ffs@tglx>
 <8751e955-e975-c6d4-630c-02912b9ef9da@amd.com>
 <871qiximen.ffs@tglx>
 <b6323987-059e-5396-20b9-8b6a1687e289@amd.com>
 <87ilc9gd2d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilc9gd2d.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 09:44:26AM +0200, Thomas Gleixner wrote:
> The decision to allow parallel bringup of secondary CPUs checks
> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
> parallel bootup because accessing the local APIC is intercepted and raises
> a #VC or #VE, which cannot be handled at that point.
> 
> The check works correctly, but only for AMD encrypted guests. TDX does not
> set that flag.
> 
> As there is no real connection between CC attributes and the inability to
> support parallel bringup, replace this with a generic control flag in
> x86_cpuinit and let SEV-ES and TDX init code disable it.
> 
> Fixes: 0c7ffa32dbd6 ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and enable it")
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
