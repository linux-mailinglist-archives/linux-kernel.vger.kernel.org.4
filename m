Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA15B8B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiINPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiINPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:09:54 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D313D66;
        Wed, 14 Sep 2022 08:09:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 2E6AF2B05DB6;
        Wed, 14 Sep 2022 11:09:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 11:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663168189; x=1663171789; bh=+EkB979beK
        RyfWOKNU4JVmYxhXnwKzOtmTgj01wh7aY=; b=dOZfPWJAXUoqvXMbbNm13WOdtY
        FZsxoMZd90mfSa5vHv8HlEboGLch8FZYrgpyVkla423E9PnnqUt+MlDl5m930spW
        Y+gdADxEu/2JQsBAOKGRiJaAyrMkxmP4yqhZbMuV1Ma/Ovf3K4PGgeQkM+Df2PHx
        IN0Nj40UfAiskrIdCx7ohzZp1fWuYO+yZui+wU6f5atPXTE3Yd5zdTYZH2MsVru6
        4dtR/HJBqLs+yeAsHtk9SUNqe3+VU/sI/BBB77rRaqYA/B5daAh4R1/SQ6B5cpBo
        7IXB5mc0EOnSS2UffRSCTeH5waHZk83XeGDP+eqLGLxXZ1OjMux1QUwNo8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663168189; x=1663171789; bh=+EkB979beKRyfWOKNU4JVmYxhXnw
        KzOtmTgj01wh7aY=; b=jO2SZkbwIEPxXuF1VC4+3FoUefEkbSGpzgtoz5JKgJOF
        T0tAOtBWYainfQDtz+6UU7I9MnPaC8EhYfyow+diYtV5BOGf4EIyejTbS5VFIIPg
        /JjkwNUcRn3YEE5SJy45YRzh3XFcbsiriUjfQdMprFkmzAamMYl04HbX2XLiEU4q
        nO97mApNUWPsYo1YNvVrKXJIX6oc5xH13Xtpnz2iMvlkyA1CozTr5FzTO+t0sYaT
        Mn1WtytbVzWbC0i8IMgyQ7NGg8nPZOx5JavCsWMmdQRHnbE4bIZ11nmbCEPcrqjE
        TX6tSBReFzRDA2dNquRw8iM8RbRUURu/l0r8RkURug==
X-ME-Sender: <xms:vO4hY3JWYrt0GAcix8mYw9fj-ts7gVQsxFGfcVhqSEUT2cw8oBeVRA>
    <xme:vO4hY7JWl_dOn3WU3yok-rkCIbsrwAIwSr2mQU4Vzah6VWTyBnD2wgdzC_xDGIl9J
    _e1jHO2BB4G19Ncmuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepkeethfeugfeugeekiedvtefgvdevtddtveeliedtteffkeffkefgieejgfdt
    ffeinecuffhomhgrihhnpehngihprdgtohhmpdhfihhrrggtohhnshhorhhtihhumhdroh
    hrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vO4hY_stzKJQF4leGKBi1zweyDUYj14F7Jj49mrHEd36cIBVnw047Q>
    <xmx:vO4hYwaChhSwi5ow2VuyG5yWjquijO0RjSIVFLcHAv3g9R_4Qxo--A>
    <xmx:vO4hY-aE4uNcKn0PDvLa0KkVCvO3sVRwqvYk97vNuiiCv6jd-JEkzQ>
    <xmx:ve4hY-L6QydqAjWCIoj7fbTzCKv6nXECh-pkLWaQSqsoq2seYTyk3ZJW96k>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A4CD7B60086; Wed, 14 Sep 2022 11:09:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <0b2da6f2-62f8-41a3-bf07-b6895a2dedee@www.fastmail.com>
In-Reply-To: <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
Date:   Wed, 14 Sep 2022 17:09:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manjunatha Venkatesh" <manjunatha.venkatesh@nxp.com>,
        linux-kernel@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Will Deacon" <will@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
        robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        mst@redhat.com, javier@javigon.com, mikelley@microsoft.com,
        jasowang@redhat.com, sunilmut@microsoft.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, ashish.deshpande@nxp.com,
        rvmanjumce@gmail.com
Subject: Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx series chip
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

On Wed, Sep 14, 2022, at 4:29 PM, Manjunatha Venkatesh wrote:

> NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
> are FiRa Compliant. SR1XX SOCs are flash less devices and they need
> Firmware Download on every device boot. More details on the SR1XX Family
> can be found at https://www.nxp.com/products/:UWB-TRIMENSION
> 
> The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
> Interface (UCI).  The corresponding details are available in the FiRa
> Consortium Website (https://www.firaconsortium.org/).

I know nothing about UWB, so I have no idea if the user interface
you propose here makes sense. My guess is that there is a good chance
that there are other implementations of UWB that would not work
with this specific driver interface, so you probably need a
slightly higher-level abstraction.

We had an older subsystem that was called UWB and that got removed
a while ago:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/staging/uwb?id=caa6772db4c1deb5d9add48e95d6eab50699ee5e

Is that the same UWB or something completely different?

> +#define SR1XX_MAGIC 0xEA
> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)

This should be in a uapi header.

