Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9196914B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjBIXiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjBIXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:37:29 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEC027994
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:37:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 889AA320096C;
        Thu,  9 Feb 2023 18:35:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 Feb 2023 18:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1675985750; x=
        1676072150; bh=JOfA1zve2uYIe0/1WRppK6GlBT8MQYHItIokJ0eEGMI=; b=n
        f7woXzegwkj1R+Hn1r7/xE+qqVvLhEEmaa5eHBAa8AOtODeBCsCXMv8kW81VMVd6
        uvrKK/M82eDZ5SsaitQS3xlcV6tsp1NZy0k6y6gmaFh6Tfg1fwY6E5QHbVHbpzln
        vLvPvkthp8+BKFFbr/VLpP1dN7dgw7pdVSTPmlL3d/jro2T+qmU/gdcqyjQIwpUh
        eqVZUb0VreTa6gBbqNTgIua31R5OFbmorklE4XNzz6HcKkFiguApWtldwmPbS3hx
        xnyyCclRNxEh/EahOtHQQ2ljlLXRUc2JNXy2eMfTHKtSjP1Q9wEj/bvoL11iSf3M
        PXElMmTLjDlOGAahA9bbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1675985750; x=
        1676072150; bh=JOfA1zve2uYIe0/1WRppK6GlBT8MQYHItIokJ0eEGMI=; b=S
        6ADJCpv/8S9wqyLQXsxAv++IU6u2AWAu7acjrHZ3pKUr6m8hqkr7PewKNEZLOBRw
        wsEPf/7aO3sm1Pxo8+IniEKcnQRK/KXPb6ZNZ+w4eDyx911JejujiPkiVih30orS
        ozD+v3JXY/89r0W8wr/xDwOIcUZDY0sO+AHCVvAFfh9r4x5o/5OGOZp30RubQOov
        leCecTZOnQL3j1Yyt9QGoFbj6jAsg3W/dLFcrtuQ/8y9yWrUryp/G6PdWBBgGKRp
        pKpa2oJzCw70zfOybYkphMG8vH0scyl6Et2T5cSgT+OYH3ly3MZ8SMxBYNtyG7LP
        W82F7rPiRk7GV9RNtjD8w==
X-ME-Sender: <xms:VYPlY1RdIBlulpeWoDy0RRiZRgvchiOcYiRG3_GqJVftSolEo-sClA>
    <xme:VYPlY-xQB_Ds_PsTTrKDRqxUIgu5xoxPuKEddf2ShtNB1NGxwXr4yC6KD48LjYCmh
    bV1aT4C6Ccpkf2crw>
X-ME-Received: <xmr:VYPlY63Uwf4Cm0DmJhYPwAFyBvQZRI0sYpdEjM4Xm-Y80Yo8EOIckn0o4jHJZ_2GGmhROO9aF9h64wGoN8X2Hu-xwq_tSEt8aI0cWkA-zoB6Rk-OQt1gCQp7QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:VYPlY9Bn-vfvW32oe8NXuqBghhJUrA92qgHk98uOQI5uRbRKvLIzLA>
    <xmx:VYPlY-jX5t59AYloVesErqvcXITFTP4_ibiQPhiD7mNZGpMSr2ZjZA>
    <xmx:VYPlYxr6Cgm4SWhbkP8IqzFyZAx1pznZ8SuHWCdAnKZDCY4-G-9nTg>
    <xmx:VoPlYyju1h3H7rb5wef2f1N_WmgKW61DcrHADeU-MY27pYBwPwWMnA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Feb 2023 18:35:48 -0500 (EST)
Message-ID: <87a0a7c9-6069-b043-2fc2-8d1bc05ddb1a@sholland.org>
Date:   Thu, 9 Feb 2023 17:35:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <20230209232302.25658-1-palmer@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] clocksource/drivers/riscv: Refuse to probe on T-Head
In-Reply-To: <20230209232302.25658-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 2/9/23 17:23, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> As of d9f15a9de44a ("Revert "clocksource/drivers/riscv: Events are
> stopped during CPU suspend"") this driver no longer functions correctly
> for the T-Head firmware.  That shouldn't impact any users, as we've got

The current situation is that the C9xx CLINT binding was just accepted,
so the CLINT is not yet described in any devicetree. So at least with
upstream OpenSBI, which needs the CLINT DT node, the SBI timer extension
never worked at all.

> a functioning driver that's higher priority, but let's just be safe and
> ban it from probing at all.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> This feel super ugly to me, but I'm not sure how to do this more
> cleanly.  I'm not even sure if it's necessary, but I just ran back into
> the driver reviewing some other patches so I figured I'd say something.

This is not necessary as long as we add the riscv,timer node with the
riscv,timer-cannot-wake-cpu property before we add the CLINT node. So it
should not be a problem for any C9xx platform going forward.

Regards,
Samuel

> ---
>  drivers/clocksource/timer-riscv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index a0d66fabf073..d2d0236d1ae6 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -139,6 +139,22 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	if (cpuid != smp_processor_id())
>  		return 0;
>  
> +	/*
> +	 * The T-Head firmware does not route timer interrups to the core
> +	 * during non-retentive suspend.  This is allowed by the specifications
> +	 * (no interrupts are required to wake up the core during non-retentive
> +	 * suspend), but most systems don't behave that way and Linux just
> +	 * assumes that interrupts work.
> +	 *
> +	 * There's another timer for the T-Head sytems that behave this way
> +	 * that is already probed by default, but just to be sure skip
> +	 * initializing the SBI driver as it'll just break things later.
> +	 */
> +	if (sbi_get_mvendorid() == THEAD_VENDOR_ID) {
> +		pr_debug_once("Skipping SBI timer on T-Head due to missed wakeups");
> +		return 0;
> +	}
> +
>  	domain = NULL;
>  	child = of_get_compatible_child(n, "riscv,cpu-intc");
>  	if (!child) {

