Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696665BE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbjACKva convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 05:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjACKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713912EB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCet8-00085P-1q; Tue, 03 Jan 2023 11:51:22 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCet7-003Xgk-0m; Tue, 03 Jan 2023 11:51:21 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCet6-0004Yo-D6; Tue, 03 Jan 2023 11:51:20 +0100
Message-ID: <9ab815d737c2c0a2aa5e31c1cb1f768f74d617d9.camel@pengutronix.de>
Subject: Re: [PATCH] reset: ti-sci: honor TI_SCI_PROTOCOL setting when not
 COMPILE_TEST
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 03 Jan 2023 11:51:20 +0100
In-Reply-To: <20221030055636.3139-1-rdunlap@infradead.org>
References: <20221030055636.3139-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sa, 2022-10-29 at 22:56 -0700, Randy Dunlap wrote:
> There is a build error when COMPILE_TEST=y, TI_SCI_PROTOCOL=m,
> and RESET_TI_SCI=y:
> 
> drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
> reset-ti-sci.c:(.text+0x22c): undefined reference to `devm_ti_sci_get_handle'
> 
> Fix this by making RESET_TI_SCI honor the Kconfig setting of
> TI_SCI_PROTOCOL when COMPILE_TEST is not set. When COMPILE_TEST is set,
> TI_SCI_PROTOCOL must be disabled (=n).
> 
> Fixes: a6af504184c9 ("reset: ti-sci: Allow building under COMPILE_TEST")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Philipp Zabel <p.zabel@pengutronix.de>

Thank you, applied to reset/fixes.

regards
Philipp
