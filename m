Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886CC6B7FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCMRuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCMRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:50:12 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A6579B25;
        Mon, 13 Mar 2023 10:49:57 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6731E20765;
        Mon, 13 Mar 2023 18:49:55 +0100 (CET)
Date:   Mon, 13 Mar 2023 18:49:50 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 2/2] gpio: fxl6408: add I2C GPIO expander driver
Message-ID: <ZA9iPnmgNO7PSv6O@francesco-nb.int.toradex.com>
References: <20230313170950.256964-1-francesco@dolcini.it>
 <20230313170950.256964-3-francesco@dolcini.it>
 <CAHp75VetwU3pr59sE5zHPf5jPxYb6yJnXZWpD_qn4o6d5Dnmog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VetwU3pr59sE5zHPf5jPxYb6yJnXZWpD_qn4o6d5Dnmog@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:35:20PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 13, 2023 at 7:09 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >
> > Add minimal driver for Fairchild FXL6408 8-bit I2C-controlled GPIO expander
> > using the generic regmap based GPIO driver (GPIO_REGMAP).
> >
> > The driver implements setting the GPIO direction, reading inputs
> > and writing outputs.
> >
> > In addition to that the FXL6408 has the following functionalities:
> > - allows to monitor input ports for data transitions with an interrupt pin
> > - all inputs can be configured with pull-up or pull-down resistors
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for the review, appreciated.

> > +#include <linux/err.h>
> > +#include <linux/gpio/regmap.h>
> > +#include <linux/kernel.h>
> > +#include <linux/i2c.h>
> 
> Seems unordered?

Whoops :-/

Bartosz: if you or others have additional comments I'll change this for
sure, if not up to you - please let me know.

Francesco

