Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B392E6490AD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJUr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:47:26 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496416587
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:47:25 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id s14so5540669qvo.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CEKDlkVHglW99KqRbYgf1kkkoJ7bs9WkvbGtzTesMCs=;
        b=hwC5B2Bgy2YVuZuCIuWyBobOEB0Fe1BJpWJkSIc4oQwwNvQsHqnsFDkYfFz2xJg/P8
         KyDos3k7Ukf7s5O9TUgyvWEiFEkj48jNTv3JBjNNV73hqsqiQLrriLriz4KkLZDk0dl5
         KwC56ngev8pyOYgI1TwGdv/aQ4JedTsClDKuUpKnjTZs6QfzCgyggCRqIH4tWKI2Waxf
         hU7dZwT8YJYsR6L70zml9KojkBtwJi/hU7NH1JWVNcq3QNhFuJI4JQ3FEjk+mBsnaQ8/
         0RN5lUIhJG/9ePxr6E0U0WJwjQsLRP+UfUUzQ/jivadqgHfFYQmiXTP91rw36oZLjBWy
         u2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEKDlkVHglW99KqRbYgf1kkkoJ7bs9WkvbGtzTesMCs=;
        b=ipiB3QlInmNWbsTX1xDZUCqloe1FoxRxb0cfOhbXcyMI7tNNmk2kHG4eZWJQEKEsxC
         bzUxhoyjRCpMR6lzeg19tw6TvyM5l8PDlksY3KuloAg2fl7I8ubq/1Z4KCL58E6UUqfZ
         ZWpNuPc4BJ8cE8/Y0RkRdVIqYMcYhHfaF7cEZceLvKb+5Oqhr+DIU5hDyBlPhzAZNc3+
         zxBfuAASVFUF4dR78aUpo02YMQHj3O5y0DEk4Qddv0Y3q/q4bPj8c0Mz6TcpG95ojgqg
         NY/3CwRuCTQ1gkGK3U8Tk9x5q9zoQzfXALOwmWfIR15K86MiKY1YNP/WiUarPZiWNTD1
         Dobw==
X-Gm-Message-State: ANoB5pkvHTHVP19ekx06kiyM6x0KZk2gBYqxgGXJyPsbeHEF4Ji5WNnu
        mHR2imqht2EHEGAm03bQ1YD/AFo8qBsA8XwNM4wD/YHg
X-Google-Smtp-Source: AA0mqf4JTJfe7jmmA7m3FjSkVUtgmodjbVf1DUnU0IQstXdpNbVdR2cLfJKeSgJLRqc8cS7xZkvdLPapsgCpdzuloPU=
X-Received: by 2002:a05:6214:c5:b0:4c6:f93f:1cfd with SMTP id
 f5-20020a05621400c500b004c6f93f1cfdmr45555224qvs.35.1670705244513; Sat, 10
 Dec 2022 12:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20221204043530.1673752-1-jiucheng.xu@amlogic.com> <6e0dcfa8-6855-cc80-5e23-443d44cae07b@linaro.org>
In-Reply-To: <6e0dcfa8-6855-cc80-5e23-443d44cae07b@linaro.org>
From:   Chris Healy <cphealy@gmail.com>
Date:   Sat, 10 Dec 2022 12:47:13 -0800
Message-ID: <CAFXsbZr8yLOy2MnhX2SaCECY38DHcfpS1pOu3tZvt3xNBuH6HQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Add Meson DDR PMU as module
To:     neil.armstrong@linaro.org
Cc:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amazon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
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

On Mon, Dec 5, 2022 at 12:40 AM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> +CC linux-amlogic@lists.infradead.org
>
> On 04/12/2022 05:35, Jiucheng Xu wrote:
> > Add Meson DDR PMU to defconfig so that build errors are caught.
> >
> > Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> > ---
> >   arch/arm64/configs/defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index 0b6af3348e79..f2324b54a6ba 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -1265,6 +1265,7 @@ CONFIG_ARM_DMC620_PMU=m
> >   CONFIG_QCOM_L2_PMU=y
> >   CONFIG_QCOM_L3_PMU=y
> >   CONFIG_HISI_PMU=y
> > +CONFIG_MESON_DDR_PMU=m

Given that the other vendor specific PMU counter drivers are being
configured as built-in, perhaps it makes more sense to do the same
with the new MESON DDR PMU driver and also set it to "y"?

> >   CONFIG_NVMEM_IMX_OCOTP=y
> >   CONFIG_NVMEM_IMX_OCOTP_SCU=y
> >   CONFIG_NVMEM_MTK_EFUSE=y
>
