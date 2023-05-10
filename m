Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663DE6FD893
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjEJHvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjEJHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:51:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8920CD
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:51:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1215194866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683705063; x=1686297063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iW7mIjsbeTQgdo4bUMRJvZS21aehBrTgArVIcYbQGoM=;
        b=GXpSk4Fy8gpUVPJnIaKxcZC/u9hWbLTYWvWqlDbTyPJPbFs+Ye8DazCVFswRLh9//O
         XfcpfcIyIqT80xWgGEZ6CneWja769c72qEJQBaSr5UyzZzb0csNnQPoVr9A71nQOh+B/
         vuVOU782ZXln4eWYhEzuVrd5bwsvuPcPuIZVkdtjyRhuWlg7nK+F6CEr2mcZF1lzZ99t
         FUPHwWI+/AEwDvOtRq8dYsHFhRsBf8vUa9AuXYaeAP3s7iE087Xfc8/Kwdd9ecmIrqM5
         LiwAKP3bIQ37GPDupGZwYj83utKlxueZgHHgi3wF4szHq5zw5aI7WLcbmjc4Nat/oNlf
         0uMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705063; x=1686297063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iW7mIjsbeTQgdo4bUMRJvZS21aehBrTgArVIcYbQGoM=;
        b=SpthREGkwogRm9mHP7P92xxROT4mg0dUL6DRQE6MBSbdUEsbd8a9hkm2EAwU4PIIAN
         Q4OYap/9emAmNEwCou7I4Kxv1okqgZBAxoUJT0AuQs7BJWOc+jnS/RQ3u1EKMW/ng/Hk
         yRQFfvMuKuYbUvdXDNuE65uclkgIyBMtdKyYruHEWDDLvEUOxaI3o8OGGVZ7+vDsqo5V
         OyrRz5KQk0WnkYKOWwgnWadgKNqStd1wEss3Af8smEC5pruZZDCoKFe3dNefJu9WA2oL
         kJBJa8I+RDBGbSOS4iXwUpZqX4omQ9gN7YTK9kSeBg3l3gJ+D3x4cKoAPr+i8+oY3czz
         +35A==
X-Gm-Message-State: AC+VfDxcapUYoejAnfUFPC640LazJHES8sD9ibSeRYcqseaHG5Yb0jQC
        rvuiV4SfzQT6p/yvCEx4Va6TkA==
X-Google-Smtp-Source: ACHHUZ7nbBgYEcv+qxcIJPx7vRKcuVTcXzNbXan5YR4QkBuj6NlqgkqEsNt58tGSuzwTXu6/V9z9Qg==
X-Received: by 2002:a17:907:2d9f:b0:969:e55f:cca2 with SMTP id gt31-20020a1709072d9f00b00969e55fcca2mr5883240ejc.38.1683705063246;
        Wed, 10 May 2023 00:51:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id gv28-20020a1709072bdc00b00965cfc209d5sm2353400ejc.8.2023.05.10.00.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:51:02 -0700 (PDT)
Message-ID: <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
Date:   Wed, 10 May 2023 09:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509163828.86003-1-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509163828.86003-1-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 18:38, Martin Povišer wrote:
> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
> mono amplifier with digital input.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>


> +  reg:
> +    maxItems: 1
> +
> +  adi,ana-gain:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    description: |
> +      The value to be set in the ANA_GAIN register field on the codec. This determines
> +      the full voltage span of the codec's analog output.
> +
> +      To quote the datasheet on the available options:
> +
> +        00: 8.4 V Full-Scale Gain Mapping
> +        01: 12.6 V Full-Scale Gain Mapping
> +        10: 14 V Full-Scale Gain Mapping
> +        11: 15 V Full-Scale Gain Mapping
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,ana-gain
> +
> +additionalProperties: true

uinevaluatedProperties: false instead, so users can have name-prefix.

Best regards,
Krzysztof

