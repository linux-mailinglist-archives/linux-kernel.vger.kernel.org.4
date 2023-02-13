Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C45695382
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBMV6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBMV56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:57:58 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 13:57:38 PST
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABCF222EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:57:38 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 4757e5b8-abe9-11ed-ab57-005056bd6ce9;
        Mon, 13 Feb 2023 23:56:33 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Mon, 13 Feb 2023 23:56:33 +0200
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
Message-ID: <Y+qyEVxMh4VRIsy3@surfacebook>
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210164636.628462-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach kirjoitti:
> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> changed the policy such that I2C touchpads may be able to wake up the
> system by default if the system is configured as such.
> 
> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> ActiveLow and level triggered but connected to a pull up. As soon as the
> system suspends the touchpad loses power and then the system wakes up.
> 
> To avoid this problem, introduce a quirk for this model that will prevent
> the wakeup capability for being set for GPIO 10.

Please, update the commit message and send v2.

We would like to have this fix nevertheless, because users will suffer w/o it.

-- 
With Best Regards,
Andy Shevchenko


