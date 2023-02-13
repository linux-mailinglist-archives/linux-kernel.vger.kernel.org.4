Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9504A693F50
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMIFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMIFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:05:45 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA66BBBAC;
        Mon, 13 Feb 2023 00:05:44 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 915805C00D9;
        Mon, 13 Feb 2023 03:05:42 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 13 Feb 2023 03:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676275542; x=1676361942; bh=PneGRKGzzq
        PYOheQ2SeW0ZVjFQxDgBZMJk96e1F96vU=; b=ISRz0Ae0bepULqIirvjXr/V+Cu
        jUWhSiVca/0RBp52DfSwBliPDAw8Pq8hswj7R2rgZXzXZrytQ3Fp8bVBHvp61B7d
        Hc3ELl22FwEfEB+mYggExZkOMr/FFy/XLNX4UXoVVcsqDSLJyDydXgCvEc+URdAi
        iAsH9k/OsKSUVe2JPrQxiblcHeh3C8bV8x187RVKLsQjFwAd8SYUcNjsS1GS0fuw
        vyVrORNdQUzc1ny3+yyyfOmkgDQEdY5W9c9LdE2toxjYnPJOljupK9LHCe6+A2up
        u+PIbGRR2/vJ1/znn4E++UHEqPZV2dmJXQX0fTcY/+Eox+CJrYhxJCKtrCsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676275542; x=1676361942; bh=PneGRKGzzqPYOheQ2SeW0ZVjFQxD
        gBZMJk96e1F96vU=; b=sZnOQjadNTLVnQV6lJipH3DxSKzklKx4nyio7wtzj6RK
        vB9vFEJrci8VKYcMz9OBvCURKoPK4aaysbvgZrJwgy+U3V5m3jsyovjf62YDkLhj
        zmSVjWAUdhN2Xr1AaGFQ7utWCgoHb3P0NwvHQIqnO0gGsthhSGVe7hB9wN6IouUG
        TKpEhyEo7CQr1sh17TR/+kv5zxRbHXF8QhZMbV42pP0L9z17BJXIAUlQLIrjBGy2
        1ed99w8cudVCtxS2i/d11V2Hcf2n5Bif0BTlgcszYD6RayDqH3TTIHMAMIFLMmyT
        WXWyrR78j+aDKBU27cgCK7EYRGbp84s0g/Vwfkh9pQ==
X-ME-Sender: <xms:Ve_pY32NDfwtw-Tfs8yKDSn_gNMRvb3VIm3Rhz01xmh51z689I54lA>
    <xme:Ve_pY2GoFZwlQaTkL-iKlufKZhdNU4RjUQO2knZTI2me12snbsSC9mCLZ8oN27wkb
    _Uq-axaW6QLg3gLi58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Ve_pY34vTDlza4J4eNyCWo5VTAi01-dXLPScXbTtPGtpoVebVAzxJQ>
    <xmx:Ve_pY83YJil3BG00-dNtigyFx_8p_OldSmBlDOmNnR2YeOcNuyWFeQ>
    <xmx:Ve_pY6FBkksVIkW0wzfLsXyyrCiF8UK-xpQjz72PMiDjHCMGTWZ2PQ>
    <xmx:Vu_pY4UIgVkZZagG-p2s30ANgOLK2TB7gVWlCqW87zh9F62vE8n6Lw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 26A52B60086; Mon, 13 Feb 2023 03:05:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <b8fb48b9-349d-4723-9b35-6471cb65b6b5@app.fastmail.com>
In-Reply-To: <20230213041535.12083-1-rdunlap@infradead.org>
References: <20230213041535.12083-1-rdunlap@infradead.org>
Date:   Mon, 13 Feb 2023 09:05:12 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "MyungJoo Ham" <myungjoo.ham@samsung.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        "Donggeun Kim" <dg77.kim@samsung.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Peter Rosin" <peda@axentia.se>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Rob Herring" <robh@kernel.org>,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] IRQ_DOMAIN: remove all "depends on", use only "select"
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

On Mon, Feb 13, 2023, at 05:15, Randy Dunlap wrote:
> IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
> it directly thru "make *config", so drivers should select it instead
> of depending on it if they need it.
> Relying on it being set for a dependency is risky.
>
> Consistently using "select" or "depends on" can also help reduce
> Kconfig circular dependency issues.
>
> IRQ_DOMAIN is selected 109 times and is depended on 3 times in
> current linux-next. Eliminate the uses of "depends on" by
> converting them to "select".
>
>  [PATCH 1/3] extcon: max8997: select IRQ_DOMAIN instead of depending on it
>  [PATCH 2/3] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
>  [PATCH 3/3] rtc: mt6397: select IRQ_DOMAIN instead of depending on it

From a Kconfig perspective, your reasoning makes a lot of sense.

Looking at the bigger picture, I wonder if we should just remove the
option and make it unconditional. It is enabled in ever architecture
defconfig other than alpha and sparc, and it's selected by a lot of
very common options such as I2C,  GENERIC_MSI_IRQ, GENERIC_IRQ_CHIP,
and PCI_HOST_GENERIC. Enabling the option on Alpha grows the kernel
image from 9010KB to 9023KB, or on m68k Coldfire from 3346KB to
3351KB.

      Arnd
