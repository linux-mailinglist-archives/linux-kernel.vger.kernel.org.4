Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAEA64E81E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiLPIZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:25:06 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5169120A0;
        Fri, 16 Dec 2022 00:25:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 38AEE320024A;
        Fri, 16 Dec 2022 03:25:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 03:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671179103; x=1671265503; bh=C4AE13Q1vq
        ynMIdifRw1TSUR9jldWPJda3LvsUqHS74=; b=aYEaZVHP0vIKV0HFkFdbByykac
        YC/eiNTz/VcrFZEbIGJLVcLR3NZK3mW8gABnN5mtpvD2eQ3EevW+vlov0yo0Ve3v
        wexkKvK9IlfT611VdtoNr8EAqrmAqPsRjaKJh2C5Dcx3PhJ7arFC2kJZ69bJOCjk
        egLSCFQwq2NF/tmYa9WO7KRm+0/RnTxF4fnPUGK72JkzTzZ4tCnofGx6yoPckBsr
        RFwn9PiqhYD7kPriJwIhDvn5dxTREjGhSxwNaqKCOvASp3oi2y+f7PzDbq8bQeTt
        ohR6YDKA6QctlIYETjmxNTjWok1OC92prm33ugm47PNUSVYrK/YCxBRmEaKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671179103; x=1671265503; bh=C4AE13Q1vqynMIdifRw1TSUR9jld
        WPJda3LvsUqHS74=; b=njoQYOd4YEzKdVo2HLPwXxO2CaeFdl3/xvY8oCxQ0sXb
        b6y4DP1Cts40eaPdC12+7aI/aRfLuFwiXGSGEDnP6lo7ryonFDjcuekMi4unGfko
        MhYC9GXIP/eFe6gICpyi0FXfINsjLWcZvt6qCJcUOjkSjYZN5u+Ts9MkHRTogfBB
        h5Jb4xer+2meXTy5G14+akKFH9c9JwNxP0cJAk/fF7oX9fNFB5zjv4FoG/KBKEAY
        vrDUCI8RBs+DFi0V1P3w8LZYqMR705PIYIs2DSfRVYgrNtmVMlIVUNgv2evkftQa
        KT2XtGoT9WGgVomgQ0QfPLpt7MhiMEdTVqoUqf4tsw==
X-ME-Sender: <xms:XyucY9G69psmeuB0obP0c5skYtzD4pQAgWUwQAWmoiC8KILd9pLmIA>
    <xme:XyucYyVth9Lozo1jzJ-Pr-GeNskKyNd4-fkKvAWOZqXKbyczHYTRYQ7WzVy7tRUvj
    goNGY2crDgop-bEZiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XyucY_IONfuLcQojQx8Yn117mWx3h_vShIsE5HYHA9cjqxC85qSseg>
    <xmx:XyucYzE1AInOd6utLvFJPhI-UNVmJJ61-RupqS1M1Xd2iHYntvfqnQ>
    <xmx:XyucYzVwUEj7qXbzoScEEXYLJk0j8hYHl9exzV9pKAMaMDZTSI1czQ>
    <xmx:XyucYwVJJtGoIVIJ7bCjtcaSH5wNHF45Nq5BaLrZheM5uqhMq_aR5A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 18EFFB60089; Fri, 16 Dec 2022 03:25:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <abb5af81-0f0c-4457-9562-8f29da4c85b7@app.fastmail.com>
In-Reply-To: <f7f57361-8a4b-00e4-57fe-0ed103ddb10e@gmail.com>
References: <20221215165836.2136448-1-arnd@kernel.org>
 <f7f57361-8a4b-00e4-57fe-0ed103ddb10e@gmail.com>
Date:   Fri, 16 Dec 2022 09:24:42 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jesse Taube" <mr.bossman075@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Abel Vesa" <abelvesa@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Peng Fan" <peng.fan@nxp.com>,
        "Giulio Benetti" <giulio.benetti@benettiengineering.com>,
        "Dario Binacchi" <dario.binacchi@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: fix compile testing imxrt1050
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022, at 21:15, Jesse Taube wrote:
> On 12/15/22 11:58, Arnd Bergmann wrote:

>>   config CLK_IMXRT1050
>>   	tristate "IMXRT1050 CCM Clock Driver"
>> -	depends on SOC_IMXRT
>> +	depends on SOC_IMXRT || COMPILE_TEST
> Not sure what COMPILE_TEST is but,

The idea is that you can enable the driver to be built in
allmodconfig or randconfig regardless of the architecture,
to see any compiler-time warnings creeping up without
having to build an imxrt specific kernel.

> Acked-by: Jesse Taube <Mr.Bossman075@gmail.com>

Thanks

   Arnd
