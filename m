Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3166165DB19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjADRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240165AbjADRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:17:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F2BDFCF;
        Wed,  4 Jan 2023 09:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D210AB81888;
        Wed,  4 Jan 2023 17:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9BFC433F0;
        Wed,  4 Jan 2023 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672852634;
        bh=flCRzPb0Fn/y+JbT6SPfEuNtl01OMb1WGCSQgr8q+sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIkzxo70Qhk/3IV9GhD0kIAbJPcx9Piiij1rPPyZlOw3UsVv4PxKwBfWtoDopSUB1
         RyXmRTIZAZKIskE9hWQdA83+hu2WAkVPv2mruhTF3QakpYDhHmN0VuhtoJoKBRaOw+
         kCdgI0PU3c/ydAWT84HAUPygbhiTcuMhQvddCLgu6eT992YDnIDl6H783KBNFEsgie
         d2h4O8/cKulJhmy2ulRYGS0+WI5CrrZ+o61YnRBiCwym5n1SBMldAWRNAGiIdH4pxY
         3/pnr8qk7C47nilEnTYZoNydhwUiWkXidDUWtNxsGdaRRe+shlqSBR4wIyBtcAvVn+
         f58Es7zvTtWwQ==
Date:   Wed, 4 Jan 2023 17:17:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: backlight: Fix doc for
 backlight_device_get_by_name
Message-ID: <Y7W0k8bQMH7cRbo8@google.com>
References: <20221215071902.424005-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221215071902.424005-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2022, Miaoqian Lin wrote:

> backlight_put() has been dropped, we should call put_device() to drop
> the reference taken by backlight_device_get_by_name().
> 
> Fixes: 0f6a3256fd81 ("backlight: backlight: Drop backlight_put()")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
