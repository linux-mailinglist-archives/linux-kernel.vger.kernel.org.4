Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030ED679DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjAXPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjAXPq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:46:29 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605C6A45
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:46:28 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6285932002FB;
        Tue, 24 Jan 2023 10:46:27 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 24 Jan 2023 10:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674575186; x=1674661586; bh=Gk83FnAdUE
        syXvflFK7DVR+IxkdYGScYi8WPtKi/v3M=; b=d7CMGUbsBnOSJXUNFchsOjYZDg
        5W9TxTm3ZHkPb/xodBLAS78YS8gbfi6G7WPqnDhaKgOQ+DWCD+xMWmiZ0dggD9uJ
        z2BEs6tp3bSmiY2FUtsB0wdT6gUJz08UKp8tawl5bX5fTcn2HujqkUWNi74Gh4Di
        NrunHknEW0YWEJ2NAvr01KEx5WTcPc2XK/ssgIePdCVlan2NkAZka9RcIoAbeGb1
        1iW9MCYOjLXZ9yb5UluMkCqzl9Q7/SrMv8B5wgaxQKYRKTQ2N8zVFq/nJS69atnd
        4uUdHfaTNKMGMQ8umpdpx52ftSKl9oPKJLwhs2KhC6uI6PVnLx6zxz0LFTww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674575186; x=1674661586; bh=Gk83FnAdUEsyXvflFK7DVR+IxkdY
        GScYi8WPtKi/v3M=; b=VEw+GnffiG/Vy7njcar5zL23D3Uzm7DUfRAxJIYfiyhL
        0PkSQEYmeLC35ob0KN6VEj33V3odxvg3MXtOb9arm+v6AYg1jJX+AWg5UO/Wp7Kx
        wxnC4f8rIDMJJKC8+AogkZauBWtZ9ZAGQBJ5StJW/anLzyvHoaMCmdhCwmFPOFX+
        pr10d7fetcBBo+LnOYPDba+aEnQ//OcpNSbA45cgvr/D5ncpIaC7Ers6E8/duLeH
        Xt1BR6UNU81qd9PG+rsJLh8eEAryBL/ARUXNpjlhBK6oQI+3i/EVIGnHE+hIJMTZ
        J9a1SeyJNRSr1G4GM8JYIM6ezjM++dJB5qsibHS2qA==
X-ME-Sender: <xms:Uf3PYyAbYIWv2O6S6kVmGQZhhhF1m6bohopPXl-pS1SiVOizpw_zRw>
    <xme:Uf3PY8howCt4J1YXyRtjyZICImFDLxYrnhAjnAUKuhIbWeIQKgdQsirfYyNnp1R9e
    sNT3ZvBz8W2hKpZHX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Uf3PY1ml0H4tHxzn9IDdxH7GpTXJB4quTrfkAjHGruNRjlDxWzcjgA>
    <xmx:Uf3PYwzJU1TNeoBVaT7cAvkrOvs9QfbNzBKhpuGXJCrUgyZTR8xTBQ>
    <xmx:Uf3PY3QmoSmZxZBU3MRV-ENdCWvT277LBmRrsaQNf0uH-ulf7ic7Ng>
    <xmx:Uv3PY89EXcef0JgtN0-77xvcL6-4n3KZN5AUZR_WOcaxDolNpv01FA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6E415B60086; Tue, 24 Jan 2023 10:46:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <8e404cef-52fb-49a2-a91b-8e3c60407ddd@app.fastmail.com>
In-Reply-To: <871qnkicsi.wl-me@linux.beauty>
References: <20230123073305.149940-1-lchen@ambarella.com>
 <20230123073305.149940-7-lchen@ambarella.com>
 <85b86d06-c63c-4481-a3dd-16b72572a5ee@app.fastmail.com>
 <871qnkicsi.wl-me@linux.beauty>
