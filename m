Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3C709AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjESPKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjESPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:10:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E1E109;
        Fri, 19 May 2023 08:09:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 78D6E5C01E4;
        Fri, 19 May 2023 11:09:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684508997; x=1684595397; bh=Hd
        AFOpP4Mmpj8sP8nf+XQRyuNt5e1ngGbSBEuPLR87Y=; b=K78d4ZcA+QFwcBlStc
        cQQ4iYXDop4aIpgBuKqwKvLt25kPy3BtCpKOgNfoIFMw7PGm8cZ9BjQmPuHlVBt5
        MUihYz2EDPttZvPEQKzYhWoFzJ4osztmjl6rOwuW4eXQuP/YMYZ2XCZNSxU2iyaU
        Sxil6LPHtoVjM+CoOmHmqU6k++qMY10ZHJK4jwT2iSt9Hupfr+wuAIEuhsycZwFV
        8EcUoeeZ7INOot/zOejk2HazHxI7B+Lop4oIoyVU0isx1e+bhUbHj1yFQlYZPacW
        XuuqUeaAEoqNaydIRHBXL0Y2QO8UfG7SJ1Hva14MAtfxfdJ7vsrurQFbhz5OG7Y7
        XIvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684508997; x=1684595397; bh=HdAFOpP4Mmpj8
        sP8nf+XQRyuNt5e1ngGbSBEuPLR87Y=; b=ftIfzBI9DALcM4R1kBB4Wvk+fT0eA
        jH509uhYkuKVC234j+xnAggzTeQXyOFTKSYxQBSlHbEKI7HrZECONql3zCZ/nEzK
        OO52dzJKuab34buXQH2Kq1smsfapoWBdYToodvYgdZig7e0v3/2G5isnIvmoXXwy
        802paETXLUhfJcfK+kgpNIQK4ZJDJulv+UxTjapN+L+jHfYTHOVXskB+dE1/eOF9
        lZdtNDgfCdNvuFOF11obm4BnzWPRjUHTCS5wvp+RBTgjBA8yy6tC2a2GCdTHoYuo
        OIe8U2MCwqLwM2JigAoGdxDvb0BWamTTzjJ7d09CsN8bCcgIyYjVXyvgQ==
X-ME-Sender: <xms:RJFnZHS89Hj16UM_F99yHs48njGmqYQr5CvroH6rwPxYGCl_lC1esg>
    <xme:RJFnZIyRavwJy2cy_851haydXIjG6Yg79riSbLKvha4bvHB-JcEn37AKbyZw4lUSD
    -TSQIxeHuJwgyaLjF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RJFnZM0YlMQyprx2zulWaohyJeS-vc1nBKMpUo22yygmgELnIGXsWg>
    <xmx:RJFnZHApNqkGugKQnUoKCcthTGm1TvdBwMM71KHG4S91TP2Ss_klVQ>
    <xmx:RJFnZAgJzkTevp3oWYlUQATh6BrWCAmopVix-Lwc9Rs_2HeliyyXTA>
    <xmx:RZFnZMyz6tATHWyAf7aoW__TOaF0d2KWH7YuNZYhPrEsLweByPC1uw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39E83B6008D; Fri, 19 May 2023 11:09:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <7d7ddc48-5985-4678-9f87-6e9b574a24d9@app.fastmail.com>
In-Reply-To: <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
Date:   Fri, 19 May 2023 17:09:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lorenzo Stoakes" <lstoakes@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Ian Rogers" <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Content-Type: text/plain
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

On Fri, May 19, 2023, at 16:51, Lorenzo Stoakes wrote:
> Given you are sharply criticising the code I authored here, is it too much
> to ask for you to cc- me, the author on commentaries like this? Thanks.

My mistake, I expected this to get added automatically based on
the "Fixes:" tag, I probably dropped you by accident in the end.

> On Fri, May 19, 2023 at 11:39:13AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> While looking at an unused-variable warning, I noticed a new interface coming
>> in that requires the use of IS_ERR_OR_NULL(), which tends to indicate bad
>> interface design and is usually surprising to users.
>
> I am not sure I understand your reasoning, why does it 'tend to indicate
> bad interface design'? You say that as if it is an obvious truth. Not
> obvious to me at all.
>
> There are 3 possible outcomes from the function - an error, the function
> failing to pin a page, or it succeeding in doing so. For some of the
> callers that results in an error, for others it is not an error.
>
> Overloading EIO on the assumption that gup will never, ever return this
> indicating an error seems to me a worse solution.

The problem is that we have inconsistent error handling in functions
that return an object, about half of them use NULL to indicate an error,
and the other half use ERR_PTR(), and users frequently get those
wrong by picking the wrong one. Functions that can return both make
this worse because whichever of the two normal ways a user expects,
they still get it wrong.

> Not a fan at all of this patch, it doesn't achieve anything useful, is in
> service of some theoretical improvement, and actually introduces a new
> class of bug (differentiating EIO and failing to pin).

Having another -EIO return code is a problem, so I agree that
my patch wouldn't be good either. Maybe separating the error return
from the page pointer by passing a 'struct page **p' argument that
gets filled would help?

    Arnd
