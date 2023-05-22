Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB070B974
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjEVJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjEVJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:53:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D551F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:53:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3094910b150so4687770f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684749213; x=1687341213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECJI0LFwwkDe66I7X1nctePo0/j7Va03pbzms4rUc9o=;
        b=W5YDVSR/w6v2V8d0U4G1JAAX5pdg0yRNNxsVnTThfSurqoKaqDjrnm8JiR3okhY4Q0
         G2IhUc03bVF44qoTGSBx+XV1XWClLpW5kmQX0p5KUn5Fo0aTlz/n8/k4nqSL0shLyrvn
         JHGnrXBZhNLBaAtNXV1I/gzfZCILl7kQTS8DVlKCr2PepXR3L7eu47hD+57m375RRxSQ
         bCzUnG5Y1+nhv4xhq8rkFrcraDcjvFY3lUm5TIR17LlB3cUvmb2gbrlZZf+w2ZOEfK0J
         9gcujURlXjnwP5oOm7NtJRNnGHfL8SE/kbfxJfAJFPvTAWNwEo2A6C95uK/3YQ5bGgfB
         6SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684749213; x=1687341213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECJI0LFwwkDe66I7X1nctePo0/j7Va03pbzms4rUc9o=;
        b=TpTSasXOIK/7ziIk+HRE/hk8kA8yLwE6261zHhqWbjbspkA4vXlsMPpfbXi1sGU/nQ
         VxoVFb+QzRgMygR9xGTNb3APNCUTL3P29ZCEAGfILBlToLtwHjQUY2POhWaPK6jkBMYC
         5xPb7q/1spCSTWJZoHEU5q9RrtHZpkmxQ/b/VgyFicdfpf+DJYfApicq0GDbFbdKnXCI
         OL9ORI8SrPvx2qdX8dA8Il1IVN9fB5dhJoZzl7f0A3rJL03XqA02nEZJXMuA+R418ae2
         hGXjfTwz6DY4uFp7aUJS40S9j24WfMTSAkw3PDh04RyTw4yJOuyKugKfJG54OqUIWzTv
         MhvA==
X-Gm-Message-State: AC+VfDxk9ZMy3NhU+6lF1z00SU/xUFNUNhL0jsvDxb9AGJRHRkyw0yv3
        FFuhuwiZ9OpBssJFfvt+aiyApj9pYWlWGAUAjLracg==
X-Google-Smtp-Source: ACHHUZ7usYrNO9DYTgz7sXSTAh0vn5Ieny/IQU9kQKCqJycC4jNWWA4vXBpS1vxwt0dtwhhCEryzsqoxwgXB5mMTtqY=
X-Received: by 2002:a5d:5584:0:b0:309:5d9:bc81 with SMTP id
 i4-20020a5d5584000000b0030905d9bc81mr7078151wrv.49.1684749213663; Mon, 22 May
 2023 02:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com> <20230522093620.3568-5-quic_kbajaj@quicinc.com>
In-Reply-To: <20230522093620.3568-5-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 22 May 2023 15:23:22 +0530
Message-ID: <CAH=2NtxwG3YaN7F_q2PARXPA_Rit7-KhkxFKXzL0xD3J8J4SpQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 15:06, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add sdhci node for emmc in qdu1000-idp.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 9e9fd4b8023e..61d8446a2d55 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -451,3 +451,26 @@
>  &uart7 {
>         status = "okay";
>  };
> +
> +&sdhc_1 {
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&sdc1_on_state>;
> +       pinctrl-1 = <&sdc1_off_state>;
> +
> +       cap-mmc-hw-reset;
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +
> +       non-removable;
> +       no-sd;
> +       no-sdio;
> +
> +       supports-cqe;
> +
> +       vmmc-supply = <&vreg_l10a_2p95>;
> +       vqmmc-supply = <&vreg_l7a_1p8>;
> +
> +       status = "okay";
> +};

This node is out of alphabetical order again.
&uart7 would follow &sdhc_1 and so on...

Thanks,
Bhupesh
