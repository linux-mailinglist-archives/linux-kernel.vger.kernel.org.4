Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529B4706353
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjEQIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEQIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:50:43 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D302469A;
        Wed, 17 May 2023 01:50:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C34DF5C01BC;
        Wed, 17 May 2023 04:50:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 04:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684313441; x=1684399841; bh=Lc
        YSP0PzI6w3Dklyzpt97/VZSI9VURjrHLoawxIJxiE=; b=JR5MsNRNwSdG3zU6Lq
        gzX573uFI7RhBv02vv4P+J8VWxe0fDiaKVV4QdBJwy8w4nzEhvG/kdHbUWv99YCe
        +L+8tp915ofO8KUeKIiB6QFnqNFz0wXpFHzYuczzYLyENiLj87jCB9xrAg0RDeuM
        CtWV7yFbw4iSH8ujNz542R+h2vB9vL56RnY6F3nzc6IaNGcBdVPx7tPJ7efmfoce
        5nsg+QH02+tNSF/UYfkGVwOwjILixFF8Fp8z+YLc9OKpxJl1Sm1czTnvbumjof7h
        3fX2ZVpFI2vNTBPdlL/BPTqROHPTOF29ljrsRLZNSAaWKLUIF507ZpKRu6urskHd
        bSyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684313441; x=1684399841; bh=LcYSP0PzI6w3D
        klyzpt97/VZSI9VURjrHLoawxIJxiE=; b=ZX5CPL2rEAFV5YL6GBAzet9FdXT8D
        cH4j2dCu2iVXURHkQbzx8jbaVbhW2IX39BQNu3dUyLjsAzd6wLk0yFgB+AN8Jkwq
        jvG7Y5OLhbkqMT/XHwjwQStdZ3cm6kEjM7pISj8G5FEAdowsqLJSbQoCSuZY2sYU
        /bc1Qk7TN5HHgB6G7AZ2VJrdAgD5dBGzUPmHD/6PEeMaIXT7LZPM2JH8K3eDfico
        zZcKOLkPuHUfiuBy7Y1HIel20X5oMBdvAipqeoWvERGPtjadolwc4Nkde9AZo+Iv
        1ghfbXgb5aK7Oq0YkkVr1ZZg7m5mLT3CCSdt81N4CHmJeGGRLNFA3//xw==
X-ME-Sender: <xms:YZVkZCTBnjriz2vFMjQjkZDz9oRbHWUcywThE0MBY6vK9zBHwHxISA>
    <xme:YZVkZHywRCS3Bx2HGLbyTN6C2Wz3bDIlZc7HyF5Ax3lGmh5DuwMKjN9Jw7Rph6NDb
    trq5lAHgcTw5gddRnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:YZVkZP3kfllorB8BwmsKi8jH6kzhkpse24AYNRCMQoU71NGJHqKTdw>
    <xmx:YZVkZOA54uASr4y8rlhjkkGlxWEbw1KFt83tv_1Q7d9j_zIGv5LztQ>
    <xmx:YZVkZLioFde3LJq26JOKGngeE-34TouiGhMarHx7R3_0Jv7wNIF9KQ>
    <xmx:YZVkZLfTsYJkLmnlPtyWobSuqjDFrnZUD4Eq7JbmrzMfoanSOyML9g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2EE84B60086; Wed, 17 May 2023 04:50:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <c28483ac-fbf3-494c-a634-d6edfb998d8f@app.fastmail.com>
In-Reply-To: <87lehngxbr.fsf@intel.com>
References: <20230516202814.561262-1-arnd@kernel.org>
 <87lehngxbr.fsf@intel.com>
Date:   Wed, 17 May 2023 10:50:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Antonino Daplas" <adaplas@gmail.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: i810: include i810_main.h in i810_dvt.c
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

On Wed, May 17, 2023, at 10:46, Jani Nikula wrote:
> On Tue, 16 May 2023, Arnd Bergmann <arnd@kernel.org> wrote:

>>
>> drivers/video/fbdev/i810/i810_dvt.c:280:5: error: conflicting types for 'i810_get_watermark'; have 'u32(struct fb_var_screeninfo *,
>
> Changes here look fine,
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>

Thanks!

> but I think you should try CONFIG_FB_I810_GTF=y to get the same
> mismatched prototype error for i810_get_watermark() in i810_gtf.c, and
> add the const there while at it. R-b stands for that addition as well.

I'm fairly sure I looked at that and did not see a problem as
i810_main.h is already included in that file, it was added
in 2006 with commit a0aa7d063927 ("[PATCH] drivers/video/: possible
cleanups").

     Arnd
