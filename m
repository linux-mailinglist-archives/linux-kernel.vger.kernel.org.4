Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67B638707
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKYKGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKYKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:06:44 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B5D27FD5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:06:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2D2605C013B;
        Fri, 25 Nov 2022 05:06:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 25 Nov 2022 05:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669370800; x=1669457200; bh=rTN6mE9PsM
        PtJWJzgBPfjFVsIw8tlQTrAia9D4cqv3w=; b=fBAKjs+hIEmhYZN+dgS1dU5ZZk
        p1/d37Pe7pKx9AwOE8y25RH57j/26oR+kof8KR+ukFwkO4Jxg/WgIhV6rARwFwyv
        PJypt+bmCDu+3/zDkL0m+ILwDcMDKvgN8DGKfi0i0qPOBF0HH13BJojlAI0Ct7IB
        EVmc3mntXzEDP07I0F2PrXA33/pMLbndev+lq1qaUviMNR/6fBcdKkW6TPkyouLr
        y9oSsC2+mYqgK+TemOZ41DmIPGzCT2Sh+rx1ujkC1BgCNvMnDFVIrGsoqF2UVWsR
        BBDG8KwMTzpAue2/dnVY+cr/BMTOBvKx506DVCtbjNag7CemH66fjRuiBVRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669370800; x=1669457200; bh=rTN6mE9PsMPtJWJzgBPfjFVsIw8t
        lQTrAia9D4cqv3w=; b=O8r2vRDZXQbpA+6y/vvszehVy3BZEvvwpyyEiwga6Drz
        g5JxxHj8j51+7OG870AzJI+Ya7lQYYxIPer8Uil1FFBFHgTat1jvwfuTPuwi4qr2
        5XQw5roYONJ4Y0wG8nGqCAwC16ldtR93oA9R/9BVrgQG6Go5RA4q55wJOOuDQN7e
        ALF0k0VeyXCcgC4fGqJZH3FKLGQqpFZS6rlv62GzSH28hP13AoCBoJO/jV2Ru9yJ
        ukGq5+2Ynq3jtmI/ujh4dZHZYhP4BtgwpjlH1ZqsziRib4ZGf3DSkNCFHUEZVo0V
        sCcO5PL+Ml7y8A4DRegUs9/Q+Nk4accJUB6jqZKDTg==
X-ME-Sender: <xms:r5OAYxrrIH9Xun07pLSUa4SqaWOGUnA69dwAmjZgrFkp6GQs3NDuaA>
    <xme:r5OAYzqSK0RoBkmwM3nHwnnZcOcYpTsYaWHs1h-Yt0gDqepHX84kildrnxKDV-155
    7gCULKnNPaZNK8jxq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfegfeef
    heenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:r5OAY-O2xTwBD6KN-QkqmglbfV_nufohtc_f8OhiTskTgUupM9k59A>
    <xmx:r5OAY848pjoZtyFQ7LXFHujFa3LqrYFjG0twwZHllzE77eF4IMZgpw>
    <xmx:r5OAYw68lEFECDX7--_fKrK7ZcCKt5SUmjMWRgJYraUUI1v_IlW1uw>
    <xmx:sJOAY9y-FCYF_Z_8HHEhhaewxF4NnA6qjLu6UrVwxJh_b_toL0ex5A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1291B60086; Fri, 25 Nov 2022 05:06:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <82578dd4-a00d-44aa-9059-c5c5215aeb0b@app.fastmail.com>
In-Reply-To: <20221125092517.3074989-3-lee@kernel.org>
References: <20221125092517.3074989-1-lee@kernel.org>
 <20221125092517.3074989-3-lee@kernel.org>
Date:   Fri, 25 Nov 2022 11:06:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amdgpu: Temporarily disable broken Clang builds due to
 blown stack-frame
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022, at 10:25, Lee Jones wrote:
> calculate_bandwidth() is presently broken on all !(X86_64 || SPARC64 || ARM64)
> architectures built with Clang (all released versions), whereby the stack
> frame gets blown up to well over 5k.  This would cause an immediate kernel
> panic on most architectures.  We'll revert this when the following bug report
> has been resolved: https://github.com/llvm/llvm-project/issues/41896.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 34f5a092c99e7..1fa7b9760adb8 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -265,6 +265,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
> 
>  config DRM_AMDGPU
>  	tristate "AMD GPU"
> +	depends on BROKEN || !CC_IS_CLANG || !(X86_64 || SPARC64 || ARM64)

The logic looks fine, this has been broken for so long without anyone
paying attention that limiting the broken code to the working architectures
is probably the best way to avoid trouble.

However, as far as I can tell, the problem doesn't affect the
entire driver, only the "new" display engine, so I would probably
try to limit this to turning off CONFIG_DRM_AMD_DC for architectures
that don't have a fixed clang.

     Arnd
