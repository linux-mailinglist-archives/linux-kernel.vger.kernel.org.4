Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD286961ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjBNLHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjBNLGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:06:31 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39028D08;
        Tue, 14 Feb 2023 03:05:48 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9423e69038=fe@dev.tdt.de>)
        id 1pRsrk-0008Ic-5R; Tue, 14 Feb 2023 11:48:52 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pRsrj-000LHd-CQ; Tue, 14 Feb 2023 11:48:51 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 86A0D240049;
        Tue, 14 Feb 2023 11:48:50 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id EEAA8240040;
        Tue, 14 Feb 2023 11:48:49 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 907A52B4BF;
        Tue, 14 Feb 2023 11:48:49 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Feb 2023 11:48:49 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 2/2] leds: trigger: ledtrig-tty: add additional modes
In-Reply-To: <20230214101119.em547qt57swzylae@pengutronix.de>
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-3-fe@dev.tdt.de>
 <20230214101119.em547qt57swzylae@pengutronix.de>
Message-ID: <a969510df240fda32a5b57099c8f90a6@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1676371732-0E3ECD43-A35EFFCA/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

>> 
>> TD/RD:	Flash LED on data transmission (default)
>> CTS:	DCE Ready to accept data from the DTE.
>> DSR:	DCE is ready to receive and send data.
>> CAR:	DCE is receiving a carrier from a remote DTE.
>> RNG:	DCE has detected an incoming ring signal.
>> 
>> The mode can be changed for example with the following command:
>> echo "CTS" /sys/class/leds/<led>/mode
> 
> I wonder if the abstraction is better be done such that you can also
> configure the mode to trigger on (for example) TD and RNG. Then you'd
> need one property per signal and then something like the following 
> would
> be possible:
> 
> 	p=/sys/class/leds/<led>
> 	echo 1 > $p/tx
> 	echo 0 > $p/rx
> 	echo 1 > $p/rng

I thought about that before implementing this patch set, but then I 
discarded it.
Coding several states would then become confusing for someone who look 
at the LED.
I have now consciously decided that I want only display one state.

> 
> Best regards
> Uwe
