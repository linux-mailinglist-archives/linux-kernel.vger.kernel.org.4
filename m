Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9333608BFF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiJVK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJVKzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:55:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CE332D296;
        Sat, 22 Oct 2022 03:13:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m15so14387489edb.13;
        Sat, 22 Oct 2022 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WlXvlEg6bctP44b/au/15ReetHC08Q5PP32gg18o8Ok=;
        b=WbjY0+tOWZdm90+Ro9ychyoYTBQ5k08JBaJAi4TzgcG8ebuY5wT6Rk2qJmmg8Se7QI
         V8GCccdnEAK2Sj8K78LRVn+dPikhaT0X909X4PIsrClXKM+V3ZmE/Zi/knzyRMdrJl6+
         lK0f7eqTF+DnNY/MQKIAWmVV0F1agtxTodB/7gpgDAXFsmZq18kFv5tvUdupybwKIi2M
         2Cw5Bom8/XkFJJqhOO3SW5QkT3A3YFq7LHOi6BEao01ZDSQkjPtNhL4ho/icP3E1qKWo
         ItleBOK3iayo/LLswsITa1oHP2O1qjOaBewGJoXEQ2qGFT/4srYlyI/39zOzOtYg97v8
         EvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WlXvlEg6bctP44b/au/15ReetHC08Q5PP32gg18o8Ok=;
        b=FHGwjNs0e9bn1uhU+k5if/mzxyivZro081eL8JDx+nCt2evIoyAD3PNhnh40glckHD
         AK8KM9j/2p/UKgIAzNMHXLn5ljxeSYRB6hfEMNxOveoo0HC7rfDyh4m9mbZAAi/SLaPd
         ca3gt+AuItj+xnA3LXdkwiAmOPFtjQTpmsaVLTc47a93zDieFEMP3sPakCk1dAAbUJQV
         38Ggjrn68frFDLsJO5u1j3HN1a5Wt7duNMdnTqVAa9kfCUKrFWX8EC3Sqyg/y5j8/Os7
         DPx5lk5FqefxAd2YamtTVzy2tJezk3w0gN9CcisfBkgoaZuStdOy8Og6VnBdCD+DBfQB
         cwKw==
X-Gm-Message-State: ACrzQf1TWXLncrYx6AQvoK3B7xCYtsLrH328ITaYwwHVvXNI/Ia4Vh+H
        Mc0xgTWXsfzm3HHFWz2YyjvAKq9tBtqYuVa3DTyQ3O3US/A=
X-Google-Smtp-Source: AMsMyM7hlcd+YDE/ZivoAfafimij3dBh6J+XlO9QT3sdw0BO/po/2UHGunU8QkJwyQeS4hfV0tD+CQPk8Dg/ApP5pUI=
X-Received: by 2002:a17:906:401:b0:73d:af73:b78 with SMTP id
 d1-20020a170906040100b0073daf730b78mr19829562eja.122.1666433600362; Sat, 22
 Oct 2022 03:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com> <20221004-up-aml-fix-spi-v4-1-0342d8e10c49@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v4-1-0342d8e10c49@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 22 Oct 2022 12:13:09 +0200
Message-ID: <CAFBinCB8j+1EpB4f2wNL4Bmmd4H-Oaeo5KHnjFbVFLtpqVXm=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
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
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
s/biais/bias/
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
>
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Other than the typo:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
