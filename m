Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACA605B99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJTJ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTJ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:04 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115521CBA8B;
        Thu, 20 Oct 2022 02:58:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BDC725C00EA;
        Thu, 20 Oct 2022 05:58:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 20 Oct 2022 05:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666259880; x=1666346280; bh=L8cNWUhBuV
        SGANYlibqkfHNdFindWIffs7dtGgKV2So=; b=uhnu+6Tq2aAeLqzLyQuV3Zimot
        dP7bQdcBQYMyFQ6GIFYuPz8VKPGd/mJqPagoIB2rc4+7Y8LCU52qPbcsW5Z+CqZO
        ijXF0KbQM6MjiSIBeOX+i7ODLsj9+vI28k4y798SodXlkyKbAXuQ9uOyxHSZsnJm
        n1UFzfHUVjlJr3wxlEBznr54cMB3oitP6J6Neu2XlHTIsHd8G7l6nSuvn5YhoaQk
        45wVELVe0mSsSG9y1GPQ9KnrLhNQRgJKLAN/6tVgWKT//Tmm0XfYE0anad4xmmFW
        Qdzlv7KwxwgJTqQLQau3ENuDJ8Azmd0guwpUt0PB5KP0ViDnE1mGnkhzlyqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666259880; x=1666346280; bh=L8cNWUhBuVSGANYlibqkfHNdFind
        WIffs7dtGgKV2So=; b=GPeSFHuouGHvtNmyvOXALREZtIznc8NW6vGUiydR9RD4
        jGNyq3ielKBn2TLyNXSwtYkNeC+pi9RgSfYkkgYRmzKFsEBV7zM0Kc2Vctc1eAB6
        kcinev5TwOdEmu9XKXmJW+sp9YKeRDl4TT5QXF1pbVtMK0FglnDdxutwERLQ/Wuk
        eiRhi1VKi0uvRG/h4p8G1JFqIRNWeIkZC9az3t4+6jnDvSghIO9Xl4vlSJw8EJ8h
        PzWQYbg/Vyag/04SuwUFgFa+17IgkPAaCvpNVsfmMdsHZlIXrTj/+vpGG2aseo2f
        j1ipscqZMeUz7IYPq3ut94xko/czPUXgAptMFkYR8Q==
X-ME-Sender: <xms:qBtRY4DFzsw8I4NJRdOQJ8ryc8gGJfGP_bDH7MyUOloWptbWo-67Rw>
    <xme:qBtRY6gzcVMXqoL0r7LLs8jH5MaIocqM4Z-tt0dCV8DPcSfmLPToWwRBD1e9cQo_W
    6aHcnSWdrUHWQkJpkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:qBtRY7lG3IEo95tlOefm_qinftOgalzj72-zCSPUrlf_pX8zA2xlIw>
    <xmx:qBtRY-y-wxfXsg4Vih_dfJzJ6I83dju5UDkCwGkXiNo0y0cLt5Qcgw>
    <xmx:qBtRY9QWtOFomAdvE7zoqLtGIH07sxpVtM6AsA_Jxw6iisDJe-5UoQ>
    <xmx:qBtRY8GKeMcybX-vNxRx4k4aF6HVxBnIq3V7DoI305rwF7k-5ZmhHg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8A5A3B60086; Thu, 20 Oct 2022 05:58:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <b6c37fd4-d9ca-484a-80c2-d4b6b05c77cb@app.fastmail.com>
In-Reply-To: <Y1EavIxVymPSfwJC@orome>
References: <1664186759-9821-1-git-send-email-kkartik@nvidia.com>
 <Y1EavIxVymPSfwJC@orome>
Date:   Thu, 20 Oct 2022 11:57:39 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thierry Reding" <thierry.reding@gmail.com>,
        "Olof Johansson" <olof@lixom.net>
Cc:     Kartik <kkartik@nvidia.com>, "Jon Hunter" <jonathanh@nvidia.com>,
        windhl@126.com, sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc/tegra: fuse: Export tegra_get_platform() & tegra_is_silicon()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022, at 11:54, Thierry Reding wrote:
> On Mon, Sep 26, 2022 at 03:35:59PM +0530, Kartik wrote:
>> Functions tegra_get_platform() and tegra_is_silicon() are required
>> for pre-silicon development to correctly identify the platform on
>> which the software is running.
>> 
>> Export tegra_get_platform() and tegra_is_silicon(), so they can be
>> used for pre-slicon development of device drivers and kernel space
>> tests.
>> 
>> Signed-off-by: Kartik <kkartik@nvidia.com>
>> ---
>>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Hi Arnd, Olof,
>
> can you take a quick look at this and provide some feedback regarding
> acceptance? It's slightly unorthodox because the only in-tree users of
> these functions are built-in drivers and early code, so they don't
> technically need to be exported for strictly in-kernel users. However,
> we do see these used quite frequently in pre-silicon development and
> having these available upstream would help with internal kernel
> transitions and so on. We may also see them used more commonly in
> upstream drivers in the future.

Hi Thierry and Kartik,

Have you looked at using soc_device_match() instead?

As long as the information is part of the soc_device_attribute
prvoided by the soc info driver, any other kernel driver should
be able to just use string matching to get what you need here.

    Arnd
