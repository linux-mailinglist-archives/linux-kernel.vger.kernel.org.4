Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5FD65044D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiLRS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLRS3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:29:08 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9052ADB;
        Sun, 18 Dec 2022 09:56:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7D0563200805;
        Sun, 18 Dec 2022 12:56:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 18 Dec 2022 12:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671386204; x=1671472604; bh=Lr3MWV45UB
        kC+Upx5XL3PAvGROvHCsXEucBbusCtnP0=; b=eJl4LtUIB9x18YUGZrQ4GBqrKA
        9CzU5TZPAy7j+3eWm/GVppdUM4HAOIBMnvYbv16dUTug5nUsFzrmkJNWEzVCzr/A
        Tm4d6Tjh8hktklG13uv+veEEUySiw9F9kNPveUJqrEGUKi3yjlasAckU3kAzYvsb
        EXf6RevLcQrqBLLCa2orfRqOc43rl3rv5FXcXvadRwD1Kc5x0z7KOgy4nczXPd3j
        Lz9PB4YBV17Np68rBvOqZPZXrOJW50mKQ4qtQ2ejmrUy0osUvaIQU5G30Opr/qEF
        FO6wP5rql3XyGtY/dLHH6N+cHgVS0b8pMjvAS2KI1/ZBh/rlgj13uf1vkPlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671386204; x=1671472604; bh=Lr3MWV45UBkC+Upx5XL3PAvGROvH
        CsXEucBbusCtnP0=; b=Qh8aFDtTYLdyWF+Gnt6+zQ9YyI69LxH6w+GokqsfG5xk
        kqTwB18D3XM5n26ONAAZePkNCdV+h4CBD8YoyvtGejqg2hS0kZMUEWiwrjIOblA5
        4TEzvj8ijL6PEUBEsNZw0q5tBuWR9H7jcu7Yk1IUVTrY6hjk5gC4a51M13V/74mj
        3CBZ1J6XFMRuRbswn1SI2Hhd9lW+JDP5R9oGYPLIOtN6oAVymtouaFjl0La1jrnG
        I7hA6FO3VGylZO9pMVwyN6NIztJ28D4ydEo4+r5nxGWoYYSDaRwAHf0alW7bLHUl
        94NGshuQ1eeZgG0w8Mx3prCKkXTHXhiPxquf4pVdGw==
X-ME-Sender: <xms:W1SfY4HGzwaAt1BhHXRtxmNfF3gN7Re9swmAXDgoiLxk8fQNxiuMeQ>
    <xme:W1SfYxWHsbdMKeNCG3w9-rNK-QsUcJJDDbppLbHP90itV3GvheRUP_8eMCbb1ysIJ
    w7FyVVOII0FP7dFtPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedugddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:W1SfYyK6r2qRATtz3_C6teA_ecEcwT5f43rbeyu1H5POtxWrdgtjqQ>
    <xmx:W1SfY6E4SKYQC71iFY-VBj7M5zXU8zk5I6KIoEnIrVK9QcfEIYrvVg>
    <xmx:W1SfY-WGUL6qNHWaZJ6fwsH8d84JHppZ6NQuDsO8X-vKIS6BQC1lMg>
    <xmx:XFSfY8yvUDK1j3raqSreXKgcF8JCCKu0DArRevWbugTXRfS6UjxnTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A00EDB60086; Sun, 18 Dec 2022 12:56:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <60290159-8d63-4358-9ff1-a65cc335e0c6@app.fastmail.com>
In-Reply-To: <20221218142231.qhczawk2zhpgh6dl@mobilestation>
References: <20221215165247.1723462-1-arnd@kernel.org>
 <20221218142231.qhczawk2zhpgh6dl@mobilestation>
Date:   Sun, 18 Dec 2022 18:56:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Serge Semin" <fancer.lancer@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Mark Brown" <broonie@kernel.org>,
        "Serge Semin" <Sergey.Semin@baikalelectronics.ru>,
        "Ramil Zaripov" <Ramil.Zaripov@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw_bt1: fix MUX_MMIO dependencies
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

On Sun, Dec 18, 2022, at 15:22, Serge Semin wrote:
> Hi Arnd
>
> On Thu, Dec 15, 2022 at 05:52:34PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Selecting a symbol with additional dependencies requires
>> adding the same dependency here:
>> 
>> WARNING: unmet direct dependencies detected for MUX_MMIO
>>   Depends on [n]: MULTIPLEXER [=y] && OF [=n]
>>   Selected by [y]:
>>   - SPI_DW_BT1 [=y] && SPI [=y] && SPI_MASTER [=y] && SPI_DESIGNWARE [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
>> 
>> Alternatively, we could drop this 'select' and require users to manually
>> put it into their .config as we do for other drivers.
>
> Thanks for the patch. Seeing the driver is only implicitly dependent
> from the mux-mmio driver (via the device described in the device tree
> blob) I'd suggest to either drop the MUX_MMIO config reverse
> dependency or convert it to the weak one - 'imply' (if it will solve
> the problem).

Ok, I'll send a new patch. I don't want to use 'imply' though, that
tends to cause other problems because almost nobody understands what
it actually does.

      Arnd
