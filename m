Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EE623D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiKJIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKJIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:17:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BECDB1E2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:17:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bj12so2929721ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0rNxJTluv+aPb6qbERbUxRGQJ+FJ2B1ayQ2etLoV6Q=;
        b=SjnpQc+sUQAfZXCU/tzpHLZoR+Vru8969ePWS+4wlZ4b/NTlQQgGoJHlUQhQNiULWu
         G3w/p3fk3EIHYeKedqJbgDFdtGxciVsTrZgvKAiyei9fxI8OxMQgO/OhHonmwC20ls/5
         P4BNwyGw/x30D/HxGlz7Pja1ErAiKIb+xSaF6OFZgyUFohSfsQjEMgrPZNf6kN9/xPRg
         sk9/iyk1C0o5kFnQELcSxVEAM93TOiBTW6/iqHI9TceCo7alfLQdbXc3jkqt3jUzoT9b
         sBKJbkg6Z6D5K/QoaKaDkKHqCJw9w+XKbAb20H0BySyFFxxi5s4pq/1uhzo6IIuzEnIo
         e1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0rNxJTluv+aPb6qbERbUxRGQJ+FJ2B1ayQ2etLoV6Q=;
        b=R+1JRWkgV/j6UtGUm3QR+CVLSbC8ulWGWt/HbttFeK6murvwDEb1gZajvF0Szzirbg
         F6TY/eSSBIv31hYHeI762h7kdUBrzos+xjfHsS6jsvlVe3Erh9cP6N6E1x98UVkF4yD3
         dbjI3dkfMYwprn3GkT8o5WIxSzfF8lOXRnqZZOs5CcFbKjUCGIUQFjTG9bt0HcuO1/Mr
         Q1Qx60QgN08TKAe2bLWnsYfl6EVypS766gEQK26r4v5Kh2/ifln4WO9Cab4JsgJsZIkt
         4JTsDTZQ2VHrAeVj1rKKtzaBzwPk4kyKsEcl/LYNsaT+3Fe8eQaU9CB80+qej3kdCpuP
         ZFTA==
X-Gm-Message-State: ACrzQf0RWQ8vGdKKH2R9twoFWv+3zeG2oQnw/79/OOoF7XHRnVejc0EH
        PY8mRO3omb7Cmqynr5VKAFmKdYQshP8hNLTReHbCy9d5kSg=
X-Google-Smtp-Source: AMsMyM57abG3IX31gqYD6zyZL+Mj4T4rDNK7ab1oXdvxrtb/1s9RZjcKgk+ZPq6eWhOb5IA0UvRuMLN7iE5ATrx4B8U=
X-Received: by 2002:a17:906:2b55:b0:7ad:934f:abc2 with SMTP id
 b21-20020a1709062b5500b007ad934fabc2mr2266166ejg.690.1668068270958; Thu, 10
 Nov 2022 00:17:50 -0800 (PST)
MIME-Version: 1.0
References: <20221109061122.786-1-zhuyinbo@loongson.cn> <fc52c692-4cbd-e5f9-2e62-d05b5330052a@loongson.cn>
 <CACRpkdbu-gqNBK0=L8pOr2TwYGOv2MUvFxzYiBNfJ5KyJT+A8g@mail.gmail.com> <Y2vA09rQSbCRX+rL@smile.fi.intel.com>
In-Reply-To: <Y2vA09rQSbCRX+rL@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 09:17:39 +0100
Message-ID: <CACRpkdb+siKhL+YKBarhRE6_f9LpQR=0y0zNihRLuONwQRkA7w@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver support
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 4:01 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Wed, Nov 09, 2022 at 09:30:03AM +0100, Linus Walleij wrote:
> > On Wed, Nov 9, 2022 at 7:42 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
> >
> > > I had added some changes in these series patch in v8, please help add my
> > > change and merge it into your tree and sync it to linux-next.
> >
> > Yeah no problem, I took out the v7 version and applied this one instead.
>
> It needs more work.

It also failed in linux-next because of missing MODULE_LICENSE()
so I took it out again, thanks for poking me.

Yinbo: don't lose your spirit, keep at it!

Yours,
Linus Walleij
