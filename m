Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F6B6F8A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjEEU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjEEU7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:59:47 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE51C0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:59:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id AEC323200A7A;
        Fri,  5 May 2023 16:59:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 16:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1683320381; x=1683406781; bh=Ya6s6qpPIjk/VZFJulF5DHNag
        eDTXkEvOczlMEoZhSw=; b=B+SuEAsLkgvhn9Z7JXQkSNmoa5t+xbfbPK2Ms++Jb
        vQExC1OmxIZ0jsfYXw9t2eObLVr75YklocYyeb0xciXYod5gokj8QLiYQ3ZqgwBx
        IRAKH+cNfwqh6OjDesCcHNOWWdKa0l2+gsauZRyKg8q3tc9koAxU2Z8q1rye/gU3
        ZQJHt+A2bPjpf3ji9PaSR7wWB0bGPo59cNhvwroJrtSiXHWs9BWc5OsbDXAFliH/
        zy+DB4tfEXwmcbIJQ2mANK9HJve6+sPqFDZTFIpNoZjy31Je5z9jXlr+JYbWzwVH
        g5Yiw37GNWOuYa082tC8fstkklKOrl4ZlmcSzNVKVhzDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683320381; x=1683406781; bh=Ya6s6qpPIjk/VZFJulF5DHNageDTXkEvOcz
        lMEoZhSw=; b=cpaF8NI/fE4TgXtlm395Xjg/90gr+Q94QG4NLSlflNiwPl0Ys9d
        xuicwDOeTAPMuWumkvjdj7dGb3VCofxoXGpiFOyrRhQbwm6kCUfE1HbNafrtakON
        KOxgbNqiUwOBHMkPQBe9GzLuKyMwSr79QQq7hNnEGdaR7tNvv9U5POTxpHONpgUz
        7SKUoUS0BLgq7sGX0zg52TDxS5Zg5e3OgwleehdSfOk/VfgLav8NF3NlhfmKSamp
        bxMrrcT85ZzUyNmHU60id9CyU/toeUtQtVb2RfeMYbWQYjSQ8dNGFXgSLjyuJ4S3
        TLOmfVZAhxVnv08XglzYN/G/mlNruESr2qA==
X-ME-Sender: <xms:PG5VZHnzqso-2KwpbxslHd2SVSwsqtu7sRrU49Tfahdk9svj6S2Jsg>
    <xme:PG5VZK18CovYL8l9LtZWbVXrXhWiqobByPE840qn5m_3P982wivT5Q6MDODeNUK3e
    DvvoFmYQ0_QZKU61R4>
X-ME-Received: <xmr:PG5VZNrbVox116OhtE7A-rnPmJ5E-HxpiImwrYJ_G0H6E2WZaPZJMoUmEurWXg4AlPEIWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpefgjeeikefffeefvedugfdtkedvhfdttdei
    feevtdehgefgjeffleelgffggfdvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:PG5VZPnjXMgHEu62mKmqZ5M5H0dmaIkmnAueLVMKFW5G1LhUWIjFnQ>
    <xmx:PG5VZF2LLhgbuGT_EvFMObE9747AzxzgPnYA7t6hm77u_0oT4RaFCg>
    <xmx:PG5VZOuAqb0HIbgFpQTN12YA5AX7-16wB_eEon5E3fFufSKvkw7Omw>
    <xmx:PW5VZN9jESMMGoMblPCrxSoMfElifacLmXVjOrywIbahALN06a-u9g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 16:59:40 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 302961099D4; Fri,  5 May 2023 23:59:37 +0300 (+03)
Date:   Fri, 5 May 2023 23:59:37 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [GIT PULL] x86/mm for 6.4
Message-ID: <20230505205937.jfxlbp5vp4cq5xyj@box.shutemov.name>
References: <20230429003822.n3mglslg666j3npp@box.shutemov.name>
 <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com>
 <f5983c42-82a5-1cd8-c717-67bfd72377dc@intel.com>
 <CAHk-=wgpOqujY210W9-KJPEfD42W_bvUdLwF-PAvyxJQ92tzDg@mail.gmail.com>
 <CAHk-=wj7q6Ng5uemZtrDnhtcfrgkzX5Z18eKZj94FY5d2quP6A@mail.gmail.com>
 <CAHk-=wgokAgkTVpEHM7c8oP9mca5s21RcxksF8h3FwWFJbCu3w@mail.gmail.com>
 <20230503190147.GA1719388@hirez.programming.kicks-ass.net>
 <CAHk-=wjVyHr9guj3fUh=Wq5vK+EMHN03VdBU83U6y2a+x9XCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjVyHr9guj3fUh=Wq5vK+EMHN03VdBU83U6y2a+x9XCUg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:56:31PM -0700, Linus Torvalds wrote:
> On Wed, May 3, 2023 at 12:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Looks sane from a first reading. But I'll try and have another look
> > tomorrow.
> 
> Well, I didn't hear back any more, and I was merging architecture
> code, so I merged my branch too.
> 
> It does fix at least two bugs, even if those bugs are not necessarily
> all that noticeable.
> 
> I guess we'll see if it introduces new ones...

The branch passed LAM selftests fine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
