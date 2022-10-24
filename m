Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9660B0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiJXQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiJXQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:05:27 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DFC27DC0;
        Mon, 24 Oct 2022 07:58:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E2C5C320096F;
        Mon, 24 Oct 2022 10:24:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 10:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666621467; x=1666707867; bh=+ruL8MzADZ
        fH0h/kt3SPTh8cOltz1qUh4HP72QzV2HU=; b=ZeqX8FaPU/tmJBkXz+rJ6DMYR1
        Q+dKu6DZhrcl/P10DwxGvbvXWWsAjpI9og/+JVjY56opbtyN5QmGpcN+Kht+flZL
        jfsVpD9iBuROSWJTnUPmC4PP/Bm3QuQ0H4G7Gbj3i0mlbOInVUs/ki9gomB57Pvm
        kxcuIM2rEzrSE3duvzy+UwruY9cNQBxHreYoq/ShlxSjCe8BJfBhMR68zwgT3OP3
        2H+dvWwCzD7GI+gSf6QQNeCwfJKI2NMMsUXWOX0dhktUnb9PFykODCwMn8IRgbvx
        RfkbsJPb2vda4SaRMWBTSXMOkYd9dluPR7EiKaOVenDYccTxkkKy0GsSQRMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666621467; x=1666707867; bh=+ruL8MzADZfH0h/kt3SPTh8cOltz
        1qUh4HP72QzV2HU=; b=EmTpUa0D1YsxEnTTEaBYZPUXntliGumISOv/TdLJHT8w
        vB+Xan76mdo/24j6ozcTCskZCYYbhAninlDvB9/HLSoI9dMRWe5efz0gwb2tyR4t
        tf6LshAAx5Gjt4NpJo4ckTsCWkVLOoGD1TAJ9pDEQZ0HebBGrAov+cT8rJn1itso
        Wm+xBNfUZd92ZYNBMZeiq3M+SXKzXGThHDvp5lahRkm0KEoKJhXVflv/ckSzn+t9
        7l2C5jbC0OP6JP9qQAMY4TIlwtGb6Hq9lSem6kkl/JJPkkr+hiJ1AExzlCABJfyL
        8w6/bs2MaHwBpFZlMyaK5hEVsF70n2EObYmNkaPxfg==
X-ME-Sender: <xms:GqBWY-dAs0XzHBdfio8ODBm27jqv44s_OHc04RwfIG2Y2sasUGdZyg>
    <xme:GqBWY4NIjCgGYtvctg6OW_eeOL2L6XdkGiFLblvlLez3qwgq6weUtc2OFEog-O8wC
    SP88g4MtbDicoRQvUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvdfggfdvvdevleeijeehgfdvleekteelhffhkeetledvtdeffeeuheehjefh
    gfeinecuffhomhgrihhnpehfrghilhhurhgvshdrnhhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:GqBWY_jpBLddIw3J3-M0VNEFJXKPzJOwc6XL7BmJoTD29zu6QjP0CQ>
    <xmx:GqBWY7_az1xIoVArRENz4cmvC4RPIe6M-6at5ARTo1J6ArFr6z9x9A>
    <xmx:GqBWY6uBX8ldDntR-uT95kyfmZCLtfGg_GiLEgacS06DH1W3gX29iw>
    <xmx:G6BWY3_59FEvE8P3zUPdBbFiVON51-htpjUgZnwourOA7VWFmUcASg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5A34EB60086; Mon, 24 Oct 2022 10:24:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <3e809ff2-6afe-4a8f-bb64-80b3f0ad3885@app.fastmail.com>
In-Reply-To: <d458f39c-9927-33e8-b200-51e7cc09f2df@opensource.wdc.com>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-9-arnd@kernel.org>
 <d458f39c-9927-33e8-b200-51e7cc09f2df@opensource.wdc.com>
Date:   Mon, 24 Oct 2022 16:24:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "Hannes Reinecke" <hare@suse.de>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/21] pata: remove samsung_cf driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022, at 00:41, Damien Le Moal wrote:
> On 10/22/22 05:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This device was only used by the smdk6410 board file that is now
>> gone, so the driver can be removed as well.
>
> This patch does not apply to the for-6.2 branch of libata tree. I can fix
> that easily, but I am concerned about the fact that this deletes the
> header file include/linux/platform_data/ata-samsung_cf.h, which has some
> function declarations for gpio used under arch/arm/mach-s3c. So If I apply
> this before you queue the other patches for this driver in for-next, we
> may endup with build failures. No ?

Right, that was a mistake on my end. I had tested the full 98-patch
series in sequence and assumed that the driver removal would be
fine to apply separately. I'll just merge this one through the
SoC tree then. I have double-checked the pbk3710 and palmld
drivers, and those should not have a problem like this one.
I still need to send the palmld driver, as the mach-pxa series
had some unrelated issues.

    Arnd
