Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7972CFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjFLTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjFLTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:40:22 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32DE6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:40:21 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id f5e14b25-0958-11ee-a9de-005056bdf889;
        Mon, 12 Jun 2023 22:40:18 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Mon, 12 Jun 2023 22:40:18 +0300
To:     Markus Burri <markus.burri@mt.com>
Cc:     linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
Message-ID: <ZId0osDU07Whga9C@surfacebook>
References: <20230612121554.367285-1-markus.burri@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612121554.367285-1-markus.burri@mt.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jun 12, 2023 at 02:15:54PM +0200, Markus Burri kirjoitti:
> Print read and expected device ID as debug warning.
> Add error check for sd_sd_init() result.

sd_sd_...?

-- 
With Best Regards,
Andy Shevchenko


