Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B15FF26F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiJNQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJNQob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:44:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051171BE938;
        Fri, 14 Oct 2022 09:44:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id b5so4765235pgb.6;
        Fri, 14 Oct 2022 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIneIIyv2q1QhRu+3OHZL3JM2gZoB+5mtMOcLTE6H5o=;
        b=BwSyffdZ7ppvkQKzkjX8ZuUEorSmxftn6JIbU9av3L4VS2Qx0gsN0ypL0HY2iVxktw
         vPLrgnsCv8xNaRWh0e52rFevY26OEa0UVXJGBukKkCoF56SvFkQdHHi59C/NiaLSPoTR
         ZRlfq1Am8o/iICbjCknzpDXBsoPEfTSyFNK9sUqX3GLgUr6nazM/f7mnMGANTUIwTeQS
         q3wz/A1OgHaFEPTZahmaUDv/Et8gW3vd2EHkVwFQwGaEU/gHOFjylAI/cIZZjYbMFHwN
         2sY0VWK4+IdzYHUpLzdp1caf9KDLafKM/Jk7ANhCXH1sw2TWS9NQGwIo6JlP//tS1zOk
         r2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIneIIyv2q1QhRu+3OHZL3JM2gZoB+5mtMOcLTE6H5o=;
        b=McFE31RGOOJrit6EiVycFpSV1ZnrGY/Tmg3g1tDHOy06v0QVl+Jk7OOXfRJ3D1Fx24
         OAmJuSKKO5ilwBmSVx3bFz18THnIl29xwlPq2SuDQmc2PI9xt6DYRTnlgnFm1MZWFKZO
         kYRyx7cfKEzm3I4yd+rKYdioj0GIDwPnae0g5/rITJgrjqgOkA1Bp106INfHFu0zSKu8
         OcbqGDdu7pXUmH98bk/ojSU1OwnHzfZDNN7YnW5sNRQFFPdbqmw+DR6q46UwzB+46mTC
         H4zK41fSpIsBpr4rXysrsLmNqbOZ05ia24VnVTfR0zEA0DliIoAa2GjINQlIzcv7RWJG
         +t+Q==
X-Gm-Message-State: ACrzQf3d3Z1L4QPI2MVlUFH9pd4wmZfLG6vStf5iLVv4Ubr4L3f2Gqsj
        9loSkKR7Ge3J//uD9Bp5AWE=
X-Google-Smtp-Source: AMsMyM4zlhvmOb981pIpU8iL5h6g94L0kwQftqJ4fjE7+cBBW14QWUC73V+KUBNWwo3Z+f4NVMFQbw==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df2 with SMTP id z2-20020a056a00240200b0052c81cf8df2mr5995331pfh.40.1665765870304;
        Fri, 14 Oct 2022 09:44:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o2-20020a170902d4c200b001708c4ebbaesm1845054plg.309.2022.10.14.09.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:44:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 09:44:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] watchdog: sp805_wdt: fix spelling typo in comment
Message-ID: <20221014164428.GA105432@roeck-us.net>
References: <20221009083944.2988237-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009083944.2988237-1-13667453960@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 04:39:44PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sp805_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 78ba36689eec..2756ed54ca3d 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -88,7 +88,7 @@ static bool wdt_is_running(struct watchdog_device *wdd)
>  	return (wdtcontrol & ENABLE_MASK) == ENABLE_MASK;
>  }
>  
> -/* This routine finds load value that will reset system in required timout */
> +/* This routine finds load value that will reset system in required timeout */
>  static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
>  {
>  	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
