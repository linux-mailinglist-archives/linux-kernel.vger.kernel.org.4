Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD396A8763
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCBQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCBQvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:51:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F1D3;
        Thu,  2 Mar 2023 08:50:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067A4615C7;
        Thu,  2 Mar 2023 16:50:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C504C433EF;
        Thu,  2 Mar 2023 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677775853;
        bh=bs4a9GzCIldMNY6Lwk2BfD+01omOGUn0cXcDxNdcbIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go20XSRtq4KkmiqnwjrCyHdYG12ZWZQNsuH5mNARSpxSe2bAOqQKknKYUG/uAxpYW
         rrv/iC46jo4ivP56qzq1FUrjAkeVrnPww6yhz1gi5oqTGqYP5dkzXLxUPrpFO7luLX
         T2AycCDDx2/VDIESByet1qEbY0LjdOX7E59nFkYG0aGeswg5SvyShZUAQ4//75Au0l
         8a0wC3BXgmvBDqyBEJPyoB60dnQlO+qBsXbQCA6Rc4Y8EtKSYvGwaWv6AerdgNMlhk
         KOEh8O+KFYG2ZxWN35cWFr26LHyNZpqv+BAmMeVnpWnvzeVHBG0dUxOYX74qVynZK1
         DB27tZvDo3Vjg==
Date:   Thu, 2 Mar 2023 16:50:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv6 06/11] mfd: rk8xx-i2c: use device_get_match_data
Message-ID: <20230302165046.GA2303077@google.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127181244.160887-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023, Sebastian Reichel wrote:

> Simplify the device identification logic by supplying the relevant
> information via of_match_data. This also removes the dev_info()
> printing the chip version, since that's supplied by the match data
> now.
> 
> Due to lack of hardware this change is compile-tested only.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk8xx-core.c |  2 -
>  drivers/mfd/rk8xx-i2c.c  | 89 +++++++++++++++++-----------------------
>  2 files changed, 37 insertions(+), 54 deletions(-)

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
