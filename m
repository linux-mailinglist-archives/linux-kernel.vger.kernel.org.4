Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1064998C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiLLHaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2D635C;
        Sun, 11 Dec 2022 23:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 738EBB80B98;
        Mon, 12 Dec 2022 07:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC3C433F1;
        Mon, 12 Dec 2022 07:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670830219;
        bh=rttVKQE2Fh59Oi8rSPm87smUTtQ1nonwIVacmtfyRXU=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=lf/+FwZgYfnc1cBk0B3Nbbal5z8ITDMvX/oBSYX3W2OPJ+sMGtIp75BCONKgOoeSN
         8gFm98Nrl4s91K03o9YWaZ6/njVcVP1u7ksYIloZzLHvhXVDff0PkIKCpgRjSWuO8X
         8+e9ccm8b5jRwSHaLS4fY9AFToEtPaFQqXFeX1vhtn8t8cOtQBRHb8Xb597WX+wYVM
         Hk/vP4PIQFJ9jbV1WVH7rkmlY2rl1MPe+pcKnICWXpW+JtIKcu7MhLq2dzo/J5JatS
         RlMTKqTcApSOjkzcHtgRfzUJfYKfbVmKC/2wV2kixWyS4UwucWtzQIGDLC750s4yhM
         3lwhb6qcCiyzA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id A21CD27C0054;
        Mon, 12 Dec 2022 02:30:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 12 Dec 2022 02:30:17 -0500
X-ME-Sender: <xms:idiWY3IbwD3IPFhgt_YaKLPIly7ldDlVHKV8zs3Rycq6jsvuJpnwuQ>
    <xme:idiWY7I3glSVgqu3Cc_31_KjbC-QPgq4vREnIzCUVsrXHp4P7usZ1NSH4rtq7rkE1
    70OwnFKgi8T23ODDu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:idiWY_v686RjNal23IbT6Eri9_KnKwC7zuvOLPhDbIsRJImmM2USfw>
    <xmx:idiWYwbLpr37rwExAXeoNIHaHPSwKYyzJvknSMY_Wu--MsuzMQLSxA>
    <xmx:idiWY-aZNzQ5UdZ8b0WTcM-jVurXSutcDYi0HTpE-ZlAO2tJfD3-VA>
    <xmx:idiWYzNBEwkyyVIvbZ7BgK9Q5v9UmFBoXRE1e3fBThRn4V1IzTY54w>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BAA7B60086; Mon, 12 Dec 2022 02:30:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <bc3d7b6b-3f08-410f-bd43-b7157419d5a7@app.fastmail.com>
In-Reply-To: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
References: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
Date:   Mon, 12 Dec 2022 08:29:55 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Nikita Shubin" <nikita.shubin@maquefel.me>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Lukasz Majewski" <lukma@denx.de>,
        "Linus Walleij" <linusw@kernel.org>
Subject: Re: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022, at 00:58, Alexander Sverdlin wrote:
> I do not read a strict requirement on /chosen node in either ePAPR or in
> Documentation/devicetree. Help text for CONFIG_CMDLINE and
> CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependent on
> the presence of /chosen or the presense of /chosen/bootargs.
>
> However the early check for /chosen and bailing out in
> early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is not
> really related to /chosen node or the particular method of passing cmdline
> from bootloader.
>
> This leads to counterintuitive combinations (assuming
> CONFIG_CMDLINE_EXTEND=y):
>
> a) bootargs="foo", CONFIG_CMDLINE="bar" => cmdline=="foo bar"
> b) /chosen missing, CONFIG_CMDLINE="bar" => cmdline==""
> c) bootargs="", CONFIG_CMDLINE="bar" => cmdline==" bar"
>
> Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() so that
> cases b and c above result in the same cmdline.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Thanks for debugging this and coming up with a fix. We probably want
to have an empty /chosen node in most dts files to stay compatible with
existing kernels, but fixing the kernel is a good idea regardless.

Acked-by: Arnd Bergmann <arnd@arndb.de>

and probably 

Cc: stable@vger.kernel.org
