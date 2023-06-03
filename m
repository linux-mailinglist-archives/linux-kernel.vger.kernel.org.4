Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3DE721048
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 15:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjFCNyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 09:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFCNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 09:54:14 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8F9F
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 06:54:13 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 1de9284c-0216-11ee-b3cf-005056bd6ce9;
        Sat, 03 Jun 2023 16:54:11 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 16:54:10 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 0/7] iio: light: vcnl4000: Add features for
 vncl4040/4200
Message-ID: <ZHtGAn8ZF_fhgNQn@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230530142405.1679146-1-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 04:23:58PM +0200, Astrid Rost kirjoitti:
> Add a more complete support for vncl4040 and vcnl4200, which allows to
> change the distance of proximity detection and interrupt support for the
> illuminance sensor.
> 
> Proximity functionality:
>   - Interrupt support (new on vcnl4200).
> 
> Proximity reduce the amount of interrupts:
>   - Adaptable integration time (new on vcnl4200) - the sampling rate
>     changes according to this value.
>   - Period - interrupt is asserted if the value is above or
>     below a certain threshold.
> 
> Proximity change the activity distance:
>   - Oversampling ratio - Amount of LED pulses per measured raw value.
>   - Calibration bias - LED current calibration of the sensor.
> 
> Illuminance functionality:
>   - Interrupt support.
> 
> Illuminance reduce the amount of interrupts:
>   - Adaptable integration time - the sampling rate and scale changes
>     according to this value.
>   - Period – interrupt is asserted if the value is above or
>     below a certain threshold.

It's a good work, thank you for doing it!

But it has a lot of small style and inconsistent issues. They are not major
per se, but since there is more than 3, it makes sense to address. Also check
if you can split your patches to two or three where it makes sense.

-- 
With Best Regards,
Andy Shevchenko


