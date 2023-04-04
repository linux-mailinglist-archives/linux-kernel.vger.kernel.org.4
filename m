Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00AC6D638F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbjDDNn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjDDNnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:43:52 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D324224;
        Tue,  4 Apr 2023 06:43:52 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-17ab3a48158so34596069fac.1;
        Tue, 04 Apr 2023 06:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tODEIpAwPnvNGUawqsylxasQ6Mk6tuNFhtn3yBSRNT0=;
        b=pqzukMi/DzJW7M6VufoRZvtIoUijH8qdL2E8I97eSAzjFtQUhqDlc+pM8NVvhu/jWB
         CTgrG5yl+oIZFin3EJyjbKp2bJSvWS5NxIxrFy7H/7jwThIBHu/tMCjD8bOSRxeHmR7z
         iuzVbsqD+M51rjPdzSKbDFEbHOOaAbtqYNS7myEda2Pe+ijWqUULWMQ39V9lQ9lLxDQD
         gJcHNafqnRZnjWOedKMtJ6a48RwQuzzWKlT6Ft3LCeMoVK5P47QOids6STJvBBIx/9+2
         Ujkqya1VYstE5IenS4zxdZ/y09seDhiz1mi0sjIaNuCSQTz92iVB3KW9XbXK/6umw2Lt
         Lx4A==
X-Gm-Message-State: AAQBX9cx23k95nldPn1vvfFpnBjzZkcD0X2w5ptcMkdbHkT6yTHlbPPk
        JaSsDnyyA18mm+EQEoqpdA==
X-Google-Smtp-Source: AKy350bsxMNesEfeufKU5Vad6zN3YBIROdhHPyyDXnruiII2TswWfiDxkGwWW7TE7zwGEZ5lANV1XQ==
X-Received: by 2002:a05:6870:f223:b0:177:80ce:497f with SMTP id t35-20020a056870f22300b0017780ce497fmr1909308oao.7.1680615831247;
        Tue, 04 Apr 2023 06:43:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yg21-20020a05687c009500b0016a37572d17sm4853705oab.2.2023.04.04.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:43:50 -0700 (PDT)
Received: (nullmailer pid 3785276 invoked by uid 1000);
        Tue, 04 Apr 2023 13:43:50 -0000
Date:   Tue, 4 Apr 2023 08:43:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH 6/7] dt-bindings: usb: mtu3: add two optional clocks
Message-ID: <20230404134350.GA3782583-robh@kernel.org>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
 <20230403025230.25035-6-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403025230.25035-6-chunfeng.yun@mediatek.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:52:29AM +0800, Chunfeng Yun wrote:
> Add optional clock 'xhci_ck' and 'frmcnt_ck';
> Add optional property "assigned-clock" and "assigned-clock-parents";
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> index d2655173e108..50c15f2ce14d 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
> @@ -66,6 +66,8 @@ properties:
>        - description: Reference clock used by low power mode etc
>        - description: Mcu bus clock for register access
>        - description: DMA bus clock for data transfer
> +      - description: DRD controller clock
> +      - description: Frame count clock
>  
>    clock-names:
>      minItems: 1
> @@ -74,6 +76,16 @@ properties:
>        - const: ref_ck
>        - const: mcu_ck
>        - const: dma_ck
> +      - const: xhci_ck
> +      - const: frmcnt_ck
> +
> +  assigned-clocks:
> +    minItems: 1
> +    maxItems: 6
> +
> +  assigned-clock-parents:
> +    minItems: 1
> +    maxItems: 6

You don't need to include assigned-clocks properties. They are 
implicitly allowed (when clocks is present).

Rob
