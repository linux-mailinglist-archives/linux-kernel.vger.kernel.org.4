Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E156733D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjASIhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjASIhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:37:12 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B235273B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:37:11 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o205so782724yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W30qCxVKf0KARy+TLTjIt9Y3WaxPoZtvKimLdjidWI=;
        b=dZmYHThxSgG/zloX7Dz/TblAHFGnQhaqJk3S0H4Co64uzDBruSrZJJAa414xkyUiZ6
         GqXevocPagiBF441A9XBAHat6S7FH48JHWwnnC6LPJeYmsq8zWSIsyMKf8KlBU8TV0qU
         csfJ8Ic2UG8OkBQU6W5nggtagyfFDQ9pK7fquszs+FGyc/ZoNNrgVV2pa4SexUZjrT13
         ocq/z2jBesQxSbF6VdXdyKsudFED0HQsJL0Kv1j/+WOZs4HxCL6BxUeaYzzYYmafDaeb
         dVddQeLZDMbbY/TRxhw5YKERjHg1IZ6NqcVmnKueThsnwWgJSCmYhVWZD1b1yKKEUd1A
         +1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W30qCxVKf0KARy+TLTjIt9Y3WaxPoZtvKimLdjidWI=;
        b=hF42uN1Vyz6jAuoLIc7UXzqX/qAQWJeGmZntOJXtdolJvLtFuJTlHxVL2wlqlAdFv5
         05SrWClt0SCNdke/GnymobFWobT8HFWhCP4dYKSRgzgr91mX8HWol7fbpiMCAAxQHnPc
         w010iJQjGiaVpAjOJ5DZlinhhiSB0Tm0SH64LBEGpLi1pEkYA018wh8FS6LpMIabjGr3
         3f/wmys43eDefUw3Um6vqgXbZyU7xqhjNImkWjfDLMBVZqCMSGK4P9sXpBnW+urb16Ls
         +DFb6p/lc8PWbOh9t2yxwGaQD3qFEau5fgrjeOZ5xQTyI8/IjWMHxylT+ANImsY1TerC
         bx0w==
X-Gm-Message-State: AFqh2koN/BHYfQEh9IgkYAWaEoly1H3X7Ic3Jka8kyetANrepKVhyshd
        o16bkFD9oCGnESR2PQmPDCn4xzBHhUv79ZeibCzX6w==
X-Google-Smtp-Source: AMrXdXuaEM66ZFVHU3adMHT8v6p6wBn0BYXl02ic25ZtL9O2RpLvMcfl5xsbyGaABZf1lpRV0+JwNKzTNmOGQDTLOdI=
X-Received: by 2002:a5b:592:0:b0:7ed:9cee:464 with SMTP id l18-20020a5b0592000000b007ed9cee0464mr1308159ybp.194.1674117430262;
 Thu, 19 Jan 2023 00:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20230118193015.911074-1-markyacoub@google.com> <20230118193015.911074-9-markyacoub@google.com>
In-Reply-To: <20230118193015.911074-9-markyacoub@google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Jan 2023 10:36:59 +0200
Message-ID: <CAA8EJpq689pt0VXEjo_F48W8JQ+MGnEX3TH1z2ACdD_49YG-mg@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] dt-bindings: msm/dp: Add bindings for HDCP registers
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
        abhinavk@codeaurora.org, seanpaul@chromium.org,
        Rob Herring <robh@kernel.org>,
        Mark Yacoub <markyacoub@chromiu.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 at 21:30, Mark Yacoub <markyacoub@chromium.org> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> This patch adds the bindings for the MSM DisplayPort HDCP registers
> which are required to write the HDCP key into the display controller as
> well as the registers to enable HDCP authentication/key
> exchange/encryption.
>
> We'll use a new compatible string for this since the fields are optional.

This doesn't correspond to patch contents.

>
> Cc: Rob Herring <robh@kernel.org>

This should be a

> Cc: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromiu.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-13-sean@poorly.run #v1
> Link: https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-13-sean@poorly.run #v2
> Link: https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-13-sean@poorly.run #v3
> Link: https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-13-sean@poorly.run #v4
> Link: https://patchwork.freedesktop.org/patch/msgid/20211115202153.117244-1-sean@poorly.run #v4.5
> Link: https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-9-sean@poorly.run #v5

Please, clean this up. I suspect that the long list of previous
iterations might belong to the cover letter, but not to the series
themselves.

>
> Changes in v2:
> -Drop register range names (Stephen)
> -Fix yaml errors (Rob)
> Changes in v3:
> -Add new compatible string for dp-hdcp
> -Add descriptions to reg
> -Add minItems/maxItems to reg
> -Make reg depend on the new hdcp compatible string
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v4.5:
> -Remove maxItems from reg (Rob)
> -Remove leading zeros in example (Rob)
> Changes in v5:
> -None
> Changes in v6:
> -Rebased: modify minItems instead of adding it as new line.
>
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml    | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index f2515af8256f..17d741f9af86 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -24,13 +24,15 @@ properties:
>        - qcom,sm8350-dp
>
>    reg:
> -    minItems: 4
> +    minItems: 5

No. eDP uses 4 register blocks.

>      items:
>        - description: ahb register block
>        - description: aux register block
>        - description: link register block
>        - description: p0 register block
>        - description: p1 register block
> +      - description: (Optional) Registers for HDCP device key injection
> +      - description: (Optional) Registers for HDCP TrustZone interaction
>
>    interrupts:
>      maxItems: 1
> @@ -154,7 +156,9 @@ examples:
>                <0xae90200 0x200>,
>                <0xae90400 0xc00>,
>                <0xae91000 0x400>,
> -              <0xae91400 0x400>;
> +              <0xae91400 0x400>,
> +              <0xaed1000 0x174>,
> +              <0xaee1000 0x2c>;
>          interrupt-parent = <&mdss>;
>          interrupts = <12>;
>          clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> --
> 2.39.0.246.g2a6d74b583-goog
>


-- 
With best wishes
Dmitry
