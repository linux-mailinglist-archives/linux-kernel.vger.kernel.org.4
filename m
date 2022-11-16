Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6E62C2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKPPtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:49:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73722532
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:49:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA834B81DDD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02740C433D7;
        Wed, 16 Nov 2022 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668613753;
        bh=jfyda4N+IAeepqw0+Uw+4BFayTwiLhxgZXOY4z+y/So=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9/66lxHR4lXNmBRaWKDCdgkvvR2lkfFgFyA37Ksdx7PvzXAfimLKKtCAse54NdD2
         N/1X4HB5Z3jEoYbe6BM7c+ZKE/vtazn+wnWtteBUwnsmx6zcaa1mc2os13YxrNJJWO
         GfPiz/YUnMb4qD7wNi1dJeJeMOKK3sl827tvLYoFp80fob8tfDzXlV9EM9n06Wmdxm
         wghvnJ62Am8mlPa28TH3K2cSwSTyRj0HLaoC5C7F2MctXUy/qn1W1O06e/FXG9Eii7
         gnCtCBnCGPTZ7YW/rrn98SJvW6tCzQt0pulck15/e6Xh6XvhFE+RVxcX3HbwIL9Crr
         r3LWRUjkS5enA==
Date:   Wed, 16 Nov 2022 15:49:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     martin.botka1@gmail.com, ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jamipkettunen@somainline.org>,
        Paul Bouchara <paul.bouchara@somainline.org>,
        Yenda <jtrmal@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: ax20x: Add suppport for AXP1530 PMIC
Message-ID: <Y3UGc//UuuinJcbE@google.com>
References: <20221114162334.1801137-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114162334.1801137-1-martin.botka@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022, Martin Botka wrote:

> AXP1530 is a PMIC chip produced by X-Powers and an be connected via
> I2C or RSB bus.
> Where AXP313A seems to be closely related so the same driver can be used and
> seen it only paired with H616 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  drivers/mfd/axp20x-i2c.c   |  2 ++
>  drivers/mfd/axp20x-rsb.c   |  1 +
>  drivers/mfd/axp20x.c       | 63 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h | 34 ++++++++++++++++++++
>  4 files changed, 100 insertions(+)

No major concerns.

> +static struct mfd_cell axp1530_cells[] = {
> +	{
> +		.id = 0,
> +		.name = "axp20x-regulator",
> +	},
> +};

Why .id = 0?

-- 
Lee Jones [李琼斯]
