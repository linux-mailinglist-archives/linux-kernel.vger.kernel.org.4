Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FECD65C8EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjACV2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjACV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:28:43 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B51274B;
        Tue,  3 Jan 2023 13:28:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB5955C010A;
        Tue,  3 Jan 2023 16:28:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 03 Jan 2023 16:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672781320; x=1672867720; bh=yNCwZ6Th6X
        npsgpDnxdC5Wteq3Enf3afecAlxpz1Yf0=; b=RT3jcKWDrIdGX0GMBXlzEaJXZo
        t7WlxKzq6ISMii12Gw1Qgc3yw8AtUuj/Y7W8CH2UZcNBIqOpaaaa3FF7o5wWjf7v
        W/0cFDOQEzBC0TTVAMb3vPe6r2oM/JceBHauEqwON+EMplFJKDTXx8cItFH36s76
        cLGUmuBMIVn4VkGmiBZvnxMX+lkB05BKdaEtS3m2pLRWPeTNUDkDpezww9LQvO0S
        yDU0tUPjx8bvNWYbkbsMUwcEDUqltHHfT2T5HDZF0Eow6917hMhqQnl8gDAfc7fG
        LMnZcCAvIxI0wK7fOMuUCZ/OF0UeFStMonJ+95w2fo7Ue5RqKlKhuRnw8PNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672781320; x=1672867720; bh=yNCwZ6Th6XnpsgpDnxdC5Wteq3En
        f3afecAlxpz1Yf0=; b=UYLDHjxb4WaTHgRLWiMAmf4ywTasuzhf9H9wzMvnKxZp
        IgksybaORA3FFMXapDEEhKCznDRLY5Sd/H6liz6G5N82nlk2QnIzZCzNBvGIFWRV
        45T4WaOnIYE0qVJOA3+60FNJchWtsUjdv93cDB+zqUaF7MAii11/5E82xI2DPTCl
        UXxdYAJbYtzuvOsEZ4qFPcMGmkqxx1s7kaJAZK/inMqTt4preDDRYxv1uGas36ru
        mYXwrjIrfxPm5jpk8prqohSSWczwMEoFMfpa9191QOJaD2l92h4xAny1fcgjd7yE
        IYw8DwbJcLurc8S/uFSdKf/xe+4snfiaMtAnfIKjqQ==
X-ME-Sender: <xms:B560Y9YFVX_Dtg4fkwkBUB8iaqySgKlZCFsv1f54amVqEenJtHdlLA>
    <xme:B560Y0bcr9dayeA-LTKyUlmSYnAuqLypLyM1clBFFloI9pXGTGZbXQXcVKAsbn-qT
    hYMAHh7qV2CQYUdkZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:B560Y_8FsJGuDFXA8ijKwIeAdFg_2ylkQS8WBxKhtAbYflLe_eD6uw>
    <xmx:B560Y7oTTRuD6ZJYnxdT2h534lETFq3EaNsZWptmYuf-RsFof0sw7A>
    <xmx:B560Y4pGRpch4vAS78YRVSLiIuo_2JMY4TMjgZ1MBfausSc3nUW31A>
    <xmx:CJ60Y6j-8vwFY28sh04DyTILDAsFcQFY_wlzCKt7SIv0jZUqJ7zzkA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CB431B60086; Tue,  3 Jan 2023 16:28:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <b5712732-40a2-4e29-b29f-e0ab5516d518@app.fastmail.com>
In-Reply-To: <20230103210400.3500626-10-conor@kernel.org>
References: <Y62nOqzyuUKqYDpq@spud>
 <20230103210400.3500626-10-conor@kernel.org>
Date:   Tue, 03 Jan 2023 22:28:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor Dooley" <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Anup Patel" <apatel@ventanamicro.com>,
        "Atish Patra" <atishp@rivosinc.com>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        devicetree@vger.kernel.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        guoren <guoren@kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        "Magnus Damm" <magnus.damm@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Philipp Tomsich" <philipp.tomsich@vrull.eu>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>, soc@kernel.org,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: Re: [RFC v5.1 9/9] [DON'T APPLY] cache: sifive-ccache: add cache flushing
 capability
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

On Tue, Jan 3, 2023, at 22:04, Conor Dooley wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
>
> SiFive L2 cache controller can flush L2 cache. Expose this capability via
> driver.
>
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> [Conor: rebase on top of move to cache subsystem]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This commit needs more work, and a way to enable it from errata. I've
> not gone and done this as PolarFire SoC has archid etc all set to zero.
> So we need to go figure out a workaround for this, before adding in
> errata enabling code for this. I've included it here as a second user of
> the cache management stuff, since what's currently upstream for the
> ccache driver does not do any cache management.
> ---
>  drivers/cache/sifive_ccache.c | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

My feeling here is that the cacheflush code is unrelated to the
EDAC code and it should just be a separate file. From what I can
tell, all of the existing contents of this file can simply
get merged into drivers/edac/sifive_edac.c, with the newly
added code becoming a standalone driver.

     Arnd
