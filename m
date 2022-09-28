Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F365EDE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiI1OAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiI1OAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:00:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA6EFD03;
        Wed, 28 Sep 2022 07:00:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C778B61D51;
        Wed, 28 Sep 2022 14:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FE0C433D6;
        Wed, 28 Sep 2022 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664373630;
        bh=CfgEVlx3/Vod/p/OGWDhEcXGvUTDa0gyZyjht1hrHd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PzI0I2cyUAP140VnRktKSZ9/lSASgoZ2YMgtYJYulUOYJcfy9Qq2P6ZZyt9NX58sl
         XWs2zVQsGdyDtXqHgHKwRHQtUhK1XHFx3Ur93+2+A9t7oLy/AXyvrG0/34m2+MyRzD
         dBJ4mdpyzq06XZdQgEq/ndD7Zt5P7ry48efpZkShNeZig9P8oWAwMOOFfvXtUcbdLp
         LDVwhi+auOPM7JuPWrdd5pwkxQUk0+adTdDIssIYp/zrh5Oulv070380ZhNdkiV2mz
         IR4sq5q0hBb84w4NI70UXT/tLOCP8UdbP2ZBf7w8CdXlPEBke2PHq12dzSDBExlU6T
         KCOB/2D3bY9cA==
Date:   Wed, 28 Sep 2022 15:00:23 +0100
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
Subject: Re: [PATCHv3 06/14] mfd: rk808: replace 'struct i2c_client' with
 'struct device'
Message-ID: <YzRTd31dKC/RYBID@google.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909175522.179175-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Sebastian Reichel wrote:

> Put 'struct device' pointer into the MFD platform_data instead
> of the 'struct i2c_client' pointer. This simplifies the code
> and prepares the MFD for SPI support.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk808.c       | 6 +++---
>  include/linux/mfd/rk808.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
