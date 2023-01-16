Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BDD66D0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAPVB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjAPVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:01:17 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EF1279A5;
        Mon, 16 Jan 2023 13:01:12 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkwpftty8y--hfpj0xqfy-3.rev.dnainternet.fi [IPv6:2001:14ba:4498:4840:1c07:fe62:30fe:9b48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id A1D661B002E4;
        Mon, 16 Jan 2023 23:01:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673902869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oqY/zzcD03j9DKBmP/L1E82sbMHJoJjY22Eh+rHM6j0=;
        b=Rn+zCzzrxOLYjnQ1nARvUOjaS4VGxfnm9sIqFF9+7Drvu6AxESF0yDIPuGY6PZyCvgGDhO
        5qkHxuho1Mt5JuX+RINHA3c9uz6ZuekcEbKSohNZHYbclb8nzpVSvbgsB/S8xPsSOb+q0J
        4AiJoLr0MutPK/MeA9teWDQSV3jwucuGQPFXCTOWWaAKCzwt+iKQJQon9L8eZtfG1RZrLv
        BNwOhVXGGgZPIt/BI/0k0d/QT0m8uSp8sV95dqZrxNqurHSQpIH1JX3QfZ2pMM2rgipuOQ
        b2KqmiT0SnXvAnUS8DTEUIvqoy+eDIMREd+8Wda4gIhxvSNwQwiM3Qh7GQ0gWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1673902869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oqY/zzcD03j9DKBmP/L1E82sbMHJoJjY22Eh+rHM6j0=;
        b=rNYG7ndds3/gohYk5+3vXQlQTEDPPSxfkcFlCJ+DjIfDNWlI92ExMiAa2jkgDiwNLO0WjR
        Nn0dZDyTt9lyrdHPXDiW8Lte9KQxrSmnM9lAxMexuJ9F0fYhz7mjTWn0Qi+PREilxhD/Mh
        ZbE8R/qaeF2zf1bKSOfxIJabmyRBQN+z70FZ67xmXiKPTCu6usgg9mBLAKdt742kPyxv8/
        Qr2ZzKPILusXSo7bGuUfrBkVwprV4t4asaGKC+tjDm/AaPpUi7XuQ6SLdM4labL7lVzIln
        OdiSvtN+Z8vOn/wQFZN9c54n3I8V1w+G+LoJPUODn5H+SsqOTCmOoXHyc6Zv5w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1673902869; a=rsa-sha256;
        cv=none;
        b=jnUpk7XtPEn9bbET8EdBYJhF/Zah7sX3oaSouzZmrY8dZp10mX1wTtcIPEn2noRnd4jGks
        Ievs0405ToPDBu8onhZIuqc0GQJM8JatInLSvygUHEbyUxYiccuceFuDw4KHfMNuI5phdB
        jnxlp2YBoUQ1fEpw4LobyVRnROtFeY+ebiCzlkWFGlhzYs7FQXs6mDTiLTqWUcIKz60V2d
        jppuW2ChM5H+VHGE60HewMTnP4TTQ4gpZQSeiyS2nyunpclSkgoMFl0cEEz3ib7d/y6uLc
        yMWFgWlNL+2R8OQdWO6P2md5Yv8OuysRPjFkw7WP4BT1paiWMMJcG6jsThnBNw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 3D6AC634C92;
        Mon, 16 Jan 2023 23:01:09 +0200 (EET)
Date:   Mon, 16 Jan 2023 23:01:09 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Aleksandr Burakov <a.burakov@rosalinux.ru>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] media: v4l2-flash: fix NULL dereference in
 v4l2_flash_s_ctrl()
Message-ID: <Y8W7FaNouVxmeWox@valkosipuli.retiisi.eu>
References: <20221207141808.22922-1-a.burakov@rosalinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207141808.22922-1-a.burakov@rosalinux.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandr,

On Wed, Dec 07, 2022 at 05:18:07PM +0300, Aleksandr Burakov wrote:
> The NULL check added for fled_cdev before dereference.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> Fixes: 42bd6f59ae90 ("media: Add registration helpers for V4L2 flash sub-devices")
> ---
>  drivers/media/v4l2-core/v4l2-flash-led-class.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> index 355595a0fefa..36cc46e80eea 100644
> --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
> +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
> @@ -291,12 +291,16 @@ static int v4l2_flash_s_ctrl(struct v4l2_ctrl *c)
>  		 * No conversion is needed as LED Flash class also uses
>  		 * microseconds for flash timeout units.
>  		 */
> +		if (!fled_cdev)
> +			return -EINVAL;
>  		return led_set_flash_timeout(fled_cdev, c->val);
>  	case V4L2_CID_FLASH_INTENSITY:
>  		/*
>  		 * No conversion is needed as LED Flash class also uses
>  		 * microamperes for flash intensity units.
>  		 */
> +		if (!fled_cdev)
> +			return -EINVAL;
>  		return led_set_flash_brightness(fled_cdev, c->val);
>  	}
>  

fled_cdev won't be NULL above, this is checked elsewhere in the V4L2 flash
LED class code. I guess the question then is whether doing such a check is
meaningful. It would require a bug elsewhere in the code to happen.

-- 
Kind regards,

Sakari Ailus
