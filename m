Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D371F11D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjFARvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFARvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:51:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA913D;
        Thu,  1 Jun 2023 10:51:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5FF8832006F5;
        Thu,  1 Jun 2023 13:51:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Jun 2023 13:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685641861; x=1685728261; bh=rI
        kHOu2cJZ+vhgMgLgXQFIzSc/FfETBAe+GmKBqE/d8=; b=YsbtSfmNvp2eXNoM+R
        izu+ChEdBnznPH+LsBdjf2+h6LdAHRujYmHDAet9DAX1gmlHLKguMCLBwmLdAHEO
        D+UVABb2eTTzqr0726+/7NHAOtmHqLCAXINuJsiG1IDxhjaITt017WqUNsBVChzh
        D90g8W2yX8ZoFDket0s7THCrhtfyEuY5C0Ndajkk/+9tv8wElxHd4U/Gn7Ea7xEx
        XbVfxHdS58S6O5Mq/yj2OHukD1a2RvVB62BOr0d3rvYg6DdO9l1EU2kX/KReg33O
        fPR6tKEUO0F7F771g7sulSQlHpOBfGP9yais1MeBS4eMz09WTiPZ3dXkonAtsOj3
        MpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685641861; x=1685728261; bh=rIkHOu2cJZ+vh
        gMgLgXQFIzSc/FfETBAe+GmKBqE/d8=; b=x278PMWMnWwyz8MB2+Pq6j4xDniu0
        TlaDyapGkeiQFJNSM0ckJ1vVqYHPh1dpmpNaqeJMLl7g8wk5al2PlkQc7NvB9v+b
        GnN6504fYOB+Hl1GRaqPa+18Zkb5vE0BQjoUe3wngRik4cKBXar65yZzHfpoMhTt
        qksemY29jYOi6hdi0fsHGM5w4bTXLGf859Bz8PCzkDPKVPKbejaWAQPDdVsLH/fK
        p6meRZqBmViLevJg6759hN/hDoAdYDzWXmViGsF+HwJAAA/2GYyXAVdAVpvsFx8m
        N21D6im9GWBMQvaasV8H05L7MAuS6ST5q8RBgJocWC9hR3Er14DmqCocw==
X-ME-Sender: <xms:hNp4ZEB47iSnUPOggsaPyqB3htwwzNbBYiP2c2CDEU-GAelh2g8d0g>
    <xme:hNp4ZGjPiJzGYKEOKXF8ZVG6qJObsay-XWlXTArfI2edvCGmlHvO6H8hcnSw2yE8S
    M_zWTR4S9o1_3Selek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeigfeiieeiheejjeeiudekleevvddvffetieehteeikeeigeeiffdttdef
    tdeggfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hNp4ZHkX2OtLDMVwiM9pUSRildLjmx7b470Z9Ca5GPuJafo5YZtD1A>
    <xmx:hNp4ZKwgiGYOpOdmKAbTAywxVof93l8RU1AQtJKMm8M8XxQ-KJalsw>
    <xmx:hNp4ZJQ1JHiPxb1I71yRvpM9eN-KRrOUQGwapN-tDspykREevQDiyg>
    <xmx:hdp4ZICyxJxKWz4v3ZWf754mlZqb1XGQlvWDQ_AdPqLkWWJ3D8psOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38825B60086; Thu,  1 Jun 2023 13:51:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <f6fcae8a-9b50-48e4-84e9-c37613226c63@app.fastmail.com>
In-Reply-To: <202306010909.89C4BED@keescook>
References: <20230601151832.3632525-1-arnd@kernel.org>
 <202306010909.89C4BED@keescook>
Date:   Thu, 01 Jun 2023 19:50:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Kees Cook" <keescook@chromium.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     kasan-dev@googlegroups.com,
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

On Thu, Jun 1, 2023, at 18:14, Kees Cook wrote:
> On Thu, Jun 01, 2023 at 05:18:11PM +0200, Arnd Bergmann wrote:
>
> I think more production systems will have CONFIG_UBSAN_BOUNDS enabled
> (e.g. Ubuntu has had it enabled for more than a year now) than GCOV,
> so I'd prefer we maintain all*config coverage for the more commonly
> used config.

Fair enough, I can send that as v2, but let's see what the others
think first.

>>  config CC_HAS_UBSAN_BOUNDS_STRICT
>>  	def_bool $(cc-option,-fsanitize=bounds-strict)
>> +	# work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110074
>> +	depends on GCC_VERSION > 140000 || !GCOV_PROFILE_ALL
>>  	help
>>  	  The -fsanitize=bounds-strict option is only available on GCC,
>>  	  but uses the more strict handling of arrays that includes knowledge
>
> Alternatively, how about falling back to -fsanitize=bounds instead, as
> that (which has less coverage) wasn't triggering the stack frame
> warnings?
>
> i.e. fall back through these:
> 	-fsanitize=array-bounds (Clang)
> 	-fsanitize=bounds-strict (!GCOV || bug fixed in GCC)
> 	-fsanitize=bounds

From what I can tell, -fsanitize=bounds has the same problem
as -fsanitize=bounds-strict, so that would not help.

     Arnd
