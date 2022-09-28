Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BF85EDA18
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiI1Kcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiI1Kcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5B7B2B1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15DBE61DF3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A00C433D6;
        Wed, 28 Sep 2022 10:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664361157;
        bh=3K4mlyQdbYqKsgWLJ5hw03fCtg9ZzFhXnWwRGvxyuag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwmNv2h0K/st1Qre0mHRPAal7LaGybr3AC9beIDaq16X562dbvaaw3FXDGb2bPcLK
         pc3lw7J2hgMjC9pgJIkeya1jdDZAkoMxmaIKt2juOiunhC9hDEUxrPa/fVYSrDZEOT
         akbw4SLwRJWVn/21IQ9I4a+QvBYN8jFfOboWEGFvo+1glArgdKT8aGFUPCpBZ5N/ub
         Fl+UILV3whae7wu6pGnj8KFiCSgTbEOjVOq3spHwa27jfqsb5ojdG+/Lr5vgB1oXfC
         uQIXuuP6d7KmAmZmubGdbLpZ2qZ67UK778+uKt0uuEymMDpanAId9eVKwa/KPOXLgJ
         h9kfVvzoLeTAw==
Date:   Wed, 28 Sep 2022 11:32:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH] mfd: htc-i2cpld: Fix an IS_ERR() vs NULL bug in
 htcpld_core_probe
Message-ID: <YzQiwMwgAZMIH0qF@google.com>
References: <20220913071659.94677-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913071659.94677-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Peng Wu wrote:

> The gpiochip_request_own_desc() function returns error pointers on error,
> it doesn't return NULL.
> 
> Fixes: 0ef5164a81fbf ("mfd/omap1: htc-i2cpld: Convert to a pure GPIO driver")
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  drivers/mfd/htc-i2cpld.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
