Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1E63253A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiKUOMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiKUOMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:12:09 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BF10B52;
        Mon, 21 Nov 2022 06:10:37 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 44ED9320094C;
        Mon, 21 Nov 2022 09:10:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 21 Nov 2022 09:10:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669039834; x=1669126234; bh=9s+DXLI+Hb
        x/B/6YDBP11EG9UqS+8JStGzB3yBGNtHA=; b=MFC5ZKFPua3CFuXVvvvIUKF8fa
        baC4PZdV3Ruxk4YdpdU/mh1HYpaHG28FI8CwzW6BuMNS0DanOPiLMclTP7WZ1ifb
        3PK3Q6RyoKxQM/7280zPQROaCPB+1OW4oZxw5wWYVGJG7k2Sl8G9J07gQgcBdJfp
        jfMQMhALezUtzEiu5lD/cG8/E3SqnpSL+GCSh9gLXsZJ0BJEEJ0BwIE6PmkxGiTR
        6dKlzS8gVM3T5hcB2l+uYzBS0DjEs49d0s4BIUMw0VvgLpa2LFAW3UpI6QGJUOFU
        0FCoQygSxklHP3gcvFFKeYBMu2mtHf096EEgy/rr9OB2APhoDDnJ03JzoT6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669039834; x=1669126234; bh=9s+DXLI+Hbx/B/6YDBP11EG9UqS+
        8JStGzB3yBGNtHA=; b=OwnRDnsb2FmDzD8qqOmFN+o5D+MLuLyFu6nGrdJCzwK5
        7q02zwiOwmo0fnE9DI2i4QfwZxfxpbfgAUUyYkFExKFKs0zxsRXSc/LcCgDYnEDr
        9SAO4d6+cyvMTQWpplK+LFkV/ap0SnEvWcDpIVdbRanR416J4LCWSKQS/BftdRfx
        TMtJ8Gz5En8G6mkrpZQWVJ7uUnyyJDDADk+hmIrH3JPyUTo1Gy9Vc4NLCJnWLi79
        uCcWLFlMIqheGvcgijn6jdkW0j1xnGRP0vJ45L3scMAKGmjf4n/MM3mGlLGL1vAb
        es9dXhAJZ90Cfjuew/cT0/fR+WGK6iTEJFDmOIoCkA==
X-ME-Sender: <xms:2YZ7Y9R4maAAVO6ukonhkujMKQmMf88Ln4OqgCmm3NWT0mHZYb_RBQ>
    <xme:2YZ7Y2wGTcczvribjjw9maZaINuaQU9vyH6jG5Yl7JpDoDpqhLnMcQo6hM8mXa2Gz
    9uYVLQPpuL7RND77vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2YZ7Yy0cgZpLWBotX4l122zHMRQCpepBod0cCyv6TWHbm5CkiHzQbw>
    <xmx:2YZ7Y1DZqAwbkR8g5YX3Uj03xvyJTKCoopTW08rjwSEhOC_atMIbOg>
    <xmx:2YZ7Y2grJglLNq5_l9wpbp8Y5ocui-AnhlSQdZCm4Jn0FJJK8eRGoA>
    <xmx:2oZ7Y-djdVN6sBAmMfM711oBnulePCyuNxoq4eZMqVT8BnPp_2qiHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 88546B60086; Mon, 21 Nov 2022 09:10:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <0189f057-0433-4397-bb9a-f8fb76ab265b@app.fastmail.com>
In-Reply-To: <20221120003930.23846-1-rdunlap@infradead.org>
References: <20221120003930.23846-1-rdunlap@infradead.org>
Date:   Mon, 21 Nov 2022 15:10:13 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Qin Jian" <qinjian@cqplus1.com>,
        "Vincent Shih" <vincent.sunplus@gmail.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] ARM: sunplus: use %pap to print resource_size_t
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022, at 01:39, Randy Dunlap wrote:
> Prevent a printk format warning by using %pap, which is designed for
> this purpose and can handle any size of resource_size_t.
>
> ../drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
> ../drivers/rtc/rtc-sunplus.c:243:33: warning: format '%x' expects 
> argument of type 'unsigned int', but argument 4 has type 
> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 
> 0x%lx\n",
>
> Fixes: 0aa94eea8d95 ("ARM: sunplus: Add initial support for Sunplus SP7021 SoC")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Qin Jian <qinjian@cqplus1.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vincent Shih <vincent.sunplus@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-rtc@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

>  	if (IS_ERR(sp_rtc->reg_base))
>  		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
>  					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
> -	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
> -		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
> +	dev_dbg(&plat_dev->dev, "res = 0x%pap, reg_base = 0x%lx\n",
> +		&sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
> 

I would have picked %pr to print the resource, but hsi works as well.

      Arnd
