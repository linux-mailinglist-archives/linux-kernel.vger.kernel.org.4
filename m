Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD872282D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjFEOGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjFEOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:06:12 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA06116
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:06:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7862A3200201;
        Mon,  5 Jun 2023 10:05:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 05 Jun 2023 10:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685973958; x=1686060358; bh=vj
        Gipo9mK2gEPtbuw/KN8gwYPMoVX58vmmTJhQl882c=; b=W3bHrz7mE2YMCDQzTz
        zTUo1l4p6JGc8xJJnsCfUmzU5H1IEAS3bejpEgus17Vg4Vmx8p54jnbjSsBYiPsx
        /MjP8O0DEN+ixvJ8psSHyAR+raKkEdZhOYOA+qDNwKGjLm2dVHrbqUGHoZB62lnv
        HXwtyVBEgex91ii1Gx7Y+Kbrmjoi8Y3GNdalOJ1V9SKeDSriKlyDw6IZYbMuGD+N
        Yu/t/KHJ/Vztihw6El/Pa/rF0SLMptWUsepxB0wBr21y58gdTFtUUrinXn/1hGYK
        KSL5j1Kd3LVcam8V+zg9mlx7aDB6KlZvtOFz21a0i6YwdDWwQfjJHvjRbEIE2ogF
        7bxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685973958; x=1686060358; bh=vjGipo9mK2gEP
        tbuw/KN8gwYPMoVX58vmmTJhQl882c=; b=HD/d+9rSb4T6OLLK0sTBZTEEEDGJ9
        wOn+mt0SMmraxPndAXYc58L4jRIsbrXd811UIZDaKh9RvWKtNrUKUe94qe4cHJCT
        qy4J1xuqQsaYWgJUcHoy9jokDCy8xnoGJKccl8XH55OCubc83mvJkV4opXhh8hLu
        nR8yOLzyeNAnCn6mQ0zNmyMfvGA58b5vUXDeKmxNdsM4HH5mZ1fRJnANbIY9BR8F
        z9L6vHFwJlaLDKNm/auIyvZP0+RfXvNxlWWHkaTN9nDwUywJKIFpja3r7xY5UEvf
        ZV+pFAuzuwnf/WyCXdcU6qVTBmwIygL0zM4NDFNCLMM2kcuXXMW9iyGww==
X-ME-Sender: <xms:xet9ZBY7djPN7mWj6Ptl9eT4Yk7oKA991YrkGAHBWQSSv2YNEAEBHQ>
    <xme:xet9ZIYIq_YlJQg64XloNmXXO8xBghVAEeT4PFmYgtxX3lIWvC2-t9m24o2-iQmdh
    oNLw30JhLOWjnss4fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xet9ZD9dY7eOAwSvgacZASdX8t4bVwgzWrG-phr3AFct5LajD1XNEw>
    <xmx:xet9ZPq5DDhTpGmHtuBo66-FeAzeGIlK48OuOzfDwFyJ50Z2vSbitQ>
    <xmx:xet9ZMqPPceibRpDqUG4AhLx9dnaLIrB6ryYiBrBuTD3-avUUvLDag>
    <xmx:xut9ZIcTMG9dfGdWDo0Wi9H6kv1V959A2L4secHKpskvrw2NeAfQng>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1018BB6008D; Mon,  5 Jun 2023 10:05:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <23227e36-a56f-478c-920f-9393028f13b2@app.fastmail.com>
In-Reply-To: <3d9657dc-7180-484f-9fef-b50597571db3@sirena.org.uk>
References: <20230605085839.2157268-1-arnd@kernel.org>
 <3d9657dc-7180-484f-9fef-b50597571db3@sirena.org.uk>
Date:   Mon, 05 Jun 2023 16:05:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mark Brown" <broonie@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>,
        "Syed Saba Kareem" <Syed.SabaKareem@amd.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ASoC: amd: vangogh: select CONFIG_SND_AMD_ACP_CONFIG
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023, at 14:48, Mark Brown wrote:
> On Mon, Jun 05, 2023 at 10:58:29AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The vangogh driver just gained a link time dependency that now causes
>> randconfig builds to fail:
>
> Actually git copes fine with applying this on top of v1 so no problem
> here.

Ok, good. There is no harm in having the dependency in both
places, there is just a duplicate changelog text now with two
commits, but that's probably still better than having another
commit to revert the first.

     Arnd
