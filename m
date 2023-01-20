Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD68675031
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjATJGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjATJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:06:37 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3568A710;
        Fri, 20 Jan 2023 01:06:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D50965C00CA;
        Fri, 20 Jan 2023 04:06:29 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 04:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674205589; x=1674291989; bh=tWpnQxdaIe
        bR2vFTYRJDrsRnibO6QCYzydQzBInxGiY=; b=ZlhYy8M9iRVinsdEPBu3dK4cYM
        lsH48zEfMvo/b8iZ0yFGJW6cH0n96N7woZsxAI9lqvsi8pe1lX6oI11vLbEKCeFn
        Io0/yI2YrgQD0uZzDxbEfB48yl43H5l6+Ag/kkyjuz1U636nZcT9vDOG3l+TbXo8
        Pdq2U60OVmxO4YBm/Icjww0tMKWqSfd/zeGXShU+sHuWOEcsVdWu15jB3WxgXwQz
        u5ZVTN5RMZZevxkkweHTsWTgmUZh2RTawvAd9Z2GYXvSvxijoB0fcBxa7+emZuny
        T53I9Tw5RQ/SpA/32Jgfs2gLytOjeWsVoAqbO4QMjzXKnMbrX7kaHsX+iNrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674205589; x=1674291989; bh=tWpnQxdaIebR2vFTYRJDrsRnibO6
        QCYzydQzBInxGiY=; b=Mr/ryk1ktCsXUeJMJo5VUad5iBAIkJkm3w7+my0oMYlM
        qi7VSwH9m7FMsNV1ETwSFt55OwzEe9axQH8fJDD/tHNfhrnnrIsjWsE3ebfFLUwy
        gbn7yKXv6bRDgK8pmTksshwbvj5Sns5nezmyW5iHUOMUQdwMo2KTqE0eWZFwXXec
        QRQUzIRlohMaMH5v2DgTuH/EDShQPdIgmq4EX7xdoYcHqXUOBY1xcgzQRwLi56zj
        Fxdy/m0JJJ08UrOeXABWALUbFQHC0fr1nushNxDIY6/hat+mQ6o1ZJXVNfERi7pN
        H9yl+E8+CDUEmrBFBH+T83tssAl3kn7q21LG4SsP4A==
X-ME-Sender: <xms:lVnKY9mn4XMOKeLMLqdsNLT2HLfZa5kr2HU9xARgwlEaunuQgucd7w>
    <xme:lVnKY42J40UbF22QfjPz0fEqc9PLc9_g6_c5jEtJw-XmB3JQ-sVCz2vSGWD-7kzse
    HOn75xDzUSbGEn06SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lVnKYzqX0jokflOnT4bvbeWh5Hfw5Jn4jQwzfb76oY4k8WiduGeh9A>
    <xmx:lVnKY9nr4zlVnsnJYXWJvNJbZS9QwG-LoENZBVXbEwTeqWSUUyn81Q>
    <xmx:lVnKY70lQEJ_8W0--wa79jubU5IbLOiIyY7FhXvKYW_8Bb_vdbvVXg>
    <xmx:lVnKY0uhn9xLi7xQvQ2ma-5mgaTApvhnCJeUxFkjTv-qUdn-AjDfeA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 939BCB60086; Fri, 20 Jan 2023 04:06:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <99519eb0-399d-4972-ae09-955a34830b55@app.fastmail.com>
In-Reply-To: <Y8l21Kb42l2ZcIC+@sirena.org.uk>
References: <20230118161110.521504-1-arnd@kernel.org>
 <Y8l21Kb42l2ZcIC+@sirena.org.uk>
Date:   Fri, 20 Jan 2023 10:05:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Brown" <broonie@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/5] ASoC: samsung: remove DMA filter function and data
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

On Thu, Jan 19, 2023, at 17:59, Mark Brown wrote:
> On Wed, Jan 18, 2023 at 05:10:45PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This data is no longer passed by the platform code, so
>> there is no point passing it down at all.
>
> This breaks an x86 allmodconfig build:

I see, this patch still depends on the s3c24xx removal, which
is in soc/for-next and I used for testing. I see a similar
problem with the MMP platform in patch 2/5. The series here
is mostly older patches I did a while ago and rebased on top
of the boardfile removal, but it breaks when it gets applied
first.

Unless there is anything in here that you really want to apply
for 6.3, lets drop all five for now, and I'll resend it
after the dust has settled on the boardfile removal.

     Arnd
