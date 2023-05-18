Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C5707F30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjERL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERL1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:27:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E3F19A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:27:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3063433fa66so1204459f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684409242; x=1687001242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbvXJRWlz/SuQ4flbBmfGTl0h1jB+7ggDXXoc965Hvg=;
        b=xmRtuf6JEyXOvFruq7cAfQZCJTY87SYsfKXdpOVjmNERcj0bHlc6urmeWcR2zQwpYZ
         RbFl4XYfH8x+5otWc09zmgpJ+7xWImSryC0EPi8hHuQmxCH8Q1QTkykXi6lrK5WLRYvy
         K4znYEJnwLKzE7hvrTIvwL3zCvZ2BT/dg9Go34sCTIriWjBxEF29pmx2O5olMiRad5F0
         pWExbfjG59ts4UitMugz8BJafmcYN4EG0c+hD8HeNSlt6xVOl8RhDHQoLAYr5cwzHhda
         NR/jMf2tH0ZiWOPhhB0WogwgqzMaTuJUwWhi+k4knI0kqrxmmHJluqjrosopYAOx4/It
         zMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409242; x=1687001242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbvXJRWlz/SuQ4flbBmfGTl0h1jB+7ggDXXoc965Hvg=;
        b=ezS9X6426mPM3cAqNJdQkqVjtvMO/Xfjh+3jceb2Ys7G2JCnzxg5oeo08/u7Jc+ZUn
         h+pjh0bcWYUNUP5h/MvUrWEhUeOZpT4zAUKYJ3U9YH3K55Mdw4vvUDcnH2Ur0RQOvFCG
         jejW64ZMITblETxS11OX7E/fgv/SJXwwxlNyqXXPbpRXotGhcOFYABUTZIBcPAOgkEjQ
         PVgIOzXT0bV9GurvWcihfHbHJf9FGzJBv5rwE0g7CKETsMboGYFXvdc4VwnJIKsUmOML
         LU9Saqge0f8Utc2gnaDVpIqNQSiiQk6fdqcXIN/DfIBjBay/rh+kG7XwBfic7BVynzKm
         qXbw==
X-Gm-Message-State: AC+VfDxWOVe9jTCYzELGXH4lMw+cNNYqorzPfiKNo4PWfUsWxxIetwtR
        F44djt+k4/24A4kwtYAifQx4MYPHCQd7gJMktUtvLA==
X-Google-Smtp-Source: ACHHUZ4aD+JXEYScBpfdnz6YAH394kPaxWE3KXojne4tAsZb7tX4F518piM9Vwm8SfOwU8dXtueL8lGV9GEcm+qPYC0=
X-Received: by 2002:adf:e2c2:0:b0:309:33c4:52e1 with SMTP id
 d2-20020adfe2c2000000b0030933c452e1mr1044451wrj.64.1684409242622; Thu, 18 May
 2023 04:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230518082934.24129-1-quic_kathirav@quicinc.com> <20230518082934.24129-3-quic_kathirav@quicinc.com>
In-Reply-To: <20230518082934.24129-3-quic_kathirav@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 18 May 2023 16:57:10 +0530
Message-ID: <CAH=2NtyJDZ=1kcO-vbvyGs3kBUyUaNuX7MXn3xf69v_tQJ_UNQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: ipq5332: define UART1
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 14:00, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
> Add the definition for the UART1 found on IPQ5332 SoC.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
>         - Added the dma and dma-names property
>         - Didn't pick up the R-b tag due to above change
>
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 12e0e179e139..753581e60604 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -218,6 +218,18 @@
>                         status = "disabled";
>                 };
>
> +               blsp1_uart1: serial@78b0000 {
> +                       compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +                       reg = <0x078b0000 0x200>;
> +                       interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> +                                <&gcc GCC_BLSP1_AHB_CLK>;
> +                       clock-names = "core", "iface";
> +                       dmas = <&blsp_dma 2>, <&blsp_dma 3>;
> +                       dma-names = "tx", "rx";
> +                       status = "disabled";
> +               };
> +
>                 blsp1_spi0: spi@78b5000 {
>                         compatible = "qcom,spi-qup-v2.2.1";
>                         reg = <0x078b5000 0x600>;
> --
> 2.17.1

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
