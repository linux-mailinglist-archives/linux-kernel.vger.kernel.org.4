Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B8675BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjATRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjATRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:39:22 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DC66E416;
        Fri, 20 Jan 2023 09:39:13 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l1so3257587qkg.11;
        Fri, 20 Jan 2023 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9g1BEZvZrqodmFDOISLKzRjoO7gt900zQziLNPYxxig=;
        b=iW5x6FyZ4kRruJuSjFDnWk3ekJ4QnBXu61QLi+LYYLgr3C/dTiEk1S/AjpKOH/cNo+
         iGXdACuzne7GknNIXvnfUAO6OT1Ssy+qoMhMwFGiQeIj5HHiGGUxPnArgkAPK8ceZQdm
         6jX5Hl7BNZTO18U4LQqpXHH7O8GvYSDlGa4bX2Jv1gKj/YQaFfcrh7UO47ldtINtb8Y4
         OvHCH5VrEMi+vsaImGlbd6YJFKqQsjoKEch9yCKE/7pGEfvTg5NKhprOUUTroDH1Rsuu
         W+xiHucnnbQJU9cwi36Q7uSjt9twwRWoa+XUKrKzPsskwpu/fcJK3P4SB3S1+fzY53VS
         zNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g1BEZvZrqodmFDOISLKzRjoO7gt900zQziLNPYxxig=;
        b=F+dr6xAYKJIsjVPFl7MgKG8DylJ6xDK+XMX1e0TSKpoa090MzG7l+7ouMZU9dSRAf7
         5Jvc5cqMijp+7Lw9zeo2qCEb8fmcoS2ZwM9DdDEM6yiQc/kbIwU1rdvqoc0IhfnBIQ5G
         RbA+kG3uaCP4zlgxpv1pkGAjk/4ejZIDO81p0O5lFuZZGaIy1k8blGv9vtIbn0i+gDYu
         nCH5H2FHmG9Lgj18myVeM4183mpY6xkW8AxtmLa9tSwFo0Rj74TS+ZjYoFio26ejFMTA
         ULGjwDvKg2A7cWV200NG0a/xlSytk2AaT3Q5xT6azAJ2YooeQHs1bIbfm/3pp395I60q
         LYPQ==
X-Gm-Message-State: AFqh2krvmyz+QTqf1MFsdF6ctodk3HYuuKlVOjOGnJ9EvyfkSYH1+FLZ
        oNwWxuVeLPgv8pXuMWUSHSjU2qJRePov4Eo1f9s=
X-Google-Smtp-Source: AMrXdXuh+LNPNSifVpuzE1cBEKvlIsgIpCH851pokA3KW+zv3u8Bf8TXGoBoW+nGOBhzndBUlwTJv+42etN/8riX1U4=
X-Received: by 2002:a05:620a:1139:b0:705:b8ad:5b36 with SMTP id
 p25-20020a05620a113900b00705b8ad5b36mr862323qkk.734.1674236352582; Fri, 20
 Jan 2023 09:39:12 -0800 (PST)
MIME-Version: 1.0
References: <Y8lZreSphK6DIkJg@kadam> <20230120171408.16099-1-bpappas@pappasbrent.com>
In-Reply-To: <20230120171408.16099-1-bpappas@pappasbrent.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Jan 2023 19:38:36 +0200
Message-ID: <CAHp75VfhWV7ArGZ_S-ik7UxvvOocKWTtAHhKGC4tSV+Y8dgb9w@mail.gmail.com>
Subject: Re: [PATCH v3] media: atomisp: pci: sh_css: Inline single invocation
 of macro STATS_ENABLED()
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     error27@gmail.com, andy@kernel.org, colin.i.king@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 7:14 PM Brent Pappas <bpappas@pappasbrent.com> wrote:
>
> Inline the single invocation of the macro STATS_ENABLED().
> The macro abstraction is not necessary because the logic behind it is only
> used once.

LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
> Changelog:
> V1 -> V2: Inline macro instead of replacing it with a function.
>
> V2 -> V3: Remove unnecessary check that stage is non-null.
>
>  drivers/staging/media/atomisp/pci/sh_css.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index 726cb7aa4ecd..93789500416f 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -97,9 +97,6 @@
>   */
>  #define JPEG_BYTES (16 * 1024 * 1024)
>
> -#define STATS_ENABLED(stage) (stage && stage->binary && stage->binary->info && \
> -       (stage->binary->info->sp.enable.s3a || stage->binary->info->sp.enable.dis))
> -
>  struct sh_css my_css;
>
>  int  __printf(1, 0) (*sh_css_printf)(const char *fmt, va_list args) = NULL;
> @@ -3743,7 +3740,9 @@ ia_css_pipe_enqueue_buffer(struct ia_css_pipe *pipe,
>                          * The SP will read the params after it got
>                          * empty 3a and dis
>                          */
> -                       if (STATS_ENABLED(stage)) {
> +                       if (stage->binary && stage->binary->info &&
> +                           (stage->binary->info->sp.enable.s3a ||
> +                            stage->binary->info->sp.enable.dis)) {
>                                 /* there is a stage that needs it */
>                                 return_err = ia_css_bufq_enqueue_buffer(thread_id,
>                                                                         queue_id,
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
