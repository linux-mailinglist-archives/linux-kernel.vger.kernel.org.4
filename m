Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB172FF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244896AbjFNNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbjFNNL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:11:29 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA8D184;
        Wed, 14 Jun 2023 06:11:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D41F33200924;
        Wed, 14 Jun 2023 09:11:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 09:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686748269; x=1686834669; bh=yg
        aeAW7Oiem/w6eWfgDKB5f6lRa+uXyAf0nyR9QWZ04=; b=fxTAGXXFTXOufJo2TO
        mE3XjaK1s19oZ0tNxGzsTfITsX4CXJyrAw0qV8fLGW5GksN0o9ugYnAx6scimgo5
        /tAVKpb5aIIT6wyviErJoUSHyE2cfBBTBZsRxOuqeYoriDz4pgvbitHhXlo64eei
        RXF2CJH1Dzg3+KfdM2huW/YTr/xmGTaC6Ugq7/f1l/OBlrsayQ1TnFimBSml7tNF
        gGevmmLslKHcCTIwwtLHYr3b0a7wBlRHxwIO8TZkoxIW/unPKf/q1Qnzt2u6EaOX
        eSCVp/ueh6ZHZim2mp/cNidLMC/G79CSoFWI53aGOFevm+iX9R516RH6uqQkEX+d
        xcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686748269; x=1686834669; bh=ygaeAW7Oiem/w
        6eWfgDKB5f6lRa+uXyAf0nyR9QWZ04=; b=clDQpDo3J4gwj9SNXUHNzGAT9LZOM
        gm+ziObp9W8LHKg5Dq4xU/FkaMAX3PXBRohpj5J+7ppYpSNd5+maeh1ZsQkSsEUJ
        puYaqexWDRZ6CkpxvMo4TSHcVu5QvtTwzhWqRBWRLhuvjN7YoX0hwx/TLfhzzY3e
        Db6p83Pr4C/ZsyzJ3RtMdke4cnH99R07rYrHTvGYbaMhcozjytbmdkBtS9BsjNIT
        FflKq7PHUyTu5ZESkPfBJJ5+M7+9cYnB94kLIBO7uEeDpoPQHiRSyQUjj+wto7DD
        Kq5kc8mrdy7u09Cc2nv+vEISQ9m0INS6sRmJP3LdvRponMW6ckHopyNHw==
X-ME-Sender: <xms:bLyJZPBEpxpI4Cm1kbP0rmAF7tPClIlganIEAFTLdUGm3AWeHQt68A>
    <xme:bLyJZFgWXpbxPv-rc6C63v84kqGtq1m6b-nsHo22pJihrffAa4NT3-ygePUa2md0G
    K5phChlWvIvr8hRpjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bLyJZKnrom6owFsuwpteY-ZLc6utfQfZPXkDJdkyH_NGvE8Xf32UdQ>
    <xmx:bLyJZByZx406ihiY66AaiPuFvehLkP7wZ0hJEyZ2FazX4Jju8EcgbA>
    <xmx:bLyJZEQdn1vYs5DpkodxIVd8IJealUtsKGwx0Vp5HV1KwVbbkRk2Xg>
    <xmx:bbyJZBixDqVYetegvOr2f9iCRFLAiv0js0Ip7UoEqQxIV6AOLgaBZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 58595B60086; Wed, 14 Jun 2023 09:11:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <20d4d296-14d7-467d-826c-b5c9cdf4599a@app.fastmail.com>
In-Reply-To: <20230614104759.228372-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230614104759.228372-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230614104759.228372-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date:   Wed, 14 Jun 2023 15:10:45 +0200
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
Subject: Re: [PATCH v9 5/6] cache: Add L2 cache management for Andes AX45MP RISC-V core
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

> +static void ax45mp_dma_cache_inv(phys_addr_t paddr, unsigned long size)
> +{
> +	unsigned long start = (unsigned long)phys_to_virt(paddr);
> +	char cache_buf[2][AX45MP_CACHE_LINE_SIZE];
> +	unsigned long end = start + size;
> +	unsigned long old_start = start;
> +	unsigned long old_end = end;
> +	unsigned long line_size;
> +	unsigned long flags;
> +
> +	if (unlikely(start == end))
> +		return;
> +
> +	line_size = ax45mp_priv.ax45mp_cache_line_size;
> +
> +	memset(&cache_buf, 0x0, sizeof(cache_buf));
> +	start = start & (~(line_size - 1));
> +	end = ((end + line_size - 1) & (~(line_size - 1)));
> +
> +	local_irq_save(flags);
> +	if (unlikely(start != old_start))
> +		memcpy(&cache_buf[0][0], (void *)start, line_size);
> +
> +	if (unlikely(end != old_end))
> +		memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), 
> line_size);
> +
> +	ax45mp_cpu_dcache_inval_range(start, end, line_size);
> +
> +	if (unlikely(start != old_start))
> +		memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 
> 1)));
> +
> +	local_irq_restore(flags);
> +}

I'm not quite sure what this does, maybe some comments would help.

This looks like a novel method of preserving partial cache lines
at the beginning (but not the end?) of an unaligned area.

As far as I can tell, most dma_mapping implementations don't
even try to do that at all, but the ones that do take a different
approach by calling _wback_inv() on partial cache lines instead
of calling _inv().

I'd say this does not belong into the low-level operations
here, especially since the ZICBOM variant doesn't do this either.

      Arnd
