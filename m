Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDB6E8DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjDTJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:18:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93555213F;
        Thu, 20 Apr 2023 02:18:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 009CF5C0274;
        Thu, 20 Apr 2023 05:18:07 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 20 Apr 2023 05:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681982286; x=1682068686; bh=3n
        hZjDHaJ334FIWpuzMOE5F3Bk26E5LBcaIBNbWiCzs=; b=PFCjMVFR8xWZt8hxXM
        6f3m+Y7Y38EftWG0FyTkI2OrmjO7kKXG2+pBmoKTG7zkH7QeZwHDh/r89IZMUEuG
        qNUHDnmXnyk+rrVtFdQAay6d3oIDWV3j4D74qje5vIHq+pI4l/1mMMCPxqRRAjYT
        0XoZTif3wsRjrRvahKl8GqmsHDAzXv1JowSUwjntxHauyCC1K2pyjFr5S2NiWGG6
        DL6j11D4CtCkvQzqdxTDy9DWgxlWwvnQ5s16Y2Djai6AhRYBy6IHNIR9RIXzcROg
        FcpaD2n6+RA4MblHQQ6rl6jSCi3GlE272tZte9tIsYYQz96l16HTeCIisCFsKbW4
        wyZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681982286; x=1682068686; bh=3nhZjDHaJ334F
        IWpuzMOE5F3Bk26E5LBcaIBNbWiCzs=; b=Dj+Tz4LUdxf5mrYe1vSPX4w5L88GB
        /oKyJpJTTpHlYIKDmAtTDKJwQReHek+u4PAEleuSt/9AXCgNGYhBWlgDYEG57C7t
        hHuEcWDAE7UghA2xS5goMqU5orHu5WcbS55Lpz7CBM0wczb45NuEqH32ngGmyrZh
        o2+B0tRwLaG0QdItw7w8CyQeTSis2YySt/fpElsA8OAOVyUx7DCzZlG8AZ2/OZqr
        nu5bFpYf61+yI0U4bWEeGWccVSCs8IqOPgP/QPwD4LaIFrqpPwbyEUjJPM3r97X8
        Qf3d/LLvIq1k/UNxVrrhvAS6SQuDAEtDO+q1wxu0fDcLrw5ZRgNKqhvQg==
X-ME-Sender: <xms:TANBZNAhuCKcpmXTJhnN-G5jtlrWllJkb9331vkfjroMSg1mRuqqDg>
    <xme:TANBZLhhfQodelQ0OBVuDIFvU7JqawIrR56NrrWnJrcgS57OhEiBd4UBTx97iyJM3
    QdE0q-NSG846yMFDts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TANBZIlDLrqFvujtpfKpLWtjTwThTuO-4FXe-VWKHnsQp_4x4BcLrQ>
    <xmx:TANBZHxDjyvV1K9HfnBkZfxtuZF_vy5PVHYP-Ai_oyrtGXumXx8IXw>
    <xmx:TANBZCToND1viv1EnxFRD6IplUkQbqMlrj-KFYC5m872jLPIH27tAQ>
    <xmx:TgNBZHLL9TTkS8V-CHLVE89zPUw-ko75V7aQ9_uX4Il_BV1L309JtQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01915B60086; Thu, 20 Apr 2023 05:18:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <acf525da-9a22-472f-abbb-6d1519be8d2a@app.fastmail.com>
In-Reply-To: <20230420090101.80812-2-pawell@cadence.com>
References: <20230420090101.80812-1-pawell@cadence.com>
 <20230420090101.80812-2-pawell@cadence.com>
Date:   Thu, 20 Apr 2023 11:17:43 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Pawel Laszczak" <pawell@cadence.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daisy.Barrera@siriusxm.com, Cliff.Holden@siriusxm.com,
        "Tony Lindgren" <tony@atomide.com>,
        "Jean Delvare" <jdelvare@suse.de>, neal_liu@aspeedtech.com,
        "Linus Walleij" <linus.walleij@linaro.org>, egtvedt@samfundet.no,
        "Biju Das" <biju.das.jz@bp.renesas.com>, herve.codina@bootlin.com
Subject: Re: [PATCH v2 1/4] usb: cdns2: Device side header file for CDNS2 driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023, at 11:00, Pawel Laszczak wrote:
> Patch defines macros, registers and structures used by
> Device side driver.
>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

> +struct cdns2_ep0_regs {
> +	__u8 rxbc;
> +	__u8 txbc;
> +	__u8 cs;
> +	__u8 reserved1[4];
> +	__u8 fifo;
> +	__le32 reserved2[94];
> +	__u8 setupdat[8];
> +	__u8 reserved4[88];
> +	__u8 maxpack;
> +} __packed;

> +struct cdns2_epx_base {
> +	__le16 rxbc;
> +	__u8 rxcon;
> +	__u8 rxcs;
> +	__le16 txbc;
> +	__u8 txcon;
> +	__u8 txcs;
> +} __packed;

> +struct cdns2_epx_regs {
> +	__le32 reserved[2];
> +	struct cdns2_epx_base ep[15];
> +	__u8 reserved2[290];
> +	__u8 endprst;
> +	__u8 reserved3[41];
> +	__le16 isoautoarm;
> +	__u8 reserved4[10];
> +	__le16 isodctrl;
> +	__le16 reserved5;
> +	__le16 isoautodump;
> +	__le32 reserved6;
> +	__le16 rxmaxpack[15];
> +	__le32 reserved7[65];
> +	__le32 rxstaddr[15];
> +	__u8 reserved8[4];
> +	__le32 txstaddr[15];
> +	__u8 reserved9[98];
> +	__le16 txmaxpack[15];
> +} __packed;

Register structures should generally not be __packed, otherwise
any multi-byte registers will be accessed as individual bytes
on architectures that have no unaligned load/store.

If you are worried about struct packing on OABI arm, you can
mark it as both __packed and __aligned(4). Most drivers just
avoid the problem by not defining these as structures but instead
use macros with register offsets.

      Arnd
