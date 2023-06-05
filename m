Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7225722199
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjFEI6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjFEI6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:58:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E968F90
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:58:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 99527320091B;
        Mon,  5 Jun 2023 04:58:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 04:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685955526; x=1686041926; bh=hU
        qz0oSYym1Zk2R50bvVZ+tdv4ZMPRJujK1PFvUebcY=; b=I1upo1i65dPzrlV8cL
        k99gS4i+O+Mu0hn3k2FIELLvItfJIxDDX2io6Py8e7l4RRJReaF+cITZq02xv5nV
        RFcE0Uhj2OqsCPtWgkEpARV1F/prxLCU3AIfkPyUl0GHoDLN6K/Bz7Oz3+kT/yKh
        2Ss2OrmpNlPMhxNzzZ6ZtRY4dPhs5+tCVkPqoR2BtsN8UcvkjU62dr99LtT/3uB5
        0PDGKxYc3jJmFNAg7/VTiCgbvsaanPLzHy3jtZ3Bt8MvJNM3tYY4OImZ4jF9Jlri
        shGoXRkwq3clNnreSYeYRv42vMxs3JZaONg5svdEi6SeqUaL2AC0qLg4357Rm4dT
        1DFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685955526; x=1686041926; bh=hUqz0oSYym1Zk
        2R50bvVZ+tdv4ZMPRJujK1PFvUebcY=; b=i2je8BCgr9i55TWp8LsTy7R9NLcAd
        UYW6Cpi4WYtjrHIw8jSrwlgF/JvA09FLBAwbNZl9TLiY0m61+V4fu4lD5YFlFOCu
        Gs0b8/M2HEQtHkQRxSavBZn1pw+Kgy50dNG94pdrjQE02vr5p6vCX3oBom3jaSiQ
        6dQ4gO28VU1LIVn4932Na/A06i0abz/EhxW5b0+mPMVdtGmn5Lgo1/IpsoJ9W5pj
        RgwHrry6YQ2Uq+VuRpqJ2Ls8XmHpVBIJNCVzU/XCMTvzkaI8+bTBHy/MocMvXnsB
        e9Aqsi6A+kfEvM1GetLvQ9+PWiVlnxz23AstYkPW5ExGOnDxUI4unaSDA==
X-ME-Sender: <xms:xaN9ZBvq5ZaWv7MVRAAEGs9BN3F2YhcV7F6SgV9bT1H1PmPYknZAqQ>
    <xme:xaN9ZKcLE1P-wGXdjQZjhFtPIQlr_CE5mwUqiw3EJpuezkxpJLGfx1JMpsGnwNtMo
    ZZi2GQhosAraVYr_Bo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xaN9ZExY6ALCIu6yuFvPJerTImw7rz-xI_-fWVnSS9_oF345oc-4YA>
    <xmx:xaN9ZINMNY8kJuY1uCtoz_2AGJlGivX3paVbx9n88MyO-9vJHfIyJg>
    <xmx:xaN9ZB8KdzsKYgjzC9-YpirU19bdxALTrR5p1_0girsej3AUrcpumg>
    <xmx:xqN9ZNTrzUdo9ANhA1SqTk1OFnDBBxPGu7HWnCe3kiR2LMqqeIaGSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66D24B60086; Mon,  5 Jun 2023 04:58:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <1108b836-38bf-4284-b3b9-82cb33509092@app.fastmail.com>
In-Reply-To: <20230602124447.863476-1-arnd@kernel.org>
References: <20230602124447.863476-1-arnd@kernel.org>
Date:   Mon, 05 Jun 2023 10:58:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Arnd Bergmann" <arnd@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>
Cc:     "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
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

On Fri, Jun 2, 2023, at 14:44, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The vangogh driver just gained a link time dependency that now causes
> randconfig builds to fail:
>
> x86_64-linux-ld: sound/soc/amd/vangogh/pci-acp5x.o: in function 
> `snd_acp5x_probe':
> pci-acp5x.c:(.text+0xbb): undefined reference to 
> `snd_amd_acp_find_config'
>
> Fixes: e89f45edb747e ("ASoC: amd: vangogh: Add check for acp config 
> flags in vangogh platform")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please disregard, this version was incomplete, and I ran into the
same issue again in another randconfig build.

v2 coming up, please use that instead.
