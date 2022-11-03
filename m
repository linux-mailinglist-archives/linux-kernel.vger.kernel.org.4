Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA883618766
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiKCSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiKCSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:22:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761D1B1D2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 11:22:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE9AC5C00D0;
        Thu,  3 Nov 2022 14:22:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 03 Nov 2022 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667499770; x=1667586170; bh=PnunbFfn8d
        27k7kspVOCAj/pWljMd5UeVfDabpVF89k=; b=dJ/uwh9wsmVVExZRBSRyG3er18
        flWHM2OZW2QUdZmN7ZPKQlWMMXlOUMH85sFmJKd0wXNUSOYRCmYNZ8wLn+gVungE
        lPLy0dad2A6GDIa3XW4Q7DRL9bHaVRAt/f6+fD4CqDqqnLjgyU2F0dUFjUcGDHng
        HRY4YomDzZUyPbB4l4F7ofjgUMtrIakD2Gxn4VYZ82vsk3Y/jXCZbhlRBJsnU715
        xr5mjo7EK1M86Ug/67FcydhiiUIjOfPMj+fFFdtzgfJuMFm0dopc8JkQNSR3XHcH
        nV05BYrEP2d2XhER6ZooWiwy3BaDqhaC+zo4YKJp0spfKA8mJoa8o9HZIurA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667499770; x=1667586170; bh=PnunbFfn8d27k7kspVOCAj/pWljM
        d5UeVfDabpVF89k=; b=or7BiqYKc9tXuNF2XG99mecxnVo8MIochELS56eaU2Zu
        qkq5nSwQ4MCSU/oeAAS+8EHWYoIJIQAbdKLqLFJhLHXtbNt8pTjv4z8vnpCz8DqR
        7EMrMG4wlhNT9Lv4lmCmUnBk5gS3jzPHpBCzTji7Y1VZaj6aDgQxt6OTXjHsqV6E
        ynvonT+btf3MErFSHJfq89Qcg7L2E6G1bclN2DltFiZsXmsf+I1WODght4+gxysp
        GT1uXTTUh45xGxa+kAOKTw03qyP0potzVg0PqyHT5JzXazyvonM7Cq5WTov/2MyL
        lSE0eaeaJEp/jZYtvN2gexDVlBYIHdESC4el81/ugg==
X-ME-Sender: <xms:-QZkYy5taNAzGCgOKjWlP7bMzB3KCHdQn6cy8LhjVxUcOqnrvc4SzA>
    <xme:-QZkY77s62AUW3kAEq0mL57JtZgQaQsx7qYZGglRFFdRJR-b7qXkpPt4YbuzzmwK3
    zzxJrhLTo-lKUjc3Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-QZkYxfZrjV7mfrB8AdUt1nSxdU4chyKBRWxxCvhS1oWm4yAiypURQ>
    <xmx:-QZkY_KElEoawhVdkyKldupsjFXNdfWpwnb5Qg9w-Dr07-G8RPRFfg>
    <xmx:-QZkY2LLCdjfPuqGwbiMT7wc9NanHw-cfETltmMA3LmrRxoepQoxdQ>
    <xmx:-gZkY4gQTNtxLfClp1MVoTMay7khfS6gfHo3Gg2qlRjHd6N15IxgIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 87681B603ED; Thu,  3 Nov 2022 14:22:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <fd442f5d-68c4-4d4e-b913-d7c6b79bb0a4@app.fastmail.com>
In-Reply-To: <20221103180845.17076-1-r-ravikumar@ti.com>
References: <20221103180845.17076-1-r-ravikumar@ti.com>
Date:   Thu, 03 Nov 2022 19:22:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rahul T R" <r-ravikumar@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, bjorn.andersson@linaro.org,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>, nm@ti.com
Cc:     "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Vinod Koul" <vkoul@kernel.org>, enric.balletbo@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] arm64: defconfig: Enable TI_TFP410 DVI bridge
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

On Thu, Nov 3, 2022, at 19:08, Rahul T R wrote:
> Enable TI_TFP410 DPI to DVI bridge. This is
> required to enable HDMI output on j721e-sk
> platform
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>

The patch looks ok to me, but you have too many recipients
in Cc, so it's unclear who you expect to pick it up.

I expect Nishanth Menon will merge it into the k3 tree and
forward my it way along with the other 6.2 material.

      Arnd
