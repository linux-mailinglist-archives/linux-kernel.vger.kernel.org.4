Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801B1666F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbjALKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjALK3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:29:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C59C63;
        Thu, 12 Jan 2023 02:26:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B80EB81DEB;
        Thu, 12 Jan 2023 10:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34675C433D2;
        Thu, 12 Jan 2023 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673519185;
        bh=jKHt3xm+qKVUuPzXztBV/shHxPSZXcZdAUm76eKPg1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+0RbeX0MzT56R5g//Ip/rfMAQHpH86N+8VtyuKIbax5eITbRYDlilE3cdLC2Z/Jl
         9olalQZk+D0790IIi9iSOeHaD1TPCUxA6euPBIg/UUpm08UCq5JjV/mXqTyKZPO3Sf
         FB9R8oTGr3X27BvYhwMzSvxU/UdzGGB+RvYMU1lkhferrY/VKEEBeKEHqwcEj1xdQi
         eZO8d4FoTi9EIr4RqFpnWH31xlm4iKVHnNybZ5IwEgD7zP5vjXrFKkwFu1K+ZyinV6
         yzjWIGeIQ9nUkLJgPgCGktWBoZzdPtpLX0bsOGRAri9iGVh03E+HDdhyeK3DMxJckY
         yx43jBlOVmJIQ==
Date:   Thu, 12 Jan 2023 15:56:14 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: Update mhi driver description
Message-ID: <20230112102614.GC4782@thinkpad>
References: <20221229011358.15874-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221229011358.15874-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 09:13:58AM +0800, Slark Xiao wrote:
> This should be a mistake. MHI contains "Host Interface"
> already. So we shall update "MHI" to "Modem" and the full
> name shall be "Modem Host Interface".
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index bf672de35131..7307335c4fd1 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1449,4 +1449,4 @@ postcore_initcall(mhi_init);
>  module_exit(mhi_exit);
>  
>  MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("MHI Host Interface");
> +MODULE_DESCRIPTION("Modem Host Interface");
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
