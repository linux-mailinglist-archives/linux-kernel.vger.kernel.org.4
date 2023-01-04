Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481A65D3E7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbjADNMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjADNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:11:17 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00238AF3;
        Wed,  4 Jan 2023 05:09:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 63C62320091E;
        Wed,  4 Jan 2023 08:09:11 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 04 Jan 2023 08:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672837751; x=1672924151; bh=sW
        97sEIph+hgvFghJa+u0wBCf7AiPUYeQdDtJ0BUk6c=; b=hE19vYa45oYCigsNdz
        PXnGM8k46ZlLPD1vWz7V9kusPHwzNr0i3KR3PBAdkA8wCzeTR6KoYqLS1YoU33Hh
        rGwsh7G8fTJPRHwH6oq+gGl81WB8XhbW50t9pJO5aRyPe1/FIuNyz02b4rr3oNSr
        UQ75Uffrr7Mc/7dZkdTIW12dx9tb1OjmmkQOg2302FSqTRQ9ygDP1KWI3cGx6Sba
        +5xs5zNpLd/sSoS6CYljQhAWdT3gJspPS9wxvOEZSqBIA+3lE/gDBjq4wrx3Nq0M
        sm+qQ3i643Ux1c3aisS00saZZ88QSpI53i/wQUl7j5yiuPsckZ/2YqpG7Dt77Itl
        5axA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672837751; x=1672924151; bh=sW97sEIph+hgvFghJa+u0wBCf7Ai
        PUYeQdDtJ0BUk6c=; b=YxnUHEhiKcb8lZ5UjzCdfW4EqEjQubucJO3YTDJwxGK+
        dCDPx1Yia2YciL2zdof/aWicGBZqsENFN5aIz1OMVtGKQwPYh3ALXt+s/f/I0SE9
        1E/uDnq4PNpvdkQkGPeMTWQ/xoL2dxGKEb5zuZBch1Y12/NEMKoSnzE189zmjKZ5
        bYqQ/ZgLOq7hihySC4j+DMKtgioPR0NOs43mHBVM16Dpao5nUChPV57CLkPk1HjK
        eDuVMkhLo844Bj0Wbk1T4/rnAAyTKrayqW1kqjdotRxFQYpeRAsLBnJ08CGaMWxj
        +eARmJ0NYSnjA0f78gGs4rdYjfQAl+ejlh5kVdTwRA==
X-ME-Sender: <xms:dnq1Y4xbEsBi_ZZyK8aqYryYMZRzpiqyuK301GmvIvJgYnY5VTyRLA>
    <xme:dnq1Y8TeFluo6wHZtCGgxausyZ8AtX00ps2Tx5XiP7MbPbFUf_icxQqTuaxuJfrkp
    TgmKltpjuTc47CNEuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:dnq1Y6VJ8aA2FhvZ6dNUS1QbWMTUw6TRSDw1PGPDrZEX-9Fg4K3L5A>
    <xmx:dnq1Y2gF5o1db_P2UT03VTg4ce88CjKm6_GueOZAGLIuldYJd8FG0g>
    <xmx:dnq1Y6CB73uums9oT5l9Lt_WriwfTvtKuSD2a0hd4OAu_5uJMZw6fQ>
    <xmx:d3q1Y-67uaMPAchUrJ4I6Jo-2yL7pIfbA_8Ql5zIfidKyp8qEE8DvQ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0F62AA6007C; Wed,  4 Jan 2023 08:09:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <1205bb21-c252-4c6f-be2d-4a10bb3cd077@app.fastmail.com>
In-Reply-To: <20230104110013.24738-2-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-2-marcan@marcan.st>
Date:   Wed, 04 Jan 2023 14:08:43 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: iommu: dart: add t8110 compatible
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Jan 4, 2023, at 12:00, Hector Martin wrote:
> t600x SoCs use this DART style for the Thunderbolt ports, and t8112 SoCs
> use them everywhere. Add a compatible for it. No other binding changes
> necessary.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Reviewed-by: Sven Peter <sven@svenpeter.dev>

