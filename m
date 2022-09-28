Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1D5ED95C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiI1Jnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1Jns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116A8262B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ABD1B8201E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A01CC433D6;
        Wed, 28 Sep 2022 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664358224;
        bh=d6wVA6TilLgAjMMWiwyuEca0uc56xybXiv2nyeFP8tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtqLUF2p2z0K3CUN5DymKWrCxv7O41AJLZAxXuIuqqB1UgO+v64uJgMjaf4Pn8i7d
         61wL/vTMKLOyt40IjIf14o5wEYuTTVzxKwSNKDsmN7Avlvii6x/I2fv+Hn4tKDD/Xr
         rmLpLELi/R06s5yqMHo1ofJc2DcBNGUBl+lMslZx3hqu7K5wG6hp46M76L2w8001MI
         SuIWULwU58bc4izOFN+WNUHwvV4yEdjZeG04Esaqb5g1v9TLpOm68KZw8f7gYMTUQP
         ttwNGHcgAgIkOn7vsM38jBbKCmtdnkwvWDwOAXJxG59FAbmpfi85kWOm2tFUvAGw3S
         9FFbpYwm8sqYA==
Date:   Wed, 28 Sep 2022 10:43:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: Add check for platform_driver_register
Message-ID: <YzQXTHNX3GjztiDx@google.com>
References: <20220913091112.1739138-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913091112.1739138-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Jiasheng Jiang wrote:

> As platform_driver_register() can return error numbers,
> it should be better to check platform_driver_register()
> and deal with the exception.
> 
> Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/mfd/sm501.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
