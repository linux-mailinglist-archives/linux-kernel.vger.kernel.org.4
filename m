Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156626866FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBANcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjBANbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:31:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C26600B;
        Wed,  1 Feb 2023 05:31:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id k4so45954083eje.1;
        Wed, 01 Feb 2023 05:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh/jcCyht4qGjsnUTpbm2j8fXqThpPLNwYUK1bpzTdc=;
        b=icO8OmZrMuzx2KUGJitcRn+N7c++c8nMwL7J/+uUCoy75ghJFTU1136MCuiwxS/TFC
         C/hHvbhVm+fnmOifO1pqmOq1Esb2zn6gecY7gUrt7/0pphg61bIJH8fQHUIkSvGpad31
         GbhAMTnQbeuLqMzYkKR/lNdSnUewl1nvJmbgnuMvfRFrUu7fR/RuJPJUXSUyJJP3ejLw
         qQEOvCUQq2WcRP3CMC0vd04XXdGYsbVER/ZWet7F6jWjQITv57khxVZsaKf71tGUCc+l
         MDFRqdtLnpPvA4Swec1l9lqBtxUKDBFLlQQ6IMgvvu8t5b6aPd+Beev6O5ACmhiSwuiR
         yApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh/jcCyht4qGjsnUTpbm2j8fXqThpPLNwYUK1bpzTdc=;
        b=CEZNqD/Y7j0Ve2qyk0IRARubRpLRDPSOFz71eGJ1GNlbOtZ/6TpjsKJIEM8eAMyt5m
         mjRnaO1NMx3TR3mZy3UjX8Ma0gpv9jQ8q1Oa+VzL3mPmktVk4tlZDEzSWB2ZF/kmggHf
         vF8m0hgy/rwX/nmvWPcvidQ0pvdd+lFa8M780toHZqLFYdBJLgcZPXI6bbGUvLeRXWLB
         +s6X68OzVoX6wo2WcuWoy7Zg7cC8VxOMqtyoBgAlC4e54hlKpjazkQH3PFFRPeLl3uRM
         Gq9NOFvExveU4u/oaMLtnCti6V263LCmcdWh/paW/7vT1WvwmNpDYrXpI0CGCJdbCsYz
         Qp6w==
X-Gm-Message-State: AO0yUKWTSoJHyiGC+2EL8X57QU/Q8ufcwEKvadKKfARsqmbJd4BjXbXh
        6NHCH9EqdkX0hZQRz2Myun8=
X-Google-Smtp-Source: AK7set/hM+ldTkI4tpY6x/QiTZ3kTYlEaoDvxKXKcg7/izE/dAtN2ZLYKSnTe9ofRB5utphli8gPHQ==
X-Received: by 2002:a17:907:7e83:b0:878:6387:5d4f with SMTP id qb3-20020a1709077e8300b0087863875d4fmr1994602ejc.64.1675258266605;
        Wed, 01 Feb 2023 05:31:06 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709064f8200b0088a2aebb146sm3944348eju.52.2023.02.01.05.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:31:06 -0800 (PST)
Message-ID: <f4d3e1b4-d4b2-9124-0d32-29182b155927@gmail.com>
Date:   Wed, 1 Feb 2023 14:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
 <20220929131309.18337-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220929131309.18337-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

It seems this patch got overseen in your queue.
Can you please check if there is still something that blocks it from getting merged?

Regards,
Matthias

On 29/09/2022 15:13, Allen-KH Cheng wrote:
> In order to make the names of the child nodes more generic, we rename
> "vcodec" to "video-codec" for decoder in patternProperties and example.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..67fde48f991c 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -91,7 +91,7 @@ properties:
>   
>   # Required child node:
>   patternProperties:
> -  '^vcodec-lat@[0-9a-f]+$':
> +  '^video-codec-lat@[0-9a-f]+$':
>       type: object
>   
>       properties:
> @@ -145,7 +145,7 @@ patternProperties:
>   
>       additionalProperties: false
>   
> -  '^vcodec-core@[0-9a-f]+$':
> +  '^video-codec-core@[0-9a-f]+$':
>       type: object
>   
>       properties:
> @@ -241,7 +241,7 @@ examples:
>               #size-cells = <2>;
>               ranges = <0 0 0 0x16000000 0 0x40000>;
>               reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
> -            vcodec-lat@10000 {
> +            video-codec-lat@10000 {
>                   compatible = "mediatek,mtk-vcodec-lat";
>                   reg = <0 0x10000 0 0x800>;
>                   interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -264,7 +264,7 @@ examples:
>                   power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
>               };
>   
> -            vcodec-core@25000 {
> +            video-codec-core@25000 {
>                   compatible = "mediatek,mtk-vcodec-core";
>                   reg = <0 0x25000 0 0x1000>;
>                   interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
