Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D372DC99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbjFMIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjFMIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:36:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64DE1BC9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:36:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-977e0fbd742so771302766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645395; x=1689237395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rV8ssDQGynZC36t/0HgyiA06amNZ3IQmsZzAzsNY8U=;
        b=y4CDzclIQZShatWDsU4g3lX8SH6bhNFHPgveih8ze7Kc9XmzuzDL+ivOWMe2eRYY4n
         SHynu8bdnfsmsbFlk4+XCv5Wpbg9kKHzPiT/1j1d4MGxedsAFbxwRaZsJzsTkg7qWRvf
         zEt9kuTsIr8II9NnplGrk2BhQpS08Pi/MuQ+wFZAzZm6ivTIL4xsFCX+I9xF+Pv1iXm6
         CRhSQWqsAtktRmbIBe55zz+xSOqqywiySXJ4d7NNX2hbcQS3lut+iQYUrUyhjCwCa6xL
         C7LzI/Fh3kXECrU/hTkW0CUPk78AkZG2g7wJoWN/rKYqPl3Mg6RE36gwKU4JTRY9N0Il
         dHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645395; x=1689237395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rV8ssDQGynZC36t/0HgyiA06amNZ3IQmsZzAzsNY8U=;
        b=G22SpW0E9pjvrQbXnm5VKytTDWKqGkL4xPFhrMS0LdClrReEpuECFJ96mrzMctk+Dv
         eKP84GhlJEbn10pNcS1tD6utRy0okVx6QA9Us1xiDk0hoFueb6sFq/sQhDdvqvwCUhw8
         lISou+Hc75pI9a3jeXoKJuNeWOZGeq6BrHFzmADOPbLE7iZ/Rx7ooZc2DZlO/c86H3Z4
         mFfLhTRUTA/zt64J0ILfpsYiZnftIbOBOfkEFI5TrkFmYWAmKdmJrJm9rnXFJPY5J4E5
         vLY+kIxsgxJSm1mQYTzBCq3k+Vmz9swqK1EeYpFszZ6FnGzueEl1X5ilVFpruG38q4jb
         TYgg==
X-Gm-Message-State: AC+VfDxU5DDCK9SZjiuq443MX3clEhDCdlbg0GTGxrRVMpQBF29cCOtr
        eFKgpysoiAMmqABkWkGIwTRT3eLlGNekf3fa3aM=
X-Google-Smtp-Source: ACHHUZ5/yWvyHNJu5kdJjggeTbrrp8iqM6D5sLzGgr3NFThPesILUShQHdYNem5UzxF8lccohUMkDw==
X-Received: by 2002:a17:907:25c4:b0:969:9fd0:7ce7 with SMTP id ae4-20020a17090725c400b009699fd07ce7mr10932258ejc.11.1686645395135;
        Tue, 13 Jun 2023 01:36:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gv19-20020a170906f11300b0097812e2b66csm6305158ejb.111.2023.06.13.01.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:36:34 -0700 (PDT)
Message-ID: <4f1c934c-5a68-a2cd-10d1-568d61865755@linaro.org>
Date:   Tue, 13 Jun 2023 10:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson audio
 card
Content-Language: en-US
To:     YingKun Meng <mengyingkun@loongson.cn>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
References: <20230612090058.3039546-1-mengyingkun@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612090058.3039546-1-mengyingkun@loongson.cn>
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

On 12/06/2023 11:00, YingKun Meng wrote:
> From: Yingkun Meng <mengyingkun@loongson.cn>
> 
> The audio card uses loongson I2S controller present in
> 7axxx/2kxxx chips to transfer audio data.
> 
> On loongson platform, the chip has only one I2S controller.
> 
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>
> ---
>  .../sound/loongson,ls-audio-card.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
> new file mode 100644
> index 000000000000..61e8babed402
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/loongson,ls-audio-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson 7axxx/2kxxx ASoC audio sound card driver
> +
> +maintainers:
> +  - Yingkun Meng <mengyingkun@loongson.cn>
> +
> +description:
> +  The binding describes the sound card present in loongson
> +  7axxx/2kxxx platform. The sound card is an ASoC component
> +  which uses Loongson I2S controller to transfer the audio data.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls-audio-card

Generic compatible does not allow you to add any quirks or differences
if one board is a bit different.



Best regards,
Krzysztof

