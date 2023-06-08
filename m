Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26787727B83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbjFHJeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbjFHJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:33:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F542736
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:33:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so555623a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686216831; x=1688808831;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHrWR78MCn7GOVO6jP+VpXAA4JR1qkGlYZ5kPs6LqkE=;
        b=mc9adXQtN6XersVDRhnlail8T5GQnruABpjREJFga4locj60fiGQc3DEbqU5rE+wM+
         IVIRmVKEaZcE4Qy9s6zN5jyiM9QHKBST+8n1uIFdlmXdHCsph6CS4JwZa2QvxkCwPDYl
         bgtCgFQr+DKjuEqmvhtdkzII9qvgdRM6Wlrxs4j4/Td7UTrfzQBbkrAghZH2zKTVKqPL
         e7UBB+XDwWHcqsGVNv+uuTGhzlK09irLgNNfQG3gdsSs+cPGMH9MIhio02yScsNjZVWw
         2eKHG9bnllb38SZ8PzHa8aMw5MKsP9G69/UdaO3HxfnpoWHAxItZy1qIiFx2AU71TI3f
         Xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216831; x=1688808831;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHrWR78MCn7GOVO6jP+VpXAA4JR1qkGlYZ5kPs6LqkE=;
        b=MKeaHVvEC2sjK5oPCBer/NXhJy/qmEaV0rWqUhZiQgBOPLfOmGQAOg2Xx+wcwYGhdl
         m80YQmY3PJaHaUTKGD+4s9t5GZ6CAoJF/dzlgSmpMNTpkRTzwnfOX8f9PX+50ADcZM2C
         pYb8Kzxq2bPLznbrJ5Cr7bQmYQlJzzGRFhFHDDLgoVhlV9AP/Z4q8izBXDkcC+72SG7s
         vncL6sh8r7H/sOwjmofeHD72FkFUkF6Z51+ow9Ao5Tq+cWTcRxsohQW3N90iQDSN/n7W
         B/gWhJESQqzPF+3x5AX8fSWqgQu5qcYGHJXjVIY7vUk+HTFbR/x6BEI658jGuTirr2l/
         9cVw==
X-Gm-Message-State: AC+VfDyK3o+dWvmQhqBweYJjKyyDtbA6m8pVJeNr0eywIfE/3vKi1Si2
        UvitW94qVciRyqAHvDkN5FHGvw==
X-Google-Smtp-Source: ACHHUZ5P3vA07L3KTs1RTP07AuvxF1iv5HiPlvFkqBvOQIBmIKUDz+s/jbEEE098Oeua68HrGDx7TQ==
X-Received: by 2002:a17:907:6d05:b0:966:54ac:17d7 with SMTP id sa5-20020a1709076d0500b0096654ac17d7mr9357802ejc.76.1686216830865;
        Thu, 08 Jun 2023 02:33:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b0094e7d196aa4sm443537ejb.160.2023.06.08.02.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:33:50 -0700 (PDT)
Message-ID: <e4cc5966-0af9-80cc-c01f-b33620717a1e@linaro.org>
Date:   Thu, 8 Jun 2023 11:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,wsa8840: Add WSA884x family
 of speakers
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608085023.141745-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608085023.141745-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:50, Krzysztof Kozlowski wrote:
> Add binding for WSA8840/WSA8845/WSA8845H smart speaker amplifiers used
> in Qualcomm QRD8550 board with SM8550 SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa8840.yaml          | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> new file mode 100644
> index 000000000000..a999f787aa4d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wsa8840.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm WSA8840/WSA8845/WSA8845H smart speaker amplifier
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description:
> +  WSA884X is a family of Qualcomm Aqstic smart speaker amplifiers using
> +  SoundWire digital audio interface.
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sdw10217020400

There is a mistake here - should be version 2, so "sdw20217020400". I
will send a v2 a bit later.

Best regards,
Krzysztof

