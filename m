Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB16716A61
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjE3RCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjE3RCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:02:42 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7B118;
        Tue, 30 May 2023 10:02:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EA885C01FE;
        Tue, 30 May 2023 13:02:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 13:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685466137; x=
        1685552537; bh=LP3nfKYA60CmRb8usg09zLfC4LK0DKsE4DbPaZWKkC8=; b=s
        zV6WskACfFVEqKzRzZ6P7qAJe6qrFMSVHpBH+79Dp07d15X23DMKWcX0I0KFcXyT
        tzvjPL6PVqxKmWl9OiZAluQTsrsRgXXSkeoGZmBjg2AqbpZoCv4E9eLQoG+5nJyS
        HkVjFdxFuVE08S4971YSmjn/wkp41pa+PrkMvbhmYb5DpFzY5XaDud34Hh+Zhoz6
        GurqkOPG4rEcEB8AJi91jlxm1UuPkwewI+Rc+Y0yep2GSLgqXZvuHbrcM3AwGmnK
        nhvhwVE6CvdzeY2SmUcbH7u12o9rJdx3GhIBQURci3ZBnL3EtUUXUYCE5IO0j3Oy
        +ve3Is8IMm7NEhKD6NgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685466137; x=1685552537; bh=LP3nfKYA60CmR
        b8usg09zLfC4LK0DKsE4DbPaZWKkC8=; b=RrRPOp3HKdgjex3qNFuRyIK+z7hQt
        HJxtGK/mchY8kBsvhzWBNaZITNLfVOjgxQFvAOTOf7PWbRIH/fhJZ3M68cpZl3Kn
        HDUVS/n7Z+vZxwnvikIMopbIJPPmy57YeU8FBhAPUN2sSq8d9kvTt2KyQQkK8gs4
        No0ajlXD9loe4/8muuMVBSwc6QJe1Lj9066iqw3R3OBSLwPg9Nby7zf3HGR8BFrS
        dYSVo6XMqyuUOZCcoeZ3/3G5JLGm2OhrRi2RCgQxZ5fd/w1BJX5y/1Ihd/UcUUuz
        E57DkJY8AxBbAzIrP2YlwBcSBfaZjdfjJciTnAVEgX/CKECNh69XtWHjA==
X-ME-Sender: <xms:FSx2ZM4Mq2KAXSzW7xxZWvfpDiasjaZIBeacE7HlH1FClmBTxkzytg>
    <xme:FSx2ZN6jM2ofnqd2UQ2vPVOctwBgLs5l_3lkVcIXxAiK_wk7w0xis6VpeGHxeSfMQ
    MfGz3AihHCrPbPLMOY>
X-ME-Received: <xmr:FSx2ZLeRPinJ2C5f9UrPoRvDeLWSbWpsQP0zjqFZOi8_cOsPLLOLFBLd6J4hz_zV5iLd1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:Fix2ZBLhJRJiOQvWIoDyOqk9SL9n8lDqxeC32Ul4urdF3eutnKxrvw>
    <xmx:Fix2ZALFMhddyYQL6OktSRbWxIz8cLG6QYGTV0okFsA0NNYe2oPMJA>
    <xmx:Fix2ZCxKXFgl20Rki5Rb1K8_TT3BALB_9tnh9UHkN9QeaU67GWhF0A>
    <xmx:GSx2ZHr72m1Fde2ANoy9Cc4IuCDUtJgIl9vC2QblR6MMwhrZPaAhaw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 13:02:13 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 228F410BD95; Tue, 30 May 2023 20:02:10 +0300 (+03)
Date:   Tue, 30 May 2023 20:02:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
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
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [patch] x86/smpboot: Disable parallel bootup if cc_vendor != NONE
Message-ID: <20230530170210.ujkv737uyjfvdoay@box.shutemov.name>
References: <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name>
 <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx>
 <87cz2ija1e.ffs@tglx>
 <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
 <87wn0pizbl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wn0pizbl.ffs@tglx>
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

On Tue, May 30, 2023 at 06:00:46PM +0200, Thomas Gleixner wrote:
> On Tue, May 30 2023 at 15:29, Kirill A. Shutemov wrote:
> > On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
> >> The decision to allow parallel bringup of secondary CPUs checks
> >> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
> >> parallel bootup because accessing the local APIC is intercepted and raises
> >> a #VC or #VE, which cannot be handled at that point.
> >> 
> >> The check works correctly, but only for AMD encrypted guests. TDX does not
> >> set that flag.
> >> 
> >> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
> >> definitely works for both AMD and Intel.
> >
> > It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
> > report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
> > we want it.
> 
> Right. Did not think about that.
> 
> But the same way is CC_ATTR_GUEST_MEM_ENCRYPT overbroad for AMD. Only
> SEV-ES traps RDMSR if I'm understandig that maze correctly.

I don't know difference between SEV flavours that well.

I see there's that on SEV-SNP access to x2APIC MSR range (MSR 0x800-0x8FF)
is intercepted regardless if MSR_AMD64_SNP_ALT_INJ feature is present. But
I'm not sure what the state on SEV or SEV-ES.

Tom?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
