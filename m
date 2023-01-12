Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C4666ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjALJ5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjALJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:55:41 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55302DFE0;
        Thu, 12 Jan 2023 01:53:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D8AD280A6;
        Thu, 12 Jan 2023 09:53:13 +0000 (UTC)
Date:   Thu, 12 Jan 2023 11:53:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] usb: remove OMAP USB Device Controller and OHCI
 support for OMAP1/2 chips
Message-ID: <Y7/YiMPIDN0Cf5Ky@atomide.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-4-lukas.bulwahn@gmail.com>
 <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2663ff-ff3f-4632-853a-ba4d38df9701@app.fastmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [230112 09:03]:
> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> > Commit 0fee2eac5c2b ("usb: phy: remove phy-isp1301-omap driver") removes
> > the Philips ISP1301 with OMAP OTG driver and its corresponding config
> > ISP1301_OMAP. The drivers, OMAP USB Device Controller and OHCI support for
> > OMAP1/2 chips, with corresponding configs, USB_OMAP and USB_OHCI_HCD_OMAP1,
> > need this removed driver (see "depends on ISP1301_OMAP") to build.
> >
> > Remove those two drivers.
> >
> > With the config USB_OMAP removed in this commit, remove some further code
> > in the omap-dma header and mach-omap1 architecture code.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> This would be a great cleanup because of the simplications of the
> omap-dma code. I had previously looked at it and concluded that
> the driver is still in use though, and I think my mistake was
> just in the Kconfig part of this patch:

It sure would be nice to drop the old custom dma api in omap-dma.c
while keeping the dma.c in arch/arm/mach-omap1.

Regards,

Tony