Date:   Tue, 24 Jan 2023 16:46:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Li Chen" <me@linux.beauty>
Cc:     "Li Chen" <lchen@ambarella.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023, at 08:58, Li Chen wrote:
> On Mon, 23 Jan 2023 16:29:06 +0800,
> Arnd Bergmann wrote:
>> On Mon, Jan 23, 2023, at 08:32, Li Chen wrote:
>> > +static struct ambarella_soc_id {
>> > +	unsigned int id;
>> > +	const char *name;
>> > +	const char *family;
>> > +} soc_ids[] = {
>> > +	{ 0x00483245, "s6lm",  "10nm", },
>> > +};
>>
>> I would suggest something more descriptive in the "family"
>> field to let users know they are on an Ambarella SoC.
>>
>> Maybe just "Ambarella 10nm".
>
> There is a "pr_info("Ambarella SoC %s detected\n", 
> soc_dev_attr->soc_id);" in this file,
> I think this should be enough, right?

The pr_info() can probably be removed here, or reworded
based on the changed contents, those are just meant for
humans reading through the log rather than parsed by
software.

The soc_id fields on the other hand need to be parsable
by scripts looking at the sysfs files, in a way that lets
them identify the system. Usually the script would look
at the "family" as the primary key before looking up the
"name", so you have to make sure that the family uniquely
identifies this as one of yours rather than a 10nm chip
from some other company.

>> If there are other unrelated registers in there, the compatible
>> string should probably be changed to better describe the
>> entire area based on the name in the datasheet.
>
> Yeah, this block is only used for identification bits. In datasheet,
> it is also named "CPU ID".

ok.

> Other than cpuid_regmap, this driver also looks for "model" name as soc 
> machine name:
> of_property_read_string(np, "model", &soc_dev_attr->machine);
>
> So I think it is not a good idea to conver it to into a platform driver.

I don't understand what you mean. A lot of soc_id drivers put
the model string into soc_dev_attr->machine, this makes no
difference here.

> As for "syscon", I think it is still very helpful to get regmap easily. 
> Generally speaking,
> I prefer regmap over void*, because it has debugfs support, so I can 
> get its value more easily.

What value would you get through debugfs that is not already in
the soc_device?

>> > +static unsigned int ambsys_config;
>> > +
>> > +unsigned int ambarella_sys_config(void)
>> > +{
>> > +	return ambsys_config;
>> > +}
>> > +EXPORT_SYMBOL(ambarella_sys_config);
>>
>> Which drivers use this bit? Can they be changed to
>> use soc_device_match() instead to avoid the export?
>
> sys_config is used by our nand and sd drivers. I also don't want to export,
> but struct soc_device_attribute/soc_device don't have private data to store it,
> I think there is no better way.

The nand and sd drivers should not rely on any private data
from another driver. What information do they actually
need here that is not already in their own DT nodes or
in the soc_device_attributes?

>> > +static int __init ambarella_soc_init(void)
>> > +{
>> > +	struct regmap *rct_regmap;
>> > +	int ret;
>> > +
>> > +	rct_regmap = syscon_regmap_lookup_by_compatible("ambarella,rct");
>> > +	if (IS_ERR(rct_regmap)) {
>> > +		pr_err("failed to get ambarella rct regmap\n");
>> > +		return PTR_ERR(rct_regmap);
>> > +	}
>> ...
>> > +arch_initcall(ambarella_soc_init);
>>
>> It is not an error to use a chip from another manufacturer,
>> please drop the pr_err() and return success here.
>
> Ok, good to know, thanks. But we don't have other manufacturers at 
> least for now,

I care a lot about supporting multiple SoC vendors, it would seem
very rude to assume that we stop supporting everything else after
merging Ambarella support.

> and rct_regmap is need to be updated here, like sys_config and soft 
> reboot. So I think this rct regmap is still needed.

It is certainly only needed on Ambarella SoCs, no other one
has this device at the moment.

      Arnd
