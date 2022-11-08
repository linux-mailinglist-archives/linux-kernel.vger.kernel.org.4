Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E76205BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiKHBXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiKHBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:23:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474D81DA76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 17:23:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id a13so20356080edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 17:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o0A0yw55ZieBl6SrkekIUPpMrnlgooteEELcL9ZP3Ec=;
        b=DK54vb1qCybXBrtEEyTCQW0ellpWxVvHx4N75ZCqL1P4rDLkJG0CiGEVVH3XeWq8xh
         8+1IjIRIPFAGUQTO7Sg3OvRkap8WxD6/LXF1uT2MaR2yNYLzsHlI24+cioPAtbMyHm9s
         a0wRssFzUFGXrvEcesGMmXNcOXvAfnaUFFqHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0A0yw55ZieBl6SrkekIUPpMrnlgooteEELcL9ZP3Ec=;
        b=GcsCp6KuE5sqpSZZ2seBcFjZeuufMViUoFP86UrllgMiVU919KWWE7TEDajLi2i7dG
         TXVnQBX6zLcnqlWSrGi1T0oPBUJkxLzuF+4bW/2bvUpvbqVifZp7Py50UNZuB18/FxoJ
         uFOsYJ+OLvKIFjGya4Ur1oH0yhX603gXSryq7IlJxBysNe0nZU002KZT7d/oNdBBaepw
         CU1wCgN6aoWtHY9qEZfKie9NxwkO3FKvFKoumCuhXklkwTYM3mrrO8GvQo3AD/a8up/D
         p6gi2zH99OPsyPEFEqbj2OeEBre5aI0oLXZOwD0/zBVLUdpdeC8MksU60zztw4PGMiMp
         Dnug==
X-Gm-Message-State: ACrzQf2iAD8KsNVol/ZLGuxwG8DYTlZ/lpbvwD7EG31lump8S+e6E77x
        9POUFc645410j90W6sEWYmIB66N0K2oomz+m
X-Google-Smtp-Source: AMsMyM7kDYoMy0D/zM6x7OWlRGuydIR4VTeXoo/0DO6My465z0aCUG95CJygK0Zr5BANNkHh2t/DjA==
X-Received: by 2002:a50:eb83:0:b0:462:a2ac:8623 with SMTP id y3-20020a50eb83000000b00462a2ac8623mr53081847edr.360.1667870584544;
        Mon, 07 Nov 2022 17:23:04 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906148f00b007aa239cf4d9sm4077063ejc.89.2022.11.07.17.23.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 17:23:04 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id o4so18720057wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 17:23:03 -0800 (PST)
X-Received: by 2002:adf:d1ec:0:b0:236:880f:2adf with SMTP id
 g12-20020adfd1ec000000b00236880f2adfmr33984142wrd.617.1667870583522; Mon, 07
 Nov 2022 17:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20221107191535.624371-1-swboyd@chromium.org> <20221107191535.624371-3-swboyd@chromium.org>
In-Reply-To: <20221107191535.624371-3-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Nov 2022 17:22:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XKHftMn4Ja40fdDggwi78F2pB0A+prs94+fFBhbSvNYw@mail.gmail.com>
Message-ID: <CAD=FV=XKHftMn4Ja40fdDggwi78F2pB0A+prs94+fFBhbSvNYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Fully describe fingerprint node
 on Trogdor
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 7, 2022 at 11:15 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Update the fingerprint node on Trogdor to match the fingerprint DT
> binding. This will allow us to drive the reset and boot gpios from the
> driver when it is re-attached after flashing. We'll also be able to boot
> the fingerprint processor if the BIOS isn't doing it for us.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 4a5ea17a15ba..65601bea0797 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -894,13 +894,16 @@ ap_spi_fp: &spi10 {
>         cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
>
>         cros_ec_fp: ec@0 {
> -               compatible = "google,cros-ec-spi";
> +               compatible = "google,cros-ec-fp", "google,cros-ec-spi";
>                 reg = <0>;
>                 interrupt-parent = <&tlmm>;
>                 interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
>                 pinctrl-names = "default";
> -               pinctrl-0 = <&fp_to_ap_irq_l>;
> +               pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
> +               boot0-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;

This isn't totally a no-op change since the pinctrl entries for
fp_rst_l and fpmcu_boot0 will now be applied. I assume you've
confirmed that it works as expected?

...other than the subject (same as patch #1), this LGTM.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
