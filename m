Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C266A7F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCBKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCBKEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:04:04 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB54345B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:03:20 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id d7so21940623vsj.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spMK8uenDqn36oHL1e/zBfnn5QTutF5o6W99Pq78A9s=;
        b=KXj8JUuCq/H7nA3qF+PWOtRzKW5T857VuIHKsVE7+XCCQ8eikkXbUFkeWhAc2ZIt9D
         lG8vviX//AJz1h2UVA8NieOiOZXik0s6LDk9r3j/A7fU8jnqTi5iaL7iN24amOLdJKBv
         N6GDybFjbmuWB/8QesrvzSo9ur2djqAJ5Bh3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spMK8uenDqn36oHL1e/zBfnn5QTutF5o6W99Pq78A9s=;
        b=4yonVnHvHf7F5QT2oAiYMOdiXeJCPVhutLZdNWgrC/XSSLRZgM9+TWQavMywWRqM5V
         /zfJjdrWCf25JVi5SlVZDcDTnCeyojsbyScBr0PdwgOBUST0v+wL9SMN6HtJ4su+J+Ye
         1j4ouSSmbWYtpkpTxWeEpoZoYixyJqrlYmisVfmsRAwjDo2IOoe3qomVNKd5dTEMpShj
         eKVABpVlRluCycWRLVCgE8n8p8tHthWy4uFkH1Yws+vUVo/yP3lhjaqJ7S9LN2nejX2U
         r7UKsUhyXvjB45rOAeGXzFrDYo8yneYoPNsUqHGyRJzlR+siEkFsRb/8n76Azls248Xp
         0LEA==
X-Gm-Message-State: AO0yUKXXnzrUfn7MoLfK/OOn9V2mW1D8mTMOzEfl8ilKiZ4ykgP/MwAh
        SNGKEmwc9KKgYRWbsCqfPS30tds55P16Ufb6FCMy4Q==
X-Google-Smtp-Source: AK7set+SWaRZ2OD4u8G2zQvT9dzOZbWXsp5NQKzNronyBvqX9kSb9fKWCyUNsfD+0ceCkURFLuMECx5o+xPfJ9qzsKI=
X-Received: by 2002:a67:ec52:0:b0:412:2ed6:d79b with SMTP id
 z18-20020a67ec52000000b004122ed6d79bmr6383028vso.3.1677751399157; Thu, 02 Mar
 2023 02:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com> <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 2 Mar 2023 18:03:08 +0800
Message-ID: <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 5:55=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add coupling for these regulators, as VSRAM_OTHER is used to power the
> GPU SRAM, and they have a strict voltage output relation to satisfy in
> order to ensure GPU stable operation.
> While at it, also add voltage constraint overrides for the GPU SRAM
> regulator "mt6359_vsram_others" so that we stay in a safe range of
> 0.75-0.80V.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index 8570b78c04a4..f858eca219d7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>         regulator-always-on;
>  };
>
> +&mt6359_vsram_others_ldo_reg {
> +       regulator-min-microvolt =3D <750000>;
> +       regulator-max-microvolt =3D <800000>;
> +       regulator-coupled-with =3D <&mt6315_7_vbuck1>;
> +       regulator-coupled-max-spread =3D <10000>;

Looking again at the downstream OPP table, it seems there's no voltage
difference requirement. It only needs V_SRAM >=3D V_GPU. Same applies to
MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >=3D 10000.

Would setting max-spread to 0 work? I ask because with both regulator's
maximum voltage set to 0.8V, there's no way we can reach the highest
OPP.

ChenYu


> +};
> +
>  &mt6359_vufs_ldo_reg {
>         regulator-always-on;
>  };
> @@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
>                                 regulator-max-microvolt =3D <800000>;
>                                 regulator-enable-ramp-delay =3D <256>;
>                                 regulator-allowed-modes =3D <0 1 2>;
> +                               regulator-coupled-with =3D <&mt6359_vsram=
_others_ldo_reg>;
> +                               regulator-coupled-max-spread =3D <10000>;
>                         };
>                 };
>         };
> --
> 2.39.2
>
