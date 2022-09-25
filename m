Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37AC5E95A0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiIYTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiIYTGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:06:34 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA62980F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 12:06:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 9AFBC2B0671C;
        Sun, 25 Sep 2022 15:06:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 25 Sep 2022 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1664132789; x=1664136389; bh=fKqy27w2GA
        4Y8LWhyhSLPIcBLwEelT8v2okY55fFoU8=; b=jbPPDbeFO7GLI8XbKyqGpGUhmq
        Az+yYtbhzHd/MgL/Zp8WSG0B27lHOQUacYU/MlKoz1Ark6WxO4/pjF08ePTsV6KU
        YoFfh1I8f/5Gxeo+uNMARiKi2iG72PeF51nJGEQ6i5n4bsKfwMLcrrIIOlXNKRPp
        n2ru0jtt4xUEeair0yERxP1y8Mq8lqk2cyAqFQSTIUuzFKAzZKo/oOmXtDQ5XJmc
        jW/oZhivd5FrPpsPO3b6+1z20jhRixXgymlZ25XfFIDmtnjIH0/rsNsBUpUNm+It
        zWq3drxBfGP1RYaVb9S1hSRJRx/LzMvqJKikrfmYoHlj5z4xpfA/Zs4SDz7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664132789; x=1664136389; bh=fKqy27w2GA4Y8LWhyhSLPIcBLwEe
        lT8v2okY55fFoU8=; b=S3ItP2HAepGCYyNk6FnrGIh83JLFjj0ZKPioD+oowhjL
        D8+mdCSty3J3AieOeh8rk1QBasuVIf8QkA5MBuyPisLrYR01c/0Wdh/SkOubAe4w
        +jgtm9k2z+evHstf+VaCASIrczA1VwYLQbLs+euMkSycOKJIqaTOHj/qE9pmyamW
        m0AIz6BHYR1HiRCbnoFkdnKXJTU+4V7oFIA/4B2kSNOnnMED+zcOTCzYWsLfr6YX
        Bd93c9Ai6dJhR+/QTaHoJlSbF+OzssnS7SA7qGz9JgurLrOv05EMQSIGdAXdjO0x
        dFV1cgu+y2AL1pEw7CYYopH4HphKqZUBjj6Pw8t+oA==
X-ME-Sender: <xms:tKYwY68wKQpgSgRYOBa-4Xqa-8RkiAKB4ffRlhlNmlEUyDP4v0PXow>
    <xme:tKYwY6sQkUAWEF0iZqNyjvbpPH42sHil3fEzJ_fm2PHqk6lDZYGMM2ZwVb1PUFp4p
    WSO8q2bd9Dor6BNoK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegtddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:tKYwYwATwnF-Miv9NQ6ImgjiknKDJXB5w18nxrGFcfZALFozCr0DpA>
    <xmx:tKYwYyeDl5WvX5B5DdQMBkASOTBFIayuCKxAZ6t7YahtsvAQKjVDIQ>
    <xmx:tKYwY_Olj8flpFI2TJOLvocoEU0c_OKjo2G8VKLiN8J84N4_idU2WQ>
    <xmx:taYwY4qsGz3SkpbjJU38rmbloaDVaSEgUtUECWrGyMst2aFGaxKNcBncleA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 535E7B60086; Sun, 25 Sep 2022 15:06:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <d7179695-46ef-4043-b0aa-bff6e9a8751b@www.fastmail.com>
In-Reply-To: <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
References: <Yy6d7TjqzUwGQnQa@penguin>
 <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
 <Yy7tLRcMaKeet9An@mail.local> <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
Date:   Sun, 25 Sep 2022 21:06:08 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dominik Brodowski" <linux@dominikbrodowski.net>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022, at 4:17 PM, Dominik Brodowski wrote:
>
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Subject: [PATCH] pcmcia: remove AT91RM9200 Compact Flash driver
>
> As noted by Arnd Bergmann, "we used to have three drivers for the same
> hardware (pcmcia, pata and ide), and only the pcmcia driver remained
> in the tree after drivers/ide/ was removed and pata_at91 did not get
> converted to DT". "There is no dts file in tree that actually declares
> either of them, so chances are that nobody is actually using the CF
> slot on at91 any more."[1]
>
> On this rationale, remove the AT91RM9200 Compact Flash driver, which
> also assists in reaching "the goal of stopping exporting OF-specific
> APIs of gpiolib".[2]
>
> [1] 
> https://lore.kernel.org/lkml/68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com/
> [2] https://lore.kernel.org/lkml/Yy6d7TjqzUwGQnQa@penguin/
>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

though we probably want to remove the binding at
Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
as well.
 
      Arnd
