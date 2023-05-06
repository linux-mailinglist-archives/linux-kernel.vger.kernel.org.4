Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB26F9363
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEFRfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:35:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD21BFA;
        Sat,  6 May 2023 10:35:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7977C5C00B2;
        Sat,  6 May 2023 13:35:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 06 May 2023 13:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683394529; x=1683480929; bh=Lg
        ril5syRG3Ut6fnOTry0JCF7zd9RTUfKTlmm/rB3KM=; b=C/0ceNnZ8vvqL16A/L
        S1MDBFo/Ujz4SMgYRuQ1JErJPQVFNayyE7nw/yjDlgK5CLim1CQ5ZOpdkuxcqU+8
        yz5caZtt6VnhE0RsE35uiRPsac+FOxrTNFEjzmUQYZK8LYkLhY3CJPYXzcZBnf8U
        iXy3DoIssXHsEjFBpWkD+BNWZ4fjgl8fgABKYyRvW36j21pqwfg3BjlQLOOwYXnF
        NWbNRhoS+HHPLop1vjlCQJg4g7plsbnOwignykTvJTA0DSJCnXo532XUbC5Zd0tW
        3dWhs7SW5k1lMy5kLp4cf9gcXbyV2H0n4NkSobc2r56nqE6IYNDt43Vdnan1CukG
        hPrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683394529; x=1683480929; bh=Lgril5syRG3Ut
        6fnOTry0JCF7zd9RTUfKTlmm/rB3KM=; b=OiSABjPe+TBGIPO5lqmLC183Ka/jl
        wVm2TFfB2WGZSf1c/Iseewplo8LhzY+F2vZw2dvFICgtGAqGlWIehqblUzSpAPuW
        Q+S/dPjO+0H/pdGMasNpXJOdbJ+HSEa2Ut9DYSGPJ1IUHZiKbtoY7h7/hPbNmit9
        oFitY3ytXH1jj2bMtzZ8oMT0vqXUd40f5lQTPjZLwsgM6WcItuNViO8Zd47myK4g
        Oz1I65/rSUB2LN9k4D7uPjs3oWxjwS7idl6rSk7GeagvvIyaqJKmu7kr/hks4UWj
        yfTIPxjdgh+g0lPlqamzdqXJFjqi3Rxtd4hgH+ILyhorle5y9UNoabz6A==
X-ME-Sender: <xms:4I9WZFN0nnZCFwkDdMQ4j0ahNX-ykvBmiwU7yDAhcwujLXEgSCjW-w>
    <xme:4I9WZH81dFyYARrLRij7-6x5eDGXeA4lPLPgE72iQ0aWMw2v8vCXzSljw9m4lHzi-
    3kjwywo2BpFfNPFRuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefgedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:4I9WZEQ5_y82Pxzf08aGUaQVSDGaa8KnGQrL1NRW_H6bFLxOfrLAmQ>
    <xmx:4I9WZBvmscRvyD7V7wlU1USKSiqa6t5vrw3rhVSyRWaxfUZKyK8zJQ>
    <xmx:4I9WZNf_ols_xA5k4uYYyx1Pts6ovEgPQm2JWwp4LHAHZvpXUXWOsA>
    <xmx:4Y9WZHsd4jFSnSTkHelZBiKb8oXhy_KPJjDRhAv7y1nqvSaje3dvBw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 92132B60086; Sat,  6 May 2023 13:35:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <315e7ec2-169c-4c4b-93df-485380bc0852@app.fastmail.com>
In-Reply-To: <20230505133426.d70a6599d9a729496b68a70c@linux-foundation.org>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-3-nphamcs@gmail.com>
 <CAMuHMdWUtb_A-uhXrBg6kC9L2zbC_q3m8oCZoq80ZSJvk6mUAA@mail.gmail.com>
 <20230505133426.d70a6599d9a729496b68a70c@linux-foundation.org>
Date:   Sat, 06 May 2023 19:35:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Nhat Pham" <nphamcs@gmail.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        "Matthew Wilcox" <willy@infradead.org>, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v13 2/3] cachestat: implement cachestat syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023, at 22:34, Andrew Morton wrote:
> On Thu, 4 May 2023 19:26:11 +0200 Geert Uytterhoeven 
> <geert@linux-m68k.org> wrote:
>
>> >  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>> 
>> This should be wired up on each and every architecture.
>> Currently we're getting
>> 
>>     <stdin>:1567:2: warning: #warning syscall cachestat not implemented [-Wcpp]
>> 
>> in linux-next for all the missing architectures.
>
> Is that wise?  We risk adding a syscall to an architecture without the
> arch maintainers and testers even knowing about it.
>
> The compile-time nag is there to inform the arch maintainers that a new
> syscall is available and that they should wire it up, run the selftest
> and then ship the code if they're happy with the result.

The usual approach is for the author of a new syscall to
include a patch with all the architecture specific changes
and Cc the architecture maintainers for that.

Note that half the architectures get the entry from
include/uapi/asm-generic/unistd.h, so adding it there
does not necessarily trigger adding each maintainer
from scripts/get_maintainer.pl.

The only real risk in adding a new syscall is passing __u64
register arguments that behave differently across
architectures, or using pointers to data structures that
require a compat handler on some architectures. I watch out
for those as they get sent to me or the linux-arch list,
and this one is fine.

     Arnd
