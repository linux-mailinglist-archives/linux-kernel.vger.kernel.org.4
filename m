Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A667B67F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbjAYQCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbjAYQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:02:09 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB25999F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:02:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E0BDB5C0193;
        Wed, 25 Jan 2023 11:02:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 11:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674662526; x=1674748926; bh=j9
        m9IV7KjyIID3/ptK8lRPhHxapTw3RI8SIqS9Yoqlw=; b=hQolHntqwrbC7SuX0u
        Vq00jIE4bQzwk1jsBGFbtmlJ+UTOyLH1mVypUSXL/61li1NhrZbeUCe/DNDvJjer
        hfpOJ3aMu2lpPS99FbM2v0glOjIqxWpcgxU39ksgLAoqitSR5Li1TLRdg6qd4ifa
        +SlT/xoPsZoLfKQn9yFvE7RirciRN46BPLqC+K3xPJigVpxLKOhiMaJ4u/dw0Kms
        yYWiX8UDYNaalP2HfABBmWtQduUaqpR19Pz0CpJHn5f4jQPBnygGtFrFlei+3roD
        22Vr1ibOc7jaOJu+rMjPArxaTxO25HZHT1VjIfhzWjDCbmDT6iHrbFRDCS4/22yg
        cfUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674662526; x=1674748926; bh=j9m9IV7KjyIID3/ptK8lRPhHxapT
        w3RI8SIqS9Yoqlw=; b=a5ZB8A2/2+6TdM7qUZmHs/pWQF2K2mHu2j+aLe9NmfDm
        2nsoRI/gm4TdtvvKwvIj0BhjL9xv/NBvnC1a5JH7kM9ZTHHRsyaZXGOl9FhHBFN+
        /VvUGWUwvF8xNvArMknd/DmaQSzlSlGwDB2THYaxJUsDNOytnWuzXQ081/ijFFUe
        1Y3Ac24i9DLfPpTEqqSa7Rg46SKAM+7CWQN8B45i/18k0QiKQdrvljmgjQwV7O3S
        SqAFw7KwCLaDrJI0oUFNco6QA2IPYYmL4nfHp9OP1MJXqLnDYFAH5STENIsmzLRi
        dvzoy75dXF9jNA5ShxhoXuBCDT4JmnCwrJD8Mxwe9A==
X-ME-Sender: <xms:fVLRY1Mz1L2Amy7_ns-7orSdcLNTWzYsAIJbo1HUdv-gVB3DoRQqwg>
    <xme:fVLRY3-I8AuFv0KfqV0XXGV6N8sFzN0xYzKyqvqcaDN0Nav127Pzxw-30_eE2LLlb
    b6dp1ImB75Jxppr9Vg>
X-ME-Received: <xmr:fVLRY0SQgB5A3hVVxzJFDxfr7wccorzHba0olQ3fuCNrtJB0LyFhv5IFKKQ_PNtVnAEzpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:fVLRYxvx7bkyO0hVIP6BDZ1DKi4NrBPTizk4MIeCdW0UkvyOGRhJ7w>
    <xmx:fVLRY9euFdx-vpmOlisT7cpGb1Ty8qmobbiYq11MS-Nzm3JLFR9g5Q>
    <xmx:fVLRY903a1Fzxx5cjbvs0ghs85vg6L-wtaKhrF1FRzYhiEtg413xlg>
    <xmx:flLRY2vk6Oict34UEQd5dXJnrRmVNZBdNQ_NLnP1M92LvIzrrJY4vA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 11:02:04 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 30AFB10BDFE; Wed, 25 Jan 2023 19:02:03 +0300 (+03)
Date:   Wed, 25 Jan 2023 19:02:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux guest kernel threat model for Confidential Computing
Message-ID: <20230125160203.z4ttwlgclfd54pc6@box.shutemov.name>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <Y9Ex3ZUIFxwOBg1n@work-vm>
 <Y9E7PNmSTP5w2zuw@kroah.com>
 <Y9FDZPV7qENtNNyk@work-vm>
 <Y9FHsvVoPbgMR2s3@kroah.com>
 <20230125103816-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125103816-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 10:45:48AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 25, 2023 at 04:16:02PM +0100, Greg Kroah-Hartman wrote:
> > Everyone wants a subset, different from other's subset, which means you
> > need them all.  Sorry.
> 
> Well if there's a very popular system (virtual in this case) that needs
> a specific config to work well, then I guess
> arch/x86/configs/ccguest.config or whatever might be acceptable, no?
> Lots of precedent here.

OS vendors want the single kernel that fits all sizes: it should be
possible (and secure) to run a generic disto kernel within TDX/SEV guest.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
