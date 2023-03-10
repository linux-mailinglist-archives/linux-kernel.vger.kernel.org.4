Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B859B6B3527
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCJEH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCJEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:07:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29731F691E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:07:52 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g3so3855750wri.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 20:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678421270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6qoxD73xYpg5xt33PC4c+C04eewyFCfIAb6qdXDdS5o=;
        b=Z3PBhObeqzKlcIdwD0Ep7KeEkGc2w5v4bvt+AxKBWb/ApLgQ7AphG1LukcJFaRAzJN
         arjynRyxq/97KDktL4N8jfbw948/eLx3pL0nNqQsOAkJMdRpcGjfaioX/NsyGbMEy7yg
         n7Cy77P/oJNgCAKchioq4ve1aczTOjhy4mUe27lAxrMyKMfgN04hon/hFNhTl8gj7PjX
         oh1YqqkbdMmsL20f9Q5GvbT8lPv1+PxEITBeXkw+P07vUxe6Bklcso4RhXO5tN38Xs9P
         lhB4UEC/286MyOffv7rjCUvE96BBL6EnFoO+v3Phnynu+iZs68nmU7rUai51pf6JB1XZ
         1vzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qoxD73xYpg5xt33PC4c+C04eewyFCfIAb6qdXDdS5o=;
        b=n2fZng9AV4lsGI593d8J+AEt1HTpqeXsaN0Q1CfliYuIGRR8x1GigkdWOs7T2HMQdQ
         6UW0uPkKillRac7tk3TYM+zYM9kEOygYxlE7qBpLHloeUIq/EBmqg0rZcrrTQ9fSX8HT
         pYp2A7C4RYMe4zHAlT4T8Lv6AXbRB0x0lnbJ+sIjrqOEEU/GhpbszuZi0AZOw2rIv2VC
         pF8hin/SEBYrpdnAWMyQmkG7BKbG3pbC9XBdpu6iJqKM+fs1AOPakNoG0pD97VlYdIIE
         Hi2qCQmGCKR90raerpxpIeZ6b+gOfi4dUmrQyGZh46OjdfsTYJOWgOzyfqqfj2nq+NTU
         xBZg==
X-Gm-Message-State: AO0yUKV9pWqtn/Zdltn/dF+xqSov3HjZEAhCa/Qng3YlmBMIjajWIr42
        eg4svLLcsHgAzdnqXdm1kZ8=
X-Google-Smtp-Source: AK7set9Cj4berzzp6cYQ3zlYMopGLoPWkkWQrMKdtIA2bykvF59yHvX5EmIDBVqCS3VS6+i2s2o2hA==
X-Received: by 2002:a05:6000:1043:b0:2bf:d937:3589 with SMTP id c3-20020a056000104300b002bfd9373589mr781767wrx.14.1678421270408;
        Thu, 09 Mar 2023 20:07:50 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b002c559626a50sm955261wrr.13.2023.03.09.20.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:07:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 07:07:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kloudifold <cloudifold.3125@gmail.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fixes alignment should match open
 parenthesis
Message-ID: <e9022276-9dbc-497b-8803-7ec7bf87414f@kili.mountain>
References: <ZAqrkWn22Q1eXjCL@CloudiRingWorld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAqrkWn22Q1eXjCL@CloudiRingWorld>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:01:21PM +0800, Kloudifold wrote:
> This patch fixes the checks reported by checkpatch.pl
> for alignment should match open parenthesis
> 
> Signed-off-by: Kloudifold <cloudifold.3125@gmail.com>
> ---
>  drivers/staging/fbtft/fb_tinylcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
> index 9469248f2..7d4741c47 100644
> --- a/drivers/staging/fbtft/fb_tinylcd.c
> +++ b/drivers/staging/fbtft/fb_tinylcd.c
> @@ -37,8 +37,8 @@ static int init_display(struct fbtft_par *par)
>  	write_reg(par, 0xB3, 0x00);
>  	write_reg(par, 0xE5, 0x00);
>  	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
> -	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
> -		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
> +	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00,
> +		  0x00, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
>  	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);

The original was obviously deliberate.  Just leave it as-is.  Checkpatch
is not the king of the world.

regards,
dan carpenter

