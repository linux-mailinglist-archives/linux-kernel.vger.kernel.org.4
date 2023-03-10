Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E906B4D23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCJQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCJQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:35:54 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A74112DDE;
        Fri, 10 Mar 2023 08:34:06 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e21so4688415oie.1;
        Fri, 10 Mar 2023 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678466045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LZymklHctXhGjv6HuiTRygfeCKyXWhZY1DVnyofWu8=;
        b=M65m23wzC1245l1q1IhCmiq2UbpeAMdmU/SWKDojb/84/qMGWwLn5/0mrI55/5mcPi
         n+eaXWzGD6ym78z/VOEr/Qcpjca5BcsHyANlBoS2lDqmxAauikijLXE3//j0Iqkdqs9B
         HaV3WIpr6ka4LmGxdisp6/KeTB480jrd3KGib9fV1BRD+b0tBGJ4U9FhAEURVzySUovg
         Ti6ci4i4v5m8Wk2VZjWGfGqadf+8hvs7pc398+xF4akKdS/YuRviu47eSgohhN9Rk5EA
         ggXYmHVCBdrKQD3NJxAqUMaGnM22eetL+xRhtxdFrs1fJkq3+wm/vp0gkmycsvi2E1hp
         eQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LZymklHctXhGjv6HuiTRygfeCKyXWhZY1DVnyofWu8=;
        b=NTfW9N7Kwlof7OHDlUXtiDtFsI/aYe91NC1e+xo2jCZL/8G4ZQ/gzI3HWyBe01FjxI
         xC2RuFxUWq/aOfNbq2xRfIV7acofyTouXyW5jhlDFk/I51y1ReyY4v0Pq97QNuycqJIE
         OUburzoOgTt0YlUezjBeoARXHB7aJ9rLy2e15C3osiZBibh/u4ROugIJX9iKAPjqLH3g
         WxVtKaiveUkXWEGBnnBOA29QU3nIpBitYTy7Dinh0a1+0tZPZtc8GmI7K0NejWl8zfj7
         qYl8joCQMZ4q23VngQf8zEn/d0F5M1/b1fTEyFQN7k1ikaypdCA58F07HR75vLR1S1Wk
         A01Q==
X-Gm-Message-State: AO0yUKUBcuuNY0TaihDYK0nNGhF7DfcIEtSCMk3Atl8HV7rVOkExb5+a
        Z8qe2qnHSKq+mWqh0AMf2Ks=
X-Google-Smtp-Source: AK7set8igdVi6XKByIK2eUyaNolvwd8Z1vrZDB0CtCNLLzuyQ5ZCtTjwrMePGo6Cheh+u7YH92Jjbw==
X-Received: by 2002:aca:f14:0:b0:384:ea1:dbea with SMTP id 20-20020aca0f14000000b003840ea1dbeamr12211919oip.47.1678466044886;
        Fri, 10 Mar 2023 08:34:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j65-20020acab944000000b0037d74967ef6sm20950oif.44.2023.03.10.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:34:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:34:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH] hwmon: (xgene) Fix use after free bug in
 xgene_hwmon_remove due to race condition
Message-ID: <329d128b-5436-44ad-89a3-75d82a7a11ec@roeck-us.net>
References: <20230310084007.1403388-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310084007.1403388-1-zyytlz.wz@163.com>
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

On Fri, Mar 10, 2023 at 04:40:07PM +0800, Zheng Wang wrote:
> In xgene_hwmon_probe, &ctx->workq is bound with
> xgene_hwmon_evt_work. Then it will be started.
> 
> If we remove the driver which will call
> xgene_hwmon_remove to make cleanup, there may
> be a unfinished work.
> 
> The possiblesequence is as follows:
> 
> Fix it by finishing the work before cleanup in the
> xgene_hwmon_remove
> 
> CPU0                  CPU1
> 
>                     |xgene_hwmon_evt_work
> xgene_hwmon_remove   |
> kfifo_free(&ctx->async_msg_fifo);|
>                     |
>                     |kfifo_out_spinlocked
>                     |//use &ctx->async_msg_fifo
> Fixes: 2ca492e22cb7 ("hwmon: (xgene) Fix crash when alarm occurs before driver probe")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/xgene-hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> index 5cde837bfd09..d1abea49f01b 100644
> --- a/drivers/hwmon/xgene-hwmon.c
> +++ b/drivers/hwmon/xgene-hwmon.c
> @@ -761,6 +761,7 @@ static int xgene_hwmon_remove(struct platform_device *pdev)
>  {
>  	struct xgene_hwmon_dev *ctx = platform_get_drvdata(pdev);
>  
> +	cancel_work_sync(&ctx->workq);
>  	hwmon_device_unregister(ctx->hwmon_dev);
>  	kfifo_free(&ctx->async_msg_fifo);
>  	if (acpi_disabled)
