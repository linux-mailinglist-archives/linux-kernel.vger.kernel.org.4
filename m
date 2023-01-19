Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3129067344D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASJXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjASJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:23:12 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43067796;
        Thu, 19 Jan 2023 01:22:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ACDF25C00B3;
        Thu, 19 Jan 2023 04:22:57 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 04:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674120177; x=1674206577; bh=/JsNdAytCy
        nPTqBsyGElSPfW98eiVw7apSDHVMC4ZLc=; b=bHL+8hi3f1w7c68W16su2/woIi
        p3/hVfC0K0wniFdYKdaMYxmZBqgZ6L9hgDIZLBacXerW+4niLyHPSv2XQb2P3CPu
        ABfSHsCUUh9c1lDJP4oqeSWj377RaH0Jaa5c93nYJfshUOU9AyIs5m/VRwMpfEZf
        nr9z1FkBNaIObcEkmOGZCksrSXwteN+chJNA95sTtDZfEk9wMv2HFyWWQzQkpPh+
        +myZFKNmh1YsvjMXzldZ6KzmM0d4II/DbO1tU2/WyOg2POSDhI6mZ6HkMlPc5vL1
        sZP0dEMSVGO1SeuhlMVXSu4jYdxlcu2Ky+jWpj5MM02PY/oLVHPZ1il0fmIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674120177; x=1674206577; bh=/JsNdAytCynPTqBsyGElSPfW98ei
        Vw7apSDHVMC4ZLc=; b=mcL8mzFLatm+U4TcbmKxB1Yygc7VY05chw0BSKnN4Yaw
        lfwDO3QLiOvQOaboPIdOKe9TkkyHMz063oSSFaKKKHTveMp6DE0qzW4Yr75t1QfE
        7zL+fKKqz6Vj4Q8jo4+KpRi9LPdY8iyx0X8AB5Isw6g1cMNhicG4NSVNhWERPwCJ
        AHzMXPsL2fnyvRCFvxVW9TZOPw6d+wtSRpPU2ah/668Pvghf7nechsRlOKYw1W96
        9j1dSzFeojb/LHRcdda0SS8PVs5MENWHmBm2amOQsngZbOuyMy629pVMBGoB1sDB
        unIvQEWZJTN4EkWOsk4BCa7F1o4I6uu/kWXHfABqGw==
X-ME-Sender: <xms:8QvJYxTegyit2P0J_Kyg1iz_5SfcC9tEY38DB9u4xGOm1dS_NEO3nw>
    <xme:8QvJY6yiERTAKVvn0jGkSrRp-ErHsqKt19df2t9jkttmMHwk1lfdyU7dQy0M2U8rq
    HVKP-61jZjTCW88dvU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8QvJY20jmXmROYht_sErXSbsvrYIshdu7bQIcCJqe7UMQMF1_R0lBw>
    <xmx:8QvJY5BvZ8-kb5SWq0Mxb_LTxg3nsVhxicrVtUOQMkvir_CsjUIVQA>
    <xmx:8QvJY6ikSTKCoPjE8A3ov4fq3HUdQ5SHB2DHnyyW-LdZRF-h0TbG4g>
    <xmx:8QvJYzA-2c5jILpcioQfhmfRzjj4KM2TStf_8tssIdvs-SmdjG4uiA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 056E3B60086; Thu, 19 Jan 2023 04:22:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <e7180562-dddf-47ff-8e6d-34265521b10d@app.fastmail.com>
In-Reply-To: <20230119033918.44117-16-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
 <20230119033918.44117-16-blarson@amd.com>
