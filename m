Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291156058B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJTHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJTHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:32:45 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45A16D542;
        Thu, 20 Oct 2022 00:32:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0537D5808D2;
        Thu, 20 Oct 2022 03:32:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 20 Oct 2022 03:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666251153; x=1666258353; bh=AV6tDFUKMO
        pEg3MRX4qWR5oX2aLW/thhAYpb2YqHogo=; b=LwBqYSaIPzEagD5t3VSAH3u8bC
        GOMlXQATN5NPYHGJFRyMCdNJ3bJrRoKDlIzXqSLAARVo0XAiVZTrHleEnER1/EDH
        OInqpIPnbivBMmUN75vwdEn9cJboi5Z1O0GhbXJY/ZQ/AgfgtfeH98a9YCaXXDYz
        k0SlfSZwM7sIY1aSnSr9dZPZh2dyWqatx9j5fwh45959VUD1CCocyiAi5SXGLGn6
        QBmIQDxJx+1LTanOxN+487ZkZiX0gzMPK41B611svX/zdsgtyx8zryp+roi8z+Y6
        kAQoRkW+9j6/JT1CxWRbc0eHDwYnWe6Fa3huhOGTL3J91VnneBSZorDOHVfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666251153; x=1666258353; bh=AV6tDFUKMOpEg3MRX4qWR5oX2aLW
        /thhAYpb2YqHogo=; b=VL3hwyWdbYa9ajHTB8LAad0OFgZoCydHOUKD/q/nRXJM
        La7526Kuk9mhD81n+xvH2WUzAZfB2SNlsZKeLEPdLFJs3TLYaqAMOT1uKOoVfH8K
        L/HAgMaXz62AxNzj/wJ1JD4ITtXCJqDUEoYhL3kqSK1x4fNPxL47VxhKZdBO1nbz
        t4qEhqH/42Yltf+1hlvgrpsM1De+bD6uXlxU+we4F2UAjUqesFo+HZEM9ATayU/a
        TJc30PBOmgy5fwrN/CIwfsx6z6tOnT57f6IEqy+m4Bc5fq6OEnpF4RLUw1Q84JKd
        1C1+a4x0f0dPk+sQn6oRcfGiFlKGMYMpk9Zn2xW02Q==
X-ME-Sender: <xms:kPlQY0COucP_JBuc3VO6ui00Aeod_vY6KX2eD5gQI9Yr1DkWG3a5mA>
    <xme:kPlQY2gtxfaxEF8E0nupOggf72VxqawQyxSR0L9pyZ_JV7qHtQn9M6vY36KXi61ZM
    KbMyjKA1pB-2a_oUQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelhedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kPlQY3kdADxAHh0mg9ZEyeDNoL9T7Br6cBC9Vw3B4UkHhpWz-Qje1w>
    <xmx:kPlQY6yu9gT9-n3kSmZ9BE9kk2TNEm3ealNf0llEEScW5_OS2XXJJg>
    <xmx:kPlQY5SryijVrEYyekFDxeVLDfbY5orH6ssBHORZUU5jX_BrZwLJSg>
    <xmx:kflQY6413sE1AInazuTgiKzob_WzdVkTnkNVvnojS32tD5OKxwgvSQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6001BB60086; Thu, 20 Oct 2022 03:32:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <c7366f60-aef0-463f-9bba-f14680d820ac@app.fastmail.com>
In-Reply-To: <Y1D08tpbdE52x7hN@google.com>
References: <20221019161831.3864786-1-arnd@kernel.org>
 <Y1D08tpbdE52x7hN@google.com>
Date:   Thu, 20 Oct 2022 09:32:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Daniel Mack" <daniel@zonque.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Felipe Balbi" <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Helge Deller" <deller@gmx.de>, perex@perex.cz,
        jingoohan1@gmail.com, kernel@wantstofly.org, lgirdwood@gmail.com,
        "Linus Walleij" <linus.walleij@linaro.org>, marek.vasut@gmail.com,
        "Mark Brown" <broonie@kernel.org>, mkpetch@internode.on.net,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        lost.distance@yahoo.com, philipp.zabel@gmail.com,
        "Russell King" <linux@armlinux.org.uk>, sre@kernel.org,
        slapin@ossfans.org, "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>, tiwai@suse.com,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-input@vger.kernel.org, patches@opensource.cirrus.com,
        linux-leds@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/30] ARM: pxa: remove all unused boards&drivers
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022, at 09:12, Lee Jones wrote:
> On Wed, 19 Oct 2022, Arnd Bergmann wrote:
>
> Are you sure these went out?
>
> They do not appear to be in my inbox, nor lore.

You are right, I was interrupted after sending out the
cover letter and didn't manage to finish sending the rest.

Since Robert Jarzmik already found a problem with the
series overall, I'll continue sending the other (mmp, sa1100,
s3c, omap2) patch sets for now and get back to PXA after
we've worked out the issue with the ac97 infrastructure.

    Arnd
