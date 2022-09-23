Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BAF5E768E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIWJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIWJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:13:39 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606CC11DFF0;
        Fri, 23 Sep 2022 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Cc:To:From:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Pyy6eEQGqm5x0ptRrX3qFJPlzABRUcd93BdxWTrxRAc=; b=tqZuE5xcs/KT9n15zbg5lQSuYP
        6Y4ZugPX+vbHS6E5JQyJ7RZExVY1fjZCsX5gA5C2Br0voZuyv2uYsymAElmESaPnylEVbdNh45n8Q
        sWhFUUcHhO0rOS6sz1VQawNnAs/yK6w5/+ML23GK/h9/xHLV6EJ97lRMXXTmB0v3nyA4OPE4GLkNV
        tBPuYsANvbkyRsL4n8TDuheqBEFxgyUwf+eZRs2U7ilKTjzlZ6h003zrmTogWtFyTjNu1ESW6yTsi
        HBGTrOkjNeBmCHvBExFDB13YLXpfW7rVyG1C2ptEOPCUj/8C6tf6d9NrgABPWoRnFyK78k+slojyt
        +ge9Sfag==;
Received: from [2001:67c:1be8::200] (port=34582 helo=roundcube.kapsi.fi)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1obekO-009CI2-Mv; Fri, 23 Sep 2022 12:13:25 +0300
MIME-Version: 1.0
Date:   Fri, 23 Sep 2022 12:13:24 +0300
From:   maukka@ext.kapsi.fi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Olof Johansson <olof@lixom.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <89f85393-c767-4c0c-90db-d78a2927d465@www.fastmail.com>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <89f85393-c767-4c0c-90db-d78a2927d465@www.fastmail.com>
Message-ID: <f6a27b077f8b595e9c74152f1fa3c780@ext.kapsi.fi>
X-Sender: maukka@ext.kapsi.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:1be8::200
X-SA-Exim-Mail-From: maukka@ext.kapsi.fi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mailserv1.kapsi.fi)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.9.2022 00:39, Arnd Bergmann wrote:
> On Thu, Sep 22, 2022, at 10:24 PM, Mauri Sandberg wrote:
>> +
>> +/* dns323_parse_hex_*() taken from tsx09-common.c; should a common
>> copy of these
>> + * functions be kept somewhere?
>> + */
>> +static int __init dns323_parse_hex_nibble(char n)
>> +{
>> +	if (n >= '0' && n <= '9')
>> +		return n - '0';
>> +
>> +	if (n >= 'A' && n <= 'F')
>> +		return n - 'A' + 10;
>> +
>> +	if (n >= 'a' && n <= 'f')
>> +		return n - 'a' + 10;
>> +
>> +	return -1;
>> +}
>> +
>> +static int __init dns323_parse_hex_byte(const char *b)
>> +{
>> +	int hi;
>> +	int lo;
>> +
>> +	hi = dns323_parse_hex_nibble(b[0]);
>> +	lo = dns323_parse_hex_nibble(b[1]);
>> +
>> +	if (hi < 0 || lo < 0)
>> +		return -1;
>> +
>> +	return (hi << 4) | lo;
>> +}
>> +
> 
> Can you use simple_strntoull() to parse the address into a u64 instead?
> 
Nice idea. Its current replacement seems to be kstrtoull(). I'll have to 
do
it byte by byte, right? Or what do you have in mind with 64bit unsigned?

>> +static int __init dns323_read_mac_addr(u8 *addr)
>> +{
>> +	int i;
>> +	char *mac_page;
>> +
>> +	/* MAC address is stored as a regular ol' string in /dev/mtdblock4
>> +	 * (0x007d0000-0x00800000) starting at offset 196480 (0x2ff80).
>> +	 */
>> +	mac_page = ioremap(DNS323_NOR_BOOT_BASE + 0x7d0000 + 196480, 1024);
>> +	if (!mac_page)
>> +		return -ENOMEM;
> 
> It would be nicer to use of_iomap() on the nor device than a
> hardcoded physical address here, at least if that doesn't add
> too much extra complexity.
> 

I'll look into this.
