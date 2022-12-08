Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B15646FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLHMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLHMjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:39:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4058000
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099CC61EFE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D8C433D6;
        Thu,  8 Dec 2022 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670503176;
        bh=ZCO8HXCGjtI1DeTCkyD3Kyt5cdYV+cSqhtaQg5OQJo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkY3GiKNZ2XjbKS6CE0sOnsSuBkSTjJN8Yn8HIsVa7CokzLDJM2G/SOP2PwYeRC6G
         ab29c5p81hLdTiZJk61huuvYAypLvJ0SpwekoxbFCV+iy6tvX3JYIyUWdT1+adGuQR
         GkNH+CE1Cr8RupFn5xFMX5KpfYf+SU3X3H0WTigXh7vsURPcJbRL8JOsH1WG9FtRsx
         kzlhYVrl7IdF0oRDH+x1KwmsfHlD4H7heBh0CJavgbPGFwVEkK0Cx2axbl+P42IHNJ
         UIQRgY43pGS02PNluy3+Uv2Jl7vuDVbsH8AY3rYw3Ep+cvwSWhEcizz9iL2o25FS7A
         gsdR1LDUGLmjA==
Date:   Thu, 8 Dec 2022 12:39:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] mfd: use devm_platform_get_and_ioremap_resource()
Message-ID: <Y5HbA6FofIO9VYPT@google.com>
References: <202211220945587336502@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202211220945587336502@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't forget to add the driver tag to the subject line.

  mfd: stm32-lptimer: ...

On Tue, 22 Nov 2022, ye.xingchen@zte.com.cn wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/stm32-lptimer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
