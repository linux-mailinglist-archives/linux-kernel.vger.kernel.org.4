Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797B563C018
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbiK2Mdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2Mdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:33:38 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C232324F3C;
        Tue, 29 Nov 2022 04:33:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 571E25C00BC;
        Tue, 29 Nov 2022 07:33:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 29 Nov 2022 07:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669725215; x=1669811615; bh=IqZipqd0Jq
        L5tnglRr5e29BfFvwlHJufO9Ma0d1pQ0E=; b=eHpcM6SZLoo4/CPogT3l+vk4mD
        6RQvCq32VDsRJ+RrliP3bJ/vEjyVomm3xgMNMNjA0eDKPjJ1JmlQ4JQo8BukXEL9
        h358hsP8VJOH9aAszO25g8chHvG2mUZbZhyqY6h+qeomtcWAWL+6qJL691CnFAGe
        HhxQm1LcSF/Q8cqyhD8mpB8BiQTrNjDfbIEQ4BBEPTlUEfJExg5/hqVm3VcCBCDR
        ae6Q2S6iDzGBRtaB7ljYLh/8r8+WXxJLxqfF7WWa5sEsv8qPUWfuvUNskdNa6QiA
        rcLu4ddclbeWBN/aWsW/K6/V+ihYVpBjMhhXMU8bjtbA9M2uOe1GJUSssaTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669725215; x=1669811615; bh=IqZipqd0JqL5tnglRr5e29BfFvwl
        HJufO9Ma0d1pQ0E=; b=HkCxwtOsOLvnCGcKAxedQxQ7kUYyjzjIEvch79MlAP5I
        WtFDVLIsaJ16v0yvGZBUVmyv6axgav4MS77qa2k1fx2OCOFg+fQMr25J9z0bNA/Y
        bskE4Xo+lnxTz/N8+2itEvXCstSvhL5KX5DlhohADAVzjbz4wFtgvbRURgHSYvNk
        mvlvt4Y6KGrPsNm7DBxk6UO02+nG11YfQiGvrGl+di6A+JJOKiwr41PnT9z/YhWJ
        Wz10XTOW57VG6VRIbgNJy18+fCTpZHNPEJFkpP3tRZBbSG0ApFO6r6KwYAfFeJH7
        Fimdg+0BsEoat3qlESRAM+Qdpe6eEe4/TiDee5SdPw==
X-ME-Sender: <xms:HfyFYy2Zkx89s8co5mb89U98CJo3lCSHwOWWiluWJlqgzw1sUshOHQ>
    <xme:HfyFY1HC6JBgb73vlMd4aYjdr0xlrvyeHgLGh2zogHqfyxJ8ODICBWPtz74kXO2bM
    ApN8R54NyqJD2gAN9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddtgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeigfeiieeiheejjeeiudekleevvddvffetieehteeikeeigeeiffdttdeftdeg
    gfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:HfyFY67auymNWGkuozMR3IEK9g6ZFjQiOROATc_cXLO3hJTb-OEOwg>
    <xmx:HfyFYz3cv0xQkFfaVc9EOEOj2-hxtxNnl5aILq3ckLOp2jlv5cZF3A>
    <xmx:HfyFY1FYDzhZFY1RNSEGk2JwvGJg040obGkQ6oV2hBfGqzR0VhSjOQ>
    <xmx:H_yFY5LtXgsZJdF45k0pMPCFLA9aRu8ejGq91gaLnQ8Nxam8H7B8IA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9B4EAB60086; Tue, 29 Nov 2022 07:33:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <63ced4a4-33b9-4c03-8d7a-987ceb1fc2c7@app.fastmail.com>
In-Reply-To: <Y4X6AHdMZcxvFnDP@wendy>
References: <20221101222520.never.109-kees@kernel.org>
 <Y4X6AHdMZcxvFnDP@wendy>
Date:   Tue, 29 Nov 2022 13:33:03 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor.Dooley" <conor.dooley@microchip.com>,
        "Kees Cook" <keescook@chromium.org>
Cc:     "Vlastimil Babka" <vbabka@suse.cz>,
        "David Gow" <davidgow@google.com>,
        "Christoph Lameter" <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Andy Shevchenko" <andriy.shevchenko@intel.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/6] slab: Provide full coverage for __alloc_size attribute
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022, at 13:24, Conor Dooley wrote:
> On Tue, Nov 01, 2022 at 03:33:08PM -0700, Kees Cook wrote:
>> Hi,
>> 
>> This is a series to work around a deficiency in GCC (>=11) and Clang
>> (<16) where the __alloc_size attribute does not apply to inlines. :(
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503
>> 
>> This manifests as reduced overflow detection coverage for many allocation
>> sites under CONFIG_FORTIFY_SOURCE=y, where the allocation size was
>> not actually being propagated to __builtin_dynamic_object_size(). In
>> addition to working around the issue, expand use of __alloc_size (and
>> __realloc_size) to more places and provide KUnit tests to validate all
>> the covered allocator APIs.
>
> Hello Kees!
>
> It would appear that one of the macros you've added here is doing Bad
> Things^TM to allmodconfig on RISC-V since the 22nd:
>
> ../lib/fortify_kunit.c: In function 'alloc_size_kmalloc_const_test':
> ../lib/fortify_kunit.c:140:1: error: the frame size of 2384 bytes is 
> larger than 2048 bytes [-Werror=frame-larger-than=]
>   140 | }                                                               
>         \
>       | ^
> ../lib/fortify_kunit.c:209:1: note: in expansion of macro 
> 'DEFINE_ALLOC_SIZE_TEST_PAIR'
>   209 | DEFINE_ALLOC_SIZE_TEST_PAIR(kmalloc)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> CONFIG_GCC_VERSION=110100
> CONFIG_AS_VERSION=23700
> CONFIG_LD_VERSION=23700
>
> The report came out of my CI (which I should have passed on sooner) so
> I do not have anything other than stderr - I can get you anything else
> you'd like/need though if you LMK.

There is generally a conflict between kunit and the structleak
gcc plugin, I think the Makefile needs a line like

CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)

      Arnd
