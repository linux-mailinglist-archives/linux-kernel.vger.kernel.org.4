Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A0C666F82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjALK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbjALKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:25:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA86373A0;
        Thu, 12 Jan 2023 02:20:15 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 75B595C01F6;
        Thu, 12 Jan 2023 05:20:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 05:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673518814; x=1673605214; bh=XnSx3k86yn
        0WY5oxd+pkTjscw3x8idBcLq30moNhD6w=; b=dh8DS6fmkcsSsxHuD8iz/zeF7K
        YG5Ghv7dmYP+9sQZSbSZJzKNhlbznIROAgjRQUXINKR6PwK8uQsIF9GqELRlVfvl
        RfAc+au/WCDFMxs+mKeZzMudPp1Lbsrnb6UVy1R7cqbzLV0EqmyhJpV2YDzayIv7
        H4R3Ly5IKKrtQETyeniID0cVz1R9Zwe/g2gxSpQSRe6LTYCwzJ7e0RlGmPndGIki
        +LygMmVPFsITN6nSIed5gYxbIyRW59fMOl5oE3PXIQviO7hcPU/hk3KHl2Cwiiog
        LXpVaqtw2WEJYbf0VYmOzuKf6SsJJE6D2mad7CvvtX3VYytW3HfsiVx6XWmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673518814; x=1673605214; bh=XnSx3k86yn0WY5oxd+pkTjscw3x8
        idBcLq30moNhD6w=; b=cAGnQv1E43V4UV4Yqz6tu3ibCfdgHR29+TKeIgPko4yD
        JKFXJiYGJ8PW/rN0+xXEIbDZtdBZH5r3wjC30Y0+HNdv3aTGCCpUEGFq/a1hkzCX
        XLMCdX6+zPYiOb9+hZWJYrAE3jJlcFKBv0+uWeU48+Fy+uuCAXKQWJpHAG445qiW
        GbFkR4SbOCt1aJhM/y2LacCy9vtAUxL6F1dKbgQJnLqaSuX78zK9Mx+YytNq3EOt
        yBhiGgmIXJnfR7hb6c1/KH+YQHbDavFU5HehZUac/ZO3+jQgYkx1TgW6IfLwk01C
        YrUEXvDkyc1j8FhC9KitRdUiK3M2DQ18YQUUdmQtXA==
X-ME-Sender: <xms:3d6_Yz1awylVRTgwA_rJVsvGAUmxAASVBjE3QHJ5E1Mj85HgdJF5BQ>
    <xme:3d6_YyFWcqlRbKPbvOo-z3VQpuAOzovW1fjf0PYWj7Cr0jZlCfX1hFWXJ-5nI1QBo
    S0xuA6VTQcJGMTXd3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3d6_Yz6q3NowLm2aP3-4vMAF-b2sA9L9NP40AfLlx4nyT7uQTbZ9eg>
    <xmx:3d6_Y42c82rVslORf6GslnFxkRjWA5D-4rCypR7Gli2_rSerSYGgMw>
    <xmx:3d6_Y2EaoDzruOLauhLHuzoYKtGhBQst0YC6yIlYiY8JU9hXwqgbmw>
    <xmx:3t6_Y0aeIuco_8XKFARyNN3ALu6l-TnmLn6Ov-FFCKfjNqVlP1WrHw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75878B60086; Thu, 12 Jan 2023 05:20:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <c9821df0-cd3e-43a0-b903-430d1251d51c@app.fastmail.com>
In-Reply-To: <Y7/YiMPIDN0Cf5Ky@atomide.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
 <Y7/YiMPIDN0Cf5Ky@atomide.com>
Date:   Thu, 12 Jan 2023 11:19:53 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI support for
 OMAP1/2 chips
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 10:53, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [230112 09:03]:
>> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
>> > Commit 0fee2eac5c2b ("usb: phy: remove phy-isp1301-omap driver") removes
>> > the Philips ISP1301 with OMAP OTG driver and its corresponding config
>> > ISP1301_OMAP. The drivers, OMAP USB Device Controller and OHCI support for
>> > OMAP1/2 chips, with corresponding configs, USB_OMAP and USB_OHCI_HCD_OMAP1,
>> > need this removed driver (see "depends on ISP1301_OMAP") to build.
>> >
>> > Remove those two drivers.
>> >
>> > With the config USB_OMAP removed in this commit, remove some further code
>> > in the omap-dma header and mach-omap1 architecture code.
>> >
>> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> 
>> This would be a great cleanup because of the simplications of the
>> omap-dma code. I had previously looked at it and concluded that
>> the driver is still in use though, and I think my mistake was
>> just in the Kconfig part of this patch:
>
> It sure would be nice to drop the old custom dma api in omap-dma.c
> while keeping the dma.c in arch/arm/mach-omap1.

I see that four out of the five remaining board files still use
omap_udc, which is the only remaining user of the custom
DMA interface. What I had not noticed earlier is that DMA support
in that driver is actually optional, though it's hardwired
to be enabled.

So if we want to kill off the old DMA stuff there is actually
a choice between either making omap_udc PIO-only or converting
it to use the standard dmaengine interface.

    Arnd
