Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35472C089
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjFLKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjFLKwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:52:51 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EAEA5D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:37:27 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 179fbd2c-090a-11ee-abf4-005056bdd08f;
        Mon, 12 Jun 2023 13:15:45 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 12 Jun 2023 13:15:44 +0300
To:     Markus Burri <markus.burri@mt.com>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: ad7192: store indio_dev into spi driver data
Message-ID: <ZIbwUKxlhWQZYnPz@surfacebook>
References: <20230612080847.39170-1-markus.burri@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612080847.39170-1-markus.burri@mt.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jun 12, 2023 at 10:08:47AM +0200, Markus Burri kirjoitti:
> After calibration the indio_dev is used to get channel information.
> Since the pointer is not stored into spi driver data, there is a kernel
> null pointer dereference.
> Store the indio_dev into spi driver data to fix this.

This definitely deserves the Fixes tag. Can you dig the history to find the
culprit one?

> Add error check and slightly extend the debug messages.

I'm not sure this will belong to the same change, so I would split this out to
a separate one.

-- 
With Best Regards,
Andy Shevchenko


