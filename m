Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA35608C08
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJVK5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJVK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:56:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF94C2C1;
        Sat, 22 Oct 2022 03:14:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a67so14408377edf.12;
        Sat, 22 Oct 2022 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HRxA1wCfL0RgEilQ0nEOZlpZEZ5XChNDT1P0uuoGXtQ=;
        b=YwPo+TMxhdFYaL4vjMP2doMRR8fiV0VoWpwn5nZQQwIfyDL8JeoFqv97TD/P0UkcEG
         fvsEZEL7uEM5F6r0xtA6szfPMw+neybQ/XFz5Z3jmwFQ8owH2Hx40x6Uw8VxDC/xZAx/
         3JmIH8Tkuwhn9KQwKQG38qW/YAexVvU1e2BS/CJ3c+EBYQ23TbKUtV2PU5sJBiypBKuj
         IaAiK0DHFzqvhMMk5HCZIAYhQOH94rG0uYIdLePxny++FEVb+PoxJaFshpBOHi5JfORy
         F4K0TGGLDCtwAUWCL5MfXPKU1vLgSKW2yWmBTnGx/5dHeVUN1K+eS6Cq4uKnOa3QuqCU
         UnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRxA1wCfL0RgEilQ0nEOZlpZEZ5XChNDT1P0uuoGXtQ=;
        b=YMLQJk9bj3TPZo9Fcj+AjrDUgBwo6m13pG63cXPb9IsnoU98hi7NxM3LIFOdJ+4vJm
         npxmJYdYMeiJznwBCki4ZHq9b65sHjEshhbdr4NBwBuB/VrJWbiNykxLdoOKjBgyRT0q
         p8TtvPdVE9ZMrAaLafcwTQGJGKa4fOkp6ODIE9DPHrzVBG8QFcqCinkQ6XjX5+HVDjA8
         cu++l0R7znnJiHn1YzRL9mEX32rKopIf/oq4ecgkSRrSDXUHy0AE4HG1YfnYi/LmEujO
         GLWRJlH88tCIIaub59qFTasNIk6924KhmtgY14Q+QFzpkvkdppmt2+x4mJJhvrtziTYl
         jOag==
X-Gm-Message-State: ACrzQf0SpHzDDf1k345UEeCi3sHt0RhXyNdv5vCo7wpi9qT5wEqQPBUP
        JMDFbiEUIWZxg3KvFJS8T+Ek2EpxAB31xOwUaEw=
X-Google-Smtp-Source: AMsMyM6d73cg4d0wNQuMJiODAPL6zKNKjfXCGBbTlKTkeqI5Y6WOfEPAHw1TL16UWW/UIDYpbG+ENDd56IYLTXWR9CM=
X-Received: by 2002:a17:907:2da5:b0:78e:1208:8783 with SMTP id
 gt37-20020a1709072da500b0078e12088783mr19641226ejc.743.1666433670312; Sat, 22
 Oct 2022 03:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com> <20221004-up-aml-fix-spi-v4-4-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-4-0342d8e10c49@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 12:14:18 +0200
Message-ID: <CAFBinCD63tjLKU0mSUhutb5beGOy1k7LHw0-WngB7yE2VaeJFQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        linux-amlogic@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 21, 2022 at 3:31 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Add SPICC Controller pin nodes for CLK line when idle for Amlogic GXBB
> SoCs.
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
