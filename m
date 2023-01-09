Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C81663182
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbjAIUbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjAIUbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:31:45 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE80265E;
        Mon,  9 Jan 2023 12:31:43 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 87E90100003;
        Mon,  9 Jan 2023 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673296302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbeX2CrSLjtCY8SfLZr2XWQhIHTZEUXfZrOhQs56VhQ=;
        b=nF/Jl9W/SdXPWGtHeblZji/VI6B8wsPNoYO7JyRSRpI4isyZZTrWYp1/az7+EtNTWEdgs5
        uiXn19t56Ou8MX3DsK1vpT94+zXMJ8TKuFmjVSrUgNWKHpnby/u/7U2BlCzvv8Q+U4w3Ts
        FEVynhvdZH4tDRgs50lglgxZAYUtnNb4OPtmRRIhFKkRozlqh1uNq98BCPj90exfV/SnkW
        4p1lGAL2dlIlhDfwtu4FVX4Xwfc3WsWO/VEduwF9lWURwSafSFYRunRFPVZPRB+rZ40Ty8
        jGhptF9gu6WWghVtRU93UhkDYAgoSbQ4XkaaCCjBYURR16LFOMXBEeGfofkWjA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Klaus Kudielka <klaus.kudielka@gmail.com>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "ARM: dts: armada-39x: Fix compatible
 string for gpios"
In-Reply-To: <Y7mpbOUmRYWw+8Wj@lunn.ch>
References: <20230107144149.5743-1-klaus.kudielka@gmail.com>
 <20230107144149.5743-2-klaus.kudielka@gmail.com>
 <Y7mpbOUmRYWw+8Wj@lunn.ch>
Date:   Mon, 09 Jan 2023 21:31:40 +0100
Message-ID: <874jszih5f.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Sat, Jan 07, 2023 at 03:41:49PM +0100, Klaus Kudielka wrote:
>> This reverts commit d10886a4e6f85ee18d47a1066a52168461370ded.
>> 
>> If compatible = "marvell,armadaxp-gpio", the reg property requires a
>> second (address, size) pair, which points to the per-CPU interrupt
>> registers <0x18800 0x30> / <0x18840 0x30>.
>> 
>> Furthermore:
>> Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
>> work reliably with per-CPU interrupts.
>> Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
>> reason.
>> 
>> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/fixes

Thanks,

Gregory
>
>     Andrew

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
