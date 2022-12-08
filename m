Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7819B646F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLHMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 07:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLHMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 07:21:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A389AFB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 04:21:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5153D61E09
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 12:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E9CC433D6;
        Thu,  8 Dec 2022 12:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670502076;
        bh=iolmuS87qVgVfIfTwWlbr2eeLktEiPex72fM3FhmbAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCntk3ncQ5OrW6j/Bw9aaikPMemPYTeIvoDN75lg8sAnh9jLqRpkFh9kK3VSg7y+i
         DSGCSs3t2KtVeyGDUIuM4pF+/cEOv6fJOjl9V9Fdm+lLaithhba2B/6IfGcvvQHl1o
         FfYxmXXqVd3Z+WllOTQZh159h7wak7FVJMvKu4T69jQS4l7NfiA2sf5B7omRGb64Il
         7poqF2vEPG/JdOoH00hwDUkri5FE9AFz2Xlxh0Nh3arUUEs5k8sSy2akWWEUjGoeKe
         4XB5h6Iqsl57itXv6+GK0hpI5YQc1ZX/IdpJelplWdkMTSbhIn0I3nmmgUnMNtcVVp
         VSZAYn8+DyA2A==
Date:   Thu, 8 Dec 2022 12:21:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: fsl-imx25-tsadc: use??
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y5HWuDih29TYdN/o@google.com>
References: <202211171407248212856@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202211171407248212856@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, ye.xingchen@zte.com.cn wrote:

> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/fsl-imx25-tsadc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
