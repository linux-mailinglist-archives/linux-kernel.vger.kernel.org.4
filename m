Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3294362C66F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiKPRd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiKPRd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:33:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2C644C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:33:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A204A61A5E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A63C433D7;
        Wed, 16 Nov 2022 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668620036;
        bh=THgT/+Aif/5vKx21/3njPqVw7J5vqdgjMqPy6WcDXzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/WJKrRgg4kQ2m040/M+a4RYZOil1dXqX29ODJ+YS1D7v6uCHD+cQEStEAaFVyN0T
         xiOBlzMxk4m2EdvdgdMyg9TlEzY/QUo2aSVbvGVKNrgLSIHU5Cgx39kTeyQZzwgwLJ
         ixfvFxBEMp5Ou8jcWA5LR7W2lUAi5GEO/EPqKyYUW63jleAhp6oJKL2AsoQC8ShfPS
         dNTbstKnxh2CX8YdalVN1QXpi2VV9Omqe4LkKhzeoruHuI7qta6f2d7otv3CAxXM6G
         M44FkZ8v6woppX1w57KHyAEHqgg3HwZ715+AJk4FXs0uLFadWUTadv5G4tj9n0m/6b
         i3wqCQaeHSBKA==
Date:   Wed, 16 Nov 2022 17:33:49 +0000
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
Subject: Re: [PATCH 03/18] mfd: axp20x: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3Ue/RTzxI0osWe8@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-4-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-4-aidanmacdonald.0x0@gmail.com>
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
>  drivers/mfd/axp20x.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
