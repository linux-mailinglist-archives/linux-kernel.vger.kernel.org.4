Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F556ECB1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjDXLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjDXLPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:15:39 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96D3AA7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:15:15 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Q4jGV2zYkz9tJt;
        Mon, 24 Apr 2023 11:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1682334914; bh=eXZhgxZ3gSLiN1Dk3zBmzyKLQtCuDkHTvvCzaNHb+/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RGFW3CGMcxS3QoyZOGf9vmiy8i/brzysGsyDHS1IUXCwfiy7eqMblx7FJMhhCRiKF
         kCF556nEtiEoj/rDJaN7E+4uTOuL6HUsL9ZGAAYzBbbDWYlaOZMJKXK9tn1x1qsCwM
         LapxPFZ/Nn2lTWpRzwb0x6gF3fswBcidsVQnsuGs=
X-Riseup-User-ID: 97066700368D72C7421B5CE4B917102B984FF54652C96645EE0B34F119C783BA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Q4jGD14LszFqLB;
        Mon, 24 Apr 2023 11:14:59 +0000 (UTC)
Message-ID: <eecbe65c-25d9-1864-dbab-97a626a19b9f@riseup.net>
Date:   Mon, 24 Apr 2023 08:14:56 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] drm/sti: Drop of_gpio header
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>
References: <20220812205746.609107-1-mairacanal@riseup.net>
 <20220812205746.609107-5-mairacanal@riseup.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220812205746.609107-5-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 17:57, Maíra Canal wrote:
> This driver includes the deprecated OF GPIO header <linux/of_gpio.h>
> yet fail to use symbols from it, so drop this include.
> 
> Cc: Alain Volmat <alain.volmat@foss.st.com>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Applied to drm/drm-misc (drm-misc-next).

Best Regards,
- Maíra Canal

> ---
>   drivers/gpu/drm/sti/sti_dvo.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index b6ee8a82e656..0fc7710b054a 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -8,7 +8,7 @@
>   #include <linux/component.h>
>   #include <linux/debugfs.h>
>   #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/of.h>
>   #include <linux/platform_device.h>
>   
>   #include <drm/drm_atomic_helper.h>
