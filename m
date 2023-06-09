Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEA729F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbjFIPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbjFIPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:50:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C43595
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:50:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f624daccd1so2412839e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686325808; x=1688917808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BijuZvJUEsuf/Cg4yfk0GyP/R5pIudpCPz7skO5PerE=;
        b=UM8cFweDKaMe3MuTcUkIOqGtI3Ge5dzxKJ49IAfxddOelilsaLCMEAczouIyLi6md8
         WoQlN4C8Nuu2MYIX2Cfp3Q8ePqdDWjiDWxbFBb3OISI3W8W31nMyNMTHlZEfiV9ks/sK
         MTj1Gr1kp8rsQsjZkp31G+bIUPiNUrMfwyJ6ZmyT9q2eqdDSP/fcSCsc4FQEEOV1sSFn
         jDzgFXN7Vjxk3o9vwpgONKseq5rKUcGe6skoSQF+LgoeT0syTQI3Kiqs6Wrr0iA2zkpz
         4ycKYR12pExd0vcn/Bz8YN49+SoIBh0PxOfrUJqiYST5qOzXCjQo0KynH2QMvV0o+oIZ
         VjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686325808; x=1688917808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BijuZvJUEsuf/Cg4yfk0GyP/R5pIudpCPz7skO5PerE=;
        b=cpELeUVunZuSZ2rK902OtUFslFIFU3I35ax/Yks0pZADsTk+oPashn9ssDejmDUmlt
         21R4sD9jh5p0auh9Bci6M2UOYcWLEyX9EcM2b1chqdTAIv2vzTvy71JK79CM/jCGJJLQ
         NBM4XDACXHEAcgVltGw3yguOREHjmX+F0K+BmSJEO8p8BKFCdhhgY2tydTdWbcibmdG4
         R+ZudQe+WPBFoHOwhFdoBQwSUqrYWVaJD2CXP8r7vaEZCTKEv0OnRDfm8tMnTHlJgMP+
         ENEjNWnZoolCdM98KqUAYpx0ybP/MCHl4JxsphoD6aHfv+dptYQrcXp84zP4PRm33BVo
         vLVA==
X-Gm-Message-State: AC+VfDy6omrVrSjMJpxBIEHryt0QfSLGGc1OaVT+CU5tjTg3cAxT6M19
        WnPk3OSvq5Z7j2WD7H3aTxD+7A==
X-Google-Smtp-Source: ACHHUZ4e9XMm/GKycxJwMywcYJfZLJMjMgJDpM8cPra6TjyORXKKqQObU/yEQzv8jcmjpVA4ysA3ZA==
X-Received: by 2002:a2e:780a:0:b0:2b1:bb66:7b69 with SMTP id t10-20020a2e780a000000b002b1bb667b69mr1345138ljc.32.1686325808325;
        Fri, 09 Jun 2023 08:50:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906379800b0096a6bf89259sm1432416ejc.167.2023.06.09.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:50:07 -0700 (PDT)
Message-ID: <77dce4ec-89aa-8802-b169-744f6c11b177@linaro.org>
Date:   Fri, 9 Jun 2023 17:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
Content-Language: en-US
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
 <20230608130147.2835818-2-yangcong5@huaqin.corp-partner.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608130147.2835818-2-yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 15:01, Cong Yang wrote:
> The ili9882t touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that ili9882t needs to use
> vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> and touchscreens to power on/off together, let's add a phandle for this.
> 
> [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org
> 
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/ilitek,ili9882t.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> 
> diff --git a/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> new file mode 100644
> index 000000000000..89584264d6a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ilitek,ili9882t.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ili9882t touchscreen controller
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>

This usually should not be subsystem maintainer.

> +
> +description:
> +  Supports the Ilitek ili9882t touchscreen controller.
> +  This touchscreen controller uses the i2c-hid protocol with a reset GPIO.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: ilitek,ili9882t
> +
> +  reg:
> +    const: 0x41
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  panel: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reset GPIO.
> +
> +

Just one blank line.

> +  vccio-supply:
> +    description: The 1.8V supply to the touchscreen.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vccio-supply
> +
> +additionalProperties: false

Why do you disallow all properties from toouchscreen.yaml? Aren't they
applicable?



Best regards,
Krzysztof

