Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C18620E3E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiKHLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiKHLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:08:16 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FAD47309;
        Tue,  8 Nov 2022 03:08:05 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A2CE35C0217;
        Tue,  8 Nov 2022 06:08:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 08 Nov 2022 06:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667905684; x=1667992084; bh=U2YniFrngs
        ovR3GGMHxDGF+HfkbcgWA9nLVRmjP0B74=; b=DLZAbHIDGlSTqD5S6iR3/gtAx9
        eQPOYkplcG08hQDSgSO1gFClIBZ2sG7HpVUj8MRQGSvwr3uX0nWzeaIFqs9BtSV0
        K6Cha0JZ4bLdlWYZtF6ytoLIqWDEAsB53CrO86XXr0e0n4Og2B/pQ/n6T7NguH3n
        ZgVhYysiE3e4IahkP7qciaGtVZyg9P1WwqW7kx8iewWSD47Jt1S4eLTkeEpd8aX9
        JaPh1OeythbWk1w12UGaD65Ah+DzjDVwXD8CLbRxEe/uwEp9nH0Prj5TDfdsKBL5
        Yfh4kvAiZbUIr3vxHNd51QMOjzK2H0RU5uQXZ1J6MLcCMmmIVHYwj/nva7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667905684; x=1667992084; bh=U2YniFrngsovR3GGMHxDGF+Hfkbc
        gWA9nLVRmjP0B74=; b=guo9ieRqxDkiVbCiCXSD12kJW79DrE3/LFbw76BjvFvM
        4OUzzLIX/dE07AIH0AAWU08egIJQ7ch32xAxGofrymLafOsbRHhjUIm6a37pPDpN
        cDBaSFbbAsIqzSE4xu+gr1WZz1z5xll+m+2Nz1MIwlbmQrPNIRaf3M78dqVb8BMS
        7H0hoZXWFqBNHFOY0yPXyHvr+V9LJl+7ivf4A8RpAweUKzOnnuPdFMfl/ozcfgfb
        vZFukuUffMCdMmegB0y0oBbl/qKMswvuwxEM/h4DNixcmQ28IpJiYITK/WJfUH85
        Zz3R7bPMFAlGHL9EyuPNhJ/cLRA8yg/NV+iBArsDQQ==
X-ME-Sender: <xms:kzhqYxSRQqupIpfPXyXLRHQN-f7Swmt-t-SiPLc9Qb4nbBbka45vSg>
    <xme:kzhqY6zZFRhJJTTEe4plBs6MlVt3yMnZ608f1Xn2QSqDkT3aN7jwyrqSZ0DPJbQ_S
    QVPa-wKNwbdLTgtfLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kzhqY22OzqwTPxWzlMhHiKqQ446U1FI1m5Yy45A9NbLjmnv4P4SJDA>
    <xmx:kzhqY5D-Rz_VgQ94AH2kjcL5y74K5vL0-T2cPdBJASFgYgnJexgiaA>
    <xmx:kzhqY6iHYGkZyYz5fovjzvcwG5T3IJmkEi9PqQopFjxW3ERDXIBujg>
    <xmx:lDhqY1TFWSNJsWkhZe0ejtZAEljf33bOXTw81USZ4MUxfDl5OYgWUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 84808B60086; Tue,  8 Nov 2022 06:08:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <d5f29c86-4bd8-4550-971e-4e941b1099f2@app.fastmail.com>
In-Reply-To: <ef5d4f48-71b9-2d5c-37f4-7a029a32a41b@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
 <20221107071511.2764628-8-Mr.Bossman075@gmail.com>
 <d293e410-223d-4baa-ba6d-65bc11ab1e55@app.fastmail.com>
 <ef5d4f48-71b9-2d5c-37f4-7a029a32a41b@gmail.com>
Date:   Tue, 08 Nov 2022 12:07:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jesse Taube" <mr.bossman075@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>, aisheng.dong@nxp.com,
        stefan@agner.ch, "Linus Walleij" <linus.walleij@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Russell King" <linux@armlinux.org.uk>, abel.vesa@nxp.com,
        dev@lynxeye.de, "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 7/7] ARM: dts: imx: Update i.MXRT1050.dtsi compatibles
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

On Mon, Nov 7, 2022, at 16:09, Jesse Taube wrote:
> On 11/7/22 02:44, Arnd Bergmann wrote:
>> On Mon, Nov 7, 2022, at 08:15, Jesse Taube wrote:
>>> Remove unused compatibles from i.MXRT1050.dtsi.
>>> Change GPT clock-names to match documentation.
>>>
>>> Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
>>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>> 
>> Can you make sure your changelog texts explain why you do this?
> Yes, sorry I wasn't clear.
>
>> Are they fundamentally different from the devices you had
>> claimed to be compatible with that need a different driver,
>
> UART and SDHC had drivers added which are better fit.
> The GPT binds to imx6dl which is also the same as imx6sl.

Where are those drivers added? Looking at linux-6.1-rc2
and linux-next, I still see them use the same drivers as
the original ones, and listing both strings would be the
preferred method.

>> or are there drivers in the field that bind to the wrong
>> string first?
> I don't understand?

I mean if you had run into the case where you have
a driver that misbehaves when the fallback string is
present in addition to the most specific one.

     Arnd
