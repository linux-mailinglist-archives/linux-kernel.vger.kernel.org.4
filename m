Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCB674BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjATFMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjATFMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:12:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE1B2D2C;
        Thu, 19 Jan 2023 20:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46826B82296;
        Thu, 19 Jan 2023 14:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF61EC433D2;
        Thu, 19 Jan 2023 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674139885;
        bh=xtZhu85yI1u7Kgj39/pnsqD82RG/N8l/7M+Kp1PAgpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBFMKN/XsXhcnvYft01O0rVKCwHsEGq1kUf5T2rFoUby4h2rVxesIEP3fvbTajexh
         zoH0+uZk5FUlk5XemnYvlyXu17UGn4jOFBKqzetLSt47LztUzTly9OumOoX4j+R5NY
         +8I2VpBkFPS11MUI9j440mjNm1z2V0/+XW1ub5hpN++J8VjD1D3oGLXF5a7T1479vg
         81C6Xs1X79dvW7XUOBrRvLqKokcLUiD27D9RULp8pLy+mMs1B1daBOECXW678jvolK
         C3rHNTsted3bQa12R4b8OOogiDyrtTSUIWpyhMWkeZArPNzKe38Z7M3PeICPyajEvx
         MZQizlgN8HIew==
Date:   Thu, 19 Jan 2023 14:51:19 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: ili922x: fix kernel-doc warnings
Message-ID: <Y8lY56324WB3Shlo@google.com>
References: <20230113064108.29172-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113064108.29172-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Randy Dunlap wrote:

> Convert comments for START_BYTE() and CHECK_FREQ_REG() macros into
> kernel-doc notation to avoid these kernel-doc warnings:
> 
> drivers/video/backlight/ili922x.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * START_BYTE(id, rs, rw)
> drivers/video/backlight/ili922x.c:118: warning: expecting prototype for CHECK_FREQ_REG(spi_device s, spi_transfer x)(). Prototype was for CHECK_FREQ_REG() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/ili922x.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
