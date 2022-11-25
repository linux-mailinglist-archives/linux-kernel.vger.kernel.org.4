Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC49638CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKYO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiKYO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:57:25 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC73D939
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:57:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 130so4152099pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jdhD7TyJAV9Yjv88DjHcR22sCnTCoFYgtGFsGgYfXW0=;
        b=Uqm0qn5phqXeWhCqw/F05B4fb0YwjNUdPVyTz7nqy4Q+gyHwPLQ6HvMR1FgS8jsCQU
         q1IK7QHUqNoSej2t1wae6i6GrPqtmNhKTjRNOXv6dBWEzRWn3zQdAUmrUhsthaHH4ikA
         cKR2je4BA6e11up3gJriA/c3gADhUN24D8E0lcOKMwEyz+uwt53A6gsbAQTo8nUyFU29
         Nzm2onZOM9+PF/v7Fqfbx9qr3HMphnAgYbvo2Oh7YGfVdmy0npoS0XPfeShCqUtIbkWN
         3x124UDWLQJk1XjK6AP0SfKR3Jb8jr/J7dC5VtiH9wtkfA9KDI0Bz/IE257BuNOsWrFa
         g8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdhD7TyJAV9Yjv88DjHcR22sCnTCoFYgtGFsGgYfXW0=;
        b=FTaeG6nV1qeMmJujJfNhk6gEwl42TuofSHOzPjgnEATP4mnKTR4ccEJTqVAO+fB4kd
         v61+rz5xBq7/nXokA5GOyozxMg2ceyP2zUi4/ZH9vPggG3nKJgNoGgjP5nKmAK7IDFtU
         cFX2bO3NFtXj8CfcfAsOiyzm4k6NAtVaOITC/M/7tOxCSAqsUHr9a2phAW10WLa5S1ve
         DaOleO4B9ZjN1zkM5xP+YnT5W8zYrZn77NOdJWP9BcjAE6MbNUp6hHMpg1ku/R0jdaof
         MzdYxi8gED70WM7xVdCCaO/f//TDTzpQtkz87lWn3LP4bl6n5/D3GgQw8ddyYF0uQ5KS
         pQ8w==
X-Gm-Message-State: ANoB5pnHmMuLZzErtyW+zVv3SGDQ3wmC2VyxBOFsjrPJqvIRqJkWWALZ
        rWZu10WXWYTpOASkeLF6QYevyn+ZWbSSpVfp9OiIyQ==
X-Google-Smtp-Source: AA0mqf5I5b28SQXiYfcgPnjF5puxBhYUKVhvjzG8dNtV0uM9fPMxZbbenGJQY8bIxdgwY3OxzBMUM0f64wcqVgqOMVc=
X-Received: by 2002:a63:e008:0:b0:46f:5979:8889 with SMTP id
 e8-20020a63e008000000b0046f59798889mr16712060pgh.119.1669388243590; Fri, 25
 Nov 2022 06:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <20221125112201.240178-3-krzysztof.kozlowski@linaro.org> <CAPLW+4kwFCLaiowajdCnA09eT4emOB-3d-6cbA=ZYyRLwYuCxw@mail.gmail.com>
 <dfd956d5-d62d-52ac-c485-afc71c441df5@linaro.org>
In-Reply-To: <dfd956d5-d62d-52ac-c485-afc71c441df5@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 25 Nov 2022 08:57:12 -0600
Message-ID: <CAPLW+4mWq5Q4Ht1Upx2Xw3fMfNvvSK6fEPbLFru1NLpKHLbKOg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos5433
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 at 08:47, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/11/2022 15:22, Sam Protsenko wrote:
> > On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Exynos5433 has several different SYSREGs, so use dedicated compatibles
> >> for them.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Cc: Sriranjani P <sriranjani.p@samsung.com>
> >> Cc: Chanho Park <chanho61.park@samsung.com>
> >> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> >> ---
> >
> > Hi Krzysztof,
> >
> > Just curious: what is the rationale for adding those more specific
> > sysregs? AFAIR, e.g. in Exynos850, different SysReg instances have
> > pretty much the same register layout.
> >
>
> On Exynos5433 all these blocks have different registers. Are you saying
> that Exynos850 has four (or more) sysregs which are exactly the same?
> Same registers? Why would they duplicate it?
>

Ah, no, you are right. Just checked it, they are different. Just first
couple of registers are similar between blocks, that's why I memorized
it wrong.

So as I understand, adding those new compatibles follows "describe HW,
not a driver" rule? Because AFAIU, right now it'll fallback to
"syscon" compatible anyway.

> Best regards,
> Krzysztof
>
