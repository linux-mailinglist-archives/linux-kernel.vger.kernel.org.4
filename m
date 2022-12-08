Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16270646F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLHLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLHLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:52:24 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14D89AC2;
        Thu,  8 Dec 2022 03:50:46 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id h16so801489qtu.2;
        Thu, 08 Dec 2022 03:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0LAxwHpjYwQaUhf8SQTC1H3vXqd/lIYTQEqP5kdFx0=;
        b=SK2TYCkrUrBbQqxrTszekNo9T38xMPqtrQDPggGx/9KupZZhdO7dyDgRuQdwCrBoJb
         lVc0G8UNLEZTxzK4Rx6O5mlqfksykinDFUu8uSujK3sazqbjUmF4f0YGZUpa7tqryhzI
         S+axOuod8flppBg/MwqZkf0CeIRXPb5Jlkr7+we/pTTKSn7umPpPEUiNOqIk8alNuxXO
         CyzDZFMd0v/S5PlFAwlmnW5MH3fO914Xeq8tUu6gYw07th5P6oc7ihfmANMeDjDVp9/s
         w84kbW3Xb/k+3eer2EWL48yTi4HJ7gLRigLi22/oA6l6muBOqSaNE0rnyjl98GM5Buil
         m/Mw==
X-Gm-Message-State: ANoB5pmPYKy+4fopYDOkKVns5PYMP0dtk9zeR1Bcj0e3jWuDxdx2dzcs
        2enzn1Xk0DlOUiXn0BEY0T3Iiwfh/PkDEdbSbUE=
X-Google-Smtp-Source: AA0mqf75+wq8Bx7g124XcAaiVFY9yZVgoZobB8jwu0LFg1dgTLA8i5QjD7tcdpKJzIECnEBMSf+Nk6MdXNSCRUUWhf4=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr86331068qtc.48.1670500245691; Thu, 08
 Dec 2022 03:50:45 -0800 (PST)
MIME-Version: 1.0
References: <202212081707505932014@zte.com.cn>
In-Reply-To: <202212081707505932014@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Dec 2022 12:50:34 +0100
Message-ID: <CAJZ5v0iovWVucVZem=eh5sOwjmq_wuwk6S3L+w=+ugeoN+bkxw@mail.gmail.com>
Subject: Re: [PATCH] thermal/int340x_thermal: Convert to use sysfs_emit_at() API
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        dave@stgolabs.net, keescook@chromium.org,
        sumeet.r.pawnikar@intel.com, jiasheng@iscas.ac.cn,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 10:07 AM <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Well, you've clearly not taken my feedback into account.

Please resend this after 6.2-rc1 is out.  It will not be acted upon till then.

> ---
>  .../thermal/intel/int340x_thermal/int3400_thermal.c    | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index db8a6f63657d..c1fc4a78607c 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -130,10 +130,7 @@ static ssize_t available_uuids_show(struct device *dev,
>
>         for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
>                 if (priv->uuid_bitmap & (1 << i))
> -                       length += scnprintf(&buf[length],
> -                                           PAGE_SIZE - length,
> -                                           "%s\n",
> -                                           int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
>         }
>
>         return length;
> @@ -151,10 +148,7 @@ static ssize_t current_uuid_show(struct device *dev,
>
>         for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
>                 if (priv->os_uuid_mask & BIT(i))
> -                       length += scnprintf(&buf[length],
> -                                           PAGE_SIZE - length,
> -                                           "%s\n",
> -                                           int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
>         }
>
>         if (length)
> --
> 2.25.1
