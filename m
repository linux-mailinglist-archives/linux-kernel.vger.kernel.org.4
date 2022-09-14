Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9E5B8AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiINOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiINOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:36:02 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB55F132;
        Wed, 14 Sep 2022 07:35:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 8BD082B05FFC;
        Wed, 14 Sep 2022 10:30:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 10:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663165833; x=1663169433; bh=Wfzkst+YiM
        JXs5sReQh7j9lQiYxOvqzMOth3P09VD2c=; b=dtA+6ioovLXgpnsW7bHMriT+T8
        ob6iCcULhl0DryCUFjedfRzE3xsBbdbGgadlAVQ41Et76qFRqBCEJYxqTKLHFJYl
        0mJp3SooHmD8Ak+7kZ6osWjGt2E1ap29T1ijHM027l7852BmXlU6gJ8/CtVM6jBs
        StaP8gavbZhPuNkxDOsOw6TvXchoXrwgU8nFCxFYpRCewlGjxOdZ+RU0NGh39qKk
        j5pVNaEUsGKo20ThJBJF+lFh5c2oVxJcH/n6QI+HCRvCLUTI5Z446aoyLA8zyJdn
        wGwrIVOzAiYcS+AOxNasXtqqFx4vqYQW36WPLWoKvU4mok2sBMK9oqBlZP/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663165833; x=1663169433; bh=Wfzkst+YiMJXs5sReQh7j9lQiYxO
        vqzMOth3P09VD2c=; b=itBX/aQz+iZxcv3EEVV/ixil/kcm2odCbKteXE91FORJ
        F10Q6kjN0bF7iLCWnXo8b53kIL+qiogY4SmdzaSLeCOtVhgmS9WgC8pJpvxYXb4u
        1luiubes8aQfEci56/Tv/RYJZM5e7WYdF0+fub403CkBQck0eJqfKkqnIDUquP7X
        uqVOr1oZdo29LEgjRysnLwNfGW5WJ0ZRQgk9HG8WAtYgoFuNwP4BwZTBJ1GshKse
        nyXTIamtSmUlGxeaofMa/5JcY+f+fxAHPhiXnRFgzQ9dmaO+4uWz4omrQcwSpRdK
        /8vAOWsSjAqLDrD8YU1lsMAraUppR+3uY0m91jwF1g==
X-ME-Sender: <xms:iOUhYzgn43n6ijqzs0nu3UeRdGFedbOa0iK7sc9buC6ZmND7X0EYBQ>
    <xme:iOUhYwAfivpNqnWCUlHFfjD0ET_yfp_Zox3wtfHK4caoT9X9BqjhIa_etaoGbrdO5
    4E_CB5j94mCYcUqey4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:iOUhYzGLCVDNglg0bGaMDQsLRwfzSKLFHFxG_iw8WkNEm_ptpLXWKw>
    <xmx:iOUhYwS2LbvTNBEYW8Cj_d9VuXMh1Rw5K6MUBURJ0QljjWqayMdBmw>
    <xmx:iOUhYwzc8UN1nshGPQZzriYzYzleWIfvRniDPa8-mJMVeaDcvcULeA>
    <xmx:iOUhYzxpua_M0Wig_41mvemz8s8eNfDmiB0qqv8bREXQMrqoJ3p7Y0J_X6M>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4CA84B60086; Wed, 14 Sep 2022 10:30:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <ecd7e46c-4ed8-41b2-96b7-4f0a37f9d5df@www.fastmail.com>
In-Reply-To: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
References: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
Date:   Wed, 14 Sep 2022 16:29:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ata: clean up how architectures enable PATA_PLATFORM and
 PATA_OF_PLATFORM
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

On Wed, Sep 14, 2022, at 4:27 PM, Lukas Bulwahn wrote:
> There are two options for platform device PATA support:
>
>   PATA_PLATFORM: Generic platform device PATA support
>   PATA_OF_PLATFORM: OpenFirmware platform device PATA support
>
> If an architecture allows the generic platform device PATA support, it
> shall select HAVE_PATA_PLATFORM. Then, Generic platform device PATA support
> is available and can be selected.
>
> If an architecture has OpenFirmware support, which it indicates by
> selecting OF, OpenFirmware platform device PATA support is available
> and can be selected.
> If OpenFirmware platform device PATA support is selected, then the
> functionality (code files) from Generic platform device PATA support needs
> to be integrated in the kernel build for the OpenFirmware platform device
> PATA support to work. Select PATA_PLATFORM in PATA_OF_PLATFORM to make sure
> the needed files are added in the build.
>
> So, architectures with OpenFirmware support, do not need to additionally
> select HAVE_PATA_PLATFORM. It is only needed by architecture that want the
> non-OF pata-platform module.
>
> Reflect this way of intended use of config symbols in the ata Kconfig and
> adjust all architecture definitions.
>
> This follows the suggestion from Arnd Bergmann (see Link).
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link: 
> https://lore.kernel.org/all/4b33bffc-2b6d-46b4-9f1d-d18e55975a5a@www.fastmail.com/
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for the follow-up, looks good.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
