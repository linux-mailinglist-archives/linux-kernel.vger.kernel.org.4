Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68962647816
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLHViC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLHVh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:37:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25420997
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:37:48 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f139so3033524yba.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G41Op/lXG3g8Cnic6c+y5fMoL1kfzSLedyaKM6ngDWk=;
        b=VpKYfGNZb5NLOpCp/ra9Y2Ulw55z+QsCoke03jVwQYoK9q/V9V4MH4UDvmU/KT5E5y
         xzaa2CrDyT8Rafr7S87MxrWHIp775KtLJccKp/ErlERK1ai8gDR1KucY4E0gS5vrC8ue
         o2a2uxAXzDyaZn6KYzvBhrGGHgU2OYNyhOgLehAiwyGEA2DxZqfqTz/ivnVp8an9p6qf
         4lnkXsUHdIeDkebmwL4Wpu0kkB+/tkL8OqnH0ExiDEFtVN1z8BIeuA4+asytJtsZBt5h
         X5+Cm5oms9BQOlb8Gfa4nskF6afkGCb/Fjw6V5SujsBw7hhQtl9yEJSbcxlJ6kfxjqFg
         m4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G41Op/lXG3g8Cnic6c+y5fMoL1kfzSLedyaKM6ngDWk=;
        b=QOJkw9ObG6b1UZkZL2b46Zan+ynmED21bcb5AIZWEaTmc0/uEtaufMOSGUaGj8GZIJ
         Bvs5OBdKcDSrknQYUKiA6YDswly4W2nUp2a+lod5U4Szc766fqpC+xC5kp1rBTLxSxkY
         tcU+uyAapSXd+qt2q/IicfFgu8kyU4S1qJmiPTNhcif35QY2FhEFMm0H8aMk8JM3VRRo
         zoCbHdSgWwdTwnpbi8uNmCWuhtVLwwCIi9HpAym3P+UqjSGKW+/37MLXGRsK2dprxsbt
         u6VhQQbOvfsKioUNDgfxF+VJbZTUQA2qjfw6i5niu8oyXXHDeavwxhnbN0hQKBPI5vfS
         UcZQ==
X-Gm-Message-State: ANoB5pkF2mwbjfbI3pUOYpXZHYSAVWsuzBaUhQktQcM0W5TID71UM0u8
        NsnO7AhXpc5/ceaglfPah8G94XG3BonEYUAAYubCOQ==
X-Google-Smtp-Source: AA0mqf7rPAESFFVwhyJ9HkuCCRFFiTbnhyEA/d6xsWGCjrmTSVvR3DD4aRUtEyo49QuIvzEJhbumeD0JLnToI4RKBHw=
X-Received: by 2002:a25:ac2:0:b0:6e9:3d7a:8012 with SMTP id
 185-20020a250ac2000000b006e93d7a8012mr69106030ybk.449.1670535468018; Thu, 08
 Dec 2022 13:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20221128054820.1771-1-clin@suse.com> <20221128054820.1771-3-clin@suse.com>
 <CAOMZO5D0wJcfbFsvUN3K17S5F4zT2Yf8yQB+wMKQPzuMBitrpA@mail.gmail.com>
In-Reply-To: <CAOMZO5D0wJcfbFsvUN3K17S5F4zT2Yf8yQB+wMKQPzuMBitrpA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:37:36 +0100
Message-ID: <CACRpkdaKYFbXRcV1WgDEiYPEwzNAZq-AqAHpWd1rJyW-h369dw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: add NXP S32 SoC family support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Chester Lin <clin@suse.com>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Phu Luu An <phu.luuan@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 8, 2022 at 12:04 AM Fabio Estevam <festevam@gmail.com> wrote:

> In other imx8m pinctrl drivers we pass:
(...)
> > +module_platform_driver(s32g_pinctrl_driver);
>
> And we also register it in arch_initcall() level.

Do you really need that though? This driver certainly does not.

I was under the impression that recent changes to the probe-order
logic has made most explicit arch_ etc initcall orderings surplus.

Yours,
Linus Walleij
