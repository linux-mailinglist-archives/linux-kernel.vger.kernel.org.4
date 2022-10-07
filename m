Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29B25F7372
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJGDvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJGDvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:51:41 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCDDBEAEC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:51:40 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id p7so571809vsr.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RerK2rBiuhYMfubodkZfB/ZpDqYK/wxKKL/JNwD3Q+M=;
        b=dlmBPgiOtRxGkbv7rjlv2SMcccR1EQVBHJ2axjdsJ02yrr5hKaM36d+WvZWaDEzGGt
         0Ip2I6qxqD35xFWKvcjWIRq3XMC3cSpvesLHz4hwsf8JP/9SIqaaTetF/Ruw2KzYi6+x
         O/+bfdw6x86sDV0ciAF9kUjgj1XrBkcTYu3P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RerK2rBiuhYMfubodkZfB/ZpDqYK/wxKKL/JNwD3Q+M=;
        b=tmytvskDtG4H0yvNXBo4WzpbGpz7Mzd4GHmv4coHTifNQBL32tKTwtPUVyuUPcLWvC
         Pl++xa/ZnsLLWbB2SnHWKel4htvkTIpbwsPnylbGPH5eIqyaWs2iPWg3/yv7BIqSlund
         BdspA1fI2FFZqx1OnyzBhNbzO9JBJSBjJ8sTCxvyi9ZKWDgtZsAfXUFvWzAkVaJ01z8Q
         wNZ7G5ACniGndxyjU9Y0upxnPB1mNizmVgYcjYB1QmcHYbf01JMALnK4dLawCt8KkedM
         iBSLFMvQn+YCpdvOhXQkhtjmIlhChUeYZdbbQWvSviC0vqHs5kxnM6cgoxI22DzgfPE9
         EQkQ==
X-Gm-Message-State: ACrzQf12JmyDel0/2bokocwAejCDULt2DRStIwswpZOpTmLAO00DlHix
        u436lc/HcdNe2mWgirFo/o6FgvehX9L92oqPm6prvw==
X-Google-Smtp-Source: AMsMyM6DZCU3H5d9leQfxkyqeLDM36598wR9p8zY1m3Q8gko7dMPnHiaV3d9xfcbyRe5ChJLBf+e8d8wNaErE59zoxY=
X-Received: by 2002:a67:ac09:0:b0:39a:eab8:a3a6 with SMTP id
 v9-20020a67ac09000000b0039aeab8a3a6mr1621057vse.9.1665114699289; Thu, 06 Oct
 2022 20:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20221006212528.103790-1-nfraprado@collabora.com> <20221006212528.103790-6-nfraprado@collabora.com>
In-Reply-To: <20221006212528.103790-6-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 7 Oct 2022 11:51:28 +0800
Message-ID: <CAGXv+5GmJOYnfLsovO_+piuJ1ry1R0ZQqALRGK3MNp=nUO-TNw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: asurada: Add aliases for i2c
 and mmc
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Fri, Oct 7, 2022 at 5:25 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add aliases for the i2c and mmc nodes on the Asurada platform DT to
> ensure that we get stable ids for those devices on userspace.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
> Changes in v2:
> - Added this commit
>
>  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm6=
4/boot/dts/mediatek/mt8192-asurada.dtsi
> index dac2d4f5e670..758ca42a6156 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -11,6 +11,18 @@
>
>  / {
>         aliases {
> +               i2c0 =3D &i2c0;
> +               i2c1 =3D &i2c1;
> +               i2c2 =3D &i2c2;
> +               i2c3 =3D &i2c3;
> +               i2c4 =3D &i2c4;
> +               i2c5 =3D &i2c5;
> +               i2c6 =3D &i2c6;
> +               i2c7 =3D &i2c7;
> +               i2c8 =3D &i2c8;
> +               i2c9 =3D &i2c9;

You should only add aliases for interfaces that are actually enabled.

Also, I think we can disable i2c6. None of the current products use it.

ChenYu

> +               mmc0 =3D &mmc0;
> +               mmc1 =3D &mmc1;
>                 serial0 =3D &uart0;
>         };
>
> --
> 2.37.3
>
