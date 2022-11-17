Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243B162D79A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiKQJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbiKQJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:57:36 -0500
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC679E1F;
        Thu, 17 Nov 2022 01:56:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 95EFF2B06834;
        Thu, 17 Nov 2022 04:56:09 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 17 Nov 2022 04:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668678969; x=1668686169; bh=n3ozN+W8YF
        HbndcMAYC2OS8cumH8vJIUWsucZSRoAV0=; b=DcMtPBgL8TjdP2NfUnS40MkbeY
        qlt/hHvPQWRrV/z+Nr+bpIfXr/GvcoDTiNTEIJNxhOz/bklMG0Ax4PWkfPjGZt+4
        U0obW7RNPX2TJSAvM2Dl33xSPvY+pguOGGMs3Lupo69sxnm3R+/aBzimG93367Et
        bVmEaZvJXbEaUzu3UZOZWtZF0EBsLQPcJCoq2mlHbZHl4kym461kkHSSidsyo0V1
        eKl47Jm2SMUrfomMY/bNrivb5no1IAk3ArHZk/aF7PSchkRb8D9+leizMu+U/MQt
        Ml1bRehQJO5AOli5iSWewspJYs1h1yZ1XmA6m3NZ9Mu3Ic+ogNJUOpyt/DgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668678969; x=1668686169; bh=n3ozN+W8YFHbndcMAYC2OS8cumH8
        vJIUWsucZSRoAV0=; b=cKMVq+HQ23RRH6MluW7EsSxG/+hlE4vE150eSqzMJ6RV
        W96xg+vLxnOHJyh0hz0HQpQIG3TOAmSu3Wb+DXVa0dEtyxUHE8fcfda5xEydwhB5
        xym/u8wS2fSazZh82f8oUW0TpMIgLmj86rgbI3SqAxwvfDslg94SY0OAjR3GFbya
        suZkVlVCOx8gHQ6nYVyzUOx9r7P6juxaiXcn6tLQownbAk5Y9kgNcrzKhUH32q/P
        q5T+eZNoUQEM7FugGCis6Jvdr8JKwxwCvAadBBFlkCTFCkXDVra9wYBZ3CzDLmX/
        Lest2dgL2/lzDAq+Njhim2eZayTsh1Kqc5D82J14nQ==
X-ME-Sender: <xms:OAV2Y_WFWESNZxVtGWi-2Okemz4il27j1JFDhRSfvGuHMD1zVIDvvQ>
    <xme:OAV2Y3lD3d3odxKj2y93JaNbggt9D5s8M1xteoFkoEfVZ--jZNv0yTl4lN1EunTBM
    S8tGw6WOVPPdQv4lNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OAV2Y7bIwFpdYNxML9JAFwbj0AoOF-x6sWlNXM46dJsFxLM7xiIqGA>
    <xmx:OAV2Y6VlFPkvFTyWHH85-yaoO3wcANC-mRsyUlsinW-kCGlABBw5EA>
    <xmx:OAV2Y5lJYWf0dxv8mn9HZVvtWfb9qjRyixNQVrRtLwnjgoQStjQEpg>
    <xmx:OQV2Y4cjvBZw3lHJZJLfDfEyXxn9XGMIxJ1J_u7cds0ZhKbaaqJevnRhq9g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 12A80B60086; Thu, 17 Nov 2022 04:56:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <9aa20e9a-92b1-4268-921f-11209785acb7@app.fastmail.com>
In-Reply-To: <20221117035902.13995-1-zhuyinbo@loongson.cn>
References: <20221117035902.13995-1-zhuyinbo@loongson.cn>
Date:   Thu, 17 Nov 2022 10:55:47 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Juxin Gao" <gaojuxin@loongson.cn>,
        "Bibo Mao" <maobibo@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        "Arnaud Patard" <apatard@mandriva.com>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Jianmin Lv" <lvjianmin@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Liu Peibao" <liupeibao@loongson.cn>
Subject: Re: [PATCH v4 1/2] gpio: loongson: add dts and acpi support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022, at 04:59, Yinbo Zhu wrote:
> 
>  config GPIO_LOONGSON
> -	bool "Loongson-2/3 GPIO support"
> -	depends on CPU_LOONGSON2EF || CPU_LOONGSON64
> +	bool "Loongson series GPIO support"
> +	depends on LOONGARCH || COMPILE_TEST

This looks like it will introduce a regression for users of the
older machines CPU_LOONGSON2EF and CPU_LOONGSON64 machines.

