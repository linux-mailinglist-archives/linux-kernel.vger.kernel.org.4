Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742077365D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFTIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjFTIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:12:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229A186
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:12:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f901f87195so23926975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687248736; x=1689840736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KRzE3IxHv0D72WxLTYYk5f9VrvCEP7kc7aTHTFKOSI=;
        b=qNDBWvbudemDgPmOjnbu080AyvX8nOks7ZLsys7A4wfr+7VWtU26irPr90roJ30HcM
         GbWu6dlSkQX77ZWpwWA6jSUeISJ5jxEs82+08vFEDzk/hN4oQH0/mwyq+ziJq0FQkNGw
         Of+e9HOUY/sUl8Iz/A3o4o1oLV4BiWQuXJfHcdvg5tdRXDQK8bMhoE7yov2rYSvKQHY8
         78+Q9+bHG3srLrD1hF2i9ACQ0zFDUoQkYbylSUsxNrCWRVXmTLCgu+shGZgrFTWZ8L3k
         2KRrwrLEVI8z927SBQ1RfzUkCRmOL8DEN9j29rrbw0vzH+nP1nIqQDn1JdQnxo54UgIB
         xt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248736; x=1689840736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KRzE3IxHv0D72WxLTYYk5f9VrvCEP7kc7aTHTFKOSI=;
        b=gAOHNSIHAxhVkJQpPD0LdX2HDgNjXek86oMuF8XS8O+xLp8rucFSLpPk6oJspOWngi
         +4SK/icc721zYpJF547ssiL9Za5exLKyHMKbZMWexE3qStEAufhRN2yy5xv16E1uv+4Q
         Ey4MUJkuWpxWAWej4smXXTgCaQGrftpDPjXNUwqBnnO5Dhv9S3S25RGKfsopItliUKtK
         dqZVN4Kmcx/eSWBLzFN9/7ubNXe+UXAUgtOS+c7/cIeIcyTjwiOcbWz0eLbiyPohfAh2
         ilDiTcCrQWUOfnnE5Kq37aPvQtGDXBa7hynGYFYaf8lVjcsGa6oWNVeivB8Y/K8a5dPJ
         KxJg==
X-Gm-Message-State: AC+VfDzHDR+JMhybgAYXlCorc8dD8xo7a7oHS2CMwIUjEXw5WHnZ+xWV
        2F2fyEmMD1cuBvO7QJYtflEIFg==
X-Google-Smtp-Source: ACHHUZ5VCMlfw7GJ9Qf2HaNFEaUXnZ28ODluape1E5lbYbI6NEx+mawbOnCdpFyStP6LzFieyg4ZUw==
X-Received: by 2002:a7b:c450:0:b0:3f7:367a:bd28 with SMTP id l16-20020a7bc450000000b003f7367abd28mr10053356wmi.4.1687248736480;
        Tue, 20 Jun 2023 01:12:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p25-20020a1c7419000000b003f8fac0ad4bsm1674906wmc.17.2023.06.20.01.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:12:16 -0700 (PDT)
Message-ID: <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
Date:   Tue, 20 Jun 2023 10:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620000349.2122191-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
> The binding expects the first register space to be VDEC_SYS. But on
> mt8183, which uses the stateless decoders, this space is used only for
> controlling clocks and resets, which are better described as separate
> clock-controller and reset-controller nodes.
> 
> In fact, in mt8173's devicetree there are already such separate
> clock-controller nodes, which cause duplicate addresses between the
> vdecsys node and the vcodec node. But for this SoC, since the stateful
> decoder code makes other uses of the VDEC_SYS register space, it's not
> straightforward to remove it.
> 
> In order to avoid the same address conflict to happen on mt8183,
> since the only current use of the VDEC_SYS register space in
> the driver is to read the status of a hardware controlled clock, remove
> the VDEC_SYS register space from the binding and describe an extra
> syscon that will be used to directly check the hardware status.
> 
> Also add reg-names to be able to tell that this new register schema is
> used, so the driver can keep backward compatibility.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> I dropped the tags from this commit since a syscon is now used instead
> of an extra clock.
> 
> Changes in v3:
> - Removed the active clock
> - Added a mediatek,vdecsys syscon property
> 
> Changes in v2:
> - Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
>   clock for mt8183) to avoid changing number of clocks twice
> - Added maxItems to reg-names
> - Constrained clocks for each compatible
> - Reordered properties for each compatible
> 
>  .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index 1e56ece44aee..2f625c50bbfe 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -21,8 +21,13 @@ properties:
>        - mediatek,mt8183-vcodec-dec
>  
>    reg:
> +    minItems: 11
>      maxItems: 12
>  
> +  reg-names:
> +    minItems: 11
> +    maxItems: 11

maxItems: 12

> +
>    interrupts:
>      maxItems: 1
>  
> @@ -60,6 +65,10 @@ properties:
>      description:
>        Describes point to scp.
>  
> +  mediatek,vdecsys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the vdecsys syscon node.
> +
>  required:
>    - compatible
>    - reg
> @@ -79,8 +88,26 @@ allOf:
>      then:
>        required:
>          - mediatek,scp
> +        - mediatek,vdecsys
>  
>        properties:
> +        reg:
> +          maxItems: 11
> +
> +        reg-names:
> +          items:
> +            - const: misc
> +            - const: ld
> +            - const: top
> +            - const: cm
> +            - const: ad
> +            - const: av
> +            - const: pp
> +            - const: hwd
> +            - const: hwq
> +            - const: hwb
> +            - const: hwg
> +
>          clocks:
>            minItems: 1
>            maxItems: 1
> @@ -101,6 +128,9 @@ allOf:
>          - mediatek,vpu
>  
>        properties:
> +        reg:
> +          minItems: 12


What about reg-names here? They should be also defined and in sync with
regs.

Best regards,
Krzysztof

