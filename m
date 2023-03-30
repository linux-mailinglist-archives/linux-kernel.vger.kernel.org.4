Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA896D051C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjC3Mnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjC3Mnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1183AA6;
        Thu, 30 Mar 2023 05:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A15756205F;
        Thu, 30 Mar 2023 12:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E1C433EF;
        Thu, 30 Mar 2023 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680180211;
        bh=iFYD1LGIj/6jD8KQayXE5QoHszyIg51yyPeXkj+wnEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZRlSAQzVqmB0+qDxKJnzbGjPI8XcK/BLW5lsm1+SSChSXyMSIniLwMaz2novRAPG
         Z2jPssj6IXcPq2XVe5xTmPWNXW1RPbQ5cNLWjcKLnYST5pVdfvs8raXKE8hvXhmRFt
         YMJ/vN/Qon5WaE/3khZ/+PBpXIlzKkAXi4qN/Fpl2kFMTJsyXUB865yllpgc8ymC+K
         pGrCmLNkPiHhrb/ORNCatHX7Pfx3rcWFDXrTrDBC/1+Esz6TVFY3gIfw57FvYjaEfA
         TduYbuFCwagwfm2jSNJ3GRZnwI5zTIWQmkKf4+mFQGV+6C/u1b/wCsKG4CoC5j5bjI
         q8rAsYlxOCMzQ==
Date:   Thu, 30 Mar 2023 13:43:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: mt6370: correct config name to select in
 LEDS_MT6370_RGB
Message-ID: <20230330124326.GK434339@google.com>
References: <20230323105410.10396-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323105410.10396-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023, Lukas Bulwahn wrote:

> Commit 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink
> type LED Indicator support") introduces the config LEDS_MT6370_RGB, which
> selects the non-existing config LINEAR_RANGE. As the driver includes
> linux/linear_range.h, it is a safe guess that the config actually intends
> to select LINEAR_RANGES, which provides the library implementation for the
> function prototypes defined in the linear_range header file.
>
> Correct this naming confusion in the LEDS_MT6370_RGB config definition.
>
> Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  drivers/leds/rgb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
