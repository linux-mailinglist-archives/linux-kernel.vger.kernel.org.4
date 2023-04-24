Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA36EC999
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDXJ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjDXJ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:58:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C88E53
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B336158D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2747C433EF;
        Mon, 24 Apr 2023 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682330286;
        bh=0Bo6Vh+vs7/WySfkMx93OTiQxZzTu1pqiefSV8EGBds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giDhPRPj8yWuvc4hpC3lloHxLOSHha1/A9D7M7PgXDu+TTPnOP5MRr9RDP1r4b1LC
         DSZfLvJHXwREXJuNU5bCSMf9CUeLVlxqNZkcxcGDjwnv5Uqnn3APFkaaMhkILAweKY
         GuRZlJ9gTkPiPKByhPnkMvmCuMRMvtAr+g6YMPQ3nFg5KteB69e9Hn7xaA9tSNunnU
         iKG2v/ogWQm20n0EJJy/Xk+Bq3+Iu0KSr3lD6WTJSluLIwTo8K5Dd+gJhA1gXLTtJP
         EDwKL8LRtd8Ri6DxUh2kZC/elJrkPaIH9YSgW5G2DETfTl0+toau6EOfZcoegXjPou
         9f4mOsV0vXStA==
Date:   Mon, 24 Apr 2023 10:57:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/3] mfd: axp20x: Add support for AXP313a PMIC
Message-ID: <20230424095754.GD8035@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-3-andre.przywara@arm.com>
 <20230421073137.GM996918@google.com>
 <TY3P286MB2611E7B758E6C2208925127E98609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB2611E7B758E6C2208925127E98609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Shengyu Qu wrote:

> Hello Lee,
> 
> Where is your branch? I'm gonna rebase my AXP15060 series on it.

You can use -next.

> 在 2023/4/21 15:31, Lee Jones 写道:
> > On Sat, 01 Apr 2023, Andre Przywara wrote:
> > 
> > > From: Martin Botka <martin.botka@somainline.org>
> > > 
> > > The AXP313a is a PMIC chip produced by X-Powers, it can be connected via
> > > an I2C bus.
> > > The name AXP1530 seems to appear as well, and this is what is used in
> > > the BSP driver. From all we know it's the same chip, just a different
> > > name. However we have only seen AXP313a chips in the wild, so go with
> > > this name.
> > > 
> > > Compared to the other AXP PMICs it's a rather simple affair: just three
> > > DCDC converters, three LDOs, and no battery charging support.
> > > 
> > > Describe the regmap and the MFD bits, along with the registers exposed
> > > via I2C. Aside from the various regulators, also describe the power key
> > > interrupts, and adjust the shutdown handler routine to use a different
> > > register than the other PMICs.
> > > Eventually advertise the device using the new compatible string.
> > > 
> > > Signed-off-by: Martin Botka <martin.botka@somainline.org>
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> > > ---
> > >   drivers/mfd/axp20x-i2c.c   |  2 +
> > >   drivers/mfd/axp20x.c       | 78 +++++++++++++++++++++++++++++++++++++-
> > >   include/linux/mfd/axp20x.h | 32 ++++++++++++++++
> > >   3 files changed, 111 insertions(+), 1 deletion(-)
> > Applied, thanks.
> > 






-- 
Lee Jones [李琼斯]
