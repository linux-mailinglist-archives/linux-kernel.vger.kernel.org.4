Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D996C95D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjCZOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCZOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:54:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8379E4EDB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:54:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er18so14637614edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679842466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcZ/Jo/w1kY/OWV2RcBdzgeDL9p88z4zNj+JBl78Nj4=;
        b=qd2CRSXmTujjDgP5tZvjjFpLzHx1FxgXu5j5DjB3SyrbszKx39fL1pPdiRnjVFnccd
         8DQ0QLRKqRBlaTJjlWICl+kdLpPjY/rECUBWD4FtGofG/zZJHmnp+VvG5PyzZiyH76vr
         TE/aCqq4a1nPaSE42BEt524QNHmdCTJKALdPiGxY3A5kQFDDKm0543JXhUPo2rXVqazc
         MrtyM7dPhq+OcMegRvfOcroeDB55TtZ7tNWMYG7rpqoRjNPNb6IkPDSuZSkke6QNksqZ
         mDUIiFBGA2I5CjdfL75cDHCceQdkaUFNDLsCvQSWHSj6zouCkV6pxLiV2FKh4wKRWBXp
         HudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679842466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcZ/Jo/w1kY/OWV2RcBdzgeDL9p88z4zNj+JBl78Nj4=;
        b=ezaXHWNSgWVzQmwJxYrgVNljtNY3ttCQwPQU5JHR2C/+O4zd0bHbWzgFi6a7Wy9QUl
         MpByuhbwynqDMebLmpClPlPiFE+CUIM8pjyOcb1iwoB/Qpn01UiAfgBA3fk8wHf70gbd
         0EL2WIUs4C3Jz0XebBP6I0pnQYQjz3BTgzcgAEh1DpVRBp5b10SV5S+LUNo5KT90/gfu
         q7bOZAGRar//5FZKWp8sdVnq1L11tbKThP9Pmj4noffS7jmioHe3jrbhtiQnbzeDiZKF
         7zNv0hNbjiQsNYYg7xvOENZQphuyN82rjT821D2CRlqDGNfpn5h0UVrMPPGB04ETx5PZ
         m15A==
X-Gm-Message-State: AAQBX9ecrJu+oQsI6V+8I5D6LhYslBRW6DmI4hdhhyU8AnS7EukIFj9E
        pRXANg4wNbS/1A7HyT5cNjl63Q==
X-Google-Smtp-Source: AKy350aZpHXZKjRE9pStsIfdL5aTVGZqwvchU8LoQ8H3Kq7MUuDueL22CgyG26hwbniR0BxUcGsyHA==
X-Received: by 2002:a17:906:2350:b0:8a9:e330:3a23 with SMTP id m16-20020a170906235000b008a9e3303a23mr8682173eja.26.1679842466027;
        Sun, 26 Mar 2023 07:54:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669? ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id be1-20020a1709070a4100b009447277c2aasm539566ejc.39.2023.03.26.07.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:54:25 -0700 (PDT)
Message-ID: <3871e958-79aa-2b4c-3300-270a2eb8f8e8@linaro.org>
Date:   Sun, 26 Mar 2023 16:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: mips: lantiq: Document Lantiq SoC dt
 bindings
Content-Language: en-US
To:     Aleksander Jan Bajkowski <olek2@wp.pl>, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326122942.870990-1-olek2@wp.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326122942.870990-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 14:29, Aleksander Jan Bajkowski wrote:
> Document the legacy Lantiq device tree bindings.

This suggests you are documenting existing compatibles, but I do not see
them at all. Confusing.

> Compatible strings for xRX100 (ar9) and newer SoCs

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

> should be renamed and will be added later.

Subject: drop second/last, redundant "dt bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  .../devicetree/bindings/mips/lantiq/soc.yaml  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/soc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/soc.yaml b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
> new file mode 100644
> index 000000000000..90e8148b111b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/soc.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mips/lantiq/soc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq SoC based Platform
> +
> +maintainers:
> +  - Aleksander Jan Bajkowski <olek2@wp.pl>
> +
> +description:
> +  Devices with a Lantiq CPU shall have the following properties.
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  compatible:
> +    oneOf:
> +      - description: Boards with Lantiq Amazon-SE SoC
> +        items:
> +          - const: lantiq,ase

This does not look like proper board compatible. Boards have almost
always minimum two compatibles - one for SoC and one for board. With
commit msg this just adds to confusion...


Best regards,
Krzysztof

