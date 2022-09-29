Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E535C5EF131
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiI2JDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiI2JDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:03:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730DC13F732
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:03:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k10so1277327lfm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ekkQC7GJQ81cuqn7yaJIyO9eK5D2lUXQODNhfljx0EI=;
        b=fNxGAx0KYpQEIJjdm4n8d4KHSovl2yvg1lawgOmCH1yEP2bkcO4mlF7ZAmlB9iuvjR
         vktrPrjflKnBQx2vPEE3Zouv/G9Snpd2uOkiB4mwZRiQ3PNxQNRMETp8erbb/lzpbzn8
         Mo+Wwvhy/OhVJa1935pFBjfc7xgkR05fhPFD/nx5ddAQ1BVXYs86eA0JmcOyPzK2KIWa
         t1nxNtGUPbW7LhuVQYqi8xEYAlFUGGjYW71fTceDy5fFzrbTTpnS3L+26mDQOPrgQ0/q
         ovk9V4dvCqmB7d0CaJVVCEVjpdP/Jes6E2uX7uG5sRbNuc81A7jMFZC1JmCkOGb+4wz0
         Mgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ekkQC7GJQ81cuqn7yaJIyO9eK5D2lUXQODNhfljx0EI=;
        b=CX2REECiZ88Q2t3dM+k3c/JDJZSGfbQ3YTPJUFuf9BrFC8GOZHHzqloBJXbdqgeSq1
         vHEVoEoJHC4z4VTWzxG7CgWgj2qdMoktj8iiEii6gM1DpnNNapNFQhS8V83GSbCTtaRt
         vDculSoHAet2woqtiDAVl24tkpO3AHu4VgAtmlVtCdqbfpIwJ3W/qVuRlrADrjCQhcBG
         yReXlgjRtdvhpdOxvKjiTCIGDi+YVeYrVPKzNaoQyw7X5BxsVHhD6jglSXDNFd6f9l5f
         zOEQLIpVCjxYh3bgWSRaIjQ95xkG5pWLKStwwX4jouTApKUxPV2bHbtlLa3VMb2BaWpQ
         s1rQ==
X-Gm-Message-State: ACrzQf2/9FP2fgCv4dxssVFrl+n+XxFN6Ti9RZLEq+BWWFtk9JP1ZNVm
        PIMVIcRbxhUCS6A5vMo1s2RYn8qy40xW3Q==
X-Google-Smtp-Source: AMsMyM6sWJPWobcdhsezk/UkFUJMWSsPWVIRNRtarpZ/N/yPz1yP4zKWe6iDX0IS1NUHjrNfMQbVow==
X-Received: by 2002:ac2:508b:0:b0:4a0:5d6b:ff14 with SMTP id f11-20020ac2508b000000b004a05d6bff14mr897827lfm.409.1664442189815;
        Thu, 29 Sep 2022 02:03:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651c038800b0026c5ab1883dsm651010ljp.16.2022.09.29.02.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:03:09 -0700 (PDT)
Message-ID: <37c6c5f9-fbdd-3a44-15f7-e28915cbb7c0@linaro.org>
Date:   Thu, 29 Sep 2022 11:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220929014456.30077-1-allen.chen@ite.com.tw>
 <20220929014456.30077-2-allen.chen@ite.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220929014456.30077-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 03:44, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../devicetree/bindings/display/bridge/ite,it6505.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a..62b9f2192202 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,6 +52,14 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>  
> +  data-lanes:
> +    maxItems: 1
> +    description: restrict the dp output data-lanes with value of 1-4

Where is the definition of this property?

> +
> +  max-pixel-clock-khz:
> +    maxItems: 1
> +    description: restrict max pixel clock

This looks wrong. You do not use proper unit suffix
(https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml),
no vendor prefix, no type and weird maxItems like it was array. Is it
coming from any other schema?

Best regards,
Krzysztof

