Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06B662C701
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiKPR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbiKPR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:57:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C86261BA7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25A37B81E50
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D29C433C1;
        Wed, 16 Nov 2022 17:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621453;
        bh=VZaIsZ26M5hdb9S7D+QY0GxU1tEbMVvXVEsUPwCzwmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTtaM9g/m45c9aui7pExcDKD02vy/BnVX+ty7MAoQFZM5GKPG0y2FAdJWyaDjmK/N
         eLBi0F73vxRPpiJAf5o7GkfX1u5wG1S0yQGpJ5v1ddgIFCaa4dwL2/ZVQE4mmuE1Wq
         spn31GP9oUAWFcqBFi7YosUg0rcRAsdBaBGqyS/lyS9tyvlx7ehSnlJUGMsuAg2D41
         //BkfdmmHGOmttnGwOnb4S2Bby6jBN/mPaCOOTuAXycX2EySml3vKlLTofylnedCdZ
         7b6aQ7KeNg5XZiEFyvCAi1TCasx7j8AEcQr3jXEZxiJRoBMpaUvRbOnNKg2TRkIZKH
         0QvyK37HHkg7w==
Date:   Wed, 16 Nov 2022 17:57:27 +0000
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
Subject: Re: [PATCH 12/18] mfd: rt5033: Replace irqchip mask_invert with
 unmask_base
Message-ID: <Y3Ukh6lnCG15fG3k@google.com>
References: <20221112151835.39059-1-aidanmacdonald.0x0@gmail.com>
 <20221112151835.39059-13-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221112151835.39059-13-aidanmacdonald.0x0@gmail.com>
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
>  drivers/mfd/rt5033.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
