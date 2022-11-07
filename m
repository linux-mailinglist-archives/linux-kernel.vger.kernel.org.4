Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DEB61EF3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiKGJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiKGJjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:39:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F720BE14
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:39:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DD8FB80EF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B76C433D6;
        Mon,  7 Nov 2022 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667813939;
        bh=ZHHX19+fBKs7UkEe9m7JbmHVUsQpj82rRSrE0l6ZQNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH2tz9X9GwQz1CHIuRiZvgPbGUE6zsEGTpAmvzVy3f3MbLC7YT1olwVT766xWAfIG
         C4vLZVH7lbuYQ7Xsxm2KEKJx6Ry71VjGvPp0MLYzfcGgXx4g9upc9vrQSG1BbnbiTH
         rUzLnDQOVqs8ZhPiim5vt6r7AoMip090awlC1A79VZWlc4a3MnfQnMiDfbf3t7o7i2
         l+7xP9CXe/1CuROJjePo40dagtnIgQ2VIOqICCNYdZhCLYO64KcyddVahMD4ZA2eR6
         xesdIE87SLlzYNXiHHcVnqHbuRLdncdHvWGbLuzIp4NrwmE4w61jMkvKKwVPqWPyUg
         8jjVeGbeM9RNw==
Date:   Mon, 7 Nov 2022 09:38:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Message-ID: <Y2jSLw78zGNFGDsM@google.com>
References: <20221105212909.6526-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221105212909.6526-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Nov 2022, Samuel Holland wrote:

> Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
> function axp20x_power_off() now runs inside a RCU read-side critical
> section, so it is not allowed to call msleep(). Use mdelay() instead.
> 
> Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
