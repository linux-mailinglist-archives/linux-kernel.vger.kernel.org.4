Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310886A2D10
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBZCHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZCHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:07:10 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617A113FC;
        Sat, 25 Feb 2023 18:07:09 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y140so1210314iof.6;
        Sat, 25 Feb 2023 18:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oUrV65DvJz1MlLRNg+iPzZY8aqrFbPa/knFZvxr1Kbw=;
        b=SGLOso4TUPA1ykJmwAoTQWhovHzSENx0gsg++egebJJ38y7f8WUlwKUrRS/lhSFwBh
         gVgI/fsabQF8fhIhJCIcpZzW+fyoCG/sclP7/Zp6VBCdvr0YT+9PRQiGhCqGoi8S0Xmo
         2uKjrWfoc+UaR0bDyk3low8Rl+7GqX5ZiG4S0CIAiqa8qk93oF3v97QHLAnIH/iQ4Tv5
         VHnPkQPYEJZEf+aSgNc+q2RdLEOvBR30T/AIKBwXXDL/hug3fRCmyMxgbha0PuKcuZjq
         6kmAM6b+XOWi1SNYiYKbgaEQ/dlrrbH8bGagwRomDcgAd7hThiFdhIVAeGndOjK/3p0y
         m1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUrV65DvJz1MlLRNg+iPzZY8aqrFbPa/knFZvxr1Kbw=;
        b=gYOwSiZLbns3uwUvJUTcmTw2lgJjcyNqQZOtDcfdtK1QsPnk6HXe/SaPoDcTTxSo5p
         22G0DqPlPeQPFr0Zx+OAMSpo4c45SqwHasYvey3hd/XpYnjb6ZCwIU1tNRZFlbf1Gs5F
         bj2XRinHYeflwnrWLB8AjR6ff+6oEcM9JAR46v7IcXEzd1SJRGD28xepz+0a4SgjMEGI
         Tom/q/Z0yn5geUCESf2nVGURjwgPOqtLV0DYE7HUgjfPOMAsLDZ5yQnRjyiLYsor/XRn
         N15rMsHUvvnKFj9XrAg9jMFWHwjg/3c/4kIp6W9yxQVjoEBW24FeDEaHPxuhWaWQRMrB
         kASw==
X-Gm-Message-State: AO0yUKVObA/KuTYbTTTMGr7ybv5lqOf+H+7Uh7aYLr2Yc+y+0+gla+00
        ks/B32reMA78lZEZd8KuwmBqAODzCHsKIsdwfsdPnzWiE5XdSA==
X-Google-Smtp-Source: AK7set/M+mqinePR1EhKVLfvDJPGeXbG/PPPOrXHzrYDx/R+R5Rs/ow2rhQugFKuYXcjHgkwb3e/2OSvb+9qg3N/KL8=
X-Received: by 2002:a6b:14c7:0:b0:745:934c:cc65 with SMTP id
 190-20020a6b14c7000000b00745934ccc65mr4098916iou.0.1677377229002; Sat, 25 Feb
 2023 18:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20220621081506.50096-1-jiaming@nfschina.com>
In-Reply-To: <20220621081506.50096-1-jiaming@nfschina.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:06:57 -0500
Message-ID: <CAEdQ38EDxV=K-kxB=u0Z+YRaBr1yTT7iN5gzhxw6-QJo+n9y3Q@mail.gmail.com>
Subject: Re: [PATCH] alpha: Add some spaces to ensure format specification
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 4:15 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> Add a space after ','.
> Add spaces around the '=', '>' and '=='.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>  arch/alpha/boot/stdio.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/alpha/boot/stdio.c b/arch/alpha/boot/stdio.c
> index 60f73ccd2e89..e6d1ebff4209 100644
> --- a/arch/alpha/boot/stdio.c
> +++ b/arch/alpha/boot/stdio.c
> @@ -42,8 +42,8 @@ static int skip_atoi(const char **s)
>
>  static char * number(char * str, unsigned long long num, int base, int size, int precision, int type)
>  {
> -       char c,sign,tmp[66];
> -       const char *digits="0123456789abcdefghijklmnopqrstuvwxyz";
> +       char c, sign, tmp[66];
> +       const char *digits = "0123456789abcdefghijklmnopqrstuvwxyz";
>         int i;
>
>         if (type & LARGE)
> @@ -83,14 +83,14 @@ static char * number(char * str, unsigned long long num, int base, int size, int
>                 precision = i;
>         size -= precision;
>         if (!(type&(ZEROPAD+LEFT)))
> -               while(size-->0)
> +               while (size-- > 0)
>                         *str++ = ' ';
>         if (sign)
>                 *str++ = sign;
>         if (type & SPECIAL) {
>                 if (base==8)
>                         *str++ = '0';
> -               else if (base==16) {
> +               else if (base == 16) {
>                         *str++ = '0';
>                         *str++ = digits[33];
>                 }
> @@ -125,7 +125,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
>                                 /* 'z' changed to 'Z' --davidm 1/25/99 */
>
>
> -       for (str=buf ; *fmt ; ++fmt) {
> +       for (str = buf ; *fmt ; ++fmt) {
>                 if (*fmt != '%') {
>                         *str++ = *fmt;
>                         continue;
> @@ -296,7 +296,7 @@ int sprintf(char * buf, const char *fmt, ...)
>         int i;
>
>         va_start(args, fmt);
> -       i=vsprintf(buf,fmt,args);
> +       i = vsprintf(buf, fmt, args);
>         va_end(args);
>         return i;
>  }
> --
> 2.25.1
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
