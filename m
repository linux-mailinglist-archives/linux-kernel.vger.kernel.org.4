Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C9F6FBF14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjEIGOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbjEIGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:14:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54093E6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:14:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965c3f9af2aso782236366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683612879; x=1686204879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGhf5+4AZLSx/aWkdnknlgjdTW0b2P9oXzfs5UXvz7k=;
        b=A3mbAw8ZEklFQGCEPeYe/NzI/Q3R4oVy8L2/Cq21L/IDlkT58DFOaqWQwp4Ld3Jiz/
         7FqmvITuFUjKIzTGhMRROM0OsDYf6jJPL4D7Qy193SSqtG5nd9hKUHbRu2oap62UioYv
         wkTFyGgQ5VXpWDl1twOPddgt1Wo7IvqyhDlraUZLKVDfaEvsz086FOPpp5vlz2IuTvV5
         RzC9Pv/2dkeZDYr7wvyWkBMIUkmaHRJYqu1v2EAlnHt4pO/PZoIjgXiC+g9nVWvOGDne
         9KBRMNndPLQzRWB/vnADOIMwWERPLDiW7sGhmXVwmRy6QqME+bLPxy+bkrftsoF4tOzi
         LrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683612879; x=1686204879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGhf5+4AZLSx/aWkdnknlgjdTW0b2P9oXzfs5UXvz7k=;
        b=b6+7kKTO3p0cgC48w27nMBRizjFSceWzOPyQCdMzumQyk4MR4fA3RGtazHWYVzMZb5
         9oPBDED39J2IcUd/bGKUy4qhnXYBsXaW83A8Bzyye8ftdavQTnf5AbjuVUPqrM19Qrti
         EqkgWxljYbSdiDdUBQWT3IrPM1ocnVQQBcaEHUU4b7FLml/rlGajt18d2T7h3zqNjfsj
         OQn+2jwBgqqHmOTezZ17G17l7dvxOLKu+wmAjVI7bQnIgeBoy2/JfYpi/8UhWg3Jre5b
         4J3aR6Ti/CnNB/Bv5I2DpIoMQFbDfX2sDrjns3xuJPvGMbnN29AI85jvDPI77kHOMg+o
         hoOQ==
X-Gm-Message-State: AC+VfDz0OnRiuWdVHawiZkgzYk5hdrWLct0l0NWH1AIVdgoWA5uDewvx
        R/7Uz+nYCo2ddS1YO7N2WIHsxjtopb9QYYasGXI=
X-Google-Smtp-Source: ACHHUZ4PzzYa6MUnO2P5nVTMxLeLhTrh/2WhQqar05N3QXEDNn0G3uR/Kj+VXuvHY19KuV+oclAjlA==
X-Received: by 2002:a17:907:97d0:b0:969:7739:2eb7 with SMTP id js16-20020a17090797d000b0096977392eb7mr3182670ejc.4.1683612879542;
        Mon, 08 May 2023 23:14:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm911043ejc.17.2023.05.08.23.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:14:39 -0700 (PDT)
Message-ID: <cd5869e0-561a-0716-2deb-8a32acd03630@linaro.org>
Date:   Tue, 9 May 2023 08:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: Add Google Chameleon v3 i2s
 device
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dinguyen@kernel.org, broonie@kernel.org, lars@metafoo.de,
        nuno.sa@analog.com, lgirdwood@gmail.com, tiwai@suse.com,
        upstream@semihalf.com, alsa-devel@alsa-project.org, perex@perex.cz,
        amstan@chromium.org
References: <20230508113037.137627-1-pan@semihalf.com>
 <20230508113037.137627-4-pan@semihalf.com>
 <168354885743.927427.9242565928327424252.robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <168354885743.927427.9242565928327424252.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 14:27, Rob Herring wrote:
> 
> On Mon, 08 May 2023 13:30:33 +0200, Paweł Anikiel wrote:
>> Add binding for google,chv3-i2s device.
>>
>> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
>> ---
>>  .../bindings/sound/google,chv3-i2s.yaml       | 44 +++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.example.dtb: camera-sensor@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> 
> doc reference errors (make refcheckdocs):
> Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
> MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

These errors can be ignored.

Best regards,
Krzysztof

