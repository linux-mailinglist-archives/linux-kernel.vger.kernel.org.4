Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1352C6A1929
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBXJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBXJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:54:18 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9F28840
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:54:16 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id f13so16598950vsg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 01:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EGhxiBvwlysDww0NUkbaD1EgWkWQWozQvNu9Svx0vuY=;
        b=D3GH0KvrLUvkVfbxeEIVAP+CJofNMYe8WmlSIRzitgtkGbjRg8uAMjvGWGs+LMyHd9
         U3Iuune1Q1VOsXq9MdE0FJhRl4Tz7uKupk3oSpicX7piqldrtoN7Hl6YUONITY8TkpSa
         bN78cOIPILAJmC+DyhJUmjhEhN6dgYnHUpqoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGhxiBvwlysDww0NUkbaD1EgWkWQWozQvNu9Svx0vuY=;
        b=kOJhAKE2EcFaPe8ggIRh0L0z60Tu2/++6z61COluUFJPK72bCCqU7p4YWyISf7y0Dz
         TpIFzRoPJkFJcfp4mPhfoO5Rk8rbxOnlzbb69ejicLBnIWdZQWt07f3EOTd31Lt0zkeJ
         u7SqfrQox+b0+7NrbhNQpKd0bfOktcb1hIM5mdZ9piaGuN7DNgcu38y7vMQfqUe9IIuQ
         saAwHDl4DhtjmiOCbrw3ZkXvrMfXxzYvI+8+xy/a0Riqs6b52v2ymottpf/XEL2ZZFtl
         kZ4lh2nQCLfkcsYxI3icmcGIDg6f7VFAJ9PHj4LBFxpu0ieIQNNBoqV3tHnhIWCZemvQ
         IMJA==
X-Gm-Message-State: AO0yUKX5dd4jTLkO2R+GE8eUwNRWvoXWjnxpg72gzwlxMwbxF7geDeRP
        UgV/94bxugZ0cfd+LkK/GvkW12k2ng4kjufE/ntEzg==
X-Google-Smtp-Source: AK7set+o5jIf8Aj61FB8vAB2PdpYzNYuxYZ6/LTUlZDsdUUZw9q6Oh65MnWKnlXUt71n3M1/wKW7aTFFkhxzCUPZiKc=
X-Received: by 2002:ab0:38d3:0:b0:67a:2833:5ceb with SMTP id
 l19-20020ab038d3000000b0067a28335cebmr6005761uaw.0.1677232455998; Fri, 24 Feb
 2023 01:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com> <20230223134345.82625-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230223134345.82625-6-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Feb 2023 17:54:05 +0800
Message-ID: <CAGXv+5GPWzCsMb3mK7detuBnX8H_FsvbPYTROW1qzkoi8sq0Ng@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] arm64: dts: mediatek: mt8183-evb: Couple VGPU
 and VSRAM_GPU regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 9:43 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as they have a strict voltage output
> relation to satisfy in order to ensure GPU stable operation.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> index 52dc4a50e34d..fd327437e932 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> @@ -52,7 +52,6 @@ &auxadc {
>
>  &gpu {
>         mali-supply = <&mt6358_vgpu_reg>;
> -       sram-supply = <&mt6358_vsram_gpu_reg>;
>  };
>
>  &i2c0 {
> @@ -138,6 +137,16 @@ &mmc1 {
>         non-removable;
>  };
>
> +&mt6358_vgpu_reg {
> +       regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
> +       regulator-coupled-max-spread = <100000>;
> +};
> +
> +&mt6358_vsram_gpu_reg {
> +       regulator-coupled-with = <&mt6358_vgpu_reg>;
> +       regulator-coupled-max-spread = <100000>;

Should we also fix up the constraints?

ChenYu

> +};
> +
>  &pio {
>         i2c_pins_0: i2c0{
>                 pins_i2c{
> --
> 2.39.2
>
