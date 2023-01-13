Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8B6697C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241343AbjAMM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbjAMMz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:55:57 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6995185C9A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:43:10 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id i188so22072199vsi.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/6TZmWfUChFLdDGAMfhGqMTkLVrzJKqZem9xSaw0S8=;
        b=RJgJ8FTqHUU4D4CXrkHoK9OBpPAdXnLS1Kp/nB2aWTWGhgIio3lKzRBd46Wy1WAvGw
         BEPfBJaLnGzVYZynfoYGEYZbRWIZ3hYeirMPXYOtnR9Xw91svg5410tc/OLwsBhGcW+/
         DTrtyHGct+k0qhdvykimdDyxwwNPzUBgrvGvSkKcmVbUATMEEgqdvHKI3XIbcmjPrLvg
         sMG/fGYpYwWrxvFWJnIiEEWq3gYNWrCGe4+ZXDRgdORdtREit+wsLQMWeEGst+1mmtBk
         TwW6Vtc+F1W2kv0ng3nXwFTGINdwIKh3ipKyH93x3vEJb3VhQ6jhs0JaA6Qr907ofAbm
         nwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/6TZmWfUChFLdDGAMfhGqMTkLVrzJKqZem9xSaw0S8=;
        b=m5Ax65Fkf1lMorn/+mbVFEvjWtnw3CBBVXZkgakJpGD8+pazjrls6RV9oFwMNIAFG/
         zqe7eGDAQilKRGMHXp6Xt4Zfym0urH3SuGKODsLalGCQ/5aAbrDAKV9ZQevRtwhaCP7k
         CrAtUcLNC9Sv7YVfE3uNV79ihNuS/j9uBO+iVjXzYRwSzrFa4cHsxXcW9uZlQ+jmy3nc
         KoKchBLNU23+cZ+jdReiS+syhxqPdrPnDLGXLEgaWAgInSuVhoAd3ZFHbW/tRJY6FKKw
         kTz5UkxVdWHlbNR8FH1ZJH6/Uk9N3FRN6zOpN4IO6rlISCmsXPqAWPW3qvV3tYot4/g8
         yK0A==
X-Gm-Message-State: AFqh2koakXoEw9wXw5hG9DBJ8qsQPtKvMFxDwXw/rYu6q98XdLmCLwuQ
        d6rJzUhdtNM2MH0Hf/Sf5AJsSIku6+xUl3K3M3ZwMw==
X-Google-Smtp-Source: AMrXdXsqEL7wsfhpmfGzD+j0DOcb/mMYgKjn7c6o6l8PSk0zZcsyvavL4MJCcHbKDwwfG0BNeyWVx5dqk0tnvx2uJKE=
X-Received: by 2002:a67:df8c:0:b0:3c5:1ac1:bf38 with SMTP id
 x12-20020a67df8c000000b003c51ac1bf38mr11701035vsk.78.1673613789271; Fri, 13
 Jan 2023 04:43:09 -0800 (PST)
MIME-Version: 1.0
References: <20230112141743.63521-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112141743.63521-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jan 2023 13:42:58 +0100
Message-ID: <CAMRc=Mfum8Vbs5_e9-1D2yyir7ce7=8kerdPO+nkwR44_JwDeA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Do not mention legacy API in the code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 3:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Replace mentioning of legacy API by the latest one.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/gpio/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 8e2e2618d40e..ddc7a14a274f 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -339,7 +339,7 @@ struct device_node;
>   * @set_multiple: assigns output values for multiple signals defined by "mask"
>   * @set_config: optional hook for all kinds of settings. Uses the same
>   *     packed config format as generic pinconf.
> - * @to_irq: optional hook supporting non-static gpio_to_irq() mappings;
> + * @to_irq: optional hook supporting non-static gpiod_to_irq() mappings;
>   *     implementation may not sleep
>   * @dbg_show: optional routine to show contents in debugfs; default code
>   *     will be used when this is omitted, but custom code can show extra
> --
> 2.39.0
>

Applied, thanks!

Bart
