Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2264D65D91B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjADQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbjADQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:21:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F65DDF00;
        Wed,  4 Jan 2023 08:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C00D61798;
        Wed,  4 Jan 2023 16:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C471C433EF;
        Wed,  4 Jan 2023 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672849279;
        bh=4P5Io4msd12mkdoVuac9CSz+gC7WUcaBjm2ZmeY+G+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdClYZR0/b3SNqvBTmKm3OMl9gch5IbOjgK2Ac5rnG/SSZ1bMLwbiFN+9wLU8X956
         Fbm7nXp7cYWLnj7LbeDj3i6LZ7WRBxWl+kD1IHeqh/dDtDtnIMF+zJTCcUB9jU0qkU
         8dr9DjsyrAO7OJNpkzd0/oEtcL3MHFx6zusb15mKzqdOz3Vb6Xesybxx3MRpGzdUti
         FCerTOu/3pERM7KFTFtkvpivRCZP4ZeGghrmk0NK6Ci7DS0QtaKt7ifLUbVKbYJ3yS
         GB/p+yUvZdTJRt3PaR9MFJCCOkwrhkw72fxLO0j9qHXmeENKhEnhu/Hji/ooMImaGL
         ZAwGk0capC/vA==
Date:   Wed, 4 Jan 2023 16:21:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] backlight: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y7WneKovX/UR8P+3@google.com>
References: <202212051556478226726@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202212051556478226726@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022, ye.xingchen@zte.com.cn wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/video/backlight/lm3533_bl.c | 10 +++++-----
>  drivers/video/backlight/lp855x_bl.c |  4 ++--
>  drivers/video/backlight/lp8788_bl.c |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)

Is this v3?

-- 
Lee Jones [李琼斯]
