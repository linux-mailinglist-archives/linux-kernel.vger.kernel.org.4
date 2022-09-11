Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009F5B4EEA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIKNAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiIKNAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:00:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887C31A399;
        Sun, 11 Sep 2022 06:00:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y17so9292724ejo.6;
        Sun, 11 Sep 2022 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=q8BgBAq6R66RZmtqSB2pMZVXrnTRpKYBq/eFoUsEnCY=;
        b=Izv/0jcT+2WAzRa4W1dDVrJ4tGpb0xmg156R2bmbW+pSnV9JXZDFYImrWH0MAJP0bh
         Bs8cU7Gur9N4xxGY3afuDXil7432AxBUTQuPk6rGz2AteaKx/Ldgogg/LFvd/wFIvLy5
         Ala9256QfSrj1lGwCMIFsSiNFYA5aaGoybjixPGghpZHKcx7qgvFgtT9siezJ0KigWlL
         Znicm/QuuIeDUp/RlHpuczbqOTEWyph6PhardzQql0axWk/1JsoX36vmOCYxDGJCeUao
         mqjbHFBz5Fgribv+tt411jLA0Paq6/8RQ+F/UzSaEQ0nb2mqGYbTot3m4JwdG7UQEgZV
         j/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=q8BgBAq6R66RZmtqSB2pMZVXrnTRpKYBq/eFoUsEnCY=;
        b=Rz402LHJanD2JuPX+3D5SrEW364TenLrCJB9n0eI3AccvqHUmzoWteOV/y4fabumjl
         85PwCunTWDclRQwprdvInW6GuDE2TgBlKq05OMFTd2/asv8Lc1IuSFeTS+BfVd4QJF3T
         PnsVgbLK23zVi5UniaQ/XlUbPbig98maur1/bF5IOrwrL0t8qReHgD5/cBbKaBB2Ol3q
         DuOfv/X3OW2xsaC63pChN0RcdG3Jn8zuMCVF6CuW2+D+U1gqeBMiI9ZJcncQWeBW+pjC
         MfTpL5f8qAmssQdozZR9LcyQcQMjkMduZ6BxNvwRJgM3OglfziIUrkk/YPBm5VVwkdwa
         McGA==
X-Gm-Message-State: ACgBeo1a7Yuke865LX2iZvGLGrTewRPoj+a7ecyTDw2d6qg7etl725eq
        38S7IX5+Mjk/0vPuaU84wSA=
X-Google-Smtp-Source: AA6agR5u7Lmevon3OENo/h2XX2qKJshmFrPYb5eSDOHpxvcWNL9No7qUM6LPwO4o0sR65ElRg9yAKg==
X-Received: by 2002:a17:907:a4c:b0:77b:ba98:d3e with SMTP id be12-20020a1709070a4c00b0077bba980d3emr3671229ejc.13.1662901233873;
        Sun, 11 Sep 2022 06:00:33 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id la21-20020a170907781500b00767297e3fbasm2950886ejc.52.2022.09.11.06.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:00:33 -0700 (PDT)
Message-ID: <63d0a64d-a31d-6128-2b47-f19a3e937ad1@gmail.com>
Date:   Sun, 11 Sep 2022 16:00:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 02/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix
 matching SD card pins
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
 <20220911111200.199182-3-krzysztof.kozlowski@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <20220911111200.199182-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/22 14:11, Krzysztof Kozlowski wrote:
> SD card pins do not have function, so do not require it:
> 
>   pinctrl@500000: sdc2-off-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'bias-disable;' is a required property
>     'clk-pins' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

> ---
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml         | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> index 8a2b4767c7b6..28b29bf714b4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> @@ -69,7 +69,6 @@ patternProperties:
>      description:
>        Pinctrl node's client devices use subnodes for desired pin configuration.
>        Client device subnodes use below standard properties.
> -    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
>  
>      properties:
>        pins:
> @@ -121,6 +120,16 @@ patternProperties:
>      required:
>        - pins
>  
> +    allOf:
> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +      - if:
> +          properties:
> +            pins:
> +              pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-2])$"
> +        then:
> +          required:
> +            - function
> +
>      additionalProperties: false
>  
>  allOf:
