Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E71663A76
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjAJIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAJIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:06:27 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308701EED0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:06:26 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 16so11059633ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JHRcdSQIGrhfLDOW6aaWJy3e1nPODetfpYyGMnxbjY=;
        b=sIgqjNkDzZm3OKPN1By/y1RFLmVC+0nOBf7BU47CjWy4t1/K09ZyyrK8IjVhrn3503
         1kYdkH/c08cnTviRuLDOzW8aOLfHSRf/+621yk51pnlX0TqYCJRQv866rRRieDVuW00i
         8go4ijcFelGFZF8SrHmRZADWYtXpQ9y1uxzmxL3FuImG5JBv7V9tLZaXm3+2sDV7+1cX
         qIntRKzC97i+qkmlqMLlMLRNyXE/LANQWLh9xl928Fle0XR2qRHdw8SB872MnE0IUa3r
         iJlRNy/P4WSCtB1eEbBDHL+IWrnm6hWKmJ11yRxc9jK57YhoiKKP9MxXqBKlfyXQtp9u
         Xz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JHRcdSQIGrhfLDOW6aaWJy3e1nPODetfpYyGMnxbjY=;
        b=ZmHEmzAIrfFnNSbfeyWSE+EMTl2J4SnEtqXB13OY50/Jg1SxA2p54FxkfDK/T5u7V7
         HxNstnKOW1dKLg3n34S2axjvRYUj/VcrqBY5eqwlUmGRyMuv71SXd8PjeC+W7OqXFOkw
         rDYUo9IFbCsZGVeHglL1GqIHuhZ5iDcVZaqXmSxaDgFg/pLlLE1YMC9kRtq+Nuz/JgkF
         hlhXgFVwtv4fT6WHa5oNVLkInm2Ei3hKbSXc2UYWacD+qGW6M2V2U0XVa9W/bzKzzxuv
         bYzuCkztfa24lOsVz9hHOGOyn2GfaaCUVfrn0KthUI3antY5wFy3p1rgAsYv0iG8JhAI
         W4Kw==
X-Gm-Message-State: AFqh2kop6e95pyU/BJaqGvBthWW4BbNvqP5AarYEz3cZgVhB0WgKIHUb
        gVZNjGlNvkkjQHNzbRbmTpqsfz6tI1uKhjaV3IU+Lds2P879zQ==
X-Google-Smtp-Source: AMrXdXsYdM6ybJMK2qiyZT+/7IJ+w4+L4tGTqBMqeir+zYWTn1ZGGCigXc2lz4KZ9ucSjiCDPaIGm/s4OsklUvcYvc8=
X-Received: by 2002:a25:8e8e:0:b0:6fa:a54e:9276 with SMTP id
 q14-20020a258e8e000000b006faa54e9276mr5386630ybl.460.1673337985386; Tue, 10
 Jan 2023 00:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20221223132226.81340-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221223132226.81340-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 09:06:14 +0100
Message-ID: <CACRpkdZRachh_o30cTT4A94GU3gWOV15Or1A3BXhahvgy31Qmw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sm8450-tlmm: correct
 gpio-line-names size
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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

On Fri, Dec 23, 2022 at 2:22 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The SM8450 has GPIOs from 0 to 209, so 210 in total:
>
>   sm8450-sony-xperia-nagara-pdx223.dtb: pinctrl@f100000: gpio-line-names:
>     ['NC', 'NC', 'NC', 'NC', 'WLC_I2C_SDA', 'WLC_I2C_SCL', ...
>      'APPS_I2C_0_SDA', 'APPS_I2C_0_SCL', 'CCI_I2C3_SDA', 'CCI_I2C3_SCL'] is too long
>
> Fixes: 9779ed30f92c ("dt-bindings: pinctrl: qcom,sm8450-pinctrl: add gpio-line-names")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
