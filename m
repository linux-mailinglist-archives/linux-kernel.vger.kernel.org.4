Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853927464E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjGCVcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGCVcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:32:06 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF51A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:32:05 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 0d41d9fc-19e9-11ee-abf4-005056bdd08f;
        Tue, 04 Jul 2023 00:32:03 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 4 Jul 2023 00:32:03 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pinctrl: amd: Drop pull up select configuration
Message-ID: <ZKM-U3aXGcXEgPLZ@surfacebook>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630194716.6497-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 30, 2023 at 02:47:14PM -0500, Mario Limonciello kirjoitti:
> pinctrl-amd currently tries to program bit 19 of all GPIOs to select
> either a 4kΩ or 8hΩ pull up, but this isn't what bit 19 does.  Bit
> 19 is marked as reserved, even in the latest platforms documentation.
> 
> Drop this programming functionality.

Can it be that documentation is not (yet) updated?

Where, btw, did the original code come from? Perhaps it may shed some light
on this.

-- 
With Best Regards,
Andy Shevchenko


