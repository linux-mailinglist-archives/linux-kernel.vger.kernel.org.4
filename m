Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254572FED5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbjFNMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjFNMgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:36:22 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2912B1BDA;
        Wed, 14 Jun 2023 05:36:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 71A9A320027A;
        Wed, 14 Jun 2023 08:36:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 08:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686746167; x=1686832567; bh=/w
        i20iR3aQR7q9wgEfHg3OvnmC0VIjOXlEhxRWFU404=; b=yIRQ9VaLmhYNvJ7VPL
        aIczJP634G2iW7do0KWyL6aYOhuFsc4QG00mqeYFH01kUogNIcHGfk5v+IpF62Ue
        jqAL/8sqmNozQRp1AkA9kyt3y1n8NCtqr+yLhuY1ESGa+LujJijvADCyDsQIg90V
        /er6lIOc344X9T+DQUydJAs/UyKi3vrGCa4ikpGMOvEQSpq/W0zGo79i4wgRoEdg
        WTw8WyggGHyoluJE72cUvp3MNbMI0qAv8vMP7tsE+6/teYIuQqvMdjyQM1Bfan+f
        rxJyI0tpdQwnnMWaL+9RxdhlNLni4dWDqwOv3H9MDW0IMY3STvyhrrzpDBdLMqW9
        ziNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686746167; x=1686832567; bh=/wi20iR3aQR7q
        9wgEfHg3OvnmC0VIjOXlEhxRWFU404=; b=MN1KtIp6YBLpIaq17zVFU3FRCWKQJ
        yv8Z7/vtGmbDpWOD6wu05MDIv2rHrKm5nvZRReioje4Hh0JLsSv8m6b/TQPCYABG
        ZNkOB7+bCa9h0doqFmQMHVA3Gw0rRVI9IO7sJueJnnpv6s5mk8Mia7L9TdfmAzN/
        BAqd3lVmpBkKpCN7V6QtWGODD8Ur3sA4UR3ZE2VeL1ImnBujkPqFnq70uAZsRnGr
        6V9kdccnyxFdRfugSagS1I9u9KbzPGFuRu3Q3F8rCafHVMNjhH3ZnNE7WtfukcFc
        HcegiOmV1P5N3QSif9makzr8a5/ZdyHEuC6X1Ym8aC3EWO/kAkX7vznPw==
X-ME-Sender: <xms:NbSJZKUGGowMH2r2BclhZcvRsf7r0LEp9v4YPt-H2qU_8_LKy9RUrQ>
    <xme:NbSJZGkuH4c6Ru5e3X9T4_IHHQUxRN1DNHh6gKIU3TY4umSuLxOJ4VKwUHMEfeA8q
    CzmaWSgPRtF4Zc_f-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:NbSJZOZwJVpkiZcwdTVw5lvyK2LVoLL3GgavcVvvEyJ82C_McU57YQ>
    <xmx:NbSJZBUiS9IkOD12b0vBVvrUSCCnrYl9_p2ag5V2eikdrQNL-Bbshw>
    <xmx:NbSJZEklPOitB19h-KpGgSWuNaSckhxNybhgO_9SXZBm3vEKxFnh-A>
    <xmx:N7SJZIkIy1nP6O52Dgs6ycEFZ-iSEukq_97ECQW5wNxWIWfRf6puGQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5CE22B60086; Wed, 14 Jun 2023 08:36:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <4f69fcfe-debb-4979-9070-1d58ba35032c@app.fastmail.com>
In-Reply-To: <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Wed, 14 Jun 2023 14:35:44 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        "Christoph Hellwig" <hch@infradead.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v9 3/6] riscv: mm: dma-noncoherent: nonstandard cache operations
 support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023, at 12:47, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce support for nonstandard noncoherent systems in the RISC-V
> architecture. It enables function pointer support to handle cache
> management in such systems.
>
> This patch adds a new configuration option called
> "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> support for cache management in nonstandard noncoherent systems.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

I understand that Christoph will still not like this, but I think this
is as good as it gets, making the standard variant the fast path,
and using the function pointers only for the nonstandard cases.


>  #include <asm/cacheflush.h>
> +#include <asm/dma-noncoherent.h>
> 
>  static bool noncoherent_supported;
> 
> +struct riscv_cache_ops noncoherent_cache_ops = {
> +	.clean = NULL,
> +	.inval = NULL,
> +	.flush = NULL,
> +};

This could be marked __read_mostly or __ro_after_init as
a micro-optimization, if anyone cares.

      Arnd
