Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3452E6BF162
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCQTDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCQTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:03:38 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FCB2D158;
        Fri, 17 Mar 2023 12:03:34 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id bp11so3251435ilb.3;
        Fri, 17 Mar 2023 12:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA6US2iEQS7WVb5Tu7I2HnyasBrHjBowuMV4CxZo+lY=;
        b=VwT5AGTxxMVbVykUiaOLqc+wPNAYDtKzyKRXCjfjYXOD8PQSx2n+Ht3F/G6cG5Ifk5
         6UUMb8qCfp5B9Y5UW3782CCtlIW8tKagWftG/DkjY4fZRZMdtp46u0HfhGbQ8WCatjym
         FCNZX+7BuwECEhtT177KTm3pMvKXY9Ol3ztqR4PEWSctztG0bTlF2V8TmMJaXqT8tOtu
         rVmodNHGLmP+Z9Z+E46gwuCe+GPC5Bo2kOYLCJFAlz1gXZt8pfd4VXoCCZZ5Y47rMaTX
         958Q+gwq4p/jW4pJEcMUfNQkkTgILCMCSltL5CKCvYvWXu/zWnNmv+WNCciB0DCNBv77
         DSyw==
X-Gm-Message-State: AO0yUKUXpdyF/veHRpFdRptQAyGU/SYwauQfpJ87g8Wc+rxDQdrnsLV3
        HjKVcLKpB7seI3Gac1o+Kg==
X-Google-Smtp-Source: AK7set9bB4NJOxOyCqNiGWCfZXmoAvBml08ZXNwdEoqMoufqX6wiMlft0ZCPwbnmvDM8kYUZndNjUg==
X-Received: by 2002:a92:c8c5:0:b0:315:365d:5358 with SMTP id c5-20020a92c8c5000000b00315365d5358mr324058ilq.10.1679079813708;
        Fri, 17 Mar 2023 12:03:33 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v5-20020a056e020f8500b00317b8e2c2b4sm804326ilo.39.2023.03.17.12.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 12:03:33 -0700 (PDT)
Received: (nullmailer pid 2631711 invoked by uid 1000);
        Fri, 17 Mar 2023 19:03:31 -0000
Date:   Fri, 17 Mar 2023 14:03:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 20/21] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Message-ID: <20230317190331.GA2628708-robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-21-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-21-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 11:59:20PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7628 and MT7688 SoCs contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
> 
> Remove mediatek,mt76x8-pinctrl from mt7620.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/mediatek,mt7620-pinctrl.yaml      | 379 +--------------
>  .../pinctrl/mediatek,mt76x8-pinctrl.yaml      | 450 ++++++++++++++++++
>  2 files changed, 459 insertions(+), 370 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt76x8-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> index 808dd8bd276f..591bc0664ec6 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7620-pinctrl.yaml
> @@ -11,15 +11,13 @@ maintainers:
>    - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>  
>  description: |
> -  MediaTek MT7620 pin controller for MT7620, MT7628 and MT7688 SoCs.
> +  MediaTek MT7620 pin controller for MT7620 SoC.

Saying MT7620 twice is redundant. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
