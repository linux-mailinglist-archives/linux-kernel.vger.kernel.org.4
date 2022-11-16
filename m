Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503AF62C717
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiKPSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiKPSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930B3C48
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:00:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEED615A2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 18:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF27C433C1;
        Wed, 16 Nov 2022 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621617;
        bh=mYNaSZCYrn8/p8lFwLUDV/NNRBJln3ed/WvLGIooOG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4xg/ejtxPV7IBCLgNbZohIkHCS4aL+oeTmW+RLfX4RMuJF2qdIfa7UAEaXT5FC8W
         PkDNmfpgXVYtpfMZLo/PuMA6V1leZKzj/WcbG+03l4wXkInVXR4EgKBYemN+5Or8gm
         oEBPM//BXAcw7+YI6TFNjJXOMglmTd8HNYuxxI7isFjbIt/oVA8om3knjaA+lITn3A
         UxprLJKEkCVudXEFaZOxYQD/JInk5eKmfPGXnHcRFhSirc899QE4cuoErAe4gDdBwa
         b+qydb0ZUCLZ0WfdxgFeXKB7axWxbEdijFp/VLDDrnWXHewuVqKb8jBgr9Lusvzmqm
         QYnjgh5W03mHQ==
Date:   Wed, 16 Nov 2022 18:00:10 +0000
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
Subject: Re: [PATCH 18/18] mfd: wcd934x: Convert irq chip to config regs
Message-ID: <Y3UlKpwXh2o/BtsK@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-19-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-19-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022, Aidan MacDonald wrote:

> Type registers are deprecated and will eventually be removed from
> regmap-irq. The same functionality can be replicated with config
> registers.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/mfd/wcd934x.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
