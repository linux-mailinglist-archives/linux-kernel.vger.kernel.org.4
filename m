Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D04605157
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJSUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJSUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:32:47 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E437317D841;
        Wed, 19 Oct 2022 13:32:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BC3EA5C00C2;
        Wed, 19 Oct 2022 16:32:42 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 19 Oct 2022 16:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666211562; x=1666297962; bh=IL27WN9f+B
        qy0uOKAIBE5GDrLy9RyB9daIupmpozQDc=; b=ddlsdl7lKAIvSKQ2z5Aeur6EMo
        CSu/eY9svXExst8mndIHpjf+DzwRkkdYkYUcmEkj88i/Fx17kWhWdOqikeATKMX3
        Ya+se51EPxKH668+ltxKrglHKHIgqoYDgtT4Kmk0lTCguYPcx8fUjnGQLvz1S5pK
        Ehsk+Jm/qZLp/UdO7BRP82ayrD7RrsG6YJ5NVFIZLEGKmTnZSK/8uGaQD7qDVQ9t
        kq3qagwV3dPNXTxVmcnXZqPVB2z0zvPku97X6SQCBaAXHZ5fonoTrbJB5UKszxMH
        uY+wA3lS+0TaJbJ3mY4Q5IQeCQDGgVH3IVaqK1vUbbE4b8lc9EjxXcwEgd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666211562; x=1666297962; bh=IL27WN9f+Bqy0uOKAIBE5GDrLy9R
        yB9daIupmpozQDc=; b=dpIo7rC3WYIKAPGm75mTGvA2+2fMaExN0+xBpVfTiyTk
        3D6LOgXP9vjcQ4XoXutmHWV6xhMlXfQsabiGO8qoHP48nprlwk8JqwmolhFibzbs
        xW3eTeCyg9/+71v9CzyntzdpbOWMIbig0yXLPyWHmME16BuCrYG/snfIdSmRAFPm
        VfjLFGHA/MyxNh01m/CsuCZrfuCgWw0+BJIp+VRnMglvFFQHzcYI6jkb21QpHwU0
        x/w7mcC0DceFDT7FwZbKfrMKd4hZ/Gwdp8M1xzqfAC2BI10aMmfmQ0HVrYX8Nhq3
        J9RrlVXGP0wWvKlF3ndVVuFUTqPhsGL91miQWPogSg==
X-ME-Sender: <xms:6V5QY-Qv1GkzvsHPobtTjTuYDt9rgbdJvK0TyXjyYwaXpZbyr_d5Sw>
    <xme:6V5QYzxYhdjrdnwVG47RUUxrM2spxo21CWyEL2nPJzm6r71geKTYqIMXZ-kwcv3QX
    EihDYHNZdPV6Hh0lvI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6V5QY73RvFSF5_p6HkfM5SranryEpFl9qeNQNg_lNnKWI9Ok1YYFXQ>
    <xmx:6V5QY6CH9D0G3WqYxCT_S4mthpVylV8vBqJpijz6_CIZZLm1TtYNRA>
    <xmx:6V5QY3hDuxbRaDvabcoaHtbwrY2frDr1DfYHkBfviOXabGahPAW5kA>
    <xmx:6l5QY3hpJXJlQKAD_YfPdqPqibf_jPn1HM3fzMafdzxpKCE7dgwmzQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E44C0B60086; Wed, 19 Oct 2022 16:32:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <501cc2cd-c3e0-452d-b32a-7234d14e8b9f@app.fastmail.com>
In-Reply-To: <e723900c-41ae-6e01-4415-7a859ab071fd@lechnology.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-3-arnd@kernel.org>
 <e723900c-41ae-6e01-4415-7a859ab071fd@lechnology.com>
Date:   Wed, 19 Oct 2022 22:32:20 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "David Lechner" <david@lechnology.com>,
        "Arnd Bergmann" <arnd@kernel.org>, "Sekhar Nori" <nsekhar@ti.com>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Kevin Hilman" <khilman@baylibre.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/14] ARM: davinci: drop DAVINCI_DMxxx references
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

On Wed, Oct 19, 2022, at 18:37, David Lechner wrote:
> On 10/19/22 10:29 AM, Arnd Bergmann wrote:
>>   static u64 usb_dmamask = DMA_BIT_MASK(32);
>> @@ -67,14 +62,6 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
>>   	usb_data.power = mA > 510 ? 255 : mA / 2;
>>   	usb_data.potpgt = (potpgt_ms + 1) / 2;
>>   
>> -	if (cpu_is_davinci_dm646x()) {
>> -		/* Override the defaults as DM6467 uses different IRQs. */
>> -		usb_dev.resource[1].start = DAVINCI_INTC_IRQ(IRQ_DM646X_USBINT);
>> -		usb_dev.resource[2].start = DAVINCI_INTC_IRQ(
>> -							IRQ_DM646X_USBDMAINT);
>> -	} else	/* other devices don't have dedicated CPPI IRQ */
>> -		usb_dev.num_resources = 2;
>> -
>>   	platform_device_register(&usb_dev);
>>   }
>>   
>
> Shouldn't the else case be kept since it applies to *all* "other devices"?
> (and therfore the usb_resources shouldn't be modified either?)

.num_resources is already initialized to 2 from ARRAY_SIZE(),
so it does not have to be changed afterwards.

     Arnd
