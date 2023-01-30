Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE6680CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjA3MBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3MBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:01:07 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68F10C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:01:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2411E32002D8;
        Mon, 30 Jan 2023 07:00:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 30 Jan 2023 07:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1675080056; x=1675166456; bh=TD
        MULWl8K42gFGxXXkhM9aDVobr1p0cNzN+gUZU3mzI=; b=a1RqhclrB/UVRDFaX/
        ABUUVNlvRQblwffKWZGbAPAFWktuBCvNeLm/GCHrgnblaGoduh2SUOXHl5dZJ0po
        KDcUHSSq28Q16PKse5EzeZfaWTwkoA/Go8HVJqyX4DXmWgYQ3M6AtWb8gsP/y6Bv
        tV3Yn2lLyaogk62/SKjxMUD4IazMpcACNoPYPt8h/JW6FHzfuhMn+yUsHiSd4JGg
        70P15/h0za9fOXvBfjK0Ljeb9MVPAldOIpu2lpY6PuDeXv5mR6EjoVqh/JJOjZRC
        bN87/M0Ubsh5/vhPvhKa1jgjvg76Z1DqlatZHaw+qRZqBW4qr9t0p6+H1W3rPGt2
        OPlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675080056; x=1675166456; bh=TDMULWl8K42gFGxXXkhM9aDVobr1
        p0cNzN+gUZU3mzI=; b=ctjHXfIO5Ph8xWu/paabAmHoAbptx7O8uCgIGXOgV0Ms
        o0xsHE4wQ+0Wt38i6PW2cviAgEAMUm/3ExG3TEQKhhRv3Fl+0ChKjbxVcfeEnoYV
        K7t+nE/+ayC+g6SM2wblCPWW2XGrLdFl4anFYk9qJOcFzECnGO38YmXO0pgIogw1
        1GtthGCX8qIoTpLmodhDXl21g8V1lVMCaKFoaEf8YJD9GJRFMy4TT/xvy76Wv7TC
        gusxPqQgdj82tK8+KaBKQ8OJe/2MXuluZUQwVeUQXmD8aGffotu+uXadEvgK0su8
        6P8xD/p0qAhaqYPbZ5pRJg2VjXK5w9t8ZYTlScwc1Q==
X-ME-Sender: <xms:eLHXY3cxkmQwr2vNdUlrnRWB1VMXssSklU4by6qrNcw_-MHltTdiZQ>
    <xme:eLHXY9MVWj6nv1bBg6djIdZdsRvxWLlisbKwamL5RGH6VnN1TDioZmUuU6WxgUEcJ
    HSjP2BWTR69GPkcSes>
X-ME-Received: <xmr:eLHXYwg124tzT2-FZXrUBd1RicH5ZxS0FNGLEiLRG6aFWNi4jxX3BUu8g-CqWR6pUp2waA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:eLHXY48wPpZNpRNidDJkiHEnNQgKkRamoZn8aOfY3wkoFELPyJ25tw>
    <xmx:eLHXYzvrMtrE7L1oUudGqznK1M_bwqZ5qwfJbiad0f5rqnjZe0GvWw>
    <xmx:eLHXY3HGTyyUcJhcO1fiXbe-VZRrOc5APVSjvQvHOXzQlhSlNbfVGw>
    <xmx:eLHXYy876Ul1Ewvgg4ljN1TkvDeK642I0yR3ilthECvGFXgAjQV9zw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 07:00:55 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D9458104B96; Mon, 30 Jan 2023 15:00:52 +0300 (+03)
Date:   Mon, 30 Jan 2023 15:00:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     "Reshetova, Elena" <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
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
Message-ID: <20230130120052.7wfb5i2vql5ibkso@box.shutemov.name>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <m2pmaw5jv4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pmaw5jv4.fsf@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 12:36:34PM +0100, Christophe de Dinechin wrote:
> Is there for example anything that precludes TDX or SEV from executing
> code in the bounce buffers?

In TDX, attempt to fetch instructions from shared memory (i.e. bounce
buffer) will cause #GP, only data fetch is allowed. Page table also cannot
be placed there and will cause the same #GP.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
