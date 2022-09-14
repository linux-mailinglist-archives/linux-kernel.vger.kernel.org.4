Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D875B8978
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiINNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiINNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:49:13 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55A65924B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:49:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id C34082B05E66;
        Wed, 14 Sep 2022 09:49:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 09:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663163351; x=1663166951; bh=rHC0R1uWCT
        vHo0njot+yizSuN1Uq7u3C4tmft5uzYXA=; b=KSARzjhaYTx5DnUZoTr5dr5qtg
        eqQjU8FvDxvi17T+67z+1/c5CMlqFP4qu1vtNOgFs6P5YyjsQ7xQmdbOZmxvChlW
        4TvEpFwnAiD+e9YVR5N9QtR5un44cXQltZ/aCiTHJZBRVO6vwlo4i9e6pa1jHYBR
        oAHaui7NzZ6G8pXuNr42WjniNB7qSptbu2ANzHoRXar+TXxvj34+BDmdtN+brQ7o
        ktslDXQns5TVsCnCeGAVWvDrJnEsEhsMalQ3gFbrUe/Fzgo1PgjgIxaYpglABDRd
        YlVUlDvZx/eHJ2zthH3eIayLcj+brzYEjI96Pp3pQW2glBZ10m3ywDoUgdvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663163351; x=1663166951; bh=rHC0R1uWCTvHo0njot+yizSuN1Uq
        7u3C4tmft5uzYXA=; b=oL5lznS7eYezjkhP2npyEtyeQ6xgZVVQCSO5O2Wl/7mi
        W3lR86JS3EPNokAEZ3NrsZBYvuakjCvt8J3fT1bY7OPMGx/62I9oQQYCFkvLwACM
        nldr+CrNTi0WjiAbpbEzQX1yxHvBMRLAYQXzAudMggfVuP1SFkCpDOjAv978h93M
        QeBdIcl/+v6wHh5808hv4ecnBl2GScBaJhAW0kXQmKiW5xkZw3sbzIOlXCtJskGy
        OA4T07zCK/m3qJCnUT+s/YjYpHgFNbk6A535lYSp5LivmZWPtyJqISrJKU+bHc/u
        /s7+aeezWL6DUfSFD4RpJnqcEQcpIo6EiOJxYsLSWg==
X-ME-Sender: <xms:1tshY5glAl1ZyEagiRvnOX4-uu3Dwd8kNXciDJQcbgGkIC9a1SAKOw>
    <xme:1tshY-Ctxkdb6yHLkePfwPTpAEprHbtlRiEcWs_F7pryw2_hCz0UFvxDyQ4-JOqL9
    3CSLbXfKLshASnaZXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhephfdtlefhtedttedvtedvueeugedvueelueduvefhuefhuefgvddtveevvdff
    hfdunecuffhomhgrihhnpehlihhnrghrohdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1tshY5Ggr5HzbtyoDZD8ah5bHFVLdsr5OuNn90dmMsSfT1Fv49b2HQ>
    <xmx:1tshY-QPmdpDs16zzVpnqo7hH9t3u7u4IFK7qYNnOkypwCRxwEqiRQ>
    <xmx:1tshY2xg5jHAWCXD3lPBGFT1lyj763sFtB1AhW9G-y-ruewzD2CVng>
    <xmx:19shY6_TsSlg2wHmlJk_mt5G4MbAJdY2d8rBHmV7v1r79vtNzLm8mbpmPfc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1900AB60086; Wed, 14 Sep 2022 09:49:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <97b5728e-e8ed-44a6-a777-a7f56370761a@www.fastmail.com>
In-Reply-To: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
References: <CA+G9fYsaxK30=z0vBcNW-NRVHHkWxaoSNDt1bE-mfXQquMONKQ@mail.gmail.com>
Date:   Wed, 14 Sep 2022 15:48:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Naresh Kamboju" <naresh.kamboju@linaro.org>,
        "Tony Lindgren" <tony@atomide.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org
Subject: Re: x15: kernel crash: LR is at sysc_enable_opt_clocks
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

On Wed, Sep 14, 2022, at 2:46 PM, Naresh Kamboju wrote:
> Following kernel crash noticed on arm TI x15 device while booting the
> mainline kernel 6.0.0-rc4.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> [    3.059600] random: crng init done
> [    3.059631] 8<--- cut here ---
> [    3.066101] Unable to handle kernel paging request at virtual
> address adacafae
> [    3.073394] [adacafae] *pgd=00000000
> [    3.076995] Internal error: Oops: 5 [#1] SMP ARM


> [    3.781494]  clk_enable from sysc_enable_opt_clocks+0x4c/0xa0
> [    3.787261]  sysc_enable_opt_clocks from sysc_probe+0xda0/0x1598
> [    3.793304]  sysc_probe from platform_probe+0x64/0xc0

So it's getting an invalid clk pointer in sysc_enable_opt_clocks.

> [    3.798400]  platform_probe from really_probe+0xe8/0x41c
> [    3.803741]  really_probe from __driver_probe_device+0xa8/0x20c
> [    3.809692]  __driver_probe_device from driver_probe_device+0x38/0xc8
> [    3.816192]  driver_probe_device from __device_attach_driver+0xb4/0x130
> [    3.822845]  __device_attach_driver from bus_for_each_drv+0x84/0xc8
> [    3.829162]  bus_for_each_drv from __device_attach+0xb0/0x210
> [    3.834930]  __device_attach from bus_probe_device+0x8c/0x94
> [    3.840637]  bus_probe_device from device_add+0x3ec/0x924
> [    3.846069]  device_add from of_platform_device_create_pdata+0x98/0xc8
> [    3.852630]  of_platform_device_create_pdata from
> of_platform_bus_create+0x200/0x4d8
> [    3.860412]  of_platform_bus_create from of_platform_populate+0x9c/0x138
> [    3.867156]  of_platform_populate from simple_pm_bus_probe+0xac/0xd0
> [    3.873565]  simple_pm_bus_probe from platform_probe+0x64/0xc0
> [    3.879425]  platform_probe from really_probe+0xe8/0x41c

It looks strange to recursively go through simple_pm_bus_probe()
here four times before getting to the ti,sysc driver.

>
> Full test log link,
>   - https://lkft.validation.linaro.org/scheduler/job/5508159
>

What is the easiest way to find out how long this job
has been failing, and what the last successful build
was?

       Arnd
