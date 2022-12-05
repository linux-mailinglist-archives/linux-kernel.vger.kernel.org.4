Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C986436EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiLEVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiLEVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:32:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B642BB09;
        Mon,  5 Dec 2022 13:32:14 -0800 (PST)
Received: from notapiano (unknown [IPv6:2804:14c:1a9:3b3c::1000])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7E9CA66015B4;
        Mon,  5 Dec 2022 21:32:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670275933;
        bh=50/6QIo85oB6JxRj95P+uB219lfikFqskeQx/8eOvno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRQUJmwna1Fd3WRydn/u93hKBrfttIOdTcafin+jSSCYjr8s1GC7M6p2HGiatKbtM
         dw3/omlPJCPUvvIgvS1mZkuutCWS18K758oZj6pZrK96KiwBrh6PwsBhwsS6x8WRCZ
         D/ZviTmlAkrpSKOigl4ACIML7N9J6ZGh3CkfXhuMDK2mQa37es2OIctUDX5itDZT+m
         neu34try3QNXbu4wn3s9rqq7sE/HkJagVPpvFShgr97iqqxw4NfM0evX5yysOwVWFU
         /tHa61VDvgghxpot4Q/5Q1TbgR4WHQZPJBtA1C1RFFEjnjCVpsTxLiyOiQ0t99oyby
         //suG3cbYJkKw==
Date:   Mon, 5 Dec 2022 18:32:04 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, yunfei.dong@mediatek.com
Subject: Re: [PATCH v5 1/3] media: dt-bindings: media: mediatek: Rename child
 node names for decoder
Message-ID: <20221205213204.ftnarhtsk33pprq3@notapiano>
References: <20221128143832.25584-1-allen-kh.cheng@mediatek.com>
 <20221128143832.25584-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221128143832.25584-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 10:38:30PM +0800, Allen-KH Cheng wrote:
> In order to make the names of the child nodes more generic, we rename
> "vcodec-lat" and "vcodec-core" to "video-codec" for decoder in
> patternProperties and example.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../media/mediatek,vcodec-subdev-decoder.yaml | 60 ++-----------------
>  1 file changed, 4 insertions(+), 56 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..695402041e04 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -91,12 +91,13 @@ properties:
>  
>  # Required child node:
>  patternProperties:
> -  '^vcodec-lat@[0-9a-f]+$':
> +  '^video-codec@[0-9a-f]+$':
>      type: object
>  
>      properties:
>        compatible:
>          enum:
> +          - mediatek,mtk-vcodec-core
>            - mediatek,mtk-vcodec-lat
>            - mediatek,mtk-vcodec-lat-soc
>  
> @@ -145,59 +146,6 @@ patternProperties:
>  
>      additionalProperties: false
>  
> -  '^vcodec-core@[0-9a-f]+$':
> -    type: object
> -
> -    properties:
> -      compatible:
> -        const: mediatek,mtk-vcodec-core
> -
> -      reg:
> -        maxItems: 1
> -
> -      interrupts:
> -        maxItems: 1
> -
> -      iommus:
> -        minItems: 1
> -        maxItems: 32
> -        description: |
> -          List of the hardware port in respective IOMMU block for current Socs.
> -          Refer to bindings/iommu/mediatek,iommu.yaml.
> -
> -      clocks:
> -        maxItems: 5
> -
> -      clock-names:
> -        items:
> -          - const: sel
> -          - const: soc-vdec
> -          - const: soc-lat
> -          - const: vdec
> -          - const: top
> -
> -      assigned-clocks:
> -        maxItems: 1
> -
> -      assigned-clock-parents:
> -        maxItems: 1
> -
> -      power-domains:
> -        maxItems: 1
> -
> -    required:
> -      - compatible
> -      - reg
> -      - interrupts

Looks like interrupts was required for vcodec-core, but it isn't for the generic
video-codec node. Which seems correct, given that the vcodec-lat-soc doesn't
have an interrupt [1]. So I guess this is just the generic video-codec node in
the binding being too generic for some cases. Ideally we would override
interrupts to be required based on which subnode we're dealing with (for lat and
core, but not lat-soc), but given these are subnodes matched through
patternProperties, I'm not sure that would be possible.

[1] https://lore.kernel.org/all/20221202034450.3808-3-yunfei.dong@mediatek.com/

Thanks,
Nícolas

> -      - iommus
> -      - clocks
> -      - clock-names
> -      - assigned-clocks
> -      - assigned-clock-parents
> -      - power-domains
> -
> -    additionalProperties: false
> -
