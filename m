Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7D621026
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiKHMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiKHMS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:18:28 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99783120BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:18:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f27so38128552eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4F6NNy3a9JKGxqIkVEd+ypPrQuW+NOqc3zUbmZnBIg=;
        b=RlWeLJGad5+ye5AWSLxrsZlN1dg8kSHWzv1Dyex3oEnUu8/bG91OG6U5MeFBmN8E3w
         vB+TrEkrrXt8lDF5bZBHwa1w7sbQ3vWilzy7lZNC6QWOHu6rYYgQ0tBbFALG0kCz+mHi
         nNEB8oDc6PF2uaygV+VIA92AdDSvST/wv3sbK/6tQKZC13bjPpzKEAzmonoTujynVtGR
         hf1IYQVWuZJGQI95y5fAzXAaWr4L087vfgeFdORzySmJgpa7FyPK6RMiOZwP7BYFXXy9
         jvqq7Br0xsN4Xm5xl5VeWwh8dC+rD7tvfnZvG2ycFlW4Eu1d1COYhK+M+YaQuUpY3zdM
         AnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4F6NNy3a9JKGxqIkVEd+ypPrQuW+NOqc3zUbmZnBIg=;
        b=mQyq3+a52F8UxUV8qwdfR/+C7eF/3l1xj2WXGHNwHuvdjZ5OFq7x2riYnte/yNZXuo
         zvrLRHMCOVRfCgsnEXsSWqzkWVtV41KnCf/X8DnEP4tKKgUPCyhMucxr298Lxzqv135j
         mRU+a7x+5xRs1yvKRHuhVg4aAHtkjPWA07emTpD8avR15ALbM2o4CruX924JvuJ5oM6W
         80ZT/hYxN6zcqdTq5G98cGQq7BsiUoayIONGkRt8pp7TZyZL7wIgY0KGnWh58Ubdx1ri
         V/+BCF73O5nBk5frdzpYsUaNmJQu3M+xXsABjS2ggJ4+jb3bxYTgoLi4ZpalUHFbTBJI
         4UqQ==
X-Gm-Message-State: ACrzQf1QiCDsA2kuP5aOO3mC1JHVIbP4qbBi+bLgDFI2Bz4vcxo2lIlO
        RHHjl9D/bkFZqvQuaI60KoyN8GoMMDjKTg5jXSn5Uw==
X-Google-Smtp-Source: AMsMyM4H8JIEgzYp5NIJE/wBpxIx6VRfnGH3T2bKh2gbpHmDTB+ZvTSz2DsvECaRyOPOnPzNLNJLoLdNGi+tnImFGrA=
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id
 d11-20020a1709064c4b00b007ada197b58emr53763030ejw.203.1667909904164; Tue, 08
 Nov 2022 04:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20221028153505.23741-1-y.oudjana@protonmail.com> <20221028153505.23741-2-y.oudjana@protonmail.com>
In-Reply-To: <20221028153505.23741-2-y.oudjana@protonmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:18:12 +0100
Message-ID: <CACRpkdYtJze2ziz+XBzNnsi_7r0jzujW0o=2P5Brgsi5QCZBuw@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] arm64: dts: mediatek: mt6779: Remove syscon
 compatible from pin controller
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
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

On Fri, Oct 28, 2022 at 5:35 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Remove syscon compatible string from pin controller to follow
> DT bindings and pass checks. Adding the syscon compatible to
> the DT bindings documentation instead causes a different check
> error due to the syscon document specifying a maximum of 1 item
> in the reg property, while this has 9. This pin controller has
> never been, and will never be, used as a syscon, hence it is
> safe to drop this compatible.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
