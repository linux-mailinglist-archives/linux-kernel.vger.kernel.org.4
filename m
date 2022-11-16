Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3299262C6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiKPRzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiKPRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:54:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E66035A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:54:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E0061F1D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09641C433C1;
        Wed, 16 Nov 2022 17:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621292;
        bh=stvDx/KRaF0ie62bJ16hwGJVxNT2Atlkb//0qZ6BK2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLu6WnVl0WUwOc5tMeih292nam1+LQ38yM7PDfhhOB21yOdgbT2DNrBZwJUUDrVlx
         GdAUUR19ckUC1beXHxF0b6DAVmtf6GoFH00Eg20FrNBwbdoNYH9N+r0lEP6dD/qR0H
         xL1oY7mLECSZlMr+2e+uf9PLprh9q7Htj5D0p838Uu6klwAO3J5ZewtTFxEOCbxAzm
         sPyBbaQn4lbJsw4cvI2FAj/ZsizQm20Fq/hs9g3Zku32jw5CJ0D5m770BM91DpH6wC
         5UU2zP5Ydp5spCFXl3Lgg8sj411TV4Ou0Xocm/x/sdCojW0wfum+Uqk43B7BeTX7uH
         wFYWVqGw4bOuA==
Date:   Wed, 16 Nov 2022 17:54:45 +0000
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
Subject: Re: [PATCH 07/18] mfd: max77693: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3Uj5Xtn94fmabdr@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-8-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-8-aidanmacdonald.0x0@gmail.com>
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
>  drivers/mfd/max77693.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
