Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6D76B08A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCHN1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCHN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:27:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DDC5ACD;
        Wed,  8 Mar 2023 05:24:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a65so5638974qkg.13;
        Wed, 08 Mar 2023 05:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678281876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qZoP71+5c3FVKBx98Aqiaa+ZcAlza86aEyQCRu3z974=;
        b=Q4QesLjAGlM42tRSwoI+HcvMCyjJlBF+MYJeMSF2XPXBTWsvyYPu6iekvSGCkG7K3M
         ZU/XdVEunzvpxGOr7gUeUo1E/0qRwzJlaw/1f6N/4eBsyhkMDJA4cnshQDglSrFfkD4r
         0OeYmtW6Y7gFIdTZBL+6yi9LiE+OSKDMe4d3Hj9AlkKZRWHbYKzqoLZTmfxSnoA0TQa9
         zaVnSwD7KgYWnPg7f0VHzCVWaqRlF3btsJJBIrXNRxZ4M53M8TkkIRmE36Psy9CG6JQ5
         chas3FBi7Bsd59EEdSKSCA3Xo/cZW2SzjqHNLdY0G/ZMywVBZSiQNu/la/6XNiavwvp0
         BOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZoP71+5c3FVKBx98Aqiaa+ZcAlza86aEyQCRu3z974=;
        b=bReBjz09RD1L5PK5pspcQ2ryeyaC/F/8rWQE269OBxZ/+PppEGsA7fx6hINnWJZ6Z+
         h+vfRNyEbupHcdSfcQ3dUPYXEGHZafi3LjQu/orTmTYCYXXnr3i2zZgBAmERwmqi1gTj
         8SQUbm39YSthUVT7YAj56rAoq4XVa0KwA+VUicMWg5eeXiVlWuEqwk9Mn+0viJQ/fhzF
         1y8aifU3/OiogW4Gp0mLOwmdH1r3juK2o//FQRUURSLIqXlrE6hZLg72iQWxkvBRpiiW
         pa6/gvxPFty8qnbGXci9trRWNlcDfy8VmCUiH1eH3G84iO+gjhpDnNL5WKRX7XJxQ6B1
         I44A==
X-Gm-Message-State: AO0yUKVtBNmwGE0kEpl8E2NDkbv0Tm4lYzKmxlKIViqCDhpzjB2g7jWZ
        TZycdLIOOn3OAzk5kc1TaiJAE4N9/BiCzlXeZNU=
X-Google-Smtp-Source: AK7set+3+KOGVmoTKCyVDclv+hazU63yGvn2mTBscxNnBRm23ESammya3zfhhVhmcnKROal6d062iEm7APHU+6r5cjY=
X-Received: by 2002:a05:620a:713:b0:742:7e5a:4cee with SMTP id
 19-20020a05620a071300b007427e5a4ceemr5114611qkc.10.1678281876099; Wed, 08 Mar
 2023 05:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20230214163116.9924-1-quic_devipriy@quicinc.com>
 <20230214163116.9924-5-quic_devipriy@quicinc.com> <ZAZ+GeGu8mW1XqpG@surfacebook>
 <15d270ca-1068-b926-efc9-a14ddfc90a54@quicinc.com>
In-Reply-To: <15d270ca-1068-b926-efc9-a14ddfc90a54@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Mar 2023 15:24:00 +0200
Message-ID: <CAHp75VfMae9M2R0Bw6-sYuHPPberakEzKct65SXV0XEaOFtXTg@mail.gmail.com>
Subject: Re: [PATCH V8 4/7] pinctrl: qcom: Add IPQ9574 pinctrl driver
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
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

On Wed, Mar 8, 2023 at 11:52 AM Devi Priya <quic_devipriy@quicinc.com> wrote:
> On 3/7/2023 5:28 AM, andy.shevchenko@gmail.com wrote:

...

> >> +    depends on OF
> >
> > No compile test on non-OF configurations?

> As per the generic convention followed in other
> SoCs, we do not have compile test on non-OF configurations

Why not? So, you have to explain the deliberate narrowing of the test coverage.

> >> +    depends on ARM64 || COMPILE_TEST

...

> >> +#define FUNCTION(fname)                                     \
> >
> > PINCTRL_PINFUNCTION() ?
> I see that there are quite a bunch of files that has to
> be modified for using the generic data type and
> macro for the pin function definition
> We shall post a separate series to accommodate the changes

Sure, that's fine. Please do!

> >> +    [msm_mux_##fname] = {                           \
> >> +            .name = #fname,                         \
> >> +            .groups = fname##_groups,               \
> >> +            .ngroups = ARRAY_SIZE(fname##_groups),  \
> >> +    }

...

> >> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)    \
> >> +    {                                               \
> >> +            .name = "gpio" #id,                     \
> >> +            .pins = gpio##id##_pins,                \
> >> +            .npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),     \
> >
> > Can you embed struct pingroup?
> Will take care of this in a separate series

Ditto. Thanks!

> >> +    }

...

> >> +};
> >
> > No MODULE_DEVICE_TABLE()?
> The MODULE_DEVICE_TABLE(of, ipq9574_pinctrl_of_match) entry has
> been added at the end of the file

So, you know what to do then to address my comment :-)

-- 
With Best Regards,
Andy Shevchenko
