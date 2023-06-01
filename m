Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1371F29B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjFATER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjFATEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:04:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CC5184;
        Thu,  1 Jun 2023 12:03:49 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id AC642320091A;
        Thu,  1 Jun 2023 15:03:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 15:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685646226; x=1685732626; bh=Du
        N/fEwKhCSFTr6+YhFwlXQbFJgJ5LGQ3Wa6HZ4sPZ0=; b=C/QaeHLc892kUIexhi
        CidYIiNZ+JwKxyerI0n6ZzlTonC2MCfttfinYy0j6nUZE0iErne0YyoQBGmfGXdj
        9XSrK2L9/tABUCYBweKqmZhi51WYnI9Rc+ezixsjUrI5D0O7CJEu9tgr0LQ+hlaz
        i4q8H2qUmcsm++18eETylqOYIPoiKrg4KB2Iu3TnF5M3VSLOCE8AKl8No+eIYhTr
        PDuaFAvN7rYWdEJTKtZCj9dXjQe6si7FJa35LvMzr89wgvMuugL3R6Or9FMCsQ64
        9p7ik2vhiZkkygcCrB0hgP/qhcSi51j0QFoZqyswikwZEd8/RytRtIER+3QkH70M
        7naQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685646226; x=1685732626; bh=DuN/fEwKhCSFT
        r6+YhFwlXQbFJgJ5LGQ3Wa6HZ4sPZ0=; b=CE0FJDq5g3+5ijPC6hPr9VM97xL3s
        mWuo2EbkcPLu+0Ph8QjOnsUIMAciuA7bGpSysjt9WU2bERAVqitgINu8w75IFTbW
        ZGidhRm9cVrKhZRK6pUfPnAbX7QEoEprhUeQ51Eys7ws6XYfc1jOC5ra5VsAJH/J
        +DhBt/1svBdIgekyjlbFPJW4k3lECF+4ACQxKjbaFOZd7RIDm4R1tLyy/UvsvOwO
        VC/1wS+ux+mYJFDJjUxJoOE13KS+q2vCe3JMtyS4Kivp8Rf5jT7SwG950gJy5c9P
        FM3Y0cXNwAT0I1W2B3CpjxRVEoYwBhUYOoytRrogBxVgl2nIlzNJcIp7Q==
X-ME-Sender: <xms:kOt4ZA_xHqfSd9_RYqeU0tHY-I1qRDgVYk7nkh_VuFNAAPpWvX7Phg>
    <xme:kOt4ZIs5inhK977IoAHvpOzRI5YQ2VRsMI28w1ZIZwpsy-4LSV5eFZEV51MXNDaY2
    j0WGqpa8cAH4l9JxWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kOt4ZGC6ERAFa-qx2gxgJOc7DAlGEWcmZqsX_cIG0jQsYmt0S7C6Qg>
    <xmx:kOt4ZAcHYho97oJtWheRANisLoDF2mjLF2bYpfDULl3ACdM99-K-jw>
    <xmx:kOt4ZFMMxRbpFHYrHlhSI_2OYDfO__X7HEz-epFmBDG_X0BSzkQ2JA>
    <xmx:kut4ZM--RC614ju2WZYpsnNbcb4noPLl_tcLOEN7DmPanaWTuZEL6g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8F4D8B60083; Thu,  1 Jun 2023 15:03:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <bfcb63da-eaec-44f6-bcf3-7a15ed745b6b@app.fastmail.com>
In-Reply-To: <202306011127.B801968@keescook>
References: <20230601151832.3632525-1-arnd@kernel.org>
 <202306010909.89C4BED@keescook>
 <f6fcae8a-9b50-48e4-84e9-c37613226c63@app.fastmail.com>
 <202306011127.B801968@keescook>
Date:   Thu, 01 Jun 2023 21:03:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, kasan-dev@googlegroups.com,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Marco Elver" <elver@google.com>, linux-media@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] ubsan: disallow bounds checking with gcov on broken gcc
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023, at 20:28, Kees Cook wrote:
> On Thu, Jun 01, 2023 at 07:50:38PM +0200, Arnd Bergmann wrote:
>> On Thu, Jun 1, 2023, at 18:14, Kees Cook wrote:
>> >
>> > i.e. fall back through these:
>> > 	-fsanitize=array-bounds (Clang)
>> > 	-fsanitize=bounds-strict (!GCOV || bug fixed in GCC)
>> > 	-fsanitize=bounds
>> 
>> From what I can tell, -fsanitize=bounds has the same problem
>> as -fsanitize=bounds-strict, so that would not help.
>
> Ah, did something change with GCOV? This (bounds vs bounds-strict) is
> the only recent change to CONFIG_UBSAN_BOUNDS...

I missed this problem in my usual randconfig builds because I was
building with GCOV disabled due to disk size limitations until
Dan Carpenter pointed out the specific issue.

I suspect it's been there for a longer time.

      Arnd
