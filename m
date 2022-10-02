Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A535F21AC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJBHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJBHPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 03:15:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A74360C
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 00:15:38 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oetBv-00021X-Pp; Sun, 02 Oct 2022 09:15:11 +0200
Message-ID: <5da3593c-1607-9075-e1ac-1e384fd62b93@pengutronix.de>
Date:   Sun, 2 Oct 2022 09:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Documentation: x86: boot: reserve type_of_loader=13 for
 barebox
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, barebox@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220513143039.2065756-1-a.fatoum@pengutronix.de>
 <YzjDHOWkIoWF+h/R@zn.tnic>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <YzjDHOWkIoWF+h/R@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 02.10.22 00:45, Borislav Petkov wrote:
> On Fri, May 13, 2022 at 04:30:39PM +0200, Ahmad Fatoum wrote:
>> barebox built as EFI payload has been booting Linux on x86 with
>> type_of_loader=0xff since v2015.09.0.
> 
> What is barebox?
> 
> That https://en.wikipedia.org/wiki/Barebox ?

Yes.

> 
> That version number v2015 - am I to understand it that it has been
> booting Linux since the year 2015?
> 
> In any case, it would be useful to explain a bit what it is here.

Release cadence is monthly. Starting with release v2015.09.0,
type_of_loader=0xff was being used. I figured it's about time, we
allocate an ID for it.

> 
>> Reserve 13, the next free id, so this can be used instead.
> 
> Sure, I guess, why not.
> 
> Thx.
Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
