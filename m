Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA51765A315
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiLaHV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 02:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiLaHVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:21:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5C2AC4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 23:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E744160A49
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 07:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE00AC433D2;
        Sat, 31 Dec 2022 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672471312;
        bh=KUen9JacSR7CuEY7PWE7I+Hsfq1XpsGgH+s1BHsk6ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IivIZIKUBnE0OX5Y0NYYTLfyZhf37XXyr8ln9bW/xchd/bEovGtqfcOS7Ns7WbLVV
         tDoGGClTkoJ/mbZnACZ7H+yx1XmTb667jo5gJ3QyD5P+XSZjfa+/2/GymO0VN2FdSV
         +leN41VbI+Z5zfDH9eOl+edu6h2S8l3G75s2fydqNQPTCkkncqQl31TJHBH4GpEWDs
         AgnVkfy8456y6qVGlquO4yBJrvSMzxLL0/1D7BiBZLVpfXKsSThid6Af83qNnLy/Ku
         Wm0CQO8cXoCJ1x+KoOVwbnQrkkM6jwDTwpFaHMbYNFR4kPMIjX1DaPeAMqsJ+5mu0l
         LKhcMOLZkBvuw==
Date:   Sat, 31 Dec 2022 15:21:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH] bus: imx-weim: use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20221231072145.GJ6112@T480>
References: <202211220940526866294@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211220940526866294@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 09:40:52AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thanks!
