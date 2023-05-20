Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305F570A6E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjETJyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjETJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:53:57 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4761E56
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 02:53:54 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 397b899a-f6f4-11ed-a9de-005056bdf889;
        Sat, 20 May 2023 12:53:51 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 20 May 2023 12:53:51 +0300
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/3] Add Intel 8254 Counter support
Message-ID: <ZGiYr6XLguZ8R3_8@surfacebook>
References: <cover.1681665189.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681665189.git.william.gray@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Apr 16, 2023 at 01:36:52PM -0400, William Breathitt Gray kirjoitti:
> The Intel 8254 PIT first appeared in the early 1980s and was used
> initially in IBM PC compatibles. The popularity of the original Intel
> 825x family of chips led to many subsequent variants and clones of the
> interface in various chips and integrated circuits. Although still
> popular, interfaces compatible with the Intel 8254 PIT are nowdays
> typically found embedded in larger VLSI processing chips and FPGA
> components rather than as discrete ICs.
> 
> This patch series introduces a library to provide support for interfaces
> compatible with the venerable Intel 8254 Programmable Interval Timer
> (PIT). Modules wanting access to the i8254 library should select the
> newly introduced CONFIG_I8254 Kconfig option, and import the I8254
> symbol namespace.
> 
> Support for the i8254 is added in respective follow-up patches for the
> 104-dio-48e driver and stx104 driver whose devices feature i8254
> compatible interfaces. Several additional dependencies are necessary for
> the 104-dio-48e [0][1][2] and stx104 [3][4].
> 
> Due to the dependency requirements, I can take the i8254 introduction
> patch through the Counter tree and provide an immutable branch that can
> be merged to the GPIO and IIO trees; the 104-dio-48e patch and stx104
> patch could then be picked up separately by the respective subsystem
> maintainers.

Good job!

What I'm wondering is that. Can x86 core and others which are using that chip
utilize (some of) the functions from the library?

> [0] https://lore.kernel.org/all/05a878d340251b781387db4b6490f288e41a651c.1680543810.git.william.gray@linaro.org/
> [1] https://lore.kernel.org/all/20230208105542.9459-1-william.gray@linaro.org/
> [2] https://lore.kernel.org/all/cover.1679323449.git.william.gray@linaro.org/
> [3] https://lore.kernel.org/all/20230318185503.341914-1-william.gray@linaro.org/
> [4] https://lore.kernel.org/all/cover.1680790580.git.william.gray@linaro.org/

-- 
With Best Regards,
Andy Shevchenko


