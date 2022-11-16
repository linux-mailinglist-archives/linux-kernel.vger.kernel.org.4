Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A362C710
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiKPR75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbiKPR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:59:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C9627C3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:59:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEE02B81E4B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCAC433C1;
        Wed, 16 Nov 2022 17:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621582;
        bh=qF2eaX68+mjNwCxChRy/AtfhyxsWAwFDEyLXbZ6662Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWzk+VC+CSzHg/4dKOoyang3oIUWxh2c8eVR0XNnaWUPJLOcqagyXL5cEvcGB3b4e
         iBx79aqC4nwFSn9/mpMTfAx0wehPjlwA4oFnzzh131P7jto1AZIxRCQDIUTIVxnWSx
         ZhFPgNPILR36y4ZixqUII0lfTCycUv1d1spdFvz++iOUnQczCA5Sf2iUALNgXnL+xO
         gswu0/ek2ix3yviJM6Mn2NmAMr/TH4Jf6YqX12ApK+nKPU8W015/w2rwqswp11Vf3K
         CL79xlTsEMPiu/gHcmPvkiqIWjyasE7gy5+KwOYfeQBMzJZgrkFxnk0UE7vaQvR3iA
         37jV6wMCm/5yQ==
Date:   Wed, 16 Nov 2022 17:59:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, cw00.choi@samsung.com,
        krzysztof.kozlowski@linaro.org, brgl@bgdev.pl,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 17/18] mfd: tps65090: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3UlB9IlWKN6v2ts@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-18-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-18-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Aidan MacDonald wrote:

> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/tps65090.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