Date:   Thu, 19 Jan 2023 10:22:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Brad Larson" <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        blarson@amd.com, brendan.higgins@linux.dev,
        "Brian Norris" <briannorris@chromium.org>,
        brijeshkumar.singh@amd.com,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "David Gow" <davidgow@google.com>, gsomlo@gmail.com,
        gerg@linux-m68k.org, "Krzysztof Kozlowski" <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Mark Brown" <broonie@kernel.org>, yamada.masahiro@socionext.com,
        "Philipp Zabel" <p.zabel@pengutronix.de>, piotrs@cadence.com,
        p.yadav@ti.com, "Randy Dunlap" <rdunlap@infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Samuel Holland" <samuel@sholland.org>,
        "Serge Semin" <fancer.lancer@gmail.com>, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        "Tony Huang" <tonyhuang.sunplus@gmail.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        "Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 15/15] spi: pensando-sr: Add AMD Pensando SoC System Resource
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

On Thu, Jan 19, 2023, at 04:39, Brad Larson wrote:

> drivers/spi/spi-pensando-sr.c

I don't think that is the right place for this driver: it's not a spi
controller implementation but rather a user interface driver that should
be in another subsystem depending on its purpose. drivers/misc/ might
be an option, but ideally I think there should be a higher-level
interface.

I'm still confused about what this driver actually does, and how
the corresponding user space side is meant to be used.

> +config SPI_PENSANDO_SR
> +	bool "AMD Pensando SoC System Resource chip"
> +	depends on SPI_MASTER=y

Why can this not be a loadable module, i.e. a 'tristate' option?

> +
> +#define PENSR_MAX_REG		0xff
> +#define PENSR_CTRL0_REG		0x10
> +#define PENSR_SPI_CMD_REGRD	0x0b
> +#define PENSR_SPI_CMD_REGWR	0x02
> +#define SPI_IOC_MAGIC		'k'
> +
> +#define SPI_MSGSIZE(N) \
> +	((((N)*(sizeof(struct spi_ioc_transfer))) < (1 << _IOC_SIZEBITS)) \
> +		? ((N)*(sizeof(struct spi_ioc_transfer))) : 0)
> +#define SPI_IOC_MESSAGE(N)	_IOW(SPI_IOC_MAGIC, 0, char[SPI_MSGSIZE(N)])
> +
> +struct spi_ioc_transfer {
> +	__u64 tx_buf;
> +	__u64 rx_buf;
> +	__u32 len;
> +	__u32 speed_hz;
> +	__u16 delay_usecs;
> +	__u8 bits_per_word;
> +	__u8 cs_change;
> +	__u8 tx_nbits;
> +	__u8 rx_nbits;
> +	__u8 word_delay_usecs;
> +	__u8 pad;
> +};

When you create a new user interface, the interface definition should
be in include/uapi/linux/*.h. The structure name and command name should
indicate what driver they are used for, these names look overly
generic.

> +struct pensr_device {
> +	struct spi_device *spi_dev;
> +	struct reset_controller_dev rcdev;
> +	struct mutex buf_lock;
> +	spinlock_t spi_lock;
> +	u8 *tx_buffer;
> +	u8 *rx_buffer;
> +};
> +
> +static dev_t pensr_devt;
> +static struct pensr_device *pensr;
> +static struct class *pensr_class;
> +static unsigned int bufsiz = 4096;

Even if there is only ever a single instance of the device known to the
kernel, it is better style to avoid static variables but instead make
everything passed around as part of the device structure.


> +
> +	t[0].tx_buf = tx_buf;
> +	t[0].len = u_xfer->len;
> +	if (copy_from_user(tx_buf, (const u8 __user *) (uintptr_t) 
> u_xfer->tx_buf, u_xfer->len)) {
> +		ret = -EFAULT;
> +		goto done;
> +	}

Use u64_to_user_ptr() instead of open-coding the type cast.

> +static const struct file_operations pensr_spi_fops = {
> +	.owner =	THIS_MODULE,
> +	.unlocked_ioctl = pensr_spi_ioctl,

There should be a '.compat_ioctl = compat_ptr_ioctl,' line here to
allow the ioctl to work in 32-bit processes.

      Arnd
