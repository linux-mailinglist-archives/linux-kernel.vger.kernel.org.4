Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8CA6FA366
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjEHJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjEHJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:32:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993B4696
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:32:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso8191655a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538343; x=1686130343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaIOfIKT6cUzQnXA2pY8MBVw5AuuF4DUG96T6VN7SUU=;
        b=r8xKe2ueE6qpZ5q7fx2Jr8j9y8jdvbEl/dJ9MSBywzTaJGn2c/IQr9fhngQwzv+eK8
         3dKMmSF6g6nSseCp2P2WS3jBDXpqlFLuLSrkAk2YV+myVAs7Aqp/C43Spb3zAe+2Lbs5
         Wt8RhC2uDN5NrFDxdf6XL5LnzmSxdtpnNvX1jDwngbIY5QuvpurFg0dPfQh7q2v8r7mP
         tnlzEa9dQfEC9d6v+YdVnGvkRNA19kacCMnSAOKdGIxlmq9ZbzonSHap2R3pxlaEyAUN
         vBvZyBx30LY5A2TJmL4fkoSn57rXbp1tm4YmcYLRoSxpUO0YYG3HCpauLVXCXCoH9thZ
         J+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538343; x=1686130343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaIOfIKT6cUzQnXA2pY8MBVw5AuuF4DUG96T6VN7SUU=;
        b=b8cxL6lvApK7q6Wq0bjJLet22uuc33J8nMr3ctBB9AFXImhoVbliwaeVTU2bK9K+Jj
         mLvteoEjJjHNVXZcbmryVXssIsnUfLR4ppr9MBZwqB/1XMEJCbkg3SD+h1RgLD17wkel
         mm6fi67FPasOSuIiIldN8L6dx/zg7+nFY4UqNPZKmh7oOqFSrG09+HFn5QCT+Z7AoOG4
         0p9FUfg5LGJ5csIpvY+iOl/06ros4Jz6vBv5DLPlvX7dm16/vTHi17dHbfAKvbh1jGtv
         65Uxvg1MDL58A5ieJe8YSKGROi3dSz3uO3YkcDDKAfB8Oj6S3rfxUviq8IUQMidxZE6y
         yD6g==
X-Gm-Message-State: AC+VfDw1lAjXWJfU+UcROG1gGBgJRBXpGY3BC2k9vGjm9xFkMT28/uZp
        xzl7K6HCNwqptgwzHHots4yxng==
X-Google-Smtp-Source: ACHHUZ7wCYtUf+7LVo6j+oVxWM1xFUqc13NehBZU/lO5rS1cti0ZTm6SDm50E98ky0UvdHVluWukHQ==
X-Received: by 2002:a17:907:1b24:b0:94e:5c28:1c19 with SMTP id mp36-20020a1709071b2400b0094e5c281c19mr9319621ejc.5.1683538343137;
        Mon, 08 May 2023 02:32:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id hw6-20020a170907a0c600b0096602a5ab25sm3629254ejc.92.2023.05.08.02.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:32:22 -0700 (PDT)
Message-ID: <228ebc9d-f70f-3f12-381f-1ef6f24f2f28@linaro.org>
Date:   Mon, 8 May 2023 11:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781 amplifier
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Shenghao Ding <13916275206@139.com>
Cc:     Ryan_Chu@wistron.com, navada@ti.com, gentuser@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shenghao-ding@ti.com, Sam_Wu@wistron.com,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        x1077012@ti.com, broonie@kernel.org, kevin-lu@ti.com,
        perex@perex.cz, devicetree@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, peeyush@ti.com
References: <20230508054512.719-1-13916275206@139.com>
 <168352721271.213340.3578983696891383785.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168352721271.213340.3578983696891383785.robh@kernel.org>
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

On 08/05/2023 08:26, Rob Herring wrote:
> 
> On Mon, 08 May 2023 13:45:12 +0800, Shenghao Ding wrote:
>> Create tas2781.yaml for tas2781 driver.
>>
>> Signed-off-by: Shenghao Ding <13916275206@139.com>
>>
>> ---
>> Changes in v7:
>>  - Submit together with tas2781 codec driver code
>>  - Add more detail description for ti,audio-slots
>>  - Keep consistent for "I2C"
>>  - remove reset-gpios description
>>  - For reg, express as constraints instead
>>  - remove unnecessary '|'
>>  Changes to be committed:
>> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>> ---
>>  .../devicetree/bindings/sound/ti,tas2781.yaml | 90 +++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> doc reference errors (make refcheckdocs):
> Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
> MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml
> 

Ignore failures.

Best regards,
Krzysztof

