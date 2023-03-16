Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C7A6BD2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCPOsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjCPOsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:48:38 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097481285B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:48:37 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id g4so1732428vsb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678978116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D7kiOj4gnK/59hK4rYeGFr7qsbvI5Wb0oej3O0Nx10=;
        b=1EyCeultkcuFWM8iBsx/m6fvHeqNzOaXvqKmBL725CYN7u0Sc28/bfjV38II7p5wlY
         V7p/aPVd6MVgWry2SsbS1LKZebBDBhz24OJhIR6N4XH89mHV+13RKj2E7h83CTspv96t
         mV/3jOnFiq3rB3CfboYKDAyl8z3sFZ7xmwtoYwR+YFsPCtIOixdmRyxmPaNNE1uWwCQK
         e+0/2ai3IaOrv/9xvM/PYkleaIsDq01k6R9u9wEkjOC4NFSymKS3qJmgpN40cG3qvRw0
         bAGEW0NWj8qj3wKgmuoUfGmUlQ/rThuq+q2OpgKi0ZjMz+MMAJB+JybtFOjVi8PiGntF
         USeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D7kiOj4gnK/59hK4rYeGFr7qsbvI5Wb0oej3O0Nx10=;
        b=DDcp6d0jEXRckKn9mXrU0z5m3yT8Yx6mE+MUHTY68xHwQjjvisQlf9GOdx1yT7sRPZ
         YG27hsKBZazFZRjHrLnV+7WualMPsoamoUKOnZ7CDOjpM4RuJA1poZpR/0stWU4Bvmea
         lO+hHUrPFaPovn51dtqUAYzeGCYq3kjVd28dJ15vlwmyVp+1o7d5ZEZ24IJenDuKesVc
         MdBO8k6JMMMqllmFpcb1Yqu95rHPLIItwS1teGeVNfq0SFUZvmwWp82oArqRLmNgjqsu
         quOwnKRctYQEX7MuXRvQv36fvnxxJsw3oOlFC1PxYRxioU5zM4TinFxwAOK+gMnLG9CA
         m+uQ==
X-Gm-Message-State: AO0yUKVJlz++X2aS+1NphH3J5FGs6tOy0HlfIHN+PniUtbQwOok5/UfH
        ISSskLPysnIuDdSS6gkAq9R7qaFmyWzz2gkIax2N5Q==
X-Google-Smtp-Source: AK7set9hresCFKa/wvC5SlJJTtVVVZfKzdiouMqI/exLoXPbb3ubYlDT3qxmZdYhYTaa0AUo709sV856uhsqLMC3WEo=
X-Received: by 2002:a67:e003:0:b0:425:d57c:bbd6 with SMTP id
 c3-20020a67e003000000b00425d57cbbd6mr1566591vsl.0.1678978115876; Thu, 16 Mar
 2023 07:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230309103752.173541-1-brgl@bgdev.pl>
In-Reply-To: <20230309103752.173541-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 16 Mar 2023 15:48:25 +0100
Message-ID: <CAMRc=Mes7ETY7isa-Kh4VHa1eyJHO3OjvWq6VeJRSnZCkX9_6Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] arm64: dts: qcom: sa8775p-ride: enable relevant
 QUPv3 IPs
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 11:37=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This enables the QUPv3 interfaces that are exposed on the sa8775p-ride
> board: I2C, SPI and the Bluetooth and GNSS UART ports.
>
> v4 -> v5:
> - remove board-specific interrupt from UART17 in SoC dtsi
> - rearrange node properties to have various *-cells properties come right
>   before status
> - collect more tags
>
> v3 -> v4:
> - use interconnect constants instead of magic numbers where applicable
> - pad addresses in reg to 8 digits
> - group pins under state nodes for UART
>
> v2 -> v3:
> - fix the interrupt number for uart12
> - replace underscores with hyphens in DT node names (although make dtbs_c=
heck
>   does not raise warnings about this)
> - rearrange the commits so that they're more fine-grained with separate
>   patches for adding nodes to dtsi and enabling them for the board
>
> v1 -> v2:
> - uart17 is the Bluetooth port, not GNSS
> - add uart12 for GNSS too in that case
>
> Bartosz Golaszewski (9):
>   arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
>   arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
>   arm64: dts: qcom: sa8775p: add the i2c18 node
>   arm64: dts: qcom: sa8775p-ride: enable i2c18
>   arm64: dts: qcom: sa8775p: add the spi16 node
>   arm64: dts: qcom: sa8775p-ride: enable the SPI node
>   arm64: dts: qcom: sa8775p: add high-speed UART nodes
>   arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
>   arm64: dts: qcom: sa8775p-ride: enable the BT UART port
>
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 99 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 86 ++++++++++++++++++++
>  2 files changed, 185 insertions(+)
>
> --
> 2.37.2
>

Bjorn,

I noticed you're picking up the reviewed patches. :) This series seems
ready to go into your tree as well.

Thanks in advance,
Bartosz
