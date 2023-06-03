Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89278720FFF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFCMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFCMIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:08:21 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86DDCE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 05:08:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 538cd1df-0207-11ee-abf4-005056bdd08f;
        Sat, 03 Jun 2023 15:08:18 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 15:08:18 +0300
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: Re: [PATCH v5 1/7] iio: light: vcnl4000: Add proximity irq for
 vcnl4200
Message-ID: <ZHstMjiCKg2KNFJM@surfacebook>
References: <20230530142405.1679146-1-astrid.rost@axis.com>
 <20230530142405.1679146-2-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530142405.1679146-2-astrid.rost@axis.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, May 30, 2023 at 04:23:59PM +0200, Astrid Rost kirjoitti:
> Add proximity interrupt support for vcnl4200 (similar to vcnl4040).
> Add support to configure proximity sensor interrupts and threshold
> limits. If an interrupt is detected an event will be pushed to the
> event interface.

>  	int (*set_power_state)(struct vcnl4000_data *data, bool on);
>  	irqreturn_t (*irq_thread)(int irq, void *priv);
>  	irqreturn_t (*trig_buffer_func)(int irq, void *priv);

+ Blank line?

> +	u8 int_reg;


-- 
With Best Regards,
Andy Shevchenko


