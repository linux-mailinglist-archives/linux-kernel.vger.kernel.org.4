Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D296ABA57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCFJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCFJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:50:01 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6751B2CB;
        Mon,  6 Mar 2023 01:49:59 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=0443564136=fe@dev.tdt.de>)
        id 1pZ7Te-000S4y-Oj; Mon, 06 Mar 2023 10:49:54 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pZ7Td-0004yY-W5; Mon, 06 Mar 2023 10:49:54 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 9BC29240049;
        Mon,  6 Mar 2023 10:49:53 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 14387240040;
        Mon,  6 Mar 2023 10:49:53 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id CF3B520E0D;
        Mon,  6 Mar 2023 10:49:52 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Mar 2023 10:49:52 +0100
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        pavel@ucw.cz, lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v8 0/3] leds: ledtrig-tty: add tty_led_mode xtension
In-Reply-To: <97e6f0ad-bc77-db86-5a8e-2f5e0a817662@kernel.org>
References: <20230306094113.273988-1-fe@dev.tdt.de>
 <97e6f0ad-bc77-db86-5a8e-2f5e0a817662@kernel.org>
Message-ID: <598bd1136138b83932323eab91faab70@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1678096194-2CB5A8D8-8055A542/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> 
>> here commes v8 of this series to add additional tty_led_modes.
> 
> I think u r 2 fast. Uwe had some more comments on v7.
> 
> Don't be afraid to wait some days after the last comments ;). As it
> is, it makes the review harder...
> 

That was probably a race condition ;-) This must have been received when 
I sent the v8.
