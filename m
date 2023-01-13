Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233116690B7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjAMI0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjAMI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:26:04 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA701BC93
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:26:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vm8so50557812ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ow5pZFQZCEYCIqWOTwm6DkLVewzWxSQ2hqbyfaIYUMw=;
        b=AC8rsonIaKcS2a/AKPnyvkOrD5LKOz/E/kypsJqKNj44ntLKk+BZQq0pJYwlExETvH
         MqJQIHgjIl49HUPLbLmq7kDUTnHbIYva0FXIOZYmPbaGDh1Y3/SLNQhcvvcQV33S6Oqw
         LWzMeZPhLmbEJ+aXOMPimAuZu0ot1TeNjbfPtLhZcajjKLL2xYNnr7xK62Hq/ECXivB9
         KR9q2u4MqGg6UDBTgMDMZg2zfotH7Eda07Tz57yWnykG44VGzeLan0+FW6jaHQbJKUpW
         MQYKFwWhW943wKe9d3rdjA0Vn9dJG//JCfFDTLFLqNrNa34NXsm30uhRzZqVFR3dtRYL
         oPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ow5pZFQZCEYCIqWOTwm6DkLVewzWxSQ2hqbyfaIYUMw=;
        b=mbvE/rxktuzUFn2yX2oEcYpAb6EPF7TQNCvHJqtiy8qYtoEE4hcs2pAqi1+Tr+bLGT
         KdxcpFf5q6O8zIgua5fvPNikC2Axef6z+NwciMlPTb5+O4BlwqjkcFTRzwxp0RmKgVJi
         Z3eZJ/At0LcL3rytqwi5RfHs8zVR/aNQvBkhvD74AGqQ53jim1JmJ/eeAqvJq/WHy0DD
         DRc8XtS+B5PCCr3ip0vhozKPQ7s2Mnr46OgDEfXGN6vBPvA5zPI7wU9ihlVUu0YC+gz5
         W0iTtis2EdkRJJgGYieXzz9aR0A5bMJaBhTfG4uroq155Z6Cfv9Ejr5sCqyB00hIyFAn
         Ittw==
X-Gm-Message-State: AFqh2kqd757yWeCZrYUa3RQDVr26NpRXU17eo4z02Kg7JfqsQS6SOMP8
        vzQgJXPhBNSvvgDNpSK3GRynLQ==
X-Google-Smtp-Source: AMrXdXvtfAJKfd+dEPUQgGjDwVPJIsdk/au7/BL5yCsi6a/MUx3IfCt5RfR2t5rlFGwdCkF3RMDP/g==
X-Received: by 2002:a17:907:2587:b0:7c0:ac4b:8b9 with SMTP id ad7-20020a170907258700b007c0ac4b08b9mr56938493ejc.14.1673598361438;
        Fri, 13 Jan 2023 00:26:01 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm8258399ejc.153.2023.01.13.00.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:26:00 -0800 (PST)
Message-ID: <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
Date:   Fri, 13 Jan 2023 09:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113060133.9394-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 07:01, Yong Wu wrote:
> MediaTek iommu has already controlled the masters' iova ranges by the
> master's larb/port id. then the dma-ranges property is unnecessary for

Sentences in English always start with a capital letter, however also
they do not start with "Then". Make it a proper a proper sentence.

> the master's node. the master is vcodec here.

Unnecessary or invalid? Don't you depend now on some feature of driver
added for example recently?

> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

There is little point in storing output of get_maintainers.pl forever in
the git log. If you need it for some reason, please keep it after ---.

> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml | 5 -----
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 5 -----
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml     | 7 -------
>  3 files changed, 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index aa55ca65d6ed..fad59b486d5d 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -56,11 +56,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 0f2ea8d9a10c..a2051b31fa29 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -49,11 +49,6 @@ properties:
>        List of the hardware port in respective IOMMU block for current Socs.
>        Refer to bindings/iommu/mediatek,iommu.yaml.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..290594bc91cc 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -76,11 +76,6 @@ properties:
>        The node of system control processor (SCP), using
>        the remoteproc & rpmsg framework.
>  
> -  dma-ranges:
> -    maxItems: 1
> -    description: |
> -      Describes the physical address space of IOMMU maps to memory.
> -
>    "#address-cells":
>      const: 2
>  
> @@ -203,7 +198,6 @@ required:
>    - reg
>    - iommus
>    - mediatek,scp
> -  - dma-ranges
>    - ranges
>  
>  if:
> @@ -236,7 +230,6 @@ examples:
>              compatible = "mediatek,mt8192-vcodec-dec";
>              mediatek,scp = <&scp>;
>              iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> -            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
>              #address-cells = <2>;
>              #size-cells = <2>;
>              ranges = <0 0 0 0x16000000 0 0x40000>;

Best regards,
Krzysztof

