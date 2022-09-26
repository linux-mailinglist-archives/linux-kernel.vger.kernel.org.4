Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213C95EA77B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiIZNj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiIZNim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:38:42 -0400
Received: from mailserv1.kapsi.fi (mailserv1.kapsi.fi [IPv6:2001:67c:1be8::25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C497EF34D9;
        Mon, 26 Sep 2022 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=ext.kapsi.fi; s=20161220; h=Subject:Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Cc:To:From:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4mbOMHf/fk/JtjbGiWpqk8AGAG2riDe2iKjSk0qpj9Y=; b=y7MbOd5uzYaSxhjTlVkEUFqKQV
        Y5V+1cNTFt/d4YmoOS/ADSV65JbVrfuMAAPA4rmYTnbJ+sGHzVYCjwkQRDeO87hsecA5tH7vNCLnc
        VB/64n82952QVTOWCq1g6GCts9rxLm51Mygc7O2ER+ekIVLHEQnQcvWbR40OQqs/8ZQet4/IEHEs4
        WVgQLBL0L47JdShLJ6NxZUODbLmQ/L66seZDP1Q7i7ikUfzUB7HHkRzXsuBXhuATj87Bb0EuoBLTM
        jJZpqtxPr7vl/Akw3ZHhlRYeL8Ro8SxStOj1uD18Aq/otlWQLMJ6FKhtdfI2J0PySRzMtqKiUsCpS
        +KNj4h3A==;
Received: from [2001:67c:1be8::200] (port=58906 helo=roundcube.kapsi.fi)
        by mailserv1.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maukka@ext.kapsi.fi>)
        id 1ocmjA-001omW-G8; Mon, 26 Sep 2022 14:56:49 +0300
MIME-Version: 1.0
Date:   Mon, 26 Sep 2022 14:56:48 +0300
From:   maukka@ext.kapsi.fi
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220923180226.vmjcefxlujg2r6u3@pali>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi> <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi> <Yy2iqE8XgXe8qYd9@lunn.ch>
 <20220923180226.vmjcefxlujg2r6u3@pali>
Message-ID: <74f2b413a617a4315cc34a0ef386dd8d@ext.kapsi.fi>
X-Sender: maukka@ext.kapsi.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

On 23.9.2022 21:02, Pali Rohár wrote:
> On Friday 23 September 2022 14:12:24 Andrew Lunn wrote:
>> > > > +	if (of_machine_is_compatible("dlink,dns323a1")) {
>> > > > +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
>> > >
>> > > I spotted this in dns323-setup.c as well. Do you have any idea what it
>> > > does?
>> > >
>> >
>> > No idea. I have tried to replicate what was in dns323-setup.c as exactly as
>> > possible.
>> > I can try to leave it out and see if anything changes.
>> 
>> It is best to keep what we don't understand. It will be there for a
>> reason.
>> 
>> 	Andrew
> 
> Hello! I tried to index all publicly available Marvell SoC
> documentations into kernel documentation subfolder:
> https://docs.kernel.org/arm/marvell.html
> 
> For Orion there is linked Datasheet and User Manual, so you could try 
> to
> find in those documents that mentioned register and check what it is
> doing.

MPP_DEV_CTRL refers to register at address 0x10008. According to the 
88F5152 user manual it's
'Device Multiplex Control Register' Offset: 0x10008.

Bits    Field     Type/InitVal     Description
[31:0]  Reserved  RES 0x03FF0000   Reserved. NOTE: Must be 0x03FF0000'.

DEV_D[31:16] receives no hits in the documentation, only to DEV_D[15:0] 
are referred.

Maybe 88F5151 is different, hard to say.
