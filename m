Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B7A72103A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFCNqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFCNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:46:34 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18436123
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:46:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 0a710ade-0215-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 16:46:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 16:46:28 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 4/7] iio: light: vcnl4000: add illuminance irq
 vcnl4040/4200
Message-ID: <ZHtENLuHKixK884F@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
 <20230530142405.1679146-5-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142405.1679146-5-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 04:24:02PM +0200, Astrid Rost kirjoitti:
> Add support to configure ambient light sensor interrupts and threshold
> limits for vcnl4040 and vcnl4200. If an interrupt is detected an event
> will be pushed to the event interface.

...

> -	int ret;
> +	int ret = -EINVAL;

What is the purpose of this change?

...

> -	int ret;
> +	int ret = -EINVAL;

Ditto.


...

>  	int ret;
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
> +	switch (chan->type) {

Had you run checkpatch.pl? A definition block and a code should be delimited
by a blank line.

...

> -	int ret;
> +	int ret = -EINVAL;

Purpose?

...

> -	val = state ? (ret | mask) : (ret & ~mask);
> +		val = state ? (ret | mask) : (ret & ~mask);

I'm wondering if you can prepere the code by introducing switch-case instead of
current implementation in the preparatory patch and then do what you want to do
here. It will show much better the change and make review easier.

-- 
With Best Regards,
Andy Shevchenko


