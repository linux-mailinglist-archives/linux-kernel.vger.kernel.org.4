Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A815F7991
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJGOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:12:25 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED0D118762;
        Fri,  7 Oct 2022 07:12:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1CE7B580ADE;
        Fri,  7 Oct 2022 10:12:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 07 Oct 2022 10:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665151942; x=1665155542; bh=nqk48zwqJw
        2zqMFJxGhKs48ruH0zDWN6kCS0ah9V814=; b=KPvr/tR9Nl7emKcZqFaisXQtdA
        ZqOqjYBj9GrgIGRt8E9gl0rWulHRiqeEzRUG5547VvPksEciWY+WUq90WlYppxNe
        7wZ+Tt+lEyCeF5tvSTbuGlnHx0XUtvH14eawkEFeyByg/YiOmhn+tiIqxaQf/Z5S
        FuT45XWo+2KXPULPiZhjL+5aewviBUG270vlPb1bLvWvLiLDLYhIlqJecFIJvKjW
        chG01qzWrGEbArebWfOHnJyqZ3F9g7H+KG+NLii9ulFJJfMeiQlT6CcdtLt6MgzZ
        wOhTS/Z1qqGkTK1Fx1j6r+vKV5JJ2sp+NX/fXiNz7n9FpqAXFqOHeQhbyFBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665151942; x=1665155542; bh=nqk48zwqJw2zqMFJxGhKs48ruH0z
        DWN6kCS0ah9V814=; b=dGdPj/PF+BNuKm7P1s0eQoGArd6sSHtqdEE8udJN7D8H
        qag2tMB5qG7THPSkPK2sVrFhaErLCF0Fx/immtcbYA2UTiLwA7ShcDm1DYYfABux
        YgAHhHX4sjqteTI2yRTV4FagCDlcsBZY5nbHtRxVWU46eYbEF7joBbJ+AsCfdOK1
        Mewfbb0XwjqDYgZiM3MR0sr/C7AksIf19uAnek2JO0zefq96wvlYMgum/6RPqsuI
        85HbE2jYm5v0Tx3Of0hlskRYZB/5ms1NGlIA2jwWaHulTGgLtwgixReAh3+oaSYb
        ZiW4BPX+Sowm51O20/l0n/y63EMiiFmIkZA4kGJpmA==
X-ME-Sender: <xms:xDNAY62EcTFqlSdTHhURLM8LagIjESNQ5DeZwR3_sLkB-Pj9-ZXgMA>
    <xme:xDNAY9EH-6e5sk_lEpvHiBGJrXLz2TCH3yTMejjwJEFzxg2sK3rKcdTlE14CSgioZ
    K0VF0S-ccchbxHjT7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xTNAYy5y9HgSQUy-xsreIGSgjLkHYTQpLnGSyZyOiqkBYozUrq816w>
    <xmx:xTNAY71d9YmrwC8FlWI27-rJDYwYKwr8zlfPxDuhC535-FvUDWQjuw>
    <xmx:xTNAY9F7MLy0y99I5NinffRK5jry1tIhJQZh32Qd2NJCwbSY_7Z9_Q>
    <xmx:xTNAYzV9mO0qd7Eruh1jVxiuwl2L3_WMPV_S5WjwGZzHhxSokT12MA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D9122B60086; Fri,  7 Oct 2022 10:12:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <ab5721fb-bb58-47f7-863f-a6c0ba3c5280@app.fastmail.com>
In-Reply-To: <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
 <cd397721-f549-5c65-2c65-35b09c3ea7f9@nxp.com>
Date:   Fri, 07 Oct 2022 16:11:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manjunatha Venkatesh" <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Will Deacon" <will@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "Jason Wang" <jasowang@redhat.com>, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx
 series chip
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022, at 4:04 PM, Manjunatha Venkatesh wrote:
>sr1xx_dev_open(struct inode *inode, struct file *filp)
>>> +{
>>> +     struct sr1xx_dev *sr1xx_dev =
>>> +         container_of(filp->private_data, struct sr1xx_dev, sr1xx_device);
>>> +
>>> +     filp->private_data = sr1xx_dev;
>> This looks dangerous if the file gets opened more than once
>> and filp->private_data can have two different values.
> Do you suggest us to use mutex lock inside open api?


>>> +
>>> +     sr1xx_dev->spi = spi;
>>> +     sr1xx_dev->sr1xx_device.minor = MISC_DYNAMIC_MINOR;
>>> +     sr1xx_dev->sr1xx_device.name = "sr1xx";
>>> +     sr1xx_dev->sr1xx_device.fops = &sr1xx_dev_fops;
>>> +     sr1xx_dev->sr1xx_device.parent = &spi->dev;
>>> +     sr1xx_dev->irq_gpio = desc_to_gpio(platform_data.gpiod_irq);
>>> +     sr1xx_dev->ce_gpio = desc_to_gpio(platform_data.gpiod_ce);
>>> +     sr1xx_dev->spi_handshake_gpio =
>>> +         desc_to_gpio(platform_data.gpiod_spi_handshake);
>> The temporary 'platform_data' structure seems useless here,
>> just fold its members into the sr1xx_dev structure itself.
>> No need to store both a gpio descriptor and a number, you
>> can simplify this to always use the descriptor.
> Just to keep separate function(sr1xx_hw_setup) for better readability
> we have added intermediate platform_data structure.

I'm fairly sure it adds nothing to readability if every reader has
to wonder about why you have a platform_data structure here when
the device was never used without devicetree.

>>> +     sr1xx_dev->tx_buffer = kzalloc(SR1XX_TXBUF_SIZE, GFP_KERNEL);
>>> +     sr1xx_dev->rx_buffer = kzalloc(SR1XX_RXBUF_SIZE, GFP_KERNEL);
>>> +     if (!sr1xx_dev->tx_buffer) {
>>> +             ret = -ENOMEM;
>>> +             goto err_exit;
>>> +     }
>>> +     if (!sr1xx_dev->rx_buffer) {
>>> +             ret = -ENOMEM;
>>> +             goto err_exit;
>>> +     }
>>> +
>>> +     sr1xx_dev->spi->irq = gpio_to_irq(sr1xx_dev->irq_gpio);
>>> +     if (sr1xx_dev->spi->irq < 0) {
>>> +             dev_err(&spi->dev, "gpio_to_irq request failed gpio = 0x%x\n",
>>> +                     sr1xx_dev->irq_gpio);
>>> +             goto err_exit;
>>> +     }
>> Instead of gpio_to_irq(), the DT binding should probably
>> list the interrupt directly using the "interrupts" property
>> pointing to the gpio controller. Since, we are configured this as generic GPIO in DT binding. So, we
> are using gpio_to_irq() to use as IRQ pin.    

I meant you should change the binding first, and then adapt the
code to match. Remove all references to gpio numbers from 
the code.

    Arnd
