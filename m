Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2551A6A0116
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjBWCLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 21:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBWCLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 21:11:02 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6E3402D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:11:01 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536be69eadfso156185077b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 18:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=agmt99ERP4Lf0P7eQYv1KVKMj6iSmC6cQgnmN8jVaT8=;
        b=WZvGVnb+n+YRSIPY+/CTmrPz91UCo3sqyZ/dznec+MC+i4V9cCWSWBlKW4EgoThebN
         mW0X9hiTrUKd2Fl+aU0bKGMtGGV6/B97QZ3tL8iPlDkhLGoSVuEceCK6YWTGMVUY7IjD
         MSK4XIDFJyizrXC5JbI2ZfvodH4EuwHJIwUn2RvCpgwTqRNz7oFc3f9mtaV1wfGYP6kS
         tixxSoP9J7YsihVBzmRJ7y/pHmmjJf7LZNyqkYPoaJHLOb1Iu+lYdc5+PqJcE0Gggtdr
         JgQ/816rR88V4fv/WPmnt+dfyAICVmDoRoDxZIAQFXRZVjjfz+WJwOpjx48Eiu6H9XDT
         c2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agmt99ERP4Lf0P7eQYv1KVKMj6iSmC6cQgnmN8jVaT8=;
        b=IBn5Qn+G5CUk+ka3uVpNgu/4YJnKj4NK67q0emi24UWuZPWuwS4Pu5nI/gz+Xnxylu
         NoVWlEu8aDAs5ty+3xOIUQvjO5hAtz2sR/I8MnEen+dT8+rTtg8ABlc+ae1Pd90YfXTF
         S6xZtVOHD89TSyjJ+x32AcdwVdw+fzCzav6SyyxYsOUaYTAWYmDnnPpQ3meH3appcPht
         3zfWVi538y7A74WzYn1Vh66BEa1jPievsHIQXXaz0miyvtBkNr2g8Js6fe4+AhKnEhAT
         Tt0IcV6QmsyDf++n+fE8jg4P2cepIG6eVep08vIVR4n2gLBHbnbvyQ6aayanAVAKNXuO
         Th+g==
X-Gm-Message-State: AO0yUKWd8GPZQwA9JgiTEF/5i7q2Y4kKs+3gQAjd+n6hhMO9d4umZcw2
        2rnhtjWbERBRy5bCiXd//+xNFHokoOJ6SctynWuxSA==
X-Google-Smtp-Source: AK7set9EP5ZbyAm7ORU/z9pS5I6CjY2Um0I5400dATxt8qpJFvve4/pI0e0j9SmFqqpSXv14xyD8Sh6ke7po12y3ISQ=
X-Received: by 2002:a25:f203:0:b0:9f8:119a:6f9a with SMTP id
 i3-20020a25f203000000b009f8119a6f9amr1055636ybe.10.1677118260856; Wed, 22 Feb
 2023 18:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20230223013847.1218900-1-sboyd@kernel.org>
In-Reply-To: <20230223013847.1218900-1-sboyd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 23 Feb 2023 04:10:50 +0200
Message-ID: <CAA8EJppgarZnGHEAfNwi768B_wz1jF0WEbTE2W1sWcs2nYRFPg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: apcs-msm8986: Include bitfield.h for FIELD_PREP
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2023 at 03:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Otherwise some configurations fail.
>
> Fixes: 027726365906 ("clk: qcom: add the driver for the MSM8996 APCS clocks")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/apcs-msm8996.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/qcom/apcs-msm8996.c b/drivers/clk/qcom/apcs-msm8996.c
> index 7ec4022c5b43..3e91e9e6da74 100644
> --- a/drivers/clk/qcom/apcs-msm8996.c
> +++ b/drivers/clk/qcom/apcs-msm8996.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> --
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
>


-- 
With best wishes
Dmitry
