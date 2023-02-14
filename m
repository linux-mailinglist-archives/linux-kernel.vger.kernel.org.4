Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D12695EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBNJSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBNJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:18:08 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980038A7F;
        Tue, 14 Feb 2023 01:18:05 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9423e69038=fe@dev.tdt.de>)
        id 1pRrRm-00053o-M8; Tue, 14 Feb 2023 10:17:58 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pRrRl-000FyV-UA; Tue, 14 Feb 2023 10:17:57 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 7F4C2240049;
        Tue, 14 Feb 2023 10:17:57 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id EB8C0240040;
        Tue, 14 Feb 2023 10:17:56 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id A568D2CFA8;
        Tue, 14 Feb 2023 10:17:56 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Feb 2023 10:17:56 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH 1/2] tty: new helper function tty_get_mget
In-Reply-To: <5f67e2cf-f141-fde4-96de-28ceeeec9c06@kernel.org>
References: <20230213140638.620206-1-fe@dev.tdt.de>
 <20230213140638.620206-2-fe@dev.tdt.de>
 <5f67e2cf-f141-fde4-96de-28ceeeec9c06@kernel.org>
Message-ID: <00390b00bf50f42ff112ee8e31b88c8d@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate-ID: 151534::1676366278-1EFFD8D8-AC9FBD0F/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> --- a/include/linux/tty.h
>> +++ b/include/linux/tty.h
>> @@ -419,8 +419,9 @@ void tty_unthrottle(struct tty_struct *tty);
>>   int tty_throttle_safe(struct tty_struct *tty);
>>   int tty_unthrottle_safe(struct tty_struct *tty);
>>   int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
>> -int tty_get_icount(struct tty_struct *tty,
>> +int tty_get_icount(struct tty_struct *tty
> 
> The robot already complained about this ^^^.
> 
> Have you even tried to compile-test this?

Sorry I made a rebase of the patch set. My mistake!
I compiled and tested my changes against kernel 5.15 (OpenWrt).
And it worked as expected.

> 
>>   		struct serial_icounter_struct *icount);
>> +extern int tty_get_mget(struct tty_struct *tty);
> 
