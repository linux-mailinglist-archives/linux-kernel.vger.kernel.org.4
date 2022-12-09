Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2191648760
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLIRLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLIRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:10:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F7317E28
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:10:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F3A65C0126;
        Fri,  9 Dec 2022 12:10:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1670605831; x=1670692231; bh=Do
        8N7UCWijnrtOsHZobz9u+3DNBCzbTpTsHVBXA9B54=; b=DlCbjqoHPUwl4YkQSm
        D88dRgu33uxI16pOZTM50ygCf04kIjUS95LEsqNr2T4xq/fj/gk60c8V/cWfe1ol
        dlor+4ctJt+AO5g4E38iQilPR6KAYYafJ3RI3MnKDauNbAsYOBjfAJrtZYisQ2vA
        wI0kJE1Vs14ubAkrbYofDvv6h6Xy+9Q1SJg5fjhMqJz6d9N8RCjinVtaHv+52IPD
        FDJeHX7NIFCq6jK3UIWwzf36LRGDVsbuS/CzWP/NJXZlklGXnUqXY2988lEITiet
        N1Ast3xB7DRcN2ava22Fy0S5wmOT8TKzfNNnEHJvXkL83IN4W2PZyMAwEz+7qAhI
        iZ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1670605831; x=1670692231; bh=Do8N7UCWijnrtOsHZobz9u+3DNBC
        zbTpTsHVBXA9B54=; b=KSRGcndOg/+eRHDM/OnXKnKTWEUnFTtXUKSi3Z8ArSAo
        79e+7ia4pZPtpya7wbm2e3OheCNnJF2j2WT6Cld8Egp/Zlk/uon/KxjccpXDoS6F
        zyYVvXpmRFaqJjCwox7Wf5+p+qZPouubqAXlEygDsnyizEoxmvR3+9BhDR5tJJkf
        xaCT4Fh4srJvWC7qBZpvMugV51Wtz50a+g7NV608gEw6YUuTSRH9lVmP4GVIgOmM
        k9zuZFi0BFIlDm64cluF6aMvJrbZ2cnHg94NlFyG58VbbRoLCrF196nQSq9ttDWP
        DtCcEzHUKenqFun4nES3tpo74xazJoqAcT3gYzNfoQ==
X-ME-Sender: <xms:B2yTY54aQVNuZoaaCqN5UYeEohr8MkQvf_2n-8Cc4jCZr5iU8LjF7g>
    <xme:B2yTY25lQMbKbwPzfECiXS5NabOmmNbQtWYoFGcOWOei5JD7p1MbcHffj1iyZDxaw
    VTI503nAIyeP0o4Mkk>
X-ME-Received: <xmr:B2yTYwdcVCHIDgLLD7CzQMW0ALQDvaDgIGyYRji-CtPQCMZTApmW1Zm3E_4aIzbwB6HYlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehttddttddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfd
    cuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhep
    vdduleejhfelgeegheejhfeujedthfekkeekgeefhffgfeelueegjeffieffkefhnecuff
    homhgrihhnpehgihhthhhusgdrtghomhdpghhithhhuhgsrdhiohenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvg
    hmohhvrdhnrghmvg
X-ME-Proxy: <xmx:B2yTYyLl8CjyIM1UzD7_pk2Qr4qycxZloKXpcuEfW3o_E2hn-ibjFg>
    <xmx:B2yTY9LfCdCMMQGjbz5BrpJ9jV8ab1Kl-rCUi7_L6618Z4kDvr1sHQ>
    <xmx:B2yTY7yUyWWsDEPjNIuuZflJGuwUTPi9HIcgCpaV8L3ryYZdFnX2vg>
    <xmx:B2yTY09U_qnGnFQKom3t3WTseV8ADohN8DVm7q9b6-ML9vB3RJt-sA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Dec 2022 12:10:31 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5B6C8109CE2; Fri,  9 Dec 2022 20:10:29 +0300 (+03)
Date:   Fri, 9 Dec 2022 20:10:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] x86/tdx: Disable NOTIFY_ENABLES
Message-ID: <20221209171029.3gtxtkul5grpxsql@box.shutemov.name>
References: <20221209132524.20200-1-kirill.shutemov@linux.intel.com>
 <20221209132524.20200-5-kirill.shutemov@linux.intel.com>
 <ac8b6afa-813d-56c7-094a-8891ba69deeb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac8b6afa-813d-56c7-094a-8891ba69deeb@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 07:50:46AM -0800, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 12/9/22 5:25 AM, Kirill A. Shutemov wrote:
> > == Background ==
> > 
> > There is a class of side-channel attacks against SGX enclaves called
> > "SGX Step"[1]. These attacks create lots of exceptions inside of
> > enclaves. Basically, run an in-enclave instruction, cause an exception.
> > Over and over.
> > 
> > There is a concern that a VMM could attack a TDX guest in the same way
> > by causing lots of #VE's. The TDX architecture includes new
> > countermeasures for these attacks. It basically counts the number of
> > exceptions and can send another *special* exception once the number of
> > VMM-induced #VE's hits a critical threshold[2].
> > 
> > == Problem ==
> > 
> > But, these special exceptions are independent of any action that the
> > guest takes. They can occur anywhere that the guest executes. This
> > includes sensitive areas like the entry code. The (non-paranoid) #VE
> > handler is incapable of handling exceptions in these areas.
> > 
> > == Solution ==
> > 
> > Fortunately, the special exceptions can be disabled by the guest via
> > write to NOTIFY_ENABLES TDCS field. NOTIFY_ENABLES is disabled by
> > default, but might be enabled by a bootloader, firmware or an earlier
> > kernel before the current kernel runs.
> > 
> > Disable NOTIFY_ENABLES feature explicitly and unconditionally. Any
> > NOTIFY_ENABLES-based #VE's that occur before this point will end up
> > in the early #VE exception handler and die due to unexpected exit
> > reason.
> > 
> > [1] https://github.com/jovanbulck/sgx-step
> > [2] https://intel.github.io/ccc-linux-guest-hardening-docs/security-spec.html#safety-against-ve-in-kernel-code
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> 
> I don't think you need to explicitly use section names (Background,
> problem or solution) in the commit log. But it is up to you.
> 
> Rest looks good.
> 

I've checked git log and some people leave them in. I've decided to keep
them too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
