Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6845E6E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIVVjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIVVjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:39:33 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02549CCE;
        Thu, 22 Sep 2022 14:39:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2A95C580C35;
        Thu, 22 Sep 2022 17:39:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 17:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663882769; x=1663886369; bh=rpJ5dLDrBG
        4RU2npy0gA4zAAD6oKp0YoLCGtrhyhwEM=; b=e4zS8LqI3yZPrJ+kkUrj70ZFD4
        pLzwXvjt8XarDbM7nDHjDrD7qKf+KoQ89l/2laVX9UfwOXPt3/YPUGWwXyMmMpDY
        2XK4dwJwerK/r9FjarhLLJ2871v0hh/j/OEG4Ow+IsQgFC+Sn/7y+ybfiCK/JUCT
        W+0EXiKgYsqDF1r+yfmpdauELR4CTUn2CARYSL5LV00you2XTJBJZ2b7+jFh0raF
        ut63oi8KRVmnAXp9/pVbIfm8cAPEP4DygOPIQW8js1uCFrcpsXkiC3m5LEOilV19
        eH+3BvPoyBjZTUNWBN6BRmQggu6BtzcGmvuwWxU3MF9WZPt03BMwdD+s0kBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663882769; x=1663886369; bh=rpJ5dLDrBG4RU2npy0gA4zAAD6oK
        p0YoLCGtrhyhwEM=; b=dohe/pkCtrPN9juvk7SNrhiPPryqGHwv/LuY11IO2HYP
        P9UJUSIo0oGRPi9TTlZlevubxSpTYyd1nUJHHpqQghC7WXs7FEDry/zBif1kVWCI
        uSBOrLO9RBYEYsEbupgqrcAKecqApNzp/CSR1+AO2ksCP0fZB65Rr/KQQPfPzwCa
        5R+DWCsiaay6e0+4OB8gtYqDJRdjCx4WEpQo6pQmvKrsfEKSGLBN2wYpWZZkW3B8
        /JJM9JoEPCjyH5BaOtkTDbUpu1o1TLZ/cU2d1CDOs2gHD3Y0U5zTY7MJIU/1G9eS
        GQkvFOdSz7cmS0tAA0GqSpAYy4f8qZI3DnOlXz6nLw==
X-ME-Sender: <xms:ENYsYyK6Yn_0rZJ8N40D4RClChiuYBU414b9pR_BXSE-v37oNKvAlA>
    <xme:ENYsY6LokUsFw-r2xHrLdD34qu098uEJR1Ih5mViVAmt0hUptIikBIoOvoXbVSG0a
    lq7_2Bmf5Ga4pjxc5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ENYsYyvx2SxCsAwt62keXyaxxfbUJ0Sy_PqnAgQYhzWD9Pvqs8gJ1g>
    <xmx:ENYsY3a9_8nKVIBF3aTNvCP2ld6b4i3_ZE1I2ApSK6Gl01r7BVaP6A>
    <xmx:ENYsY5ZzJ_8Naxql2ueZcPSg0Q4qSiQRbwPrLVROH3asoaxUQ9dqQA>
    <xmx:EdYsY7kn93-xv4nFI2RpnAyNrnFEJM17ZSBqDducZjim7q1EMUzwPw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4ED65B60089; Thu, 22 Sep 2022 17:39:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <89f85393-c767-4c0c-90db-d78a2927d465@www.fastmail.com>
In-Reply-To: <20220922202458.7592-4-maukka@ext.kapsi.fi>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
Date:   Thu, 22 Sep 2022 23:39:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mauri Sandberg" <maukka@ext.kapsi.fi>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Olof Johansson" <olof@lixom.net>, "Andrew Lunn" <andrew@lunn.ch>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Russell King" <linux@armlinux.org.uk>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device Tree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022, at 10:24 PM, Mauri Sandberg wrote:
> +
> +/* dns323_parse_hex_*() taken from tsx09-common.c; should a common 
> copy of these
> + * functions be kept somewhere?
> + */
> +static int __init dns323_parse_hex_nibble(char n)
> +{
> +	if (n >= '0' && n <= '9')
> +		return n - '0';
> +
> +	if (n >= 'A' && n <= 'F')
> +		return n - 'A' + 10;
> +
> +	if (n >= 'a' && n <= 'f')
> +		return n - 'a' + 10;
> +
> +	return -1;
> +}
> +
> +static int __init dns323_parse_hex_byte(const char *b)
> +{
> +	int hi;
> +	int lo;
> +
> +	hi = dns323_parse_hex_nibble(b[0]);
> +	lo = dns323_parse_hex_nibble(b[1]);
> +
> +	if (hi < 0 || lo < 0)
> +		return -1;
> +
> +	return (hi << 4) | lo;
> +}
> +

Can you use simple_strntoull() to parse the address into a u64 instead?

> +static int __init dns323_read_mac_addr(u8 *addr)
> +{
> +	int i;
> +	char *mac_page;
> +
> +	/* MAC address is stored as a regular ol' string in /dev/mtdblock4
> +	 * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
> +	 */
> +	mac_page = ioremap(DNS323_NOR_BOOT_BASE + 0x7d0000 + 196480, 1024);
> +	if (!mac_page)
> +		return -ENOMEM;

It would be nicer to use of_iomap() on the nor device than a
hardcoded physical address here, at least if that doesn't add
too much extra complexity.

     Arnd
