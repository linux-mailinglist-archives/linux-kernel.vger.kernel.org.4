Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61506147AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKAK02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKAK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3E5D120
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7774F61589
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BF5C433C1;
        Tue,  1 Nov 2022 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667298384;
        bh=d1bo6timk6B7ADhvR2hghK7fGY7864r4jsunkJM1uOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKGSdsz67ojeu39+UmZOyi0KWgrQwabP8AOI61s5egWY9dknhpJ69lCmXsq3ZtnrH
         f3BzeI67YFl0nEHWuMB/iPxgZrnSt6F3D//s0VKG2iTANioi3q18/+VKuWyh56TqeM
         SwW04Epu78UAqsrHcGqsYMAUIwxTD3I5egwcpe/K6+xpZ3whsuOLHfEcuEzvyrwaDL
         63NZZfelDyJNc4c3Qqc6D66RVAQVTVWXfhkPMYkLCQ7JoB0g1XdAsGES53SNAluyko
         6vH2euIzae5MU/q7/fz+MA+tfnN7Nsap3iI6Oi/RssmOFKIPeyiGdeQa1oiVVKmfAX
         Cfy7iqDNfIiJg==
Date:   Tue, 1 Nov 2022 10:26:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: rk808: permit having multiple PMIC instances
Message-ID: <Y2D0TH57A9oO2ibm@google.com>
References: <20221025-rk808-multi-v2-0-d292d51ada81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025-rk808-multi-v2-0-d292d51ada81@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022, Neil Armstrong wrote:

> This set each cells id to PLATFORM_DEVID_NONE to allow multiple
> instances of each cell in case multiple PMICs handled by the rk808
> driver are probed.
> 
> This fixes probing a RK818 and a RK817 on the Odroid Go Ultra
> devices.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes in v2:
> - replaced -1 by PLATFORM_DEVID_NONE

Thanks.

> - Link to v1: https://lore.kernel.org/r/20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org
> ---
>  drivers/mfd/rk808.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