While the driver previously called 'platform_device_register_simple'
to create the platform device itself, this call is no longer
done anywhere, so it also cannot work here, but whatever was
working should not be broken. I can see two possible ways to do
this:

a) create the platform_device in the mips code in a way that
the driver can handle it as before

b) duplicate the entire driver and leave the old code untouched.

The second one is probably easier here, but the first one would
be nicer in the end, depending on how much of the original
code remains.

>  	help
> -	  Driver for GPIO functionality on Loongson-2F/3A/3B processors.
> +	  Driver for GPIO functionality on Loongson seires processors.

s/seires/series/

> +static void of_loongson_gpio_get_props(struct device_node *np,
> +				  struct loongson_gpio_chip *lgpio)
> +{
> +	const char *name;
> +
> +	of_property_read_u32(np, "ngpios", (u32 *)&lgpio->chip.ngpio);

This does not work: chip.ngpio is a 16-bit field, so you
cannot overwrite it using a 32-bit pointer dereference. Just
use a local variable as an intermediate

> +	of_property_read_string(np, "compatible", &name);
> +	lgpio->chip.label = kstrdup(name, GFP_KERNEL);
> +	if (!strcmp(name, "loongson,ls2k-gpio")) {
> +		lgpio->conf_offset = 0x0;

This probably works, but is not reliable since "compatible"
is an enumeration rather than a single string. Using
of_device_is_compatible() would work here, or even better
you can have a configuration that is referenced from
the 'data' field of the 'of_device_id'

> +static void acpi_loongson_gpio_get_props(struct platform_device *pdev,
> +				  struct loongson_gpio_chip *lgpio)
> +{
> +
> +	struct device *dev = &pdev->dev;
> +	int rval;
> +
> +	device_property_read_u32(dev, "ngpios", (u32 *)&lgpio->chip.ngpio);
> +	device_property_read_u32(dev, "gpio_base", (u32 *)&lgpio->chip.base);
> +	device_property_read_u32(dev, "conf_offset",
> +					(u32 *)&lgpio->conf_offset);
> +	device_property_read_u32(dev, "out_offset",
> +					(u32 *)&lgpio->out_offset);
> +	device_property_read_u32(dev, "in_offset", (u32 *)&lgpio->in_offset);

This looks worrying: While you addressed the feedback in the
DT binding, the ACPI version still uses the old format, which
the binding is different depending on the firmware.

A modern driver should not set the "gpio_base" any more, and
the firmware should not care either.

The other fields appear to correspond to the ones that the DT
version decides based on the device identifier. There isn't
really a point in doing this differently, so pick one version
or the other and then use the same method for both DT and ACPI.

> +static void platform_loongson_gpio_get_props(struct platform_device *pdev,
> +				  struct loongson_gpio_chip *lgpio)
> +{
> +}

> +	if (np)
> +		of_loongson_gpio_get_props(np, lgpio);
> +	else if (ACPI_COMPANION(&pdev->dev))
> +		acpi_loongson_gpio_get_props(pdev, lgpio);
> +	else
> +		platform_loongson_gpio_get_props(pdev, lgpio);

The third branch is clearly broken now as it fails to assign
anything. Using device_property_read_u32() etc should really
work in all three cases, so if you fold the
of_loongson_gpio_get_props and acpi_loongson_gpio_get_props
functions into one, that will solve the third case as well.

> +static const struct of_device_id loongson_gpio_dt_ids[] = {
> +	{ .compatible = "loongson,ls2k-gpio"},
> +	{ .compatible = "loongson,ls7a-gpio"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_gpio_dt_ids);
> +
> +static const struct acpi_device_id loongson_gpio_acpi_match[] = {
> +	{"LOON0002"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_gpio_acpi_match);
> +
>  static struct platform_driver loongson_gpio_driver = {
>  	.driver = {
>  		.name = "loongson-gpio",
> +		.owner = THIS_MODULE,
> +		.of_match_table = loongson_gpio_dt_ids,
> +		.acpi_match_table = ACPI_PTR(loongson_gpio_acpi_match),
>  	},

The ACPI_PTR() macro here means that you get an "unused variable"
warning when the driver is build with CONFIG_ACPI disabled.
I think you should just reference the variable directly. If you
want to save a few bytes, you can keep the ACPI_PTR() here
and enclose the struct definition in #ifdef CONFIG_ACPI.

    Arnd
