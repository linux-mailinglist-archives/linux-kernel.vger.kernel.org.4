Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1606B0741
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHMg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjCHMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:36:21 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3DAF6BD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:36:15 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-53852143afcso302262727b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678278974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xO1hBBzWC5xPl3/6643V8lJnrCNoLWUVWizLzOaN//c=;
        b=lQUclai1rdzYsqXvn59DO1R8bwwSUY5U6B0bbjA2BDU+047RJ9UdyK6bU2MzTyfIDS
         mUOgqgbbsNvQEqS4UHjZ0k3oCBKr18Met1VXlMA8hkhqPG0nAWVSlTZqoMdmM+k1+6if
         0qKiFs1m/bEwpmBCA4N9YsVAas+9sQv/jvH6iR6VSku+mxSKbuS9p0g/hIZ1T/yJnPrC
         IiNE2aSNK/9/8neaOW0e/ZzeRHXDblGy+5Bsqtt4JfquMhvk/rBR8azNf9r9GPGcgMlR
         e2ygBT1S03YLBSS6/2Oca1YUPMq8HAvm1omdtlfB1tDB4fRxUpy8QKLunc5yyLiY200H
         yFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678278974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO1hBBzWC5xPl3/6643V8lJnrCNoLWUVWizLzOaN//c=;
        b=8HVFMJwkG8D7tc0u4J9kO7nXdmMdWSnQ4VD9TUmXadVIOpWAGrcNrP8vFt+hLGg09k
         ULnvZHIke9H80o8nIOHv+7yaJUsBigcVD7MD4YZptOJRG632AeUEecnl3nDcnj+R8yE1
         5qIPtxf5izo+arY38VOhzZogHn7abwD7/hwMrxI6KLd/OwtK6pzICNYo9IyEU9QLoGVv
         sKalyscFEsGLvhFOAqlhbOLkAhD0p36VlNG7Hn8KI3ZmHCRbrSZrbSB9bNW6qE2a7e8K
         marXNOfho9jcMC/9MT/8loiTiQ0YxTQE/9xGOkmoEQbyWQW0QdnrKrYZaqRAfUrg5l3z
         RinQ==
X-Gm-Message-State: AO0yUKUEHktxnwyGkk4G1iQYpg3bZ0E8GKQY5pyzsrm6/MM0asTUmMTm
        3VzC3ntiq6PvpU4rXsuPMp4ZzBNxCiuXQPxjxfIB9g==
X-Google-Smtp-Source: AK7set85Mr1/+R8baj8+S6hdGBaznKQDfCA4bpt2xrYC83pDU9GtCFHK2UnDuGKv9cj1bNhC1nqZUhy9JWYm4X7LHNE=
X-Received: by 2002:a81:b288:0:b0:52e:ee55:a81e with SMTP id
 q130-20020a81b288000000b0052eee55a81emr11524770ywh.7.1678278974522; Wed, 08
 Mar 2023 04:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20230308104009.260451-1-brgl@bgdev.pl> <20230308104009.260451-7-brgl@bgdev.pl>
 <5aacecc9-e3e4-f229-350d-14d547b52578@linaro.org>
In-Reply-To: <5aacecc9-e3e4-f229-350d-14d547b52578@linaro.org>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Wed, 8 Mar 2023 13:36:03 +0100
Message-ID: <CACMJSetFuejNBPQBr8OBeq-edqhwNZfQ+Uz6iBJYf_kt+i_OeQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: sa8775p-ride: enable the SPI node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Mar 2023 at 11:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 8.03.2023 11:40, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Enable the SPI interface exposed on the sa8775p-ride development board.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > index 5fdce8279537..d01ca3a9ee37 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> > @@ -14,6 +14,7 @@ / {
> >       aliases {
> >               serial0 = &uart10;
> >               i2c18 = &i2c18;
> > +             spi16 = &spi16;
> >       };
> >
> >       chosen {
> > @@ -40,12 +41,25 @@ &sleep_clk {
> >       clock-frequency = <32764>;
> >  };
> >
> > +&spi16 {
> > +     pinctrl-0 = <&qup_spi16_default>;
> > +     pinctrl-names = "default";
> > +     status = "okay";
> > +};
> > +
> >  &tlmm {
> >       qup_uart10_default: qup-uart10-state {
> >               pins = "gpio46", "gpio47";
> >               function = "qup1_se3";
> >       };
> >
> > +     qup_spi16_default: qup-spi16-state {
> > +             pins = "gpio86", "gpio87", "gpio88", "gpio89";
> Rather weird to have an identical configuration for all
> MOSI/MISO/CS/CLK pins.. Please doublecheck
>

This is in line with many other boards in arch/arm64/boot/dts/qcom/
that have the same config for all SPI pins. Some of them unnecessarily
split the config into separate state nodes with the same config
though.

Bart

> Konrad
> > +             function = "qup2_se2";
> > +             drive-strength = <6>;
> > +             bias-disable;
> > +     };
> > +
> >       qup_i2c18_default: qup-i2c18-state {
> >               pins = "gpio95", "gpio96";
> >               function = "qup2_se4";
