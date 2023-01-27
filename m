Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1E67DF64
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjA0Ilo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjA0Ilm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:41:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35102CC76
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:41:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k16so2906428wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxnWhrFnVg9VP58IS7ZKzQX3VM2IYjNuKWEuyc1Z10U=;
        b=NQCHspnEctpCE8vljAUa6h3ikw9CPSk1fOcWf9iseJERN2npBiZFIcBJiwlDVQhshA
         s3nOMsVhQJvYM6NgHdqjwftcEEUFrjLMXCRSsSWNxPKV41UH3WYxJQM+3ikN1HQuCcEH
         s9vyRfIQjEL/21h/cAsthPAHg0YWwvtoKN6JQ5B5xKnvVl1mrcuvs33yWEZOcW0F/tUz
         Xj0AQtW6tdq7c/+DE0acUuCH3Oc70HlTPAl4NM1PQu+tEmznQBz4NziJnHAye9iScLq9
         uk4krR9dj6hACvGmgFLDnErk4C8yHOBKV5ZmdKG+te9ZjurwjPVODYLRs0R5OsQD9Doe
         +0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxnWhrFnVg9VP58IS7ZKzQX3VM2IYjNuKWEuyc1Z10U=;
        b=2nlZraoNuVCMmF7vaMqUC4CuwNiTkbObT79PMsiIY5FYqt+WByi8JLVKuTco5EbAEK
         NBMti8K9qJgVhgJttCkGLnaOE7F3zgcuB/uDjIRnm/vuTAnpTn1/SoYw9QnwniBIjCP5
         CW/eBJm0vTfYZWW8xnm5apPFmD8mZmeGdzEhii/Zfde+X7cfyNd7OD4RGkM6MpKYRrfY
         jtpS9V86JL9gsyarfEih5X6uKXGUk2GfcDBcunAwRfQMyns92gp3eD65mJEYC1X/llAz
         rKeexGZkUg1tvaVYi1FlIwuwCGobyFUw7aj5ETRjOOBrfggwJDwjEtifoOFHVlwc4Bjm
         h1xw==
X-Gm-Message-State: AFqh2ko8EnTvvH9mwTRQH5AutwVNl1SF1gBGpFqNzvNjCIRlZ+1Ru6wY
        lHvZmfXwtXBpcCoRurphHCwPhA==
X-Google-Smtp-Source: AMrXdXvTpwGNtr6wPm4vSPwSZLub/71exUFMnbCUGJxPEgkSu5kw1bcyisR+Dnx1LOm6LZ1OCZeeAQ==
X-Received: by 2002:a05:600c:b90:b0:3d8:e0d3:ee24 with SMTP id fl16-20020a05600c0b9000b003d8e0d3ee24mr39376985wmb.37.1674808900181;
        Fri, 27 Jan 2023 00:41:40 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l4-20020a7bc444000000b003db03725e86sm3662743wmi.8.2023.01.27.00.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:41:39 -0800 (PST)
Message-ID: <492fd43c-ca32-17f0-dcdd-48eee0e7e035@linaro.org>
Date:   Fri, 27 Jan 2023 09:41:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: tfp410: Add tfp410
 i2c example
Content-Language: en-US
To:     Jonathan Cormier <jcormier@criticallink.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>
References: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
 <20230125-tfp410_i2c-v2-1-bf22f4dcbcea@criticallink.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125-tfp410_i2c-v2-1-bf22f4dcbcea@criticallink.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 23:40, Jonathan Cormier wrote:
> Add a i2c example with HDMI connector
> 
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> ---
>  .../bindings/display/bridge/ti,tfp410.yaml         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> index 4c5dd8ec2951..1f3d29259f22 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml
> @@ -116,4 +116,34 @@ examples:
>          };
>      };
>  
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tfp410_i2c: encoder@38 {
> +            compatible = "ti,tfp410";
> +            reg = <0x38>;

This differs only by two properties, I don't think it's beneficial to
add it.

Best regards,
Krzysztof

