Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71244715470
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 06:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjE3EPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 00:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjE3EPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 00:15:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30860E3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:15:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30aea656e36so1087834f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 21:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685420131; x=1688012131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9zAmG8r5Tvl40l89QOePVe0ImxWIFUXod7GM9rjQ6w4=;
        b=Cb0tUT/yg+2xLrCPQuYqIbDjPDTphCH1qAbkrurkgLiNWjf/+GsbPBedPGXMO0NPeo
         2csyGZIh/5JddVjwDBMEHKWK+Oobnbg83tOJsq28qtKMvAGMIhHdrw19I2qk/UHJzS4R
         eBeI+QR7McKqWffpzi1fC+lB3XK0TURBrmBhXrQWmlMYVsWAzG8f4uDtAaRL/ZvVZ3BF
         2xNjgjpI1h14o3ItEAjw/DbBXH94w7FRKwSyRLNMErYyz9YGkX3h5hJ3utLQC2cP5LCQ
         24xBICXEBTLk9Dv77Gfwvayf9MqeaCnaruG5SvRTnk3gnd+YLUSRY/xj6Br4WTjsuDC9
         MjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685420131; x=1688012131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zAmG8r5Tvl40l89QOePVe0ImxWIFUXod7GM9rjQ6w4=;
        b=dXRqnq12CxlXiI2M57ic1Fer82jptmV3IqSY8EkOQwExYX499Dod9vbevbCxAnu1PL
         UDLeJaRiWwOm7Gaz+t49w4e7dB2dXFYWx043y42tHJjP02gq+QmFphjtGk9zVFB9JDTO
         UmYIWJi1zjhn+Sy4BILviszb7guVuIy06YsnkhxTreE5CUJ56dcQIY41XDm3nCkhNk6X
         NjsRaCjqzmhrkef4HqZGn0Rk1Eb4otAgRjq7joc1C0DWmP4St0Yz1v0gguwcgmqXYFIu
         VhMsVNOmlWu3+yBAdzsqAQkQaZ9iL0ixTATbqBofQB9yyB5M/r+aE1m0447eGvtHdgf0
         WMzQ==
X-Gm-Message-State: AC+VfDyfvnNeXlmx/W3kLWYB+YKkfw14LF6bdzZZmbmIbEZ2BmGqzKQo
        w/cDwBNMPPYFElbonw32azJ+Sg==
X-Google-Smtp-Source: ACHHUZ5SesDtWuZ/F2abelZZil/nppjy3LFKMWP+MiqKh1HA0BKpirE+O275NqL6Cp90anfi0dLFIQ==
X-Received: by 2002:a5d:4a11:0:b0:30a:bae6:fa98 with SMTP id m17-20020a5d4a11000000b0030abae6fa98mr434634wrq.39.1685420131670;
        Mon, 29 May 2023 21:15:31 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b003077a19cf75sm1780745wrs.60.2023.05.29.21.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 21:15:29 -0700 (PDT)
Date:   Tue, 30 May 2023 07:15:26 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Staging: rts5208: rtsx: Moved else statement to same
 line with else if
Message-ID: <ee41bf67-a074-49fd-bd0f-7fb992d68884@kili.mountain>
References: <20230530022259.24094-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530022259.24094-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:52:59AM +0530, Deepanshu Kartikey wrote:
>  drivers/staging/rts5208/rtsx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
> index 2284a96abcff..47dacef0aaf8 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -399,10 +399,8 @@ static int rtsx_control_thread(void *__dev)
>  				chip->srb->device->id,
>  				(u8)chip->srb->device->lun);
>  			chip->srb->result = DID_BAD_TARGET << 16;
> -		}
> -
> -		/* we've got a command, let's do it! */
> -		else {
> +		} else {
> +			/* we've got a command, let's do it! */

This code is part of series of if else statements that all have the
same issue but you're only changing one.  Please change them all.

regards,
dan carpenter

