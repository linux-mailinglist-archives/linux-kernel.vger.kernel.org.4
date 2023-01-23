Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882B4677648
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjAWI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWI3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:29:31 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0216322
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:29:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FF5B5C00E1;
        Mon, 23 Jan 2023 03:29:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 23 Jan 2023 03:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674462567; x=1674548967; bh=ADDaCT7LRv
        3SPIh6BoxXQg5cKChUVADCO5GhHss33LQ=; b=uM0NHdNbqPzET5M7qo4iHWWdtY
        zuuwLn65XOoH7/Nn4MteHGuyTGWgz1LRMVbcwjARg5mgoT0KTqluIxNgwsDcnmSa
        etYV0r45rxDr3R9jbkN/17KMiVX/VodOZgFusB3YktUG1wJ3eK2inMUtIQVKYlz2
        hpdBqRrlikcy2QRUjm104sxOmuLPdx2ACWmm7UpXBud8IxsIziYClyDvpJ0CKvlL
        PrK7Fv1u6DzzEOILA55jTshI/UwOyLJ0rpBp3Jn9UN7EuxMwvgPWY0TDn6VKIhBP
        beZ06ohmMYio7jvTj7Wiiwm4f2v9OWSViNpSF9LG5bEOIUKXY10Yx6yTTR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674462567; x=1674548967; bh=ADDaCT7LRv3SPIh6BoxXQg5cKChU
        VADCO5GhHss33LQ=; b=TwnoHPvaHl9DX5lfgadGkxMSdygLGUf41zGRT1WUpMPH
        zJ0SmxrCj+dOU5yVfY0Y268vLST0YUWZ44aVOsG4U6e1+/TNKQEuwQHUw4HJcC0z
        TYieS73mpjrBwcnqpgnK9kCIfIbyl6rRTahYAQ3b0oZRNmq97cN4XdWgl7FQfRW6
        uVfEFLjyiwURAzr/dNQtNAVczmsmdBMOPtqbCymJdiLlZXo48jhKTxwLAUbSHKuZ
        FTO3Kc/fMPo8tOBRacaYhHLgyu+JkYY/ix1jL1XVrnCSCdjWq7F+KE6Nt51GpfY6
        a6Ohqursr/UErKaawht0bfSzFwbTrTBdZnbqh6QECw==
X-ME-Sender: <xms:ZkXOY4Yzyb9VA14m06-yOp1cO9BfjZA3V6pr2G_mLStYWIaU5Rxoow>
    <xme:ZkXOYzZwc2hbUohax4nxqNBqpk3JUHu5a5RhqFET-xUvPUVQE2DmqPF-YtW-82V9y
    pFRCTAu5Hpge7V56qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddujedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ZkXOYy-jH22bzegBh-XsigdamWCSBAWxPU-4WPjEn7aH0o6jsrJ-Sw>
    <xmx:ZkXOYyohTFnS84WkPDWOo_S87EgVwUoJfopgpNiLjHrGab6wYP6NPQ>
    <xmx:ZkXOYzqfMaY7tP0e35FLhEY6Ao2LHfW2clmVaHsATVeyjrTrA1DDTQ>
    <xmx:Z0XOY23gsyizSFQ3nSaDvYilZGKZfEfVY0xxx6F8uUVHNw1JWoHCPg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 085C2B60086; Mon, 23 Jan 2023 03:29:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <85b86d06-c63c-4481-a3dd-16b72572a5ee@app.fastmail.com>
In-Reply-To: <20230123073305.149940-7-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-7-lchen@ambarella.com>
Date:   Mon, 23 Jan 2023 09:29:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Li Chen" <lchen@ambarella.com>, "Li Chen" <me@linux.beauty>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "Lubomir Rintel" <lkundrak@v3.sk>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Brian Norris" <briannorris@chromium.org>,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Ambarella SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 06/15] soc: add Ambarella driver
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

On Mon, Jan 23, 2023, at 08:32, Li Chen wrote:
> This driver add soc_id support for Ambarella,
> which is stored inside "cpuid" AXI address mapping.
>
> Also provide sys_config(POC, aka power on configuration)
> for other drivers.
>
> Signed-off-by: Li Chen <lchen@ambarella.com>

The soc_id support looks ok

> Change-Id: I4869a3497366ac7779e792835f8e0309239036a8

Please drop these lines in the submission, the IDs are
not reachable outside of your own git, so we don't want
these to show up in the public history.

> +static struct ambarella_soc_id {
> +	unsigned int id;
> +	const char *name;
> +	const char *family;
> +} soc_ids[] = {
> +	{ 0x00483245, "s6lm",  "10nm", },
> +};

I would suggest something more descriptive in the "family"
field to let users know they are on an Ambarella SoC.

Maybe just "Ambarella 10nm".

> +static int __init ambarella_socinfo_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *np;
> +	struct regmap *cpuid_regmap;
> +	unsigned int soc_id;
> +
> +	cpuid_regmap = syscon_regmap_lookup_by_compatible("ambarella,cpuid");
> +	if (IS_ERR(cpuid_regmap))
> +		return PTR_ERR(cpuid_regmap);

Is there anything else in this syscon node? If the block
of registers only contains the identification bits, you
could just make this file a platform_driver that binds to
the node instead of using a syscon.

If there are other unrelated registers in there, the compatible
string should probably be changed to better describe the
entire area based on the name in the datasheet.

> +static unsigned int ambsys_config;
> +
> +unsigned int ambarella_sys_config(void)
> +{
> +	return ambsys_config;
> +}
> +EXPORT_SYMBOL(ambarella_sys_config);

Which drivers use this bit? Can they be changed to 
use soc_device_match() instead to avoid the export?

> +static int __init ambarella_soc_init(void)
> +{
> +	struct regmap *rct_regmap;
> +	int ret;
> +
> +	rct_regmap = syscon_regmap_lookup_by_compatible("ambarella,rct");
> +	if (IS_ERR(rct_regmap)) {
> +		pr_err("failed to get ambarella rct regmap\n");
> +		return PTR_ERR(rct_regmap);
> +	}
...
> +arch_initcall(ambarella_soc_init);

It is not an error to use a chip from another manufacturer,
please drop the pr_err() and return success here.

> +#ifndef __SOC_AMBARELLA_MISC_H__
> +#define __SOC_AMBARELLA_MISC_H__
> +
> +extern unsigned int ambarella_sys_config(void);
> +extern struct proc_dir_entry *ambarella_proc_dir(void);
> +

The ambarella_proc_dir looks like a stale entry that should be
removed. Ideally you should not need a private header at all.

    Arnd
