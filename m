Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80666772F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbjALOk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbjALOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:39:49 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876B853701;
        Thu, 12 Jan 2023 06:29:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2C5D0320097C;
        Thu, 12 Jan 2023 09:29:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 09:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673533772; x=1673620172; bh=AhjbbWm8r+
        Pw4BQBEtEyFPfrXz0EzGlo++1xsl3ewec=; b=S7WnE5qnpG6GUsRr7LUFNqHKbg
        7HK10LzSf0SlJqdBvA2m6B0MqCERAzJHqFCnnbSryhvnYMsBDoj22WSxVwKfCiTf
        1l5gKwsF1CPnQ0qlTRRj6IFPkG9rMcUTLrxC+3AkVBnwmGJZShp8/Sdlw0tQtW1v
        RzBz0XeO8lAmkYIxqlKQ6jWB+lkcBCp1Y/Fp0f1ILQ1DW8LJoUbpz+Ql9qONrriB
        6fDPmMt2n9It7YkTG8vUiiSkM9DZUvRZny26E3HKGNfHwG4AJE15uu9n3Ts/yDuz
        1u1qbry2g+MdBM6SwsY1GcsEEgkzMdGERrdNsqo5BDoG3Kyd+drpcTn1P7Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673533772; x=1673620172; bh=AhjbbWm8r+Pw4BQBEtEyFPfrXz0E
        zGlo++1xsl3ewec=; b=iC3mvF6Ntfdvnv/henI2GNUtYvh9Mq5M94nC2lBq3Ipt
        h4W/W4kwovxVS9kcQvE0Ke2dB+G+MxJMBFVH0vvDlBRl4j2bUF0t+E+RTDl8hoEB
        UpW7xclTDsQk8QB7z7bZCwSOT71aTRg4mEfGCccm4i/ynG1Jggn46BxXJEqwsB8O
        RbnxMjkAIEtrvppkEavRE/S8q4GrWE5uOFQ6au2Dzuvhrkz3Ap3Lk3JZ6t55k1bD
        WDCc3Fygam36uLYsL0EyAAiPVIIyVO0isGnmej0oH3iP2dS33ifePdt5aRrzSYHe
        BB+KLrNbXsQg0XfdQJdwGqDhPnE1Tlp6LRT0Ur8oRw==
X-ME-Sender: <xms:TBnAYwBvPQBCQzgpWyGVBQ2vM8WM32xxXG5lFzUmeiEsDnd7Dim78A>
    <xme:TBnAYyhf2OeVwaUAVgnzUM0B_Ob4ZAVSGjJqhYtuOi8Es8YrktOJjwB2Bykcnxw1b
    IFeS7mpFdpW-N0wuHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:TBnAYznM3nwi7kT9G9wjzPs7Qoov7IIUvTwYxOaxlJRZpgt6_dBbaA>
    <xmx:TBnAY2yWx01JLM1NYFAAOmMna6TzpWGj6bZ1MzTNWMEbSCEldMC7aA>
    <xmx:TBnAY1TY8_7botTyu5J2oLw9k07p4BzV_h7tzdKWHGI7xbOvxua79g>
    <xmx:TBnAY6InEbqIfwU6muYiODHMeiqlT7mtKzzU4968LebyMY0Mr9SAIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8E865B60086; Thu, 12 Jan 2023 09:29:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <8171f4a5-d5ec-43e3-a6df-5a3965c87479@app.fastmail.com>
In-Reply-To: <20230103213844.GA216540@roeck-us.net>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-5-nick.hawkins@hpe.com>
 <20230103213844.GA216540@roeck-us.net>
Date:   Thu, 12 Jan 2023 15:29:10 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Jean Delvare" <jdelvare@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Russell King" <linux@armlinux.org.uk>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/5] ARM: multi_v7_defconfig: Add GXP Fan and SPI support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023, at 22:38, Guenter Roeck wrote:
> On Tue, Jan 03, 2023 at 02:36:53PM -0600, nick.hawkins@hpe.com wrote:
>> From: Nick Hawkins <nick.hawkins@hpe.com>
>> 
>> In order for HPE platforms to be supported by linux on GXP it is
>> necessary for there to be fan and spi driver support. There fan driver
>> can support up to 16 fans that are driven by pwm through the CPLD. The
>> SPI driver supports access to the core flash and bios part. The SPI
>> driver spi-gxp was added previously to linux.
>> 
>> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> This patch will have to be applied through the arm tree.
>

The patch looks good to me, please send it to soc@kernel.org
(Cc the interested parties and lists) for inclusion, I'll
pick it up from there.

     Arnd
