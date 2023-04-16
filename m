Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21006E3793
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjDPK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDPK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:56:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBCC2684;
        Sun, 16 Apr 2023 03:55:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A36E95C00CC;
        Sun, 16 Apr 2023 06:55:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 16 Apr 2023 06:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681642555; x=1681728955; bh=fk
        scw5C6UtGOyo2XCy0gMeqYDqdOiGFASGsf+zxWwSQ=; b=lqGpep3svdshIMgyWG
        GEeCCPzSYF54z0m8AcOjIOOLY04FaFHhgHlOXRFFoyNVftlkUKO70Bc7jY5p5VVG
        ZDEi+u7WTnL38V3LYZdFJHdNKVL0rqVGWBjPvwfcXdXd/Gn22ZmomB9nvYDD/7H0
        AXklvYDCUxaNH/Z9lP3mbDLqyhgLKvjIuAhI2imDwUq8HhbdSZRguqwiN3Q2fyUZ
        Ggsdbn/HMkgmbZccgk4FbjXqIyoU9Xl7Nehpmz6YReA0xglON+6BvV6DEUswX7sk
        c/wO6a58oItrT7LURtUG9TtqjIdu/YKqOhlb28wAthJ73m6bemGMVjXRfn9oamD1
        ar0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681642555; x=1681728955; bh=fkscw5C6UtGOy
        o2XCy0gMeqYDqdOiGFASGsf+zxWwSQ=; b=dAnNhM18ULa8Q1Ka9OhSBawufZCBN
        XMEDAYXOBUB9vxhWXv+fDsmGchb4s0/EA0tvTWi1o3wOiTZivw6WeKK0ctFRNbzD
        +xDG/4IwpnRktsc0qVdOoMDr4Atl13inEr5IUWG5uVtacvfaav+DTWYG6BGIWatw
        oqWtCG/WMqR3mAtWJHpqej5+XO1I0U5JdqvyBL8EuvX4UCZPEZsNyfNZte+//k06
        Dlutn8rEZL2Xgyx4Radf2nTFztwn9va1K2vsLJ4k1Sd/dx2kQdxNh218HePQ5BLA
        34ro/9AaH4LxIKpvdCP61lwMSOchahPapJOldkiCG35hnz7rdqzEUI+LA==
X-ME-Sender: <xms:OtQ7ZJKjwmuSKnZPPtjLChuAtmWISIVuNsLENqQlQfv2FSJTWniQZg>
    <xme:OtQ7ZFLtYm_-Wut0XO2z2LT_2GTreKSvmsaDPoxF2E58jj67C9RK1Cew5pZJU860U
    PnEVH9V3FzADm-O5xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:OtQ7ZBsQTympyZmpEVHpW8CrF4VKH7qqz0PH9sMpHTOOXBI1VzRg1g>
    <xmx:OtQ7ZKaJ6SZozcXCFRWZUfftFbWf8dFUR4CM5Ev7qGv3hNrJJofChQ>
    <xmx:OtQ7ZAaEZnidplmVP7RIHukjp80UMbxzSPgbX3CQBTHr2wNIP3tx-g>
    <xmx:O9Q7ZGM1Hr8aQ-XbiMTPNnaoN-uA8vPH6ItE9GMUtORXdnUqBKB_kA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66DDEB60086; Sun, 16 Apr 2023 06:55:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <6785a18a-1df3-433c-a5e5-70179dab7908@app.fastmail.com>
In-Reply-To: <CAMuHMdWNQRgXzaEsb1M=SGm683dTOU2gLyjD2UuoD8qy+Ex74Q@mail.gmail.com>
References: <202304150025.K0hczLR4-lkp@intel.com>
 <20230415125705.180426-1-akinobu.mita@gmail.com>
 <CAMuHMdWNQRgXzaEsb1M=SGm683dTOU2gLyjD2UuoD8qy+Ex74Q@mail.gmail.com>
Date:   Sun, 16 Apr 2023 12:55:35 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Akinobu Mita" <akinobu.mita@gmail.com>
Cc:     "kernel test robot" <lkp@intel.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>,
        oe-kbuild-all@lists.linux.dev, shinichiro.kawasaki@wdc.com,
        chaitanyak@nvidia.com, "Andrew Morton" <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH -block] fault-inject: fix build error when
 FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023, at 11:53, Geert Uytterhoeven wrote:
>
> -       depends on FAULT_INJECTION && CONFIGFS_FS
> +       depends on FAULT_INJECTION && (CONFIGFS_FS=y ||
> CONFIGFS_FS=FAULT_INJECTION)

FAULT_INJECTION is a bool symbol, so the last part is not
needed here.

     Arnd
