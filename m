Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42046677FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAWP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjAWP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:29:33 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004462A161
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:29:29 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:f8ca:19b4:6313:bc3])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 1C4BE5FFA6;
        Mon, 23 Jan 2023 16:29:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1674487767;
        bh=WbK/LG7M/k96SelRUF5n6606HzF8jzCjM42uzWQfHd4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=DJFTBEgKXmicNlV8FOTRamo+7Ni2jdCaPVA1I+9B/t/dSCRPVP921b0ROpWosA5Mb
         Rc28meg+Iwj0Jw/EW5BPXDYYPU/UZCeABSnN/J8z8RaXy/rkgPmTlMuIKn9cZcU6sj
         +IolQW6MvGwmrWYk+0BIoNny/LMc8BQ4nBxaK4a7VksqXiu1wtIGtilYrK64U3TjBd
         /0KP6iRdYXTYzRgTkBsr+BiRciVnAD4z6Ivughi4K8CfZJdjeNmoRG5r4B0jxAozEG
         girN5wtq8KWlOp2LRhgidhb2Fc/evHMW7zJcbFTyUmJXkBulNrZ209dAZznMwx2jX7
         p3fzxFg9/hC2w==
References: <20230117174117.3314951-1-arnd@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: irq: remove handle_IRQ() for good
Date:   Mon, 23 Jan 2023 16:28:08 +0100
In-reply-to: <20230117174117.3314951-1-arnd@kernel.org>
Message-ID: <m2fsc1gth6.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The only difference between generic_handle_irq() and the ARM
> handle_IRQ() version is now the range check, and in the 
> remaining
> drivers this does not appear to be needed any more.
>
> Remove this old interface and use the generic version in its 
> place.
For PXA:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
