Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55105699B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjBPRXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjBPRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:23:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCAE4CCB6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:23:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id eq11so5569031edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CgujHaHXUR9rsoL7c92bZNN7/8k5pOu6iNqvBQ5bLj4=;
        b=lBP7D2RChfckbpLKqiJvNWKcJ9clSqSYv8bnizeDEmQluv6xMIOnbtFGrHei1W+ZZN
         rRm946SwdJjWXjawN2Tj5ny2Zj+g+ytsVyfAhZotJJEK6eSsb4TOzf5ub0uAbARG/SAn
         1gzQgAu8GFO7HRTd74gwpL+Jmhcve2n5bWkWBESO9S8uLMDtvxhHsWoWCLBZ4rGQ/RQV
         yOkohcxhrzcJBNe0lef3a+AISNeXnq9NKYbxMsBXG6uVQh2fSKMRPWkYrUaUEZlN2bVn
         2kKsStvuQxmeuwpmV33GLYfvi6shxe3UZV8IVUPhGgP2wWVsm9ozDVshDkR9MqxmsEnM
         x8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CgujHaHXUR9rsoL7c92bZNN7/8k5pOu6iNqvBQ5bLj4=;
        b=v4zzq9TV5BFhzPWJtI/Yfwer3LQII8OKKomc6stpaZfgf7VHWx42uKiYSOZNBCd02h
         sErjdOc2+hPade5CSbdbI8HSjN1/FXwnWLavEH+t94qi6Ai4g82V9AZRsvCjpzTGXtis
         ibEOJ8VuMdlXuMPU3tWJvKYViXOl52Kdt3m9erJhi+/rmcqHXpoA+3+IM4Y6jkY5gvQb
         y7o6KYhzbp13UXFvjjRkvOXcUkwUjyHw4zpelxhPMvXMXgKG4u8Vszs7FZMpbhRboIxb
         29VIuziCcATj96lpQlJC6lFJqs4xqEzu4xrmkSNDlkfJ9tX1qFqCCSBmHt/vZ13p6yv3
         4dog==
X-Gm-Message-State: AO0yUKU31/MZI/pQPdWcGVyxUuaLY3wqZJFAnEdXToEMnQ6foz00ALRf
        2JEZWZDzkbBbV1kiaFuy0VjD4tskktDmE8W0Qfjneg==
X-Google-Smtp-Source: AK7set8WtPrjRgcSyrVQo+ZpdoncG6QN25IVOlwDMY0eXKiuWBP53zX28TlFTLNWpPB4OJ2SCaKg/2mpehtwFG+pACQ=
X-Received: by 2002:a17:906:3b10:b0:886:4b7e:c1dc with SMTP id
 g16-20020a1709063b1000b008864b7ec1dcmr3261650ejf.6.1676568178457; Thu, 16 Feb
 2023 09:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20230215214724.3798917-1-linux@roeck-us.net>
In-Reply-To: <20230215214724.3798917-1-linux@roeck-us.net>
From:   Joe Tessler <jrt@google.com>
Date:   Thu, 16 Feb 2023 12:22:21 -0500
Message-ID: <CAJPkMDTDU-UK35hrx4=c26VmBVSuZO6usr9Omiq2dtyTjHsZLg@mail.gmail.com>
Subject: Re: [PATCH v2] media: cec: i2c: ch7322: Drop of_match_ptr
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joshua Pius <joshuapius@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Guenter,

Thank you for this fix.

On Wed, Feb 15, 2023 at 4:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The driver does not instantiate on ACPI based systems if OF is disabled.
> Fix the problem by dropping of_match_ptr.
>
> Cc: Joshua Pius <joshuapius@google.com>
> Tested-by: Joshua Pius <joshuapius@google.com>
> Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Joe Tessler <jrt@google.com>

> ---
> v2: Added Joshua's Tested-by: tag
>
>  drivers/media/cec/i2c/ch7322.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/cec/i2c/ch7322.c b/drivers/media/cec/i2c/ch7322.c
> index 34fad7123704..3c6e6496a001 100644
> --- a/drivers/media/cec/i2c/ch7322.c
> +++ b/drivers/media/cec/i2c/ch7322.c
> @@ -589,7 +589,7 @@ MODULE_DEVICE_TABLE(of, ch7322_of_match);
>  static struct i2c_driver ch7322_i2c_driver = {
>         .driver = {
>                 .name = "ch7322",
> -               .of_match_table = of_match_ptr(ch7322_of_match),
> +               .of_match_table = ch7322_of_match,
>         },
>         .probe_new      = ch7322_probe,
>         .remove         = ch7322_remove,
> --
> 2.39.1
>

Joe
