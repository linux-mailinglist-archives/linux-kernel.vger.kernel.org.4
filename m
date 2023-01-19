Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55716733E4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjASIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjASIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:40:44 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52E4F34C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:40:42 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4bf16baa865so16778187b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz30k0eHuCJ5qW+R1e/5VxG1p016U2jxYAEXQ6zDyEk=;
        b=IYs36GIo4XvlIdNhAXfovMq2GHRF7gmKwKlRQmrnF4ajNS9SSKRkjhGtnAxNu+XsbF
         4lYop2I58AhUQvp6C1U8Sg08CXcjtReKV5TH3rsatEn+FiyLfnN9fgHV1E+wNqhtC7yG
         PG0GsRqAPE27R94ZCIOFARXmHTa5kkQNuo8c41oWFdmGazDVm9n0g/NEBvel22/cQdx8
         7qvT1InMrpl3t+rEjLo2EXjI7kfGnUUbPo+JU8AtVJgubdVEQaSNIXTB5foczjEY/yRD
         9SFXwwWe8k6x1G8apIF7slaNxKeCFm7zsrNxnNaHwXSzp0W7897zq3kN4mQl9VXyopSZ
         CCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wz30k0eHuCJ5qW+R1e/5VxG1p016U2jxYAEXQ6zDyEk=;
        b=eiW4P9aNPlBgqH12/B7k++3EcvIC+vr4IvbTVx4927HEwK4kZuyImIGhGWxXwKpAoq
         UMn4E4oIHS7BZxlRcjbQDpoUNkYS2/vgX+Mwlu9+i4sfed0X0vEIN5MmB66L4kadCpxI
         X3jTf6i3g5WmMCXTZk5K8IQ9yDf/lhN1pJqE4gN0ZE2d3bz+VRNfaXMXS6mIUvq5c8ud
         MP7ZUKsxt9nuvUTW4Y7VRudNnP3EJwuPyttnIjpBf2UWvgBmC1S/xHYdUbvy0/JXVj/n
         bchWsD9j7QEyzWjDEw89p2Mqmh9kSVRJvwe2bIS2sfFsYaxnEKZowGyQloO3Ish5O92B
         rnbA==
X-Gm-Message-State: AFqh2kohZWT5PpQahvXeWS60xHv91M08VgOF5qKL3rnFZ1e7gqC0be+v
        gqcDKp9QiskBGSeoAsX2EPYll1mz5oWrIL/jV+OwNg==
X-Google-Smtp-Source: AMrXdXvA8Npb0BzSkuo6iBimkuIOlahd1dNVQpsDdSqUrv249CwsCg4zyuf/p2yX6ErTXCQN9nQbqKKzNwL6V4wL72M=
X-Received: by 2002:a81:7582:0:b0:370:4c23:eacc with SMTP id
 q124-20020a817582000000b003704c23eaccmr1183986ywc.127.1674117641858; Thu, 19
 Jan 2023 00:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20230118193015.911074-1-markyacoub@google.com> <20230118193015.911074-10-markyacoub@google.com>
In-Reply-To: <20230118193015.911074-10-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Jan 2023 10:40:31 +0200
Message-ID: <CAA8EJppqft3vtB9PgLe=NunYCo48rAQzAb_nLYACAQ8Onr_ZaA@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     quic_khsieh@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        tzimmermann@suse.de, ville.syrjala@linux.intel.com,
        stanislav.lisovskiy@intel.com, matthew.d.roper@intel.com,
        imre.deak@intel.com, lucas.demarchi@intel.com,
        manasi.d.navare@intel.com, swati2.sharma@intel.com,
        bhanuprakash.modem@intel.com, javierm@redhat.com,
        jose.souza@intel.com, lyude@redhat.com, hbh25y@gmail.com,
        arun.r.murthy@intel.com, ashutosh.dixit@intel.com,
        ankit.k.nautiyal@intel.com, maxime@cerno.tech, swboyd@chromium.org,
        christophe.jaillet@wanadoo.fr, quic_sbillaka@quicinc.com,
        johan+linaro@kernel.org, dianders@chromium.org, marex@denx.de,
        quic_jesszhan@quicinc.com, bjorn.andersson@linaro.org,
        abhinavk@codeaurora.org, seanpaul@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 21:30, Mark Yacoub <markyacoub@chromium.org> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> This patch adds the register ranges required for HDCP key injection and
> HDCP TrustZone interaction as described in the dt-bindings for the
> sc7180 dp controller. Now that these are supported, change the
> compatible string to "dp-hdcp".

No change in compatibles, so patch description should be updated.

>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-15-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-14-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-14-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-14-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-10-sean@poorly.run #v5

Again, this probably belongs to a cover letter

>
> Changes in v3:
> -Split off into a new patch containing just the dts change (Stephen)
> -Add hdcp compatible string (Stephen)
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v5:
> -Put the tz register offsets in trogdor dtsi (Rob C)
> Changes in v6:
> -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 178efaaa89ec..6f6fe5cb6563 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -817,6 +817,14 @@ &mdss_dp {
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hot_plug_det>;
>         data-lanes = <0 1>;
> +
> +       reg = <0 0x0ae90000 0 0x200>,
> +             <0 0x0ae90200 0 0x200>,
> +             <0 0x0ae90400 0 0xc00>,
> +             <0 0x0ae91000 0 0x400>,
> +             <0 0x0ae91400 0 0x400>,
> +             <0 0x0aed1000 0 0x175>,
> +             <0 0x0aee1000 0 0x2c>;

Is there any reason for adding these to the -trogdor instead of adding
them to the base dtsi? Does hardware differ between the sc7180.dtsi
and sc7180-trogdor.dtsi?

>  };
>
>  &pm6150_adc {
> --
> 2.39.0.246.g2a6d74b583-goog
>


-- 
With best wishes
Dmitry
