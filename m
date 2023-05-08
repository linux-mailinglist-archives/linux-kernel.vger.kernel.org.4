Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478066FA5D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjEHKNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbjEHKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:13:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11BF2268F
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 03:13:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso8422436a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683540789; x=1686132789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0bUYgyAW1KcUEIp+/BaoIIH2SkuwFbOX5OEnZzGpPE=;
        b=mlqB56kZjsCn/nd0n2xeick6726d7EajL2c9cuU6J3RmpBzhv6x/mKdP9XPTOs8z/p
         QcPPbPrsWes8d4wV6/gQewZ1uiJ8GrJre+Yxk7MmaRCIP9urvZzlv2+lI7ngI6piFyMd
         YJ55D811ZkXqjOOJ51EnS7r5wpz4rC20gM7eKKoHFJ3mKDC10fzJ2ruWyJ0ad6r/8YFr
         TEa6iAh/Qw8DgozOLQ1okF3kwAUW8xZtaq9CbDhJdDOt68StTAF8RzsVVvyQ6C0DA89h
         djsYnJA4o4zue+UYNA4VbGawrPqug0t4lNbUahkkd/lNZ4wqDJ1uejqr/eav1nqOaAn1
         xi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683540789; x=1686132789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0bUYgyAW1KcUEIp+/BaoIIH2SkuwFbOX5OEnZzGpPE=;
        b=HVs+AzZNODooB0Gn4Ze6+/S0QsajeG+2zgaX3peaQYG7gyWXVWc/jlwpxDG++id+/F
         5Fuiy9BzdqifGL8b0kO7KOzZwpdpDVO8Y/eeCgW48eLOJugaU1/lqepR3w/S9vcfHy2s
         CTynh9VnHtRYiUE9FdrKDU+M1LyfRtjqPn6qFtoRjo5aSgC/i8txxy4mpE6RzpHZxZ1C
         Nh5a0Q746Pliwa4Emsbld+pk83GvU7f4O/FnL9c5Mki2H2lTjInAjqAAjJN2H5cYT1Hg
         ly8mCs5A5kucm6x8tmwynDKdG/t8Bx7F/Vzh9Irw8vZ7dHd54W2E1wG7CNXInB/U9aDv
         kWBw==
X-Gm-Message-State: AC+VfDxYi24VCSo97tNcwM8BMm2pLPHBe1AKHf+UlyW+aFGLLBZAzLIx
        jhRcwljiUUkv8Ma2oAfDmVCl9Q==
X-Google-Smtp-Source: ACHHUZ5YD8AO6D9gf6AVXaZ+auVXI1PmMz3JgEkIwD5kyBnDCgai4MzAUre+IQ+TWEOyKWpi3eJ1hQ==
X-Received: by 2002:aa7:c546:0:b0:4fc:709f:7abd with SMTP id s6-20020aa7c546000000b004fc709f7abdmr7478054edr.2.1683540789040;
        Mon, 08 May 2023 03:13:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id o7-20020a056402038700b0050bc41352d9sm5910606edv.46.2023.05.08.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 03:13:07 -0700 (PDT)
Message-ID: <0b31922c-ef01-12a6-5f07-9d48f6f4bf5e@linaro.org>
Date:   Mon, 8 May 2023 12:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add BOE
 EV121WXM-N10-1850 panel
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Liu Ying <victor.liu@nxp.com>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, daniel@ffwll.ch,
        sam@ravnborg.org, devicetree@vger.kernel.org, airlied@gmail.com,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com
References: <20230508083826.1016206-1-victor.liu@nxp.com>
 <20230508083826.1016206-2-victor.liu@nxp.com>
 <168353803230.575435.10408042054525345719.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168353803230.575435.10408042054525345719.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 11:27, Rob Herring wrote:
> 
> On Mon, 08 May 2023 16:38:25 +0800, Liu Ying wrote:
>> Add BOE EV121WXM-N10-1850 12.1" WXGA (1280x800) TFT LCD panel
>> compatible string.  The panel has a LVDS display interface.
>>
>> The panel's product specification can be found at:
>> http://www.onetech.com.tw/files/EV121WXM-N10-1850ProductSpecification_20180801.pdf
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>> ---
>> v1->v2:
>> * Add Krzysztof's A-b tag.
>>
>>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

Warnings are unrelated, can be ignored.

Best regards,
Krzysztof

