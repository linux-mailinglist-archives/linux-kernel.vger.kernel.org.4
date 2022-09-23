Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A935E76DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiIWJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiIWJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:25:02 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE16C74F;
        Fri, 23 Sep 2022 02:25:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7A1A3580C6D;
        Fri, 23 Sep 2022 05:24:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 05:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663925097; x=1663928697; bh=t50zxbg1je
        01zo3yx+LqGItWRVx6GNoJo4k1q5aGeVg=; b=mnD6w11k5nxhH9/kQW48EZGzp7
        5oOwVtxHS6LcB154wnimw3mI+61b/xqSLY+QBAbhAcYTfAhf1Z75Az0+dlaLASIT
        ZJxsHkU5+BpVsi8bTH2HUIo7V1gKzXNElLI3N1/3JFYPVS8S9+SZYkNXCoFYOe4U
        E+P3B+9VCSs1Gzq9UcghvFSgtG2I4ygXTbHxUNLIiTuYxIcOYOcWxI8NyvK7sHUZ
        sZXhBlaAA4PXrz2DdYp5b4nABQ0l6BU2MSTBPIB2l/cRsNLbo4Y2t3itUoWN8gCC
        9zvEFKQ5/zvH5MYV1/HQP1BDLvODbjTeYUiWFs9UYI2gAhwPyzYNJkohDNGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663925097; x=1663928697; bh=t50zxbg1je01zo3yx+LqGItWRVx6
        GNoJo4k1q5aGeVg=; b=AuZv+USLGde8oMEu1C58bKJrB412oxQvNHao8ZeMUfQA
        3toGUYt/r6EojSrXcwB0kK6RKwLEa8e92tPItzAJVadNejYiYoli5mtQtl3GZVjO
        gcELQKqq6mIy+AK5DS90bqj9AMWCr6HLIIerihmtnrIVkVOaLgbPTgESdKOLhG5S
        Cz9e8fwsXCsEZF9zc4jiXrjt8wcgokE8d36g+zCmzH3joAX9UJDzVw9tFlmBP52T
        RRlA2xQYUPVuywC6rmh5ueQJPySYTHdHddIO62mEA2531U1xP2OAR2PIDDMD8Saf
        tQyKLWOUXqZZtIl62/irkpR1v3qLMWgduT9FHg508Q==
X-ME-Sender: <xms:aHstY4szl5GIsEFYIiS2sJA_UVG8lRBrC5A_cdRWcoGzj12EVm_YAA>
    <xme:aHstY1fwySuIAyVgk3_9DwIprKGKkLV4Xd2MQ4v0q68Tl2u0Rta2YzjDse0zDj_y8
    keovKRs2RiQou6EsSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:aHstYzzXfQxH_vMDVl727RCMx_hb65deJ2mAjHwMn64_NpcF4z5tXg>
    <xmx:aHstY7P4Jxlg5fiUf627VeJ-R2e0c-P24NY8T1ocFRr8ml9FqA8mxw>
    <xmx:aHstY496vVr6AFLOsJDE2NH7eLEa9xItKfpOogRnPsV7bbwRqB-EBQ>
    <xmx:aXstYzasSKHab3iuVHBdN2X__vEhRyRwYTn5EggrEGNXyiSLREbS-A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DA519B60086; Fri, 23 Sep 2022 05:24:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <230d397d-1bf8-422b-8ce0-4a63bb451394@www.fastmail.com>
In-Reply-To: <f6a27b077f8b595e9c74152f1fa3c780@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <89f85393-c767-4c0c-90db-d78a2927d465@www.fastmail.com>
 <f6a27b077f8b595e9c74152f1fa3c780@ext.kapsi.fi>
Date:   Fri, 23 Sep 2022 11:24:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mauri Sandberg" <maukka@ext.kapsi.fi>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Olof Johansson" <olof@lixom.net>, "Andrew Lunn" <andrew@lunn.ch>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Russell King" <linux@armlinux.org.uk>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device Tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022, at 11:13 AM, maukka@ext.kapsi.fi wrote:
> On 23.9.2022 00:39, Arnd Bergmann wrote:
>> Can you use simple_strntoull() to parse the address into a u64 instead?
>> 
> Nice idea. Its current replacement seems to be kstrtoull().

Right.

> I'll have to do
> it byte by byte, right? Or what do you have in mind with 64bit unsigned?

I misread your code and assumed it was stored as a 12-digit
hexadecimal number, but you are right: with the colons you still
need to iterate the bytes.

I looked a little further and found the mac_pton() function
that I think does exactly what you need.

      Arnd