> +static int sr1xx_dev_open(struct inode *inode, struct file *filp)
> +{
> +	struct sr1xx_dev *sr1xx_dev =
> +	    container_of(filp->private_data, struct sr1xx_dev, sr1xx_device);
> +
> +	filp->private_data = sr1xx_dev;

This looks dangerous if the file gets opened more than once
and filp->private_data can have two different values.

> +static long sr1xx_dev_ioctl(struct file *filp, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	int ret = 0;
> +	struct sr1xx_dev *sr1xx_dev = NULL;
> +
> +	sr1xx_dev = filp->private_data;
> +
> +	switch (cmd) {
> +	case SR1XX_SET_PWR:
> +		if (arg == PWR_ENABLE) {
> +			gpio_set_value(sr1xx_dev->ce_gpio, 1);
> +			usleep_range(10000, 12000);

The usage of 'arg' does not match the definition of the command
number, which expects a pointer to 'long'. If you want to keep
the behavior, I suggest changing the #define.

> +static void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
> +{
> +	int retry_count = 0;
> +
> +	do {
> +		udelay(10);
> +		retry_count++;
> +		if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
> +			dev_info(&sr1xx_dev->spi->dev,
> +				 "Slave not released the IRQ even after 10ms");
> +			break;
> +		}
> +	} while (gpio_get_value(sr1xx_dev->irq_gpio));
> +}

The way to wait for a timeout is to compare against the timestamp
before the loop, using e.g. "time_before(jiffies, timeout)"
or possibly using ktime_get() instead of jiffies if you want to
be more accurate.

10ms is really too long for a busy-loop anyway, so better use
usleep_range() from a non-atomic context.

> +/* Possible fops on the sr1xx device */
> +static const struct file_operations sr1xx_dev_fops = {
> +	.owner = THIS_MODULE,
> +	.read = sr1xx_dev_read,
> +	.write = sr1xx_dev_write,
> +	.open = sr1xx_dev_open,
> +	.unlocked_ioctl = sr1xx_dev_ioctl,
> +};

There should be a .compat_ioctl callback, either using the
same sr1xx_dev_ioctl function if you keep using the 'arg'
value directly, or 'compat_ptr_ioctl()' if you move to
pointers to arguments, or a custom function if you have
a mix of the two.

> +static int sr1xx_probe(struct spi_device *spi)
...
> +	ret = sr1xx_hw_setup(&spi->dev, &platform_data);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Failed hw_setup\n");
> +		goto err_setup;
> +	}
....
> +
> +	sr1xx_dev->spi = spi;
> +	sr1xx_dev->sr1xx_device.minor = MISC_DYNAMIC_MINOR;
> +	sr1xx_dev->sr1xx_device.name = "sr1xx";
> +	sr1xx_dev->sr1xx_device.fops = &sr1xx_dev_fops;
> +	sr1xx_dev->sr1xx_device.parent = &spi->dev;
> +	sr1xx_dev->irq_gpio = desc_to_gpio(platform_data.gpiod_irq);
> +	sr1xx_dev->ce_gpio = desc_to_gpio(platform_data.gpiod_ce);
> +	sr1xx_dev->spi_handshake_gpio =
> +	    desc_to_gpio(platform_data.gpiod_spi_handshake);

The temporary 'platform_data' structure seems useless here,
just fold its members into the sr1xx_dev structure itself.
No need to store both a gpio descriptor and a number, you
can simplify this to always use the descriptor.

> +	sr1xx_dev->tx_buffer = kzalloc(SR1XX_TXBUF_SIZE, GFP_KERNEL);
> +	sr1xx_dev->rx_buffer = kzalloc(SR1XX_RXBUF_SIZE, GFP_KERNEL);
> +	if (!sr1xx_dev->tx_buffer) {
> +		ret = -ENOMEM;
> +		goto err_exit;
> +	}
> +	if (!sr1xx_dev->rx_buffer) {
> +		ret = -ENOMEM;
> +		goto err_exit;
> +	}
> +
> +	sr1xx_dev->spi->irq = gpio_to_irq(sr1xx_dev->irq_gpio);
> +	if (sr1xx_dev->spi->irq < 0) {
> +		dev_err(&spi->dev, "gpio_to_irq request failed gpio = 0x%x\n",
> +			sr1xx_dev->irq_gpio);
> +		goto err_exit;
> +	}

Instead of gpio_to_irq(), the DT binding should probably
list the interrupt directly using the "interrupts" property
pointing to the gpio controller.

> +
> +static const struct acpi_device_id sr1xx_acpi_match[] = {
> +	{"PRP0001", 0},
> +	{"", 0},
> +};

As far as I understand, you are not supposed to list
compatiblity with PRP0001 when using this on a PC, the
ACPI subsystem will instead look at the of_device_id
table.

> +static const struct dev_pm_ops sr1xx_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sr1xx_dev_suspend, sr1xx_dev_resume)
> +};

Use SYSTEM_SLEEP_PM_OPS() instead of SET_SYSTEM_SLEEP_PM_OPS()
to avoid a warning about unused functions.

> +static int __init sr1xx_dev_init(void)
> +{
> +	return spi_register_driver(&sr1xx_driver);
> +}
> +
> +module_init(sr1xx_dev_init);
> +
> +static void __exit sr1xx_dev_exit(void)
> +{
> +	spi_unregister_driver(&sr1xx_driver);
> +}
> +
> +module_exit(sr1xx_dev_exit);

module_spi_driver()
