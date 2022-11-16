Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1C762C747
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiKPSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiKPSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:10:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4765EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:10:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EBF9B81DA8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C568C433C1;
        Wed, 16 Nov 2022 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668622235;
        bh=bO5AhemiIaMwveJ6u3QR7ik1Pfk5Qq+/QWLepHSA6qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2HPGeS1ajqFhpRxwSzYCfsu1imXAlmgsewIkIfWLI2/VAjuqk/GAROM7kd24Pl45
         C04GtGIQ+zipQxC2GhYWuhQSz0+awWyHTekWhiMBl3UUtm6iWq1145YQxjd9SzNVVo
         qrseKwxUaT7YKf7kDKHFQMsRRuKMPuyIqj8dCUugeKG08en8/hacehJdddouUNlBs5
         PyMgPBXrQR8iUr51DNFSz7xE+lyeDYD6eJwIQ8xuKhuJjKq+CwvB9HWoIi39WAP8va
         Q+QvBAtlRw6BqPGTXW6+7kL4yxPv4Nl4wk+0Ihx7SbP75PY7jeb8V+R7mb5bBqfNXY
         6FQwpyQ+VTorw==
Date:   Wed, 16 Nov 2022 18:10:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd: bd957x: Fix Kconfig dependency
Message-ID: <Y3Unl4GEcCrvXv7D@google.com>
References: <Y3SdCWkRr1L64SWK@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3SdCWkRr1L64SWK@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022, Matti Vaittinen wrote:

> The bd957x driver uses regmap-IRQ but does not SELECT ot depend on it.
> This can cause build failure.
> 
> SELECT the regmap-IRQ for BD957X from Kconfig.
> 
> Fixes: 0e9692607f94 ("mfd: bd9576: Add IRQ support")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Oh, found this forgotten treasure while cleaning old branches from my
> local git. It seems to me this is still valid but has fallen through the
> cracks.
> 
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied with some commit-log clean-up.

-- 
Lee Jones [李琼斯]
