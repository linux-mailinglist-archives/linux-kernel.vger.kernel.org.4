Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF56704C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjEPL0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEPL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:26:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72808A9;
        Tue, 16 May 2023 04:26:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1019F5C0040;
        Tue, 16 May 2023 07:03:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684235004; x=1684321404; bh=oG
        PUyY4yOz1WGHHszNYUVcNjTWFW5iDK/V4m5UVgnR4=; b=u0dLgjR28/VUWc9UXa
        1ieJatFzXqFB2OTuWSJKHAEFcbw2GG7e+VB91wwXsIluDMoImUF+Wlns5DPtpTEn
        bK9WxIW9Aqz3b3sD2whWE7t1rTiy3JEblbfK/BIPAaBP7HrBVInFfW+uNgr0C5bG
        7P3zzCHMmLMMzoZGMFF3eT4SQ53ltUAs89/iIInqTeQiw2MbKqGSXIPQNxozfTkP
        anaRtkULBQcsJ4vHkCCwshC9tvHzVTY3EKJ9BYdplmZfylN0zKKxrgj3A26wxf7t
        L16ftbfQEoPo8xQt9hH9+ZagOp9Pcqwxtu6VfPhlnPtIGfUylSNCtEV3iydHQ0RL
        7tNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684235004; x=1684321404; bh=oGPUyY4yOz1WG
        HHszNYUVcNjTWFW5iDK/V4m5UVgnR4=; b=d1bhxwARlVsUGSNkdNQwEG+OzSCgY
        rWtF/JWFxjiD1UZkLCww3i0xPEcoOZ4epcRYG4Kb3yWqwmlr/sTxCbWCrF1iHATv
        gHt/Um0FXfZ7okpgekmRj+e8buh2LzmYAPx4vHciNWQt0pQM8+4dtzsBn4FwH7qA
        hJNdqSy3YlXf5zXRHY0ilBh9sJ+X83XOTVh7OZJU1FrUoJNyfPWJNsp+VkFA97ur
        6TyVKaH8nTlSa1P6jlFRSkTAnV92njIwu2dXAZ48wLToGqHkH3FX73RtVl8Da+ew
        Nj2UHR3sBxODQiTGsbiHTufF13fsM90kphJazsYoe1p13xj9NLzSxtF5g==
X-ME-Sender: <xms:-mJjZBHz4LwqB9dwBPD_0kW5iN4br5CTjqrUyClEA_CKLiNDSVu4Sw>
    <xme:-mJjZGXgyp_PhaxgHTFIGJQoW3qUoj1wuR5_PD9IEfe2ZwgwaLmCutYCD4qCltHCx
    XSsRXKkOcOppOSI1vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-mJjZDKheLkxkYltH5LKHOrq6dIOmLUfGPaozLyw6CHt817keEY1MQ>
    <xmx:-mJjZHH6KpQzZWUL48pz0mRNzu3_rf4lrs01I4o7H65gr4GKJ7QWJQ>
    <xmx:-mJjZHXsvc0LbcwxEoE5UdpEgP5ckkIZIDbNPtCXXRT3CgMht-LcMA>
    <xmx:_GJjZAbSoNXXu3RyqGk2TISdgK6tRgCUi67z4178MnSkgsDiDlJJvw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5C737B60086; Tue, 16 May 2023 07:03:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <bc5118f2-8982-46ff-bc75-d0c71475e909@app.fastmail.com>
In-Reply-To: <20230515181606.65953-9-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-9-blarson@amd.com>
Date:   Tue, 16 May 2023 13:03:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <blarson@amd.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org,
        "Adrian Hunter" <adrian.hunter@intel.com>, alcooperx@gmail.com,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "David Gow" <davidgow@google.com>, gsomlo@gmail.com,
        "Greg Ungerer" <gerg@linux-m68k.org>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "Joel Stanley" <joel@jms.id.au>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Mark Brown" <broonie@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Serge Semin" <fancer.lancer@gmail.com>, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Walker Chen" <walker.chen@starfivetech.com>,
        "Will Deacon" <will@kernel.org>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org
Subject: Re: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC Controller
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023, at 20:16, Brad Larson wrote:
> The Pensando SoC controller is a SPI connected companion device
> that is present in all Pensando SoC board designs.  The essential
> board management registers are accessed on chip select 0 with
> board mgmt IO support accessed using additional chip selects.
>
> Signed-off-by: Brad Larson <blarson@amd.com>

Hi Brad,

I'm sorry I wasn't paying enough attention to this driver as the
past 13 revisions went by.

> v10 changes:
> - Different driver implementation specific to this Pensando controller device.
> - Moved to soc/amd directory under new name based on guidance.  This driver is
>   of no use to any design other than all Pensando SoC based cards.
> - Removed use of builtin_driver, can be built as a module.

it looks like this was a fundamental change that I failed to see.

> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "AMD Pensando SoC drivers"
> +
> +config AMD_PENSANDO_CTRL
> +	tristate "AMD Pensando SoC Controller"
> +	depends on SPI_MASTER=y
> +	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
> +	default ARCH_PENSANDO
> +	select REGMAP_SPI
> +	select MFD_SYSCON
> +	help
> +	  Enables AMD Pensando SoC controller device support.  This is a SPI
> +	  attached companion device in all Pensando SoC board designs which
> +	  provides essential board control/status registers and management IO
> +	  support.

So generally speaking, I don't want custom user interfaces in
drivers/soc. It looks like this one has internal interfaces for
a reset controller and the regmap, so those parts are fine, but
I'm confused about the purpose of the ioctl interface:

> +static long
> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{

> +	if (num_msgs > 1) {
> +		msg++;
> +		if (msg->len > PENCTRL_MAX_MSG_LEN) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		t[1].rx_buf = rx_buf;
> +		t[1].len = msg->len;
> +	}
> +	spi_message_init_with_transfers(&m, t, num_msgs);

This seems to be just a passthrough of user space messages, which
is what the spidev driver already provides, but using a different
ioctl interface. I don't really want any user-level interfaces
in drivers/soc as a rule, but having one that duplicates existing
functionality seems particularly wrong.

Can you explain what the purpose is? Is this about serializing
access between the in-kernel reset control and the user-side
access?

Also, can you explain why this needs a low-lever user interface
in the first place, rather than something that can be expressed
using high-level abstractions as you already do with the reset
control?

All of the above should be part of the changelog text to get a
driver like this merged. I don't think we can get a quick
solution here though, so maybe you can start by removing the
ioctl side and having the rest of the driver in drivers/reset?

     Arnd
