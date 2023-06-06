Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F90724B85
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbjFFShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237728AbjFFShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:37:22 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A963E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:37:21 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E6C2F5C01F5;
        Tue,  6 Jun 2023 14:37:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 14:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1686076640; x=
        1686163040; bh=qNOCEgxMB7pIxtXQBqOz7su+7qTpoyeO5gMs+si+Gg0=; b=O
        e4ZsRW6iVpjbhERzX1UNjYYmJCM3yNzrlbc/Mqm/fgtCVavQ27KOVLZPDHIfPQVt
        gUmEUMUO+nhr1+gK+vswfOIgkdkJdSuO5SSYroAQU+XxJ/kW5x3+dApmVkpxcVS5
        zDMiwy4gna60+aiQ8m/PAhnUbMrIO2nFI+OX72q3xRZIbcTr83FEh6tGIoPxiCOl
        oagGYKTtQugL2otxicQr4RVZirDHIOpM+Sg2turkDV6eM+30tHvMrUGxJMCbPmvJ
        AchejnfC7+I/6fosYCA8w5hCDf9RyVm9m81PBZ+IVICmr8ufvvuDiTlA5dKH89TF
        trqzSiLxkx99iD4vaQ8+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686076640; x=1686163040; bh=qNOCEgxMB7pIx
        tXQBqOz7su+7qTpoyeO5gMs+si+Gg0=; b=ZiEpH+rjON5QD10p6KlAGSQa0CioJ
        3jSbFTLUzTrFO/qZwCmFvycmoxKo/OQfOFUdrPiP8QaSCmObUHpd7weWuhqD7Uz5
        h3T0dwU9AGX4b4QlryS/lPM+rONHPpuJfThwYD8w2GLomvLOlazG/B2ZJM3rVsxj
        9R8+yFdtb2usH6aKksTMneVwGSQD/P/LlwdK/AzcCxFrLBL1pDqBAntU6JzJQysV
        OvY9bGAwt2T/Qe7MMeiuaenQ+/h7vIXdhTNUiyfIoeUQ7c8UrFSedt9sQSn0WKBB
        kAtfG0dZjxeL3r8ZdBb+91skOYQW55iSCjvY6aCkVmSxPaWSmpRZW9/5g==
X-ME-Sender: <xms:4Hx_ZPWnQPzTTC0iHuwySndkSwHFC6csNYsjolzgkhTqBdbI0EvmUw>
    <xme:4Hx_ZHm9PxINpzqUgBWXbyiUujO5tBSAr4S5DJSVrbbHuXUDizR29Aig5-2iKBvlY
    tqBGcjdascMDr-t9S8>
X-ME-Received: <xmr:4Hx_ZLa6SprNOAe2q7j3vwc2d_Zd4-unPmO9TfHgE2GwLe6iIyXr5K0wrHekvcfkwFvUsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhi
    rhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueeh
    tedttdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:4Hx_ZKVvPA4okQpLp8iw9-22OVgyCQNn8Xw-s8mj7kadnLYP0gKNTA>
    <xmx:4Hx_ZJmLaZpsXDr1CD7t_G0EVHUj_ghUQ1NWN_0-sspURHK7l3opNA>
    <xmx:4Hx_ZHeCTnK6hassXKkLU1_SziivHKeUVuIMLdQgo80OLdz7ucLthw>
    <xmx:4Hx_ZCc2njkEmdLRsDcqaUaNuhnczemTucjvjcMT4IVwQNJDHWfreA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 14:37:20 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 98CCA10CFD2; Tue,  6 Jun 2023 21:37:18 +0300 (+03)
Date:   Tue, 6 Jun 2023 21:37:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        decui@microsoft.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] x86/tdx: Fix race between set_memory_encrypted()
 and load_unaligned_zeropad()
Message-ID: <20230606183718.i3iqwbk7gdomiq5s@box.shutemov.name>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <20230606095622.1939-3-kirill.shutemov@linux.intel.com>
 <f7f82377-6127-79e3-07d8-def490c4e35c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f82377-6127-79e3-07d8-def490c4e35c@intel.com>
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

On Tue, Jun 06, 2023 at 11:14:29AM -0700, Dave Hansen wrote:
> On 6/6/23 02:56, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can touch memory that is not owned by the
> > caller, but just happened to next after the owned memory.
> > This load_unaligned_zeropad() behaviour makes it important when kernel
> > asks VMM to convert a GPA from shared to private or back. Kernel must
> > never have a page mapped into direct mapping (and aliases) as private
> > when the GPA is already converted to shared or when GPA is not yet
> > converted to private.
> > 
> > load_unaligned_zeropad() can touch memory that is not owned by the
> > caller, but just happens to be next after the owned memory. This
> > load_unaligned_zeropad() behavior makes it important when the kernel
> > asks VMM to convert a GPA from shared to private or back. The kernel
> > must never have a page mapped into direct mapping (and aliases) as
> > private when the GPA is already converted to shared or when the GPA is
> > not yet converted to private.
> 
> Heh, that must be really important info to have it in the changelog twice!
> 
> I'll fix it up when I apply it.

Ouch. Please fix the comment in the code too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
