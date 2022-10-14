Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6875FEA33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNILJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJNILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:11:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF7C6956;
        Fri, 14 Oct 2022 01:11:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 952215C0097;
        Fri, 14 Oct 2022 04:10:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 14 Oct 2022 04:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665735059; x=1665821459; bh=m2djQg3F4D
        VynenjUu/6ySRNpcHRzX+D6LlzucfEhYs=; b=EhwpxGIJWz7/N+hl0C2NDCsdpD
        sSkzHhxV5b20Luv58TV4gL/dmXHZ1fxw3EETGEEf/OmAIwdj+3ORLjlCfyJREoX5
        NyoV4BF/zTmfNZg5M4vw3USDC0rJndcYmdEs6NtD7LDJMBEWmt+KTbMpFCJea3+0
        c9TNxIRzE5CXODdnEWnxYDT2kRHyQoUOJQVmblDyvpqyGLKODAijBkwIg8WHkuh1
        mKkmXpWVjDZEH5g8fhYeCedyOw/urT4KNS+3dpH+pEiBnxlmGzCPNqVtViAJH8JT
        TI1pgtfAj3H/XvQlsoswowmDu/XknFtBFEbFNv8Q1ojLbUrKwUPTOfNOWJCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665735059; x=1665821459; bh=m2djQg3F4DVynenjUu/6ySRNpcHR
        zX+D6LlzucfEhYs=; b=YqcxPACNXvW6SWq3nFas6BSz8Pb8z8+Zh1QFfWfR4BLv
        hNa65a1BkkZl3n3hI2zZKteOlLqJTMbM59tTdUA5fhbpDnMK2GWhEdZkcM0+A02/
        BxSFmO5eSablgsmMBJ2GZnvyJknzznxQMkFdHg4qgM+85nC13LG9fBzSpSsEmk7R
        AbrlIQ+qBdJj9k2vluO2oCRVzMvCR655aUXhpeTM5fXlk896JNQ1iwQc9SS8nhOM
        Xf3kyJiaH/9I1/j9cSSN1tLbbk6r2CBKqY2m2KgttscjKAhjEqoolvOT7q2u8+6Z
        l8rpAGPL/Zkh+zBU/j02LzI/R5zi6b/ohj3tXOcTig==
X-ME-Sender: <xms:kxlJY3F8XvO4JalLcHH-n6vFHLebIQssw4bnPFMe1qaod7ChZqTOcg>
    <xme:kxlJY0WeKoHJ7I5K1UnOm6Y2eFZiYX4s_FqmOq5hgXF3Qf_78ejyScCX_85wmKnhc
    cBMUvEpI9ehUOUCA_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekvddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kxlJY5K5U_5zFgWIBrgYD0M530mKfMqteXU-UeolqK0rjvh_otNpqA>
    <xmx:kxlJY1Gb2nXV6G45-XezRsWksKGuvdsnuYLJQbY2gzTAjJGFjapi_Q>
    <xmx:kxlJY9Wrjj73t_p7ClI2cppRSw2nn_RxeF4KjuQccZtwnDb0oG6n4A>
    <xmx:kxlJYwTnPAdERQjRBMXc7yN5SJWzM8fc3t55mhlc7QdIo8S7v6iREg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 59E0BB60083; Fri, 14 Oct 2022 04:10:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <767d768e-70e5-4a94-accb-3384a3bfd582@app.fastmail.com>
In-Reply-To: <20221013195153.2767632-1-nathan@kernel.org>
References: <20221013195153.2767632-1-nathan@kernel.org>
Date:   Fri, 14 Oct 2022 10:10:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matt Flax" <flatmax@flatmax.com>
Subject: Re: [PATCH] of: Define of_match_ptr() with PTR_IF() to avoid unused variable
 warnings
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

On Thu, Oct 13, 2022, at 9:51 PM, Nathan Chancellor wrote:
> 
> -#define of_match_ptr(_ptr)	NULL
>  #define of_match_node(_matches, _node)	NULL
>  #endif /* CONFIG_OF */
> 
> +#define of_match_ptr(_ptr)	PTR_IF(IS_ENABLED(CONFIG_OF), (_ptr))
> +

I think this is counterproductive, as it means we cannot use
of_match_ptr() for its intended purpose any more, it will
now cause a build failure for any driver that references a
match table inside of an #ifdef.

Ideally we should be able to find the misuse of this macro with
coccinelle and have it automatically generate patches that just remove
it from drivers.

A first-level approximation would be this oneliner:

git grep -wl of_match_ptr | xargs git grep -wL CONFIG_OF | xargs sed -i "s:of_match_ptr(\([\ \#\>\"a-zA-Z0-9_-]*\)):\1:"

which takes care of 535 files that don't reference CONFIG_OF at all.
There are 496 more files that use of_match_ptr() as well but also
guard something inside of CONFIG_OF. Most of these are just
incorrectly copy-pasted from older drivers and should not have an
#ifdef in them to make the of_match_ptr() work, but they are not actually
usable without CONFIG_OF.

Historically, we added the #ifdef at the time when we supported hundreds
of boards without DT and only a couple of boards with DT, so having the
extra #ifdef was a way of ensuring that the DT conversion would not add
a few extra bytes of .data to each driver. Now we support thousands of
boards with DT and only a few dozen without DT, so this is all pointless.

       Arnd
