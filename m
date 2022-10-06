Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2682F5F69DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiJFOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJFOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:41:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D48AA3DF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:41:25 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3560e81aa1dso19688397b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=0bdCfSyzpGfAoJSANHuhm55S5uoWkaNWFJov2aB6O3k=;
        b=qXizk7O/TXpOaed4Brj9iDn9ZawW0STTT+7HkaIG0XfT7SU6jw/XA8F9haRtaXutTB
         JcTBNE4uMKmvMM9692CMaiPMJritFTozczq63xGMvZ4Qk1r0zSeZEXLGUNCk3tvbVj7T
         bWWW3ogICcKBDEiXW2WcIThhL4+6i8OumAYlcWP5X8fgbT6LL0CkrI2ftr2CZ2JtV0C7
         MQ3KfFRcT6TNe4fJBqqfKfw62G/dpmHxJ4G7r/1x3nmdkpmkKnRJT6yarclcbyLwbGd0
         DNesfTeCRDp58tWTjNXYJmCu6uMqd/jxvMYwJhawT2KKzFGeX3KNuBpv7InX0s7yPiNy
         93+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0bdCfSyzpGfAoJSANHuhm55S5uoWkaNWFJov2aB6O3k=;
        b=xEGRPQGkPcFQo0YeUVtKd0ZODZGybk4AeFgprSb5SQgL0OxwoYreQXbU91iVnG6Vw/
         liDrwxjFMtNt2z5ZC3zzTFZfNusl8tjLG+H3G6G86rVfPvz16xjGH77Ptj01k/5zHvqc
         /FcB90k8m7YX2xy5YbH7qx3mBdGZz/Umw0X5R3KVdROBpESm60rbQaiZLKx0IQ95msI+
         dJ4S4KybWXDJnKPysL3nhoAPo8VeFlPH91Pz9JNvY6v0CJXy7ReQLEo1yxOaYo0qq5Sn
         6niKLPq3Eic3Si0oclheBCj6EtY3Hde25x69+BD2sJd94iXlB07rRZunaIjuHozs2e+z
         rYpg==
X-Gm-Message-State: ACrzQf3luPmc071bkj/jLpmtLiZ7R/br4qZnZ0MSu2nRYpPrNZl57BxW
        MQ+sPUK6pc+DR6ZSuoL9t59pE6IG8qEw0SFvnWMzjICwEJQ=
X-Google-Smtp-Source: AMsMyM7fkByOV+NFyPjftfX6gmNicZPSB8P3YjbBriCzl4WcyN5xloYos+R/sliNAN6rr5FRvjjyf4e+t/3++Zy0PQo=
X-Received: by 2002:a0d:dc82:0:b0:350:8169:f190 with SMTP id
 f124-20020a0ddc82000000b003508169f190mr181243ywe.344.1665067284300; Thu, 06
 Oct 2022 07:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <1664331299-4976-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1664331299-4976-1-git-send-email-wangyufen@huawei.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 6 Oct 2022 23:41:12 +0900
Message-ID: <CAC5umygFSZ1ho4nDn_8sjU4_tsi8Hu4bkw0m4g=n6UO0+=cz4A@mail.gmail.com>
Subject: Re: [-next RESEND] fault-injection: using debugfs_create_xul()
 instead of debugfs_create_xl()
To:     Wang Yufen <wangyufen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, could you consider picking up this patch?

2022=E5=B9=B49=E6=9C=8828=E6=97=A5(=E6=B0=B4) 10:54 Wang Yufen <wangyufen@h=
uawei.com>:
>
> Using debugfs_create_xul() instead of debugfs_create_xl(), and del the
> local define debugfs_create_xl().
>
> Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

> ---
>  lib/fault-inject.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index 9dd1dd1..dbb5409 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -185,14 +185,6 @@ static void debugfs_create_ul(const char *name, umod=
e_t mode,
>
>  #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>
> -DEFINE_SIMPLE_ATTRIBUTE(fops_xl, debugfs_ul_get, debugfs_ul_set, "0x%llx=
\n");
> -
> -static void debugfs_create_xl(const char *name, umode_t mode,
> -                             struct dentry *parent, unsigned long *value=
)
> -{
> -       debugfs_create_file(name, mode, parent, value, &fops_xl);
> -}
> -
>  static int debugfs_stacktrace_depth_set(void *data, u64 val)
>  {
>         *(unsigned long *)data =3D
> @@ -237,10 +229,10 @@ struct dentry *fault_create_debugfs_attr(const char=
 *name,
>  #ifdef CONFIG_FAULT_INJECTION_STACKTRACE_FILTER
>         debugfs_create_stacktrace_depth("stacktrace-depth", mode, dir,
>                                         &attr->stacktrace_depth);
> -       debugfs_create_xl("require-start", mode, dir, &attr->require_star=
t);
> -       debugfs_create_xl("require-end", mode, dir, &attr->require_end);
> -       debugfs_create_xl("reject-start", mode, dir, &attr->reject_start)=
;
> -       debugfs_create_xl("reject-end", mode, dir, &attr->reject_end);
> +       debugfs_create_xul("require-start", mode, dir, &attr->require_sta=
rt);
> +       debugfs_create_xul("require-end", mode, dir, &attr->require_end);
> +       debugfs_create_xul("reject-start", mode, dir, &attr->reject_start=
);
> +       debugfs_create_xul("reject-end", mode, dir, &attr->reject_end);
>  #endif /* CONFIG_FAULT_INJECTION_STACKTRACE_FILTER */
>
>         attr->dname =3D dget(dir);
> --
> 1.8.3.1
>
