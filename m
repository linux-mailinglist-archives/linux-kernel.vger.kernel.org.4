Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A42721509
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjFDGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:04:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B37E5120;
        Sat,  3 Jun 2023 23:04:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B52C0804D;
        Sun,  4 Jun 2023 06:04:37 +0000 (UTC)
Date:   Sun, 4 Jun 2023 09:04:36 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v12 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <20230604060436.GT14287@atomide.com>
References: <20230525113034.46880-1-tony@atomide.com>
 <20230602083335.GA181647@google.com>
 <87a5xii33r.fsf@jogness.linutronix.de>
 <20230603054139.GR14287@atomide.com>
 <20230603215718.ca5hdzdsj4btnlc2@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603215718.ca5hdzdsj4btnlc2@mercury.elektranox.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Sebastian Reichel <sebastian.reichel@collabora.com> [230603 21:57]:
> On Sat, Jun 03, 2023 at 08:41:39AM +0300, Tony Lindgren wrote:
> > Looking at the kernelci.org test boot results for Linux next [0], seems
> > this issue is somehow 8250_mtk specific. I don't think the rk3399 boot
> > issue is serial port related.
> 
> The rk3399-gru-kevin board is broken because of a change from me
> renaming CONFIG_MFD_RK808 to CONFIG_MFD_RK8XX and forgetting to
> update the defconfig :( This means the board is missing its PMIC
> driver. It should be fixed once the defconfig update is queued:
> 
> https://lore.kernel.org/all/20230518040541.299189-1-sebastian.reichel@collabora.com/

OK thanks for the info.

> Unfortuantely nobody seems to feel responsible for the generic arm
> defconfig files :(

You could put together a git branch with the defconfig changes and
send a pull request to the SoC maintainers if it does not get picked
up before that.

Regards,

Tony

