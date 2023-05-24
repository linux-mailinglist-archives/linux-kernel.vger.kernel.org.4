Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1796270FD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjEXRwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:52:03 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD236B6;
        Wed, 24 May 2023 10:52:01 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-96f44435d92so36069866b.0;
        Wed, 24 May 2023 10:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684950720; x=1687542720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8s+iCfLGhAWMeUCmISWbcng6Ztiz5xZ2WYWKuHiGSM=;
        b=lF4CE7v3mkS5uyHcSO3DBJsY2RIW2jmgW7C2ODtdsVJjqUwAU9J20fCEvLMVFdD/GZ
         w1E38YNRYMWyBgxeMz7wY40FTrUvw2gvt0npA9vyqdHtWRrl7WSQ5sU+170Fc3J/2WGp
         VZrbHcktcSUTxTnNqh1TRtmZTQnMdxqn/XvVuazkN0865Q6FYBM9vNjh4Op8UFzYkT6g
         25mXHJPWvCloZMugvWwsd8QOz/YCcCmMkDSX/byTEZDdLTPeuI3KB54IvDLODwjKEUY3
         cGhy5a8LyXoiiTGGaURqEhxz6EF9fukhYJbYmHlwjVVvO90f6UtV3s5xw0hlXWI20VKB
         mHbQ==
X-Gm-Message-State: AC+VfDysLP9+W0FFnabPqAYDkKNo+g7qB8m4d9eCeCkL86IPOUe+cxAh
        WQc+1olkRUWMa9o9zQvDHEDT+indzuuilqjy8pg=
X-Google-Smtp-Source: ACHHUZ4YXBkzSuEfty00UMlynnqkeyUgeGVEfPlZ+2J8FPdlV5kw/fEgWNxRTkh05T2PyijTLADuM1aNeKD5o0+b3Sk=
X-Received: by 2002:a17:906:77d8:b0:959:37cc:190e with SMTP id
 m24-20020a17090677d800b0095937cc190emr16001159ejn.3.1684950719996; Wed, 24
 May 2023 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230522223844.2330343-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230522223844.2330343-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:51:48 +0200
Message-ID: <CAJZ5v0izNboNVZHvtV+-hB7e7P73MfJAMj5i0SjFRJwVAt4D3g@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: Add new line for UUID display
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:39 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prior to the commit:
> "763bd29fd3d1 ("thermal: int340x_thermal: Use sysfs_emit_at() instead of
> scnprintf()"
> there was a new line after each UUID string. With the newline removed,
> existing user space like "thermald" fails to compare each supported UUID
> as it is using getline() to read UUID and apply correct thermal table.
>
> To avoid breaking existing user space, add newline after each UUID string.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Fixes: 763bd29fd3d1 ("thermal: int340x_thermal: Use sysfs_emit_at() instead of scnprintf()")
> Cc: stable@vger.kernel.org # v6.3+
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 810231b59dcd..5e1164226ada 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -131,7 +131,7 @@ static ssize_t available_uuids_show(struct device *dev,
>
>         for (i = 0; i < INT3400_THERMAL_MAXIMUM_UUID; i++) {
>                 if (priv->uuid_bitmap & (1 << i))
> -                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
>         }
>
>         return length;
> @@ -149,7 +149,7 @@ static ssize_t current_uuid_show(struct device *dev,
>
>         for (i = 0; i <= INT3400_THERMAL_CRITICAL; i++) {
>                 if (priv->os_uuid_mask & BIT(i))
> -                       length += sysfs_emit_at(buf, length, int3400_thermal_uuids[i]);
> +                       length += sysfs_emit_at(buf, length, "%s\n", int3400_thermal_uuids[i]);
>         }
>
>         if (length)
> --

Applied as 6.4-rc material, thanks!
