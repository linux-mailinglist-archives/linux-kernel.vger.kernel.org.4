Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB05B9949
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIOLEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:04:22 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B819926F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:04:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3450990b0aeso214994817b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Fjdmt49Ip6IrMmuwN3vP4Pv2wpYe0K89XUz1Xteq1mY=;
        b=Kb++79upi6ZTFZJV2hwSGbfOJio8ZRLuBoYUkuGjepiU/FlyqLePo7fQ6FO6XQKPuq
         TwY/2NUsz2viNbON85Vpb2sXvMrUnuRyovsqd7JhCVPlgQwCBDmYVJQSZNLoW8Tt/BLJ
         959QybdG+5G6VrQs9VUFjjHm5IDWMWp118ByJ23G1U3rzfFVHYQSkIOVMgnXncGnplUP
         wQUN4MQMezpJTsFXOffMasb9m3LYQrqzuXMwSzArM3TqWH/ldnp3VmzGrH9/LcC6hygR
         1h6/eTvdz/48wYADMpO3IXE5xcyzld/QNuh6BUH1MVdnjbExQoGlF4iRvwv766fxFrqS
         dSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Fjdmt49Ip6IrMmuwN3vP4Pv2wpYe0K89XUz1Xteq1mY=;
        b=0M7SglAx/OoeMFudpAzNWULtJJxARXNJ9cRGVtDla36Y+q10hHPothN1442r1vrJ6V
         SuIOJqdbiWwmNJX9zNwYvXO+pyeWttG2sfJJcvh6bk/FzcvK/mK7zsppK6eBl+BGFnuZ
         dKWhMdhAyDAyWJiWB7pALR8/WECHnXzIyj+lSAAWhRJu+yh+Z9WpJ/qH0DNp+RGHrMbo
         7pN/jMM5bjh/GEaN/TzOnqB3UVIsgTKk2rG88hBN1Q7FzuoaQ33Jz1KsUwOKk7LrGSB7
         d7FoBXcXF1Py4YdqFrbBMdmUpiEvpTqp9me9pO6lZ5hUyozQ81LilhGKzFkY9rd6nS+K
         Ediw==
X-Gm-Message-State: ACgBeo3DJp335RPbZ0fbsytVaOtqXDBnnkjZPZ0RQZcwmscFVm0nC0zB
        F3QX7kohlXf3saVICqtajD6GtCgy/++9U4TRDS5Lvg==
X-Google-Smtp-Source: AA6agR4GL88S9tVhRmjA6i/uTEy7NyuRQAaU9cz/cIZdqHJpBAPT5tAcPdAYvuxOxAY+H8MVrip6/s9i3CauqquYrGE=
X-Received: by 2002:a81:1988:0:b0:345:11a6:fa56 with SMTP id
 130-20020a811988000000b0034511a6fa56mr34928167ywz.138.1663239860269; Thu, 15
 Sep 2022 04:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220915085733.20290-1-luca.weiss@fairphone.com>
In-Reply-To: <20220915085733.20290-1-luca.weiss@fairphone.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 15 Sep 2022 14:04:09 +0300
Message-ID: <CAA8EJppkPgNpiyVW+JGzPTzC2wW0Z+qv1DRMWWTYv=p6x0mH7Q@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: qcom-spmi-pmic: Add more PMIC SUBTYPE IDs
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sept 2022 at 11:58, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Add more IDs that are found in the downstream msm-4.19 kernel under the
> path include/linux/qpnp/qpnp-revid.h.
>
> While we're at it, make sure all hex numbers are uppercase and
> consistent in this file.

Please make all hex numbers lowercase. If they are uppercase
somewhere, it's worth fixing.

Additionally, it would be better to split this patch. One fixes the
case, another one adds the new IDs. It would help the review a lot.

>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes in v2:
> * Convert existing lowercase hex numbers to uppercase
>
>  include/soc/qcom/qcom-spmi-pmic.h | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/include/soc/qcom/qcom-spmi-pmic.h b/include/soc/qcom/qcom-spmi-pmic.h
> index 72398ff44719..f1c9f1676fb4 100644
> --- a/include/soc/qcom/qcom-spmi-pmic.h
> +++ b/include/soc/qcom/qcom-spmi-pmic.h
> @@ -18,26 +18,40 @@
>  #define PMI8962_SUBTYPE                0x07
>  #define PMD9635_SUBTYPE                0x08
>  #define PM8994_SUBTYPE         0x09
> -#define PMI8994_SUBTYPE                0x0a
> -#define PM8916_SUBTYPE         0x0b
> -#define PM8004_SUBTYPE         0x0c
> -#define PM8909_SUBTYPE         0x0d
> -#define PM8028_SUBTYPE         0x0e
> -#define PM8901_SUBTYPE         0x0f
> +#define PMI8994_SUBTYPE                0x0A
> +#define PM8916_SUBTYPE         0x0B
> +#define PM8004_SUBTYPE         0x0C
> +#define PM8909_SUBTYPE         0x0D
> +#define PM8028_SUBTYPE         0x0E
> +#define PM8901_SUBTYPE         0x0F
>  #define PM8950_SUBTYPE         0x10
>  #define PMI8950_SUBTYPE                0x11
> +#define PMK8001_SUBTYPE                0x12
> +#define PMI8996_SUBTYPE                0x13
>  #define PM8998_SUBTYPE         0x14
>  #define PMI8998_SUBTYPE                0x15
> +#define SMB1381_SUBTYPE                0x17
>  #define PM8005_SUBTYPE         0x18
>  #define PM660L_SUBTYPE         0x1A
>  #define PM660_SUBTYPE          0x1B
> +#define SMB1355_SUBTYPE                0x1C
>  #define PM8150_SUBTYPE         0x1E
> -#define PM8150L_SUBTYPE                0x1f
> +#define PM8150L_SUBTYPE                0x1F
>  #define PM8150B_SUBTYPE                0x20
>  #define PMK8002_SUBTYPE                0x21
> +#define SMB1390_SUBTYPE                0x23
>  #define PM8009_SUBTYPE         0x24
> +#define PMI632_SUBTYPE         0x25
>  #define PM8150C_SUBTYPE                0x26
> +#define PM6150_SUBTYPE         0x28
>  #define SMB2351_SUBTYPE                0x29
> +#define PM8008_SUBTYPE         0x2C
> +#define PM6125_SUBTYPE         0x2D
> +#define PM7250B_SUBTYPE                0x2E
> +#define PMK8350_SUBTYPE                0x2F
> +#define PMR735B_SUBTYPE                0x34
> +#define PM6350_SUBTYPE         0x36
> +#define PM2250_SUBTYPE         0x37
>
>  #define PMI8998_FAB_ID_SMIC    0x11
>  #define PMI8998_FAB_ID_GF      0x30
> --
> 2.37.3
>


-- 
With best wishes
Dmitry
