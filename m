Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0386E693379
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBKUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBKUGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:06:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F7C18B21;
        Sat, 11 Feb 2023 12:06:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jg8so23350315ejc.6;
        Sat, 11 Feb 2023 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vaNbpINT2Xmkn9BcHjtJ02zq/IlpYiq1cxdo5OW1ad4=;
        b=k6op3JKzRxsftji1LbveTFIAS5CatKMw4aoTuTC+ba/knIJ9Tic2KjwinicvmuLr9j
         mUFv2/su61jVqGAXHO1iBy28NRoM6m9dOCjbmobZoC+8tgfcTFHaiwSTkOm1HWVfbKNI
         KQfEU+9LUcCwdL6bXPTRKr71+pCXNt8iMnZ16QtsKR9uIFJCb5lIiKOje0qp8hEWchMj
         D1xvt/U8RRgyRV+UlnestoFeklytyjJ1VPDakzHR10jeLax1TMaM8KomrsoyP/FdFC/R
         sPuKSl4fR1WQJvwyLXGfrZFIyBQi1CVIkroUka5s7nzxWZajbkUej7WyYb9kwfYwmypb
         kohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaNbpINT2Xmkn9BcHjtJ02zq/IlpYiq1cxdo5OW1ad4=;
        b=I/YGiLZoWItboMJWmBFoGRHicFTy9Cav8KtkVU3bsFXlVM0g1jRgKCjo/bNIOM5zJk
         cmlggxT/GORzmfJxocwjcxmFS1E9CYpW9Gg7EBbNc63mZXMXvMxbDUdOpzmrdZfcmnwr
         +cxPwr8tPcAfRO+hHpj8fu3vWHJRzJdPuTJcPrb4rbTDyV7/GSC/avUVeDn+BgTI2nJ8
         UVZILApuGDq/uItoxiSgC+I8uPcmnyBdnKDW1SzSN6T88LzaDc9pS9ndM7BnpHSsf8aw
         FneQ7izmfaoeMvPIGCU1O3b3tIh01YhTEyZShlLfjs92jeF9lnrIPSOoSBU02skAZpUJ
         vhCA==
X-Gm-Message-State: AO0yUKWHKaC4XGfMwesqxnSdXfO6CzaEvDWvSP41A8CtptOxsJThswy3
        RYdVLzJL8yBHP2MDYrwf4gtkHZH2cQHSbeJwD/g=
X-Google-Smtp-Source: AK7set+ooeXlh1YIDkOcBMPjkcIHlqurC5sma2WWEDW4q11b1xsSXdCafR8YQhXjeTPZholKQbiqX3EhtEIiF8xmqg8=
X-Received: by 2002:a17:906:c44e:b0:8af:341c:1f82 with SMTP id
 ck14-20020a170906c44e00b008af341c1f82mr2608701ejb.4.1676145962006; Sat, 11
 Feb 2023 12:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-8-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-8-93b7e50286e7@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Feb 2023 21:05:51 +0100
Message-ID: <CAFBinCAJCOU1ihXxGxN3X3UQAMBDFpCkkMewY2z0KT9WnP5c0Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm64: dts: amlogic: meson-gxm-s912-libretech-pc:
 remove unused pinctrl-names from phy node
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Fixes the following bindings check error:
> phy@78000: 'pinctrl-0' is a dependency of 'pinctrl-names'
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
