Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CC0653320
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiLUPXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:23:37 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468C2339C;
        Wed, 21 Dec 2022 07:23:34 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h8so6921156qkk.8;
        Wed, 21 Dec 2022 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUXeKrsZn4EDklCtcl9IwuZ+sDDVGfdsHNn3PCdSLec=;
        b=mfk3AhkaAgAN7hCtsc00tDgCYjhBWripOGsjsOOCeqRPm57hg9ZTlxqkFAg4zfFJ8w
         8mDM4psrSudUT/NFgyhBzLB5U6+YlMbZAX5fWZHIgjeB2kODGPL23oAXXr+q/z7rUlVs
         v+8s2IFZd5HULFp0LDSlTXKZxInAm1u87//cuVMJf3LvEwMqeY6XN5dw+dY3Gs7+rSCi
         XweGlE/JXjGhxgFPsFCrZXGnrtWfp2/2R8lv1Q7iNzpG6nzRk1aNUsxCELuzruIO7a2w
         BDIf8FsLFc7DI0R9KQg9JhzcOdlFMPgVESxP8n7Bem9ayaHZSEt2xJU2u5hfjTWMhELd
         8qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUXeKrsZn4EDklCtcl9IwuZ+sDDVGfdsHNn3PCdSLec=;
        b=mTfMvLfSLx24LmeY+wJcYgCZ6QGyQ09vNKA4+hlJp2p7yC8K/wCauDhbjFj1iwo9kl
         3HP6dlHYEsnvjDfgEARtlHyannlEqJDDw/E0GJ5aJaEuxeivfo8Uum6plERpkBFFhDwR
         +AAOWclQRqk84xnr5hVdzUMWpqtFpH+FX2ugAe2UVYyIiLM7vZOfZ2z9mNDngvxLDq1p
         x2bLWuPtJNf/+wifYe5RJ+Hba44QM9E2FU2INYxBl3vbXeHhmX0BBKovMk5nrheC6Q5G
         qRJu3Ccxu6XvTC0jWPRawfVjBEcj8Ilqes+nlL7MKCCGyHb+XBzXoFkOiG8LUmCDs9N5
         jxjQ==
X-Gm-Message-State: AFqh2krc22xr+S+8yDue566KJP6qfPCdEd3WuWQ20qLOGbmU4UmLE40J
        52Wq/ijpIBgWZCyFVRjZR9FtQM3Yc2xx1w+vmrRULfPVYelmFm/Uvw4=
X-Google-Smtp-Source: AMrXdXt4dGRRkPaXQf/5uLyqwJxqdWNQrklT0RU9ZuU4lr+pjq/gAtre4l9m6yprTV0xPFmzqwJYaICOatCTzK233ns=
X-Received: by 2002:a37:b93:0:b0:6ed:d040:c175 with SMTP id
 141-20020a370b93000000b006edd040c175mr70004qkl.536.1671636213283; Wed, 21 Dec
 2022 07:23:33 -0800 (PST)
MIME-Version: 1.0
References: <Y6MkcVIpEaWrTrsS@VM-66-53-centos> <Y6MksLH9POLt6UTI@VM-66-53-centos>
In-Reply-To: <Y6MksLH9POLt6UTI@VM-66-53-centos>
From:   ty <zonyitoo@gmail.com>
Date:   Wed, 21 Dec 2022 23:23:21 +0800
Message-ID: <CAMmci2UP+oagyQtxZ+9FmDrfDHhhD0Mf5xdgBSnO+iFF1nZb+w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot the `From` line.

Yuteng Zhong <zonyitoo@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=B8=89 23:22=E5=86=99=E9=81=93=EF=BC=9A
>
> From: DHDAXCW <lasstp5011@gmail.com>
>
> Add devicetree binding documentation for the EmbedFire LubanCat 1.
>
> Signed-off-by: Wenhao Cui <lasstp5011@gmail.com>
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 88ff4422a8c1..058ed707f3cd 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -95,6 +95,11 @@ properties:
>            - const: elgin,rv1108-r1
>            - const: rockchip,rv1108
>
> +      - description: EmbedFire LubanCat 1
> +        items:
> +          - const: embedfire,lubancat-1
> +          - const: rockchip,rk3566
> +
>        - description: Engicam PX30.Core C.TOUCH 2.0
>          items:
>            - const: engicam,px30-core-ctouch2
> --
> 2.27.0
>
