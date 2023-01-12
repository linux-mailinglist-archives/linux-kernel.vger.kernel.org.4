Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD0667765
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjALOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbjALOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:42:13 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561923C70B;
        Thu, 12 Jan 2023 06:31:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2121532001C6;
        Thu, 12 Jan 2023 09:31:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 09:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673533900; x=1673620300; bh=XcokMuesyw
        xRllOXpayJil3m4/0GhcocSOMeW29gsw4=; b=MLiwNAi8tcaeCi9MXc2YWFpOBf
        Gj0dNvvVQ9uzseSNWXiPXH0wXgkI/LOafa68F0NExmTfhCLgg8/M32DSVEnz9A7r
        rcEqQJ33E5Le2+GyGeM27kNK/9XVc1t0GvaTQlV7Mr7pQTO81lqGiewGflsWh/Dh
        pv3cVbkGZUm2j6xjgfDWnh9NNaPsHrsQdIsA2lR9o7HbNrabMFTGkWONTA03Uzgy
        3KgIdHsuQBadMigHriIx17ycPmnNWGxJwhY1UEJFUPvyex+pwgb9LmImEuNql7Am
        Bop7Jdj9DwpQRdNcTbWQ7vv4upEaC333BkEzygdIKJB98L+McTJOiYk9r/uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673533900; x=1673620300; bh=XcokMuesywxRllOXpayJil3m4/0G
        hcocSOMeW29gsw4=; b=Kp+q7KmpXhT06eQ8k8uKv5pp/8jC2FUMvhwGGSnkwWq2
        haMAlzUGzfmB0GqB9JbbIylV/rYm8YdrT518/XZbw+3+GSDTa97JW1RSmAdzmtg7
        jiVyBufj11z45pejxjWHCqMuLm3uCYubbj5msWSjulwMaJH+Ag9qf6GwC8jMywh+
        e8ZNZzbE5tpEp/BJlRKODYkQQFlqhk1+4E7WL1XbiAL7eZk6ay9F4rjshAv3YLsx
        RCFLhvU3DZ7EmT+Ss1xXmQH9QpIpE1I4l/egJr2YKnKqyrIzynYEgNEfdyTJLpX7
        +HUAppD9ASzm11qIQ6yag14Z2ujU8TSsoqiQ7s5KdQ==
X-ME-Sender: <xms:yxnAY9hnKceMyJg1D3pZU0c-p6zS31a1aq4w790l4Lt8VxaMpwqJAg>
    <xme:yxnAYyBjA1NbvGwmvEf3yL_Vl70SV1wFFGXxRyGZeHQzdV02SUglazqaqCM-x5SVi
    rmrf0pM5c0yp6qBK7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yxnAY9FMYHy_CzTfZAlnvRu-bHh1jYb9eWdyb9ulOkPDrVvusf20NQ>
    <xmx:yxnAYyTnk83VCJUyAH0nd5YO19FKWkmaYZk-3ZsGcBko-aTX9674ow>
    <xmx:yxnAY6yGF_NZutjA1nD61SUyqVD_Ekr_vlsCZo5eJ_Hel6r2-_VgRQ>
    <xmx:zBnAY5kLcLvv8htSNyYYknZ9lvkkqFl2Iv0UZhszoq7-tZlF9zPR3Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA596B60089; Thu, 12 Jan 2023 09:31:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <179739a0-5d75-412b-964b-16d5cb6d306d@app.fastmail.com>
In-Reply-To: <20230112140524.GK730856@darkstar.musicnaut.iki.fi>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
 <Y7/YiMPIDN0Cf5Ky@atomide.com>
 <c9821df0-cd3e-43a0-b903-430d1251d51c@app.fastmail.com>
 <20230112140524.GK730856@darkstar.musicnaut.iki.fi>
Date:   Thu, 12 Jan 2023 15:31:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Aaro Koskinen" <aaro.koskinen@iki.fi>
Cc:     "Tony Lindgren" <tony@atomide.com>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI support for
 OMAP1/2 chips
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 15:05, Aaro Koskinen wrote:
> On Thu, Jan 12, 2023 at 11:19:53AM +0100, Arnd Bergmann wrote:
>> On Thu, Jan 12, 2023, at 10:53, Tony Lindgren wrote:
>> 
>> So if we want to kill off the old DMA stuff there is actually
>> a choice between either making omap_udc PIO-only or converting
>> it to use the standard dmaengine interface.
>
> I use this driver on Palm TE and 770, and without it those boards would
> be useless for my use cases. Also DMA doubles the throughput, probably
> also power usage is smaller.

Ok, if the performance is important, converting to dmaengine
is probably best. Do you know if this is just a straightforward
replacement of the function calls, or are there technical reasons
why it's not using the dmaengine interface yet?

     Arnd
