Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CFA5B8913
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiINNZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINNZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:25:52 -0400
X-Greylist: delayed 489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Sep 2022 06:25:51 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4661B20;
        Wed, 14 Sep 2022 06:25:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 0DDB12B05DAE;
        Wed, 14 Sep 2022 09:17:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 09:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663161459; x=1663165059; bh=GdgMo8oW1+
        2SMCLkBxj5GR3RIMNzrKHtUDN4Kx4rnvU=; b=oV2STMsFokkBLoSvn4LZ0bRXEy
        PHOYPvTVkohPZ3QmjXZLv9j5XItd9ZNYiti3Wo4bAf2GM4x9AeypXkXC3LBsScan
        Kmy9B8+xsVZr/vnEyYBcz21o9Yw88uaUeLjkqr74E7pCILyqReQ29e45Wa5acU3J
        ho+vBjNlTfz6VOp/hN5SHKvU8cT2hJwBZjMD2XYx367k/jlYM/Z5veWFt3Fhg6fh
        rbxmdolsi8GJbQn/KwhhogeJrfd1TMEsn8JPMEKFQMUVj0WpvLIMH6d4kDZWb04U
        /PRpWHr6uHjcf0/3XhAOUqlKo/UfxA1K+lDQF6i1zuhT9mfv04hiddcn+cEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663161459; x=1663165059; bh=GdgMo8oW1+2SMCLkBxj5GR3RIMNz
        rKHtUDN4Kx4rnvU=; b=XCF+z87anTvBmL047FIOUpa6x9uESrqeWJ3cwS786o4z
        xEAaXWiyDQjSXtwPo9X/c9XThNu3ZGvo2Or/gRR2LgdEdH28HJY6Q9bHHngv6Hgf
        /UaaCIt+37K95+xGc58DX0sjTo3ddMtRgCXmpRjG/wZ24MvXETdwjenDrwzjLDAE
        ER7Om+9EtMgd20C6baZSASSXID4sKdc8eZxcsx3O31RYU9M7A94Zc3uWvQC8XqA2
        nagA+oi6svFbnoiY1GDTondJ6rcDHD7wCV8roRcRoFA2DjIJxPZNR+iY/NUpk/dy
        tHgTNZRT7kSGcyTnz/pGCQsB2woNL2fQ10G9mfqF4Q==
X-ME-Sender: <xms:c9QhYwNU1B3CFZ9FtJk6ZWvN6ycygvi59KycL-TIvj-wqmK2s4HCRw>
    <xme:c9QhY2-TnMvcy_oJGJXZFzUg7HuEdflBSfav2AZZ2hm6CmLEpvQBiZrVZFi4l0ca5
    sCsUUJTOBYqf5X01Go>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:c9QhY3TY1IEVSEOOna3_4PFQX1dFGTueXtVLfkWVexxdzCSgaYNYPg>
    <xmx:c9QhY4vN6-ltPj0HDnOD-MOOZLIlkzPT2vypTCOvTWEeo9IUeE-2Sg>
    <xmx:c9QhY4cqebahSOONM198AYIhlJN6sYnlngJHkdU8Eo012O3XVP9dKQ>
    <xmx:c9QhYw70bq9fTuEpVjnaG2x6gUvgPPWuTqrV856AxnykH6fb2q9C_2kUGGU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48733B60086; Wed, 14 Sep 2022 09:17:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <28501fbf-3508-4afe-804d-fa5a3ccd4291@www.fastmail.com>
In-Reply-To: <499f0940-3d7f-0ed5-e469-5c0979e6f761@baylibre.com>
References: <20220913140303.437994-1-narmstrong@baylibre.com>
 <667da463-1edc-4a99-9ac1-85303d9187c6@www.fastmail.com>
 <499f0940-3d7f-0ed5-e469-5c0979e6f761@baylibre.com>
Date:   Wed, 14 Sep 2022 15:17:17 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Neil Armstrong" <narmstrong@baylibre.com>,
        "Mark Brown" <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: meson-spicc: add support for DMA
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

On Wed, Sep 14, 2022, at 2:35 PM, Neil Armstrong wrote:
> On 14/09/2022 13:19, Arnd Bergmann wrote:
>> On Tue, Sep 13, 2022, at 4:03 PM, Neil Armstrong wrote:
>> 
>>> + /* Sometimes, TC gets triggered while the RX fifo isn't fully flushed *
>>> + if (spicc->using_dma) {
>>> +          unsigned int rxfifo_count = FIELD_GET(SPICC_RXCNT_MASK,
>>> +                       readl_relaxed(spicc->base + SPICC_TESTREG));
>> 
>> Same here in the interrupt controller, I don't see anything enforcing
>> the DMA to actually complete before the readl_relaxed().
>
> I don't see the relathionship between a register relaxed read and the 
> DMA not finishing
> writing the data in uncached memory, for me it's 2 unrelated things.

The race is between the readl_relaxed() and a subsequent access
to the data that is being transferred. On Arm processors you
need a "dmb(oshld)" instruction to ensure that the CPU cannot
prefetch data from the DMA buffer while it is waiting for the
MMIO to complete.

The __io_ar() in readl() exists specifically there for this race, and
this is the reason that readl_relaxed() exists for drivers that
do not do any DMA.

Note that this prefetching can happen for uncached memory, but
spe-meson-spicc uses cached memory.

     Arnd
