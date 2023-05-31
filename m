Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5DF7177AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjEaHS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjEaHSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:18:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F91125
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:18:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-973e7c35eddso586234666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685517498; x=1688109498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fFyLFhsggW8A8YrdnWJOLOkpBJdZswSLetiahcSr+o=;
        b=nq5BILXY39XcNsBRsD2kWVG5orno9JOxYhk4t+GDnNTRUVCPzXs8ooW5khrP5OTSfy
         8eCpk5H3JQM+Unpj0y2Ptw9lFeFhzGjkZ3dTF4s7JGwJQIuOoggO4NBNVkQ/GfhJRxqp
         jm+IUQ+XTpSc9ntDj6Rsh7e2r5mcMP4Y69CmHc9oIEjt2I99eF0pwQPjfgD6RbRx2LFL
         6zTv7baCYCzXhab6ZJEpUD5ooUyXewlHlZAGNiK+f+2z9+IMSXF2+xJWv2JLp6asjncw
         OaWcvCsa83CoSA3GtlLWO3rm2gKc5IGAz6nmvEt9LebW8PIfHrIA+iw+dNCWe++UJ5rt
         cFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517498; x=1688109498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fFyLFhsggW8A8YrdnWJOLOkpBJdZswSLetiahcSr+o=;
        b=UoPf8My52jRBEdmAO7u0/f74Pk8CBkN+o10A6urbcPuIUSeE5d97t6+P70Yt4Zb2qK
         bb/kTYgbYwL5p97sz0JMnnXttAEs9da5Y9Kx88nyex410S/uVqhxR+CKRw/a0f5/7bJ6
         +pRI5rIv4gq/+plIt3UdFyR/vrYVY2DimbmvamOQie6mNMXP2/Y19krgXLp4YIneGLXg
         +7+2i8Qytfh7F/X0Sd5jTKs+oLvziG4gAL1qLBsJcl+meSk9CI40yJALAPL77B4bXnAT
         i206q3J0wbd1FzUz2RFUmY+784lSkEppV1/pwR/zeNNNK66Ec/OfxfvHSgazBb+6Og6e
         gb3g==
X-Gm-Message-State: AC+VfDzXhjV03DnnkuTXz9H9Af8rjnQHJ9KyuwU17kebtLil/n5BUlH6
        IAe4afARON9y7pREB1bFDgK8nQ==
X-Google-Smtp-Source: ACHHUZ45JXthOqFQmjKUFzygujKR44SA7fO7b6Z6A+/RQ0o3szCpXKFF3BbHPhOInNc6o5VRNCBlGA==
X-Received: by 2002:a17:907:3e28:b0:96a:3811:f589 with SMTP id hp40-20020a1709073e2800b0096a3811f589mr5536703ejc.10.1685517497980;
        Wed, 31 May 2023 00:18:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7db94000000b00502689a06b2sm5203661edt.91.2023.05.31.00.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:18:17 -0700 (PDT)
Message-ID: <fb3de5a5-4477-ec8d-eb2c-e00813f078a0@linaro.org>
Date:   Wed, 31 May 2023 09:18:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: cdns,macb: Add
 rx-watermark property
Content-Language: en-US
To:     Pranavi Somisetty <pranavi.somisetty@amd.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     git@amd.com, michal.simek@amd.com, harini.katakam@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230530095138.1302-1-pranavi.somisetty@amd.com>
 <20230530095138.1302-2-pranavi.somisetty@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530095138.1302-2-pranavi.somisetty@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 11:51, Pranavi Somisetty wrote:
> watermark value is the minimum amount of packet data
> required to activate the forwarding process. The watermark
> implementation and maximum size is dependent on the device
> where Cadence MACB/GEM is used.
> 
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
> Changes v2:
> None (patch added in v2)
> 
> Changes v3:
> 1. Fixed DT schema error: "scalar properties shouldn't have array keywords".
> 2. Modified description of rx-watermark to include units of the watermark value.
> 3. Modified the DT property name corresponding to rx_watermark in
> pbuf_rxcutthru to "cdns,rx-watermark".
> 4. Modified commit description to remove references to Xilinx platforms,
> since the changes aren't platform specific.
> --- 
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index bef5e0f895be..2c733c061dce 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -109,6 +109,14 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  cdns,rx-watermark:
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +    description:
> +      Set watermark value for pbuf_rxcutthru reg and enable
> +      rx partial store and forward. Watermark value here
> +      corresponds to number of SRAM locations. The width of SRAM is
> +      system dependent and can be 4,8 or 16 bytes.

You described device programming model - registers - not the actual
hardware.

Best regards,
Krzysztof

