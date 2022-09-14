Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7B5B8A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiINOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiINOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:33:37 -0400
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 07:33:35 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5CB2C125;
        Wed, 14 Sep 2022 07:33:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 6A99E2B059AB;
        Wed, 14 Sep 2022 10:33:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 10:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663166013; x=1663169613; bh=0UwiLm9wU3
        WSNfSxDyHppyIXzHYDWSLCX7HdL5pdjGA=; b=U8HqBi9PfsGkfsCdkrz12F+ZAc
        0cDBzVgonGcmcjSkr4ufqkTjDbFfL+iykG8prjDotuDt9xGH1BidESVImJmytVUU
        DGdHM+ct1xwQaeQ9jvRHGniTW49a4WSdOKqYuy40WAtuunl6xhqpHNkCeEZ9nwiJ
        v/apP+JayoIOeb88koFTXLQGH1GHrHSwiprrv2gPNNg1mENDVPW0bnDgTaTl3iEN
        LkJeowub6uYfqaogrZdkjwatc3N4sKVVHUYZjIqMDrTncNgoFyj1GLsAOW+Gbr+/
        DdTkNyXr5wyJbixWuW88qeU7SfwBteAJ0/B1VpfMdVq8urlk7FvnxRoXK59g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663166013; x=1663169613; bh=0UwiLm9wU3WSNfSxDyHppyIXzHYD
        WSLCX7HdL5pdjGA=; b=kY8PbjarEfWRSC0PCGKMCFhPOEFU9xjnQSuLRvepFcxi
        MDZt5RTJvqtetLam3jL7Bf60+2rUoevFWdGTOKK5CYATmXtIWuO3gj3uDnQ7JTmX
        mjh7gMEYza6vCcRLv/9XszYzFrduAi92m+IsHcQ3ghzs8JxGvfb/Y/LRqulDIKF0
        Ow6jfbDoxVBs+xyVbbNKzqJ+cgwPPLjul2S2NukfBXm7kRvm63LOXnwaLJMa1uLD
        ocR/sSBihW44Oi1QhfpCah0jXdEy630ICrVtN3Ks/lQJtlFOL2Iz9PxehI4tezo2
        wsNpnsDTjp0G/GONo1NnxGuB5lzuAQEuI+WuBtBNpQ==
X-ME-Sender: <xms:PeYhY1BXlZq-lyBD17CO7IH9CI99Pye-0rG4x254hPBM0KVMtgeHVw>
    <xme:PeYhYzgpviN6BoUgB_LQOU1LaiGnDImFMfJEA0IbAiemhm9mE8nKL89M1TIJ0Zoup
    WAngjyOlK4lApRxiiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:PeYhYwk1AJiBkKNb89UF5LFcQNV48_6gWkk7cS1dnStA73FTEy2UEQ>
    <xmx:PeYhY_wW7N7R6mGUh9ib165mLsFQ6_8JBPv9Ct3-JIFa-BFRqrpbuA>
    <xmx:PeYhY6T1v_v2n5m6QaDruKwQ42IJgb1J_8ECPQfoyB6cxqOHt7Z_MA>
    <xmx:PeYhY3RxZC-g3EuWJDHOaERaVasqOCdnWjnXyDSqda5UNjdv_HdoetjRuKo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A394B60086; Wed, 14 Sep 2022 10:33:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <0485fd4d-21f3-4972-8667-91959180e60f@www.fastmail.com>
In-Reply-To: <20220914142713.29351-2-lukas.bulwahn@gmail.com>
References: <20220914142713.29351-1-lukas.bulwahn@gmail.com>
 <20220914142713.29351-2-lukas.bulwahn@gmail.com>
Date:   Wed, 14 Sep 2022 16:33:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ata: make PATA_PLATFORM selectable only for suitable
 architectures
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
> It is currently possible to select "Generic platform device PATA support"
> in two situations:
>
>   - architecture allows the generic platform device PATA support and
>     indicates that with "select HAVE_PATA_PLATFORM".
>   - if the user claims to be an EXPERT by setting CONFIG_EXPERT to yes
>
> However, there is no use case to have Generic platform device PATA support
> in a kernel build if the architecture definition, i.e., the selection of
> configs by an architecture, does not support it.
>
> If the architecture definition is wrong, i.e., it just misses a 'select
> HAVE_PATA_PLATFORM', then even an expert that configures the kernel build
> should not just fix that by overruling the claimed support by an
> architecture. If the architecture definition is wrong, the expert should
> just provide a patch to correct the architecture definition instead---in
> the end, if the user is an expert, sending a quick one-line patch should
> not be an issue.
>
> In other words, I do not see the deeper why an expert can overrule the
> architecture definition in this case, as the expert may not overrule the
> config selections defined by the architecture in the large majority
> ---or probably all other (modulo some mistakes)---of similar cases.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Sounds reasonable. My best guess about the intention of the EXPERT
dependency is that it would be used for users with third-party
board files or dts files referencing these. We can't really help
users with out-of-tree boardfiles, and the external dts case would
be covered by your patch 1/2.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
