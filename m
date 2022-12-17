Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F764FB17
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiLQQnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiLQQnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:43:47 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3B13D4A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 08:43:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E5FC5C00C6;
        Sat, 17 Dec 2022 11:43:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 17 Dec 2022 11:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1671295425; x=1671381825; bh=YJ
        E5DMN0xLjlH9KMp+9oxiZ/dYLT2XkC6oRGgrVYZ6E=; b=WUlB0zmtj43GVTA6mY
        F4Msv2/vGOMGYsQrvl42CVgC8BbIMx3c7JZoYRct6GugVSM2T47zMCESmXNy8ewv
        GUHA29vla0/k50vYrOLMReBcbnE+NcIUmsF/Bs9BKvTmbYtzjsSPihMO7x1K1CQP
        ZLctd5Ai2OWnt9lPQnQO2ufOldmkI9BZBUYFiTJQYablqtXXJU2hL+JLIIhznc1k
        cOCA0jN3N7+BgGQHtjFOt2mk9QJjm7uXlGWfXN7pZ8jpYUGgsXzhzNCPf9xbtApj
        Q1P26SWpsZ+Nnd0XfjNXrCadEJu8OHRoAP/XjUHI/ts9Aopde2um9/nZFLzpFJsW
        768w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671295425; x=1671381825; bh=YJE5DMN0xLjlH9KMp+9oxiZ/dYLT
        2XkC6oRGgrVYZ6E=; b=EPaSmWlnUW+pBTa1V3NWCW7JFP1E6Mpg2CF8turEgLFX
        7fEp5a7fhgrljsi1ENe+bBCqIZGh2+JH1KZggjl03qikKgUw44eGZfyQpZKxUjRA
        noioUO3VMemwDyrioivplAGBfEir3VzkjiMRdCEc4eOFzmAoeOMmKsVsPUTu8H1H
        1lnktAdDvkDSL7n73gNbAcUn8nhtTVGcbNEvfwlRNQfm7Nwoy3teaeZIxn2eApDX
        9jj2L/LZidOXOjvkr1947bG7FTyNOra2eLH53xO3d1jHTQkXDxxV9lkv2KIwkcFK
        vbgaSu+vwMyKsZ1zMa3O8p8JcnEt/A4qcnPd38D7ug==
X-ME-Sender: <xms:vfGdY7aIPDriIOxojc0kN8hWcOUdC-gx9wr8KCDQIht7aZFsTt3tfQ>
    <xme:vfGdY6bVV1IXy0qy2IanWYPafjozH6srKxyKvrNdu0PvbtZ-aV5jmk-QwzeK8EEDN
    dpKdFYlTJf2Tgn5ooY>
X-ME-Received: <xmr:vfGdY99zwdlYjE3WrFL8oygDNl2xKaT7VGi54iSbKdr6EGUbcTTNu3zlV7JEVssIWtLOLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttddttddttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhephfeigefhtdefhedtfedthefghedutddvueehtedt
    tdehjeeukeejgeeuiedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:vfGdYxoc8P1jK20SZx7nRMcSu6FNFGINfDVIu8JD-7GJcIwX1THXSA>
    <xmx:vfGdY2oXt4iEalbNAzqbt13LLu_MB4IEn5s2CZhdOJctCoMULls13w>
    <xmx:vfGdY3TQnLe9W8TOIEjQiFm1atNxhooTUfUipynz2cKwivsPVJoMoQ>
    <xmx:wfGdYzDyEYG83y-AjrbDassdC-dfCCveeTZNcEUVAtPzgX4PIbaYcw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Dec 2022 11:43:41 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3E6E5109689; Sat, 17 Dec 2022 19:43:38 +0300 (+03)
Date:   Sat, 17 Dec 2022 19:43:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kirill.shutemov@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [GIT PULL] x86/mm for 6.2
Message-ID: <20221217164338.vgfu5lebtz3fsriu@box.shutemov.name>
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name>
 <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
 <20221216021645.jn576zrhadocpt66@box.shutemov.name>
 <20221216150532.ll4oyff2tlrisqsh@box.shutemov.name>
 <CAHk-=whjCVDeVa8jxEjnimfhKNnXiku7ku4NirmY+poKsnM5HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjCVDeVa8jxEjnimfhKNnXiku7ku4NirmY+poKsnM5HQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 09:43:11AM -0600, Linus Torvalds wrote:
> On Fri, Dec 16, 2022 at 9:05 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > Below is preliminary fixup that suppose to address the issue. It does not
> > include change to untagged_addr() interface to avoid the clutter.
> 
> Looks like the right direction.
> 
> And once you change untagged_addr() to take 'tsk', you should then be
> able to cache all the information in the thread struct, and avoid the
> 'tsk->mm' dereference entirely.

Making untagged_addr() take task as an argument does not work well. We
don't have relevant task on hands in some places. The most notably GUP
only has 'mm'.

It is also not clear what untagging rules has to be applied: whoever runs
untagged_addr() or the target task/mm.

Up until now I choose the target mm rules. It makes things easier for
GDB, but it is not strong enough justification. Maybe always use rules of
'current' is the right way?


In other thread you suggested to make untagging in untagged_addr()
unconditional and I see how it solves the problem, but I don't think it is
good idea.

The current LAM patchset only enables LAM_U57 mode that doesn't compete
for real virtual address bits, but hardware also support LAM_U48 which
provides more tagging bits, but limits available address space for the
process. Unconditionally untag according to LAM_U48 rules is obviously
broken.

Although, x86 maintainers rejected LAM_U48 upstreaming as of now, I want
to keep door open in case a strong use case for it comes. I have code that
enables the mode stashed, just in case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
