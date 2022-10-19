Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A5860370C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJSATG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJSAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:18:57 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DBF61724
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 17:18:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 609D232005D8;
        Tue, 18 Oct 2022 20:17:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 18 Oct 2022 20:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1666138651; x=1666225051; bh=Zs
        rr5zTY02howzem/uvI6lDyxx0n45EbNI50IgAhUQI=; b=IekZB6N9aXmmp56dDq
        AGYDZPjs8E8Embg0az0P7eZ9n8tRRlGNNDOXryCpMXrKYNhuBRwA4/4WPHvwh5ON
        jOeZ12EjTF6wds2wejtrrCTeSQaomXjL/v9gbLH10hLXyjW1iKO1j2QCT/XMkqXl
        GL/ugr9lYS3EMHsKjG/ztjBv67WHTbh9I6lv4VGKXsd6aH1RskzZhk6lM6VnttLW
        lJ0GARrdwvsWxTPQmtQG3Z5VoTbtK/7YJOy5DE4lfqn5t+Ox9rU9dwnC7oV4s+bz
        OyahTkuhyM6V9vBlwfH4Z81G1D3/jMsVZdKlaw6p7AmDnF2gFtOCcER541IKWOqg
        QTcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666138651; x=1666225051; bh=Zsrr5zTY02howzem/uvI6lDyxx0n
        45EbNI50IgAhUQI=; b=fKmR60Lv+g7sxHHF/buBNNOaiofDe5SvlSZdQqetpZY+
        jJljp5xTlx5IJzTGM3i+IF74xp9EfmshbhJIAD9wMqtMgzrG2J//IBorNW3QRD6/
        3MnJ6BjchFYWPyKs1t0yUik9otojIOaqADMERKc9XcW6KtNBsBLFAqlJ4+iOgdc2
        Ev/RrHTgRQRgsPPFpg0CWMOUPaPTZknk1q9pHA5rqReGJXaAyYsrcyZ1HUbOrYlq
        dbRqRyhfP+FLbumsJ7nOyM1caD5EA4SPc08jrTrehBEBIK7LoD/yj3La4jrEywnK
        tJEoZ488L6AoV6cdNcw52Afcfcuu/m9wbCZqY4kBcA==
X-ME-Sender: <xms:G0JPY_rLkYgHfYIjG-7wVduJcKOJQI7gB8B9RZmjV_1uP7k4xhWH5w>
    <xme:G0JPY5qRxEH9OFdrU6Nu4mVdKNcnpuiEFl4D1fA1NR6RrN10QCpTu3Gwb2vV2uXpx
    RnPfAfrjN6c4u6mKS0>
X-ME-Received: <xmr:G0JPY8Oy2lh9P035SRuoJygWKlgRU_2bd0MQcg6ITvJCz4QLQpnr36TC3jK5p_6S41jbYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:G0JPYy67YHxtmEsVhKCQsrxdZ4hlEBlgJdAe3XbB3Zyqf1-_lhEFCA>
    <xmx:G0JPY-7KBozKyQcXReyr4QmWhmHSVCFy02lz_v0Fy7E1Sh2eeyhQgw>
    <xmx:G0JPY6jXhLGSNJFTmRz2bIwr8oglEKw3V3rmHj7uM8XZA1xOACAcgA>
    <xmx:G0JPY7xBPgC_F-VtQMsLh4fhrBjp3FWeANHNGhNpZYt1lgbyb6ghMg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 20:17:31 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5C2781068AD; Wed, 19 Oct 2022 03:17:28 +0300 (+03)
Date:   Wed, 19 Oct 2022 03:17:28 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 10/15] x86/mm, iommu/sva: Make LAM and SVM mutually
 exclusive
Message-ID: <20221019001728.jvjtrkoe7aqmhfww@box.shutemov.name>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
 <20221018113358.7833-11-kirill.shutemov@linux.intel.com>
 <eb590d2c-581a-03e0-863c-0a33a20ae772@intel.com>
 <20221018223341.tiyypudh6k63mnnb@box.shutemov.name>
 <3a0dd700-ce2e-e1ec-ee8b-74cd68c360b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0dd700-ce2e-e1ec-ee8b-74cd68c360b7@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:43:24PM -0700, Dave Hansen wrote:
> On 10/18/22 15:33, Kirill A. Shutemov wrote:
> >> Is this #ifdef really necessary?  CONFIG_IOMMU_SVA selects IOASID,
> >> without which pasid_valid() is just stubbed out to 0.
> > mm->pasid is only defined for CONFIG_IOMMU_SVA=y.
> > 
> > Do you want me to add mm_has_valid_pasid()?
> 
> A quick grep makes it look like pasid_valid() could be *replaced* with
> mm_has_pasid_valid() since all the places doing pasid_valid() do it with
> mm->pasid.

Almost: the second pasid_valid() in iommu_sva_alloc_pasid() called for
just allocated pasid.

I guess we can just opencode this case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
