Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8376488EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLITWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLITWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:22:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA478BA7;
        Fri,  9 Dec 2022 11:22:05 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn7so5860963plb.13;
        Fri, 09 Dec 2022 11:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhRGeJWGrl0tr2bjnWyizth/nhOim0rSCX/mVsf4FsI=;
        b=jdzNMVpr4uHxXDO6uF6Z+4fuId1VRik3H9I3yGfzwXeRXAMfacAtS2iG+grTIwxiee
         6bMVyhr8xa6JdiZyypIERaCGtlmS77PHs8tHVkTwFWA6/GgShNry8csPojRQL2LmzLOU
         QZhPHUlv/ltOFMmIGh6B+2lpHCfCI7EyxlSu7MlYTkdhRwNvoeNApleDxmPl2wsOKnKt
         pXBImU/vsPCAFdHByYxONpKDX8jghKpHo4suCZge3VNpFhlzpmS4qsq/Ih/n7uwkkV1W
         nmLklSSr2mTHQw8Lh9kEmYTv1XTTidafb++TuFK4cV3oZVmkt0vZM7QRVQip70GisfHt
         XSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhRGeJWGrl0tr2bjnWyizth/nhOim0rSCX/mVsf4FsI=;
        b=KQmCoxz1BUeXKE1dFhS80S3nQY4P39jwGeRqtfXXonA8qmeeE/HdmhxRmvRIdr+pl0
         PVow0fSUf9npJJVA1xxC8GR087Yl8NOC7NN1E2KVXx0ISKL+ztapK0L0shG7wUyi78g1
         jAemPteh2OQ8gO4et1h1kR9qHJNZRCo4rJ2cjwZ1hTAlg0kBStF+MwfCYvxEWTyutg3z
         Fg0Zjwxu++K9hElMPb35DSBvG+Ar5/R1GpjvXUCrSpEmlJHAXavuA+TJaDLL1hg+rVtf
         nXJ7xht+KJHz4kSEIOO1q90Y2dh3zDYdZq5gq8ApceIP7RcsCMseS3M7LHPLmAE2fEea
         k4CQ==
X-Gm-Message-State: ANoB5plXpZcwWc47zd/QP8ibf3uQ/yxrrup68biU+oYFc2bfJvZgqIQU
        Tiuz+2E1v4Xg+Zfme9HUAdA=
X-Google-Smtp-Source: AA0mqf4wdfMIqGQEHLdJxiXpEjHBSnTL5Tg00ntUG/Fa/LRlZHT0p2nb7uxswyrXWf6WqayH3/tOgA==
X-Received: by 2002:a17:902:ccd2:b0:185:441e:4cfc with SMTP id z18-20020a170902ccd200b00185441e4cfcmr7857718ple.44.1670613724242;
        Fri, 09 Dec 2022 11:22:04 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5853:f1e8:694c:1488])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b00183e2a96414sm1658778pln.121.2022.12.09.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:22:03 -0800 (PST)
Date:   Fri, 9 Dec 2022 11:22:00 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wireless: ti: remove obsolete lines in the Makefile
Message-ID: <Y5OK2AvJGhgHXepf@google.com>
References: <20221209095937.17773-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209095937.17773-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 10:59:37AM +0100, Lukas Bulwahn wrote:
> Commit 06463f6e98df ("wifi: wl1251: drop support for platform data")
> removes TI WiLink platform data, but leaves some dead lines in the
> Makefile.
> 
> Remove these obsolete lines in the Makefile.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks for spotting this.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/net/wireless/ti/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ti/Makefile b/drivers/net/wireless/ti/Makefile
> index 0530dd744275..05ee016594f8 100644
> --- a/drivers/net/wireless/ti/Makefile
> +++ b/drivers/net/wireless/ti/Makefile
> @@ -3,6 +3,3 @@ obj-$(CONFIG_WLCORE)			+= wlcore/
>  obj-$(CONFIG_WL12XX)			+= wl12xx/
>  obj-$(CONFIG_WL1251)			+= wl1251/
>  obj-$(CONFIG_WL18XX)			+= wl18xx/
> -
> -# small builtin driver bit
> -obj-$(CONFIG_WILINK_PLATFORM_DATA)	+= wilink_platform_data.o
> -- 
> 2.17.1
> 

-- 
Dmitry
