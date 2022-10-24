Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3642609B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJXHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJXHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C163B4CA2E;
        Mon, 24 Oct 2022 00:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B2EDB80ED2;
        Mon, 24 Oct 2022 07:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1943DC433D6;
        Mon, 24 Oct 2022 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596785;
        bh=I7u26njqwLHKC2d1vm5DpBCy1awMPGRHP+my05zpxD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfaOvKVsRe2oEX92hs9RtEP70KhzACin5nOOUgn9+BY0OvMFaKm1nh/ge0mV8IBTg
         Y6k5oFSq/4D0SOK4tm2jReNI6awpXVHyj70GVfiYXnaHUs9/CnYKbpZD7xU8E6tcK5
         5swEZe0E3BN6hdv3qK0FstnYnVZ3wxsT0kOkHikyFUBMTctQi3f1a4JMdVUAN8/yBZ
         L/jYqY2o6ZTFlNECayVy7+UB+J2nH4z8KtyvV+IE5oJBPWBn8JsdRV3J9Nr61ydPS8
         FcSx2nTWJx+ethinq2dy/OO578LmBDmtQBvXLYLu6PetD2ZBtm0tcT/UqwMzQDwbP2
         x4C2+/dfkDTrA==
Date:   Mon, 24 Oct 2022 08:32:59 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/5] mfd: madera: include correct gpio API
Message-ID: <Y1Y/qx3k10lvqzN3@google.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
 <20220926054421.1546436-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926054421.1546436-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022, Dmitry Torokhov wrote:

> The driver is using gpiod API and therefore should include
> linux/gpio/consumer.h, not linux/gpio.h. Also, the driver does not use
> any of the APIs from of_gpio.h, so we should not be including it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/madera-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
