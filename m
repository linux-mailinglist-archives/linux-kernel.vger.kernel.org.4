Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E009715F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjE3Mam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjE3MaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:30:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A1ED9;
        Tue, 30 May 2023 05:29:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F49D5C0187;
        Tue, 30 May 2023 08:29:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 May 2023 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685449796; x=
        1685536196; bh=EEiwGlX0Rwp4JD9gZJQ2+HoBg+CT8hF4DrYL0banGb4=; b=J
        hSWsjxiEcHNkhsyc3AMDUebr4x6d+5Z/IPmQcP3r3HEa2PV4iCNRm3rpXjqMalMw
        /OE0m3uI6TqVPy5TXs2laPgrna5SS91VjYoT0EXhAxxqYtnfxHMo7QJ6Jnmck2VP
        qm3TSO2CTWhnzg3XOjo+mkHnuk/QAm3oPsYysD8xP3lNHGWahS0Xzz2Vdy00xqfC
        yAn6/IaCpooPjW/r5dFkd/NaFIY0S16nWFqTsAWzyPFXWDFJvzH1dM+PTmRZ6g7j
        2o0X6GJUAtrKbuNWm0yrLAHjaZxrzujAqghJbB5Pgmh3apFHgN+WZcMp8TtzR5PN
        UmtTiyLIs/YDkMAzAHUpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685449796; x=1685536196; bh=EEiwGlX0Rwp4J
        D9gZJQ2+HoBg+CT8hF4DrYL0banGb4=; b=O8gpcmbIa+lNB390LgDoxjyCM0VpN
        DeUDIRCCkjdQ+WpdGdzcgnse0TwvjzKgs5YriXR9QomUEOgfslSoIJc3vkGujs74
        VPkfaqeBhzNmKSfdheBPc28aFjtzgiElyb8XMQ0DCHEgvEKGVEHWluQY5NUAZeJE
        0lhHFHNpkdZmPZZBdDmvBiTp7eiVYb6eCW3ZjMWdk153TSS6tRrEHYat++3ogA0G
        Z8/iPnkXzgVKZDv3CCQVLAT94m9xNd1Y4sHfuu5+Nx2HBWBDzJVK/E2qPoDde2j0
        6E+pDcEqROIFws3Einak7j/Pec39SrUOUvx1BCXKNueY+QbbjiTx3jhIA==
X-ME-Sender: <xms:Qux1ZDpZHdZDdRqzuQ3oUtp4N6AbptLlyGyPf-zqztvLum_Wpk8xEg>
    <xme:Qux1ZNo1F15jgz6IzDPB24Axf7HXd1_RtRQC-fw6kQbdty6wE8mBYqfLb7uXR-P_r
    JVGo2mcRT2J7JcrdCo>
X-ME-Received: <xmr:Qux1ZAMinJKpb7I-Q699cMCl5dTtv9S_hHYYcGI6fA9B46v2Q7yLRFaxadSo-LlFaSYPXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Qux1ZG6ZsOw6xeVtxhzYN2s1-Hwz6qJfUWen7z_-iQrz1HVXN1ijxA>
    <xmx:Qux1ZC7stYJcdgzWQepJmmrvNf0MLSMCayxkwEJj9btY7h4-oM2Vrw>
    <xmx:Qux1ZOh_9TgCy4k005YOTV8O1Ry7xm6HbvZqesWx4liI3OpUdnIllw>
    <xmx:ROx1ZAaQz7AjEzvPi21kVUbjMxYAZy5wCX2Z0W4XoTeRn9P4Z4ohSw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 08:29:54 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id EB5E1104992; Tue, 30 May 2023 15:29:51 +0300 (+03)
Date:   Tue, 30 May 2023 15:29:51 +0300
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
Message-ID: <20230530122951.2wu5rwcu26ofov6f@box.shutemov.name>
References: <20230524204818.3tjlwah2euncxzmh@box.shutemov.name>
 <87y1lbl7r6.ffs@tglx>
 <87sfbhlwp9.ffs@tglx>
 <20230529023939.mc2akptpxcg3eh2f@box.shutemov.name>
 <87bki3kkfi.ffs@tglx>
 <20230529203129.sthnhzgds7ynddxd@box.shutemov.name>
 <20230530005428.jyrc2ezx5raohlrt@box.shutemov.name>
 <87mt1mjhk3.ffs@tglx>
 <87jzwqjeey.ffs@tglx>
 <87cz2ija1e.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz2ija1e.ffs@tglx>
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

On Tue, May 30, 2023 at 02:09:17PM +0200, Thomas Gleixner wrote:
> The decision to allow parallel bringup of secondary CPUs checks
> CC_ATTR_GUEST_STATE_ENCRYPT to detect encrypted guests. Those cannot use
> parallel bootup because accessing the local APIC is intercepted and raises
> a #VC or #VE, which cannot be handled at that point.
> 
> The check works correctly, but only for AMD encrypted guests. TDX does not
> set that flag.
> 
> Check for cc_vendor != CC_VENDOR_NONE instead. That might be overbroad, but
> definitely works for both AMD and Intel.

It boots fine with TDX, but I think it is wrong. cc_get_vendor() will
report CC_VENDOR_AMD even on bare metal if SME is enabled. I don't think
we want it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
