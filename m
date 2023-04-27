Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7446F07F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbjD0PLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbjD0PLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529235A5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:11:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C95263CBE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14243C433D2;
        Thu, 27 Apr 2023 15:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682608298;
        bh=Gf8nlpng7soqr5+IOxjYLYRRA4rKG/YU02EyHleTbyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BV9ao6OrjxMppVoEoC3CCctoTYVGW62VOyw/PhZ6mtpWAC5RcdQXZKdvWCYNYDhkx
         jGN69oBmu+vaF+y7dsozQIUS97w4X+Dx/CIHexTEgcz8zINrM671gC/8eZ9JsBbKsC
         i+n07RYQhjqJWig+0tLNm6J8CYeiSY1dTyH9+fRjwsYoYb/CoSZZg+Zzkm9Lg2fovQ
         8EZBePLkQt+Ez1ULH5K1e44WKzVsHtrJJfh0pybJfghGOcjm8nYHGLo7bIQ4RdfCRj
         VhU00Z8Z2k5XbHyW93P2w0MHlSYpfyb0a0+qGqzl9dKNxyc92JO04hGq1j1npuQENo
         uuRzGzE5dLM5g==
Date:   Thu, 27 Apr 2023 16:11:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wm831x: Use maple tree register cache
Message-ID: <20230427151134.GW50521@google.com>
References: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, Mark Brown wrote:

> regmap has introduced a maple tree based register cache which makes use of
> this more advanced data structure which has been added to the kernel
> recently. Maple trees are much flatter than rbtrees, meaning that they do
> not grow to such depths when the register map is sparse which makes access
> a bit more efficient. The maple tree cache type is still a bit of a work
> in progress but should be effective for some devices already.
> 
> The wm831x devices have a pretty sparse register map and being always on
> devices never do cache syncs so don't hit the major current disadvantage
> so they should be good candiates for using the maple tree cache.  Update
> to do so, there should be little if any visible difference at runtime.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/wm831x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
