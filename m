Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B026F4347
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjEBMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjEBMG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:06:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB1910E3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:06:26 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 24F6632009DD;
        Tue,  2 May 2023 08:06:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 02 May 2023 08:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683029185; x=1683115585; bh=e6
        ZpoB4EKtL/wShRyscPzqJdGs2mxQsMN1Lh/8d4E30=; b=ckQke21HMY4mSKIz6w
        tifP9N4h5GAXJQD74T92ecD8JtaYIZblUcRVPbgz3CR5luxK38BHnWhW/gHpYBeI
        f4J+4iFVqPRMzKj7co3GUhuWdgb/3gtp6yvJVwcOnlle5aiDxj+lWoi2fENoJ2aC
        RpU9XtUb4uOFTVF4JMFDPIP9V4UmIP6GMGguTFnJCN5risx8s5zikcM3zHWPKzXV
        gYoVAiub8feAqK+nWGYxj3RAXcRQ4SV4lVYQJfhAw63aOslNO7xeYTYF5a4jlc3U
        +xqDG5TWd4BhJ9xNKTImfnQ8WhISyq4VzY+hRkgyTyC45olS42FKIcvKEPT5V4lX
        VxzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683029185; x=1683115585; bh=e6ZpoB4EKtL/w
        ShRyscPzqJdGs2mxQsMN1Lh/8d4E30=; b=Kw2b0muo+ym3ZjoIKfjDP25rCamue
        u5mhlpv899xcPz9cnUIm7cd2UkWPqRBPnuBVtP2L4RBIHLykg1ORNupVV2XV3DNf
        YSA/9+VlvngWkquGCj8wVzFnD/j9rKlPXC1mOaeS1jdaVd5u8/pLWK72Le29bi0G
        +sOJBRNNA0yHsYmfI7jQNc+d6oaG7BE5MZJ/YHD1xWye8T/SflkQ2ihhw55VT/wz
        mRV/H1s7WV6G9fmqY2n63C69aHUzbVu2+yVzbWMVpx/j8dkzztglh6dzYpp9xM2k
        TYOkx8l5ZQk2AkiheLQjGv9PFwlfmi8+HUDR4PP9sjNaVmCvrEnHSHcgA==
X-ME-Sender: <xms:wfxQZEIXF84c8ER4jQj5Awtc1Aix5qUNudKsbS6QrWOTD95z-rnuPw>
    <xme:wfxQZEJPiHOyULpe6_hCzwtpB6U3k86u54XUsXxyXUWmLqTNm4FidXESCnctYxyCQ
    OLjBfcZmdJiALbwDYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedviedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wfxQZEtjd-w3p4v_0SC-4cv5kGIIC1T2stR0dbhWChcJTwC4lysRdQ>
    <xmx:wfxQZBYVEspgIsTdWY3uDvEXysc7HqxzZ2pCBoVn7ybQAdRAoKhhAA>
    <xmx:wfxQZLaCMAnBW-4XoxpGShs34xKLbWyGWdj9KdFnrc7Yjge0ZEGU3A>
    <xmx:wfxQZCxt8hijL4O52EEIEwx7AcXFWjSppA7Kuc5Hqoa-oyK9vL47kg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E013B60086; Tue,  2 May 2023 08:06:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <fd95ebb3-80be-4449-91f7-f47f8a60f420@app.fastmail.com>
In-Reply-To: <20230502102041.1418397-1-p.zabel@pengutronix.de>
References: <20230502102041.1418397-1-p.zabel@pengutronix.de>
Date:   Tue, 02 May 2023 14:06:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [PATCH] reset: mpfs: select AUXILIARY_BUS
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

On Tue, May 2, 2023, at 12:20, Philipp Zabel wrote:
> CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
> with 'select'.
>
> Cc: Conor Dooley <conor.dooley@microchip.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks for the two fixups!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
