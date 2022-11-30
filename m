Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64B63D1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiK3JVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3JU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:20:59 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC7C391F8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:20:57 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id z192so20810938yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VgWpKJeG3/tybrVDEBxDjhgC2NrM3Rx6PkdmaV95rbk=;
        b=zdtQAQWDk4FnFK86ZcgrZQAMzCT1IyHgsnQbdaM9MxP1jbUKoo405i8aFBPc2XxnvN
         72mLgb3//1aOTLAuTenYxEYS2Qog7auIYPPg2d5dljDuySf0AdxzIwnB0teGfyh3MHXH
         7T5NfKCg9gyoGE2r8WTcsCR5Gsrq/tbwK9k4UmtV482FrjipmAESmoMrZHVQK1Mn8+mo
         AugT8o9vYgoN7Yuv746DbDvt/ldIJlsB5BQnH7w9iVSD15F/iTfgeCA4hxVQuGmR6TlI
         QcTn7HivJ3tn71hBper17qTBIYVbLsGddGXI5rXd/IQRpdEgqx2PUr/vTvykUORMCJlk
         DiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgWpKJeG3/tybrVDEBxDjhgC2NrM3Rx6PkdmaV95rbk=;
        b=VPHRF/o86waOt9K71pqS7ffJ0VUY4it5sQ6F4mkfacX/uqUsySAqBcIqiy5o+JUVw5
         WOG4HExxLwaQduBO4NKDE0gOV2/AQpT5cm7IFPFp7wf3t8q8Fo25L62SxbOdL4W2j0Xg
         yI/y23tVSIufZA5o2dD2Q8PJxnRDaxP6naYx0dk1LAhHIwEeMXjthnFFZH5i3FeOnIro
         vFlezzmkbuaP+8r7fgqyyYdavIP2uYT4wjBtu0LeGypgoeZhzsFv+msbmEe7k1M6liFN
         kaKUBBtAI48OIGe2qSZkxrSc+jTa8H3e696DqNVQzfmp4hIlDUjodtBcM4lOQJgOLA3z
         CXFQ==
X-Gm-Message-State: ANoB5pmq/Oe1XMtd+Zke7LyJ+6I6ihq5Xw/fQJOSQNaggdkjrGHvYMBp
        TOM1WqADeY5VhhEEIqnzxM0Q/8/IN1K51uYudUzoNA==
X-Google-Smtp-Source: AA0mqf78Hw8TSqu8oK1aqKN8OQkfbNJgRXzi7U0lTakAB9DHU/yOz5bIOkvZbFBAe3UtMnwI80NSL2OBrOGx5UEJzs8=
X-Received: by 2002:a25:ae91:0:b0:6f7:fd66:8e5c with SMTP id
 b17-20020a25ae91000000b006f7fd668e5cmr10277731ybj.516.1669800056665; Wed, 30
 Nov 2022 01:20:56 -0800 (PST)
MIME-Version: 1.0
References: <1669767131-13854-1-git-send-email-quic_khsieh@quicinc.com> <1669767131-13854-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1669767131-13854-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 30 Nov 2022 11:20:45 +0200
Message-ID: <CAA8EJpr_AODJ6WPB8_4aRY8q6XBy3-cXMOkox7VfL-PK1p4pQg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
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

On Wed, 30 Nov 2022 at 02:12, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
> add link-frequencies property into dp_out endpoint as well. The last
> frequency specified at link-frequencies will be the max link rate
> supported by DP.
>
> Changes in v5:
> -- revert changes at sc7180.dtsi and sc7280.dtsi
> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi

Bindings update?

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 6 +++++-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 754d2d6..39f0844 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -812,7 +812,11 @@ hp_i2c: &i2c9 {
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hot_plug_det>;
> -       data-lanes = <0 1>;
> +};
> +
> +&dp_out {
> +    data-lanes = <0  1>;
> +    link-frequencies = /bits/ 64 <160000000 270000000 540000000>;
>  };
>
>  &pm6150_adc {
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 93e39fc..b7c343d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -440,7 +440,11 @@ ap_i2c_tpm: &i2c14 {
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hot_plug_det>;
> -       data-lanes = <0 1>;
> +};
> +
> +&dp_out {
> +       data-lanes = <0  1>;
> +       link-frequencies = /bits/ 64 <160000000 270000000 540000000 810000000>;
>  };
>
>  &mdss_mdp {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
