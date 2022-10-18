Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684076032D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJRSvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJRSvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:51:35 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69726CB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:51:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5161D320015C;
        Tue, 18 Oct 2022 14:51:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 14:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666119087; x=1666205487; bh=3RC7vjx470
        1esgCkuWvNG5/6JY7MnC1sAs73PlHoeiQ=; b=D8g0GXL8A6vRp6/fbp1VXzYpXZ
        dEITLY0IbO3QT47HK+6XTXlZMB2BfqCK+WCKaKGx4z02RqHbaV3Ak2yqwcANznub
        3ll9zNhTSWUO3mw1Ua+zQdCc0h8YtuWqNfhwG4I4bw2kMg2be3lSnhLXHt+zqmLB
        c11ua2ndkWWo6MgMiCmEjg5AP2Fy+fpcq9IoQDOmOoXXUzQe+gdCKnyFMefWvU7K
        ALq9/6nqIidqxu5tY59xwlOeSmdbk57uyrh/NnyO3TggGcF4K168ZRcv4MliXbdV
        brnqF/t519QvJZmuTZ4pwY1fWPWyTaFQUXzflDFM9XNlN7DFNlFBCw4Dp+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666119087; x=1666205487; bh=3RC7vjx4701esgCkuWvNG5/6JY7M
        nC1sAs73PlHoeiQ=; b=iFevmzKcvQ2zxCaanVDxSg7ul4jm5nRxURMijHT/lq0R
        ez1fQefThF01ucRMUlKyPuCXIjMmsYN3uqAD/53i8EPOYBH4zj5jyoN/8K8z8MM7
        6K1smqR2dUo051gX1i4uO/vp4PQwy9rU5Tx5X+8dmLvoXP0LwVLEK9a8NU1enT8p
        UaWdzw+v0DRzuOaXPl1G/8G2kdl8x9FTL4JeuRb5HEyZnxHpTBW5ZwyXu2hwUv/S
        W+XncV58VwoYrqYjiGtqpZ4QS9ZA7ljDiFcn3UKo5pO7gFeWP1yFJ89dguwbsceo
        +YDfpvWpxBm/RyoAGD2cLGei8NjNbwQXn24/zbVlZw==
X-ME-Sender: <xms:r_VOY1_uylDNqMMQI49RAK1wtSPHUzrXEfUk-wcn68XjkG4HT4yMog>
    <xme:r_VOY5v0GiLXn85GEx7F4g-aAk10RDVS1AjxfXWLZ5OT1XduGz3rfFnugeUzPTWmR
    1ggPiHwlqC_dg3nIRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:r_VOYzDAgZ2gn6ZbwlAHjiuJ20a1tKS5qE-hNRKVRn9g1ji6xYvvwQ>
    <xmx:r_VOY5dgDbTYZLFWqaPt_JkLoOOlbNr8LZT5riE5JwWbUoilimn_hA>
    <xmx:r_VOY6OO8ee7igBnQ-VICFTe4fMOrA53oElCux_7K2XvasQsJBXCww>
    <xmx:r_VOY3pNM86GuF6zhzZMoIOmQ-cS4ojG-uk4ddtelBmp5LfY5CkyLw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 42077B60086; Tue, 18 Oct 2022 14:51:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <b4011de0-d5a4-4083-aa0d-2fe5861ba4d6@app.fastmail.com>
In-Reply-To: <868rldf5qx.wl-maz@kernel.org>
References: <20221018133034.10442-1-firas.ashkar@savoirfairelinux.com>
 <868rldf5qx.wl-maz@kernel.org>
Date:   Tue, 18 Oct 2022 20:51:01 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Marc Zyngier" <maz@kernel.org>,
        "Firas Ashkar" <firas.ashkar@savoirfairelinux.com>
Cc:     alex@digriz.org.uk, "Thomas Gleixner" <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, inux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip: add TS7800v1 fpga based controller driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022, at 18:36, Marc Zyngier wrote:

>>  }
>> @@ -371,6 +418,12 @@ static int ts78xx_fpga_load_devices(void)
>>  {
>>  	int tmp, ret = 0;
>>  
>> +	if (ts78xx_fpga.supports.ts_irqc.present == 1) {
>> +		tmp = ts_irqc_load();
>> +		if (tmp)
>> +			ts78xx_fpga.supports.ts_irqc.present = 0;
>> +		ret |= tmp;
>> +	}
>>  	if (ts78xx_fpga.supports.ts_rtc.present == 1) {
>>  		tmp = ts78xx_ts_rtc_load();
>>  		if (tmp)
>> @@ -402,6 +455,8 @@ static int ts78xx_fpga_unload_devices(void)
>>  		ts78xx_ts_nand_unload();
>>  	if (ts78xx_fpga.supports.ts_rng.present == 1)
>>  		ts78xx_ts_rng_unload();
>> +	if (ts78xx_fpga.supports.ts_irqc.present == 1)
>> +		ts_irqc_unload();
>>  
>>  	return 0;
>>  }
>
> I am absolutely *NOT* keen on adding more non-DT stuff in this day and
> age. The DT effort has been going on for over 10 years, and maybe it
> is time that this board makes the jump before we add anything new to
> it, specially given that there is a DT board for this platform.
>
> Arnd, what's your call on this?

I'm in the middle of sending out the patch series that removes
most of the legacy board files:

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=boardfile-remove

TS78xx actually stays for now because this is one of the
machines enabled in the debian armel tree, but my hope is
for the remaining 27 board files, we can either complete
the DT conversion or just remove them in the future.

Aside from the FPGA, this machine should be fairly easy to
convert, so I agree we should try doing this first. Not
sure how the FPGA is best represented, but I'm sure we can come
up with something once the rest of the system is working
with DT.

      Arnd
