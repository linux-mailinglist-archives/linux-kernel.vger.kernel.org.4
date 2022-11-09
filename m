Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66C6224C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKIHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKIHhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:37:06 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D71C115;
        Tue,  8 Nov 2022 23:37:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 243FE3200A09;
        Wed,  9 Nov 2022 02:37:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 09 Nov 2022 02:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667979423; x=1668065823; bh=m5tlTh9rdx
        ZedEf0I72h9Z/RT+0wwLzchj8jUt4pxV0=; b=RN/n7Ysr/X6xMvyB9zi1Sk33PD
        uDA0TBM2q8v1Xc+I+gl0aHifbshJ7RdHWKCkrFao05V9x1dMEfbIPRcViCKIt6md
        EvUWu5Rbs2DGRDwzVStLgsxYe9EvdoJEpplkElT97CWmDg4AJSw3X7OzEgcB7Sbc
        1vU1e3JAdBUvrvTisA/+XMRr3U0EKHgGI7fOYT69ZDqG+JvfPzRM5NaUjtX+6g3a
        rxdij5DZRBPVfun4RhcB7X8sdhPOavLYNnJ9u/VTaD5yBLQuop0toYtYyPdqwnPJ
        WbWBjk4IwlUakpBzrI8DHtLi5ZDOiwHIoTgRngcOksgmGRurS1RGrHxQjc1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667979423; x=1668065823; bh=m5tlTh9rdxZedEf0I72h9Z/RT+0w
        wLzchj8jUt4pxV0=; b=ghJbLOwZHBuSVe8vpALgyPRWeUZNgJwo1fc7GrUmYejI
        3mew45OfeoPtgKBZAe2Cwlx/o6xvg6QxPtoyylUuuY36tbG0mOplPsxO0Htn0cOv
        n/8r9y8ssfwYJO0Aebn6DH6vWBO8kBIarsUxpVG93rfOVZcLYbevUUVZNXd+IKRK
        ncj5EBRd7nh4+M7QUhK3urVi9bROVOj8QYvVE9N6PiL6JqSfk88e2jTMI7Y3MCTm
        MkSyXkXxDdaea/A7SpbXRa721FlnxLeWniYXlKZnvvM0RKKL7OLOiuAbx634ffz+
        6o88Bp2daeFP6sjCdI0LeH/teoHi10yfcOWCCY0CEw==
X-ME-Sender: <xms:n1hrY4glhWHd7yrbM3hvbjrGRJP0a4rocCoyvesyPEGkZuEcNzzo_w>
    <xme:n1hrYxBHv_YfbOezYwMGvhsVyLPGWKr9g838kCdhQQumWVXLxzPSXW4Gc-QDW_9B_
    kKj7Fx6Jiy9oM9Cdv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedugdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:n1hrYwH6aUMm2A57oRvJTbGjd0gP4BpDMft8kbNoUr9Unxjun-o5uA>
    <xmx:n1hrY5TEi4YQ3Je7HRK33NDY5K1SmRRVhWUsNjgqhJh3rBkjdknnvA>
    <xmx:n1hrY1xv06jcomWepM8DoEv8o8jjJkwhw6D5CJb3yJ_gS1mZCbcNog>
    <xmx:n1hrY8lk_9EzEOfV-LweLeOMq2UzCMq3rs7IvTi9vqfZEvWshm15lQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BDA8B60086; Wed,  9 Nov 2022 02:37:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0bd058df-aca6-4193-81b4-c073e06d9e5c@app.fastmail.com>
In-Reply-To: <1667974651-10893-1-git-send-email-kkartik@nvidia.com>
References: <1667974651-10893-1-git-send-email-kkartik@nvidia.com>
Date:   Wed, 09 Nov 2022 08:36:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     Kartik <kkartik@nvidia.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Dmitry Osipenko" <digetx@gmail.com>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, skamble@nvidia.com,
        windhl@126.com, sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: fuse: use platform info with soc revision
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022, at 07:17, Kartik wrote:
> Tegra pre-silicon platforms does not have chip revisions. This makes
> "revision" soc attribute obsolete on these platforms.
>
> Populate "revision" soc attribute with "platform name + chip revision"
> for Silicon. For pre-silicon platforms populate it with "platform name"
> instead.
>
> Signed-off-by: Kartik <kkartik@nvidia.com>

This looks like a good way of handling the pre-silicon identification,
I like it.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
