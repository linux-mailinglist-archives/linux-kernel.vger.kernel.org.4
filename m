Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26A06FB195
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 15:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjEHNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 09:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjEHNdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 09:33:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129162FA00
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 06:33:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-966287b0f72so356082266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683552819; x=1686144819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tYR6P7sJcX8oTnpRUorpFral+vjD58DTCG1fvb35J4=;
        b=K0Pl1X4E7bwAlAkGzbEs+5B6FpFXS/1au19R5NBCEt+BTR9L9vL+JJ7Q8We0MaeiTr
         AXp8Q5O+3Zagr9DINU7ZJFFCdazz8yoLhImXOoF9Vx2D1+N94hEg51ETviAh40lpcF1L
         MJozvy6Y+xYd1yipRQU/RYAo1QYxYnSKP+8Kt1B5y4ENseBtokBKir2yUNhkw4fYztA6
         FoHQfrGLmHTs5Ol78OcTG5YUkbzMZAsgQjESMWW8UY7dq8G0EZUVCSDd/SV7wJtKag/Z
         j6jfzQGt0hK8Jhj5yQIuIgSq7mEgazlur+m31ypVfX6K5FymykQGawkNSJJlvxzc7Kkn
         65+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683552819; x=1686144819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tYR6P7sJcX8oTnpRUorpFral+vjD58DTCG1fvb35J4=;
        b=cr7E/90CxYMqoa9dnAQiMPtmJp68nAbl1XoOaYpT3rQ+LocxwyaQA3pJ87ZmhDpjmU
         nPafkkXhIk6w9EUQUiwIF8OCH+ofgX0XxBfDWRjb55zZY3FZsMmWUMDclgxJAwYyi83g
         YER6TxG+fQm9BKfO+6eBLmL04x/5hK0YOpv4VinIDIWZfQWmJHYaOC7LkXjyvZJQBaUj
         whMXQPAdaNF/5e9aHgKBuFDn1D7piJYsawZlqoeazox0eZdCmuXVs025tgzTHCMpAEMf
         8QbhS2x063esLOjVbIrtCU7vRIsD7PsKSrcw8RWIdLOTeBSJsZNwAKL6zVvEChWDakvf
         +2+w==
X-Gm-Message-State: AC+VfDyq8qoPVQb5/l98Cw8gvVrRyA575ERIPmOTO0tCHv9MxQbZg9pg
        JUrs/P1XC1hf8euV+YZ4G1q7xw==
X-Google-Smtp-Source: ACHHUZ7P68NqwCqkZU5gLXoPHzHQvITJ1zWXVGW18yaw8iQMK7pibINZp1l+7h5Fqnn+2VayEQJxGw==
X-Received: by 2002:a17:906:fe04:b0:966:1984:9d21 with SMTP id wy4-20020a170906fe0400b0096619849d21mr5389819ejb.9.1683552819421;
        Mon, 08 May 2023 06:33:39 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id ht7-20020a170907608700b00968242f8c37sm848320ejc.50.2023.05.08.06.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:33:38 -0700 (PDT)
Date:   Mon, 8 May 2023 15:33:35 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, thara.gopinath@gmail.com,
        rafael@kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230508133335.rppr54ywbwwh7qth@krzk-bin>
References: <cover.1683523370.git.quic_varada@quicinc.com>
 <345a61f6cd56e504e1f82ac2328ffa6d89e2d510.1683523370.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <345a61f6cd56e504e1f82ac2328ffa6d89e2d510.1683523370.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 May 2023 11:02:38 +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> [v2]:
> 	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 	for the tip to make qcom,ipq8074-tsens as fallback.
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: [error] syntax error: expected <block end>, but found '-' (syntax)
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:69:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts'
Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: did not find expected key
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/thermal/qcom-tsens.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
./Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/thermal/qcom-tsens.yaml
./Documentation/devicetree/bindings/thermal/qcom-tsens.yaml:67:9: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml: ignoring, error parsing file
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Documentation/usb/gadget_uvc.rst: Documentation/userspace-api/media/v4l/pixfmt-packed.yuv.rst
MAINTAINERS: Documentation/devicetree/bindings/pwm/pwm-apple.yaml

See https://patchwork.ozlabs.org/patch/1778256

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
