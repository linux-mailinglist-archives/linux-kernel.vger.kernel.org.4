Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23B62B3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiKPHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiKPHbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:31:18 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE9B1F6;
        Tue, 15 Nov 2022 23:31:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5EFE55809C4;
        Wed, 16 Nov 2022 02:31:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 16 Nov 2022 02:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668583877; x=1668591077; bh=E7Jvxw9QD6
        996LKckctE3pdX4RULOQBfxqDk4Zxzl70=; b=UCYzRJf5/nF7KDyRXSU6qXw6m2
        h/GU0Nq4X2X7krevsnL8L2tQjh7uA+CbeT3BoQMb0+Z7hbw3YCDdZh3StmM3fQla
        L+8mrROo/hgakmB9OW4IUO3GJj1yZwqE8JnxdBh6dYzTfATlwnzoSBDzME8MyDTT
        ksd98dty5hszdERTH7aOJ9A5lXFno5oW9VJ414s4ixJyOfDjugQucJc02H/yraY7
        m8D/EpW3c4NzwprB+ZRuzHLf99xy3MLiDnSWAKTV4C7GPG6mSl+bu8j21ycmD9Gc
        RD0dwIdCqv6pAmrzjsTKMDN8jGWTAyhrPQINx0ItVtRXFZX60RtwNhaVDaPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668583877; x=1668591077; bh=E7Jvxw9QD6996LKckctE3pdX4RUL
        OQBfxqDk4Zxzl70=; b=a71ozBRnHjODiY3Bl2l8nH5zIEdMV8WQ9QLrSluipnJQ
        c+ZPC8SEZNgpWnmMNqVGumLalZNySjSk2TFEHXWBflhQXSwblMaBzCHDll3ksYkv
        12sVw0c3uZGlni/OyzVh4u/8yVkN4In+Neu8oOK44OdkRjKicMfd88Wp9JpVJsJg
        Ueg6dGTdJmIUAu1TIdA1z1xmAIOvybbmCEieBdj3cnQMBn+lSPTMlaM019IYdisK
        Y149puB9nPI8d7avw0dglZCmuP1niuRXJT042eDWdyAcew/kisksjG6M4N9UP8SD
        6Y065HA8/rCwTDOlRBmzVWQ6NmnPx8ftOwIbBKvmcg==
X-ME-Sender: <xms:wpF0Yzx92FxEviZ4rKqY1Dg_MtW2wQb6JgAnuyGBwODp2NtLbv_B6w>
    <xme:wpF0Y7RW98tAi8rBUArSO9nbjLyaioIX8LXbGJFJvmATCQJHsCnxF4urgcYuhecJH
    WOkouzlyP3ZjLEGZCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeehgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wpF0Y9X6hQ1Q0rn2n4V8MUqsEMXEI0muIoGMmjnJbHJCYDyzSuE-5A>
    <xmx:wpF0Y9iWplj5NDFNtnjL2cdlkcKiQqTlvZB06KLoCz-R_6U9mGd23w>
    <xmx:wpF0Y1AO2AU2yBr2weajsEHEiXyu1eHgd-DKgd8DWFtExHvqN5LVHA>
    <xmx:xZF0Y957IjAdhwipWoPh3GF8kRlSsqFjl4NYXgZtisTgQwYQyRkuHQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D04D8B60086; Wed, 16 Nov 2022 02:31:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <88f8d4b3-b144-4d04-a2bc-61ee30dd6ff6@app.fastmail.com>
In-Reply-To: <20221116065335.8823-1-zhuyinbo@loongson.cn>
References: <20221116065335.8823-1-zhuyinbo@loongson.cn>
Date:   Wed, 16 Nov 2022 08:30:54 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Juxin Gao" <gaojuxin@loongson.cn>,
        "Bibo Mao" <maobibo@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        "Arnaud Patard" <apatard@mandriva.com>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Jianmin Lv" <lvjianmin@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Liu Peibao" <liupeibao@loongson.cn>
Subject: Re: [PATCH v3 1/2] gpio: loongson: add dts/acpi gpio support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022, at 07:53, Yinbo Zhu wrote:
> The latest Loongson series platform use dts or acpi framework to
> register gpio device resources, such as the Loongson-2 series
> SoC of LOONGARCH architecture. In order to support dts, acpi and
> compatibility with previous platform device resources in driver,
> this patch was added.

I think the support for legacy platform_data should be left out
of this patch. I am working on a series that removes unused
platform_data headers for machines that have DT support and no
longer use static platform_device declarations anywhere in
the kernel, so if you add another instance, that would just
get removed again in the near future.

Just don't add it here. If there are users that use traditional
boardfiles instead of DT, they already need kernel patches to
add the board files, and adding in the driver support can be
part of the same patches.

      Arnd
