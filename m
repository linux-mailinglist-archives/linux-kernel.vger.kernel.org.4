Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEF674C23
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjATFYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEE07AF37;
        Thu, 19 Jan 2023 21:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4E9CB82674;
        Thu, 19 Jan 2023 21:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902BBC433F0;
        Thu, 19 Jan 2023 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164375;
        bh=yQT7vF8YUwj4dpk5uOYW6ZI2HJbDbf0PuVFcTzzBj/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW/EJdAhnBZ70wuOAsx/7rczHPj006EtmoxDD+J6Ce2Zw+Nanrs7JqMej38VCsGfu
         w8x7ze74AHlVv7fjBNnd+nHIqwQuL4mKA/e17XE0iav6L8XfugKQp8l15PAIYhd8Ec
         WyCDvGyPoKvLRryTge0rzzAJqffxADf1pnrYgyfyBiAVhT34+Xek1K0eWTWns9lox6
         udROIv+bL+htcolekcNqfSdqWzsI7UFO0CG/DAP8eODuq360y+JjrPCZMQIT2uph05
         +q1i82sD8VBVDqp47gKyyb0CQmIzXAeOdmSVYY1Ltzws1lQr8EZxjHY625K13H1BFv
         R3+Uo/3FdQXHA==
Date:   Thu, 19 Jan 2023 21:39:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] backlight: ipaq_micro: Use backlight helper
Message-ID: <Y8m4krH0nh6sh5NM@google.com>
References: <20230106164856.1453819-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106164856.1453819-4-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2023, Stephen Kitt wrote:

> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/video/backlight/ipaq_micro_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
