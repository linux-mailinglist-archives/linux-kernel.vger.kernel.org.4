Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBDA66CD13
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjAPRdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjAPRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:32:39 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 756D52A143;
        Mon, 16 Jan 2023 09:08:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B88E28108;
        Mon, 16 Jan 2023 17:08:52 +0000 (UTC)
Date:   Mon, 16 Jan 2023 19:08:51 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <Y8WEoxiOXgZNB1Oc@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
 <Y8VkjQ2yZQssx/wJ@atomide.com>
 <20230116173922.585904bf@aktux>
 <Y8WBuKt6mw6TN1Cp@atomide.com>
 <CAHCN7x+b2_dnpRs8RarhhgTfBrTVfGfmcQNbfHLoWBwkZ_3Puw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7x+b2_dnpRs8RarhhgTfBrTVfGfmcQNbfHLoWBwkZ_3Puw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Adam Ford <aford173@gmail.com> [230116 17:00]:
> Doesn't this imply the target-module stuff needs to be implemented for
> the drivers?  It looks like a lot of the omap3 drivers are still using
> hwmods although some have target-modules. In this case, the mcspi
> drivers that Andreas is disabling don't appear to have target-module
> stuff configured.

Sorry I don't remember if omap_device.c ignores status disabled or not.
But in any case, it should be trivial to update omap3.dtsi to configure
some of the devices like mcspi to probe with device tree data and ti-sysc
as needed.

Regards,

Tony
