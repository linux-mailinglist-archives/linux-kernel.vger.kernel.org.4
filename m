Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47746455F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLGJA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLGI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:59:57 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3DE1D0F2;
        Wed,  7 Dec 2022 00:59:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E11FC32009BE;
        Wed,  7 Dec 2022 03:59:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 07 Dec 2022 03:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670403594; x=1670489994; bh=nlpaUoviu+
        Qxrq04vf4bc0HEZWMsaQTQBqwbNWHZ6ms=; b=MpfQHCTPCVZ5PMA1MVdiTU4cpL
        b7hcJcR7JCZTCagfZKygFWH01hsgklXSN1ZtnT1WDYjQtHT8aUdFb1jsnL9PBOFf
        s01MGjPswaQDgg4boZsMBQeGNESofWLOUpFYL3tWm0aE6Xo16VK24uyao0p/6Lka
        NNvRlrCHpbW8SPX+egI1onJVJ6BVTIxh43Dbw3TzVGyEBjFCQPVxuZK8eVEzwPmk
        hU9A+diO31bx1q014tEJLy6eAJ5rOQtYAl+2ADb/Ie+Up7rXXQ39I9XcvXKv8rC2
        jWbomNz7RXwS6vaBdHjKPykdkJ743aDNhuDP0pgxkjQHuPJIkAnh2algjznw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670403594; x=1670489994; bh=nlpaUoviu+Qxrq04vf4bc0HEZWMs
        aQTQBqwbNWHZ6ms=; b=XswPz6dvx8NTWZqmrWKFxTUZoCvqW0jR48oaFW4gXXIZ
        vk05CIx8hEmrOCGShjag31JtgCv8JVHI7Hhlj6IPkM2UZkItbPGvcFlCfquFVGfd
        mz5afEL7EQVeVxuyM2VQt9IXnN0y/dtbrFhvsaQ2oZpoL0B5tyK2rFaPFxN6WU/u
        Kfigz9sbn40/ozpuLi+LQlZ+4/lh5/OR2h475rxwQ/uwKTot1BG1cq1cGbGOj9xM
        MHYI3/UsL6FDi9BAeeKvL1X9y6CnJ3eHYWfEX/e/yGJS5n+ySlyokRrnJMvXAyIB
        0QdcrSDAqFYJ+X/uVqILG3f3JcJVkTI0YQc3IRC+DA==
X-ME-Sender: <xms:CVaQY5c69UrMkwcTwYtMeqbX_NQ95-BwJqJKF4-18sdet10VaOhfpA>
    <xme:CVaQY3O4N3qJF--bZHONBb13XEmslwfwDT9whJIYqyf6HOW18lkyv_42DhQScfhKN
    _zwNY_ARFzO_693VAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:CVaQYygz1dSre9W_EvIBBFyA4lA4li7chjy2vYj6m-4iqZiuiV25Hg>
    <xmx:CVaQYy8kgEi0PfJsoA0YFbO_UfKHxt7T8t1TRfoDcaZ1F1Powk-p0Q>
    <xmx:CVaQY1tmqVi9jaguYgCN8UNBIdrFOIIaJPo8baXXw64IZ9VwxG0JBg>
    <xmx:ClaQY_K5Ib-Ub6CJU25_nH9p9ZV6jz8STqEccqizft6CgUhVAso-4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D690AB60086; Wed,  7 Dec 2022 03:59:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <5a57e163-c705-4308-93ac-11e0cea2804b@app.fastmail.com>
In-Reply-To: <ff70222596646757cbd6e2f24aadf3247183061d.camel@codeconstruct.com.au>
References: <20221206073916.1606125-1-jk@codeconstruct.com.au>
 <20221206073916.1606125-3-jk@codeconstruct.com.au>
 <e46a680f-e891-489c-9747-98ae3df42ade@app.fastmail.com>
 <a83f62d604e70a8e58309dc7a5e2e3515227e1c4.camel@pengutronix.de>
 <b29dceb0-a07f-4e12-9e7b-6fead4db826d@app.fastmail.com>
 <ff70222596646757cbd6e2f24aadf3247183061d.camel@codeconstruct.com.au>
Date:   Wed, 07 Dec 2022 09:59:32 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jeremy Kerr" <jk@codeconstruct.com.au>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC PATCH 2/2] mfd: syscon: allow reset control for syscon devices
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022, at 08:56, Jeremy Kerr wrote:
> Hi Arnd,
>
> Thanks for taking a look a this. Just a question about the early
> approach; I'm not too familiar with the internals of the syscon/regmap
> infrastructure:
>
>> > reset_controller_register() only initializes a few fields in the
>> > passed rcdev structure and adds it to a static list under a static
>> > mutex, so there's not much of a limit.
>> 
>> Ok, in that case I think we should at least leave the option of
>> doing the reset from an early syscon as well.
>
> OK, sounds good - I'll add a direct of_reset_control_get_<variant>() in
> the early of_syscon_register path, which should work in a similar way to
> the clocks properties.
>
> However: this may conflict with the later platform_device syscon; if the
> late syscon tries to of_reset_control_get_exclusive() the same reset
> controller (because it's the same syscon node), that will (of course)
> fail.
>
> Hence a question about the syscon infrastructure: how are the late- and
> early- syscon registrations supposed to interact? Should I allow for
> there to be two syscons registered (one through of_syscon_register(),
> the other through the platform device probe), or do we expect that to
> never happen?
>
> In case of the former, I can just grab a shared handle to the reset
> controller instead, but I want to make sure that's the correct thing to do.

Hmm, it's clearly not doing what I was remembering it to do ;-)

Before 2014 commit bdb0066df96e ("mfd: syscon: Decouple syscon interface
from platform devices"), it was supposed to be the same regmap in
both cases, with the linked list being maintained to ensure we
never get more than one instance for device_node.

After this commit, I see that the platform_driver no longer matches
syscon nodes from devicetree, but only those nodes that have
platform_device.dev.name="syscon" and are created from board
files. The only user of manually created syscon devices at the
time was mach-clps711x, but that has been converted to DT
a long time ago, so I don't even see anything using the
platform_device at all.

This would in turn indicate that we can completely remove the
platform_driver code, but I don't see how your RFC patch then
had any effect because it wouldn't actually perform the
reset for any devices in mainline kernels.

    Arnd
