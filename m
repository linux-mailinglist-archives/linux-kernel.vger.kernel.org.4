Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCA6B7B83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCMPIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCMPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5821D6E691;
        Mon, 13 Mar 2023 08:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A4661321;
        Mon, 13 Mar 2023 15:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580AAC4339C;
        Mon, 13 Mar 2023 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678720070;
        bh=9uDAGZu4CJyMoYzZK2RUuQqShh9kqX6wJsiU6PIlzuE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qLMBvQhsNBgoWCgd+R9FhR31f+41+FX6l3p7oDgiAvisb1mK8aFGZeUWxTXcRinyM
         A+9EJOnF3pr9gdQ+xqubBulIiZOFXfZ6IE2VWj4dqBlBh1ZCodv19JbU1PLy0l0Phe
         dWuuZsI12q+YpDn/DW4XagMSw4VDFLGeD0YUQ0FwN7N5LO50rwjmQ+8x7qCQDEiN2B
         ZwRW7ySB2tMHBfhmdf7w5Rr28ejjmZkX4P36GYwyZ0T1BeA78MHKSrwhDQVcnbbpd9
         uapqtSh+bFX4p0MTokoXCoFnBsrhW9O0RSRpCHYUQY4X3nkgOHe4OSI+Sbohl45qkA
         31vSu0JOc0MwQ==
Received: by mail-lj1-f175.google.com with SMTP id h9so12966235ljq.2;
        Mon, 13 Mar 2023 08:07:50 -0700 (PDT)
X-Gm-Message-State: AO0yUKWHvUTaa8TfN26LeAhAt0mkPRJan8xIttlGugSpzMnUXnEPpFAq
        3eNaSiCPf/ylP0r62x1H/pxgX+v1EqRDR44xMg==
X-Google-Smtp-Source: AK7set96FceeAgzIrNFk6O5tGtdzNZKS74mjeYqgSiEvYzM4A13lNdDb9HBRGzIk8lESKcb8+sqursSIAO3pnU2VYxM=
X-Received: by 2002:a2e:b55c:0:b0:295:d632:ba20 with SMTP id
 a28-20020a2eb55c000000b00295d632ba20mr10877049ljn.10.1678720068446; Mon, 13
 Mar 2023 08:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-8-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-8-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 23:07:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY__1rm_neb7UPDt0xum2Yr81++Z+uz0KMsLRm2QLvBUSFQ@mail.gmail.com>
Message-ID: <CAAOTY__1rm_neb7UPDt0xum2Yr81++Z+uz0KMsLRm2QLvBUSFQ@mail.gmail.com>
Subject: Re: [PATCH 08/21] dt-bindings: display: mediatek: gamma: add binding
 for MT8365 SoC
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre:

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Display GAMMA for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml |=
 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ga=
mma.yaml
> index a89ea0ea7542..f54859cfc97b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> @@ -30,6 +30,7 @@ properties:
>                - mediatek,mt8186-disp-gamma
>                - mediatek,mt8192-disp-gamma
>                - mediatek,mt8195-disp-gamma
> +              - mediatek,mt8365-disp-gamma
>            - const: mediatek,mt8183-disp-gamma
>
>    reg:
>
> --
> b4 0.10.1
