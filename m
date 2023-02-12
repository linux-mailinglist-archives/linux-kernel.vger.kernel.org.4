Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70B69384F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBLQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBLQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:08:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7C11659
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:08:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id by3so8611474wrb.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yo4+QqlKq3rBI4dUhZnosf5TfI2MY6+eR5qfzKyTIIs=;
        b=rpoNjAyj9Kh3k/VP0r39ILsWg2J9vtY6VvPCv+w3UtbqUk3Ud6jUd7dcTk/fZLApEq
         5qyBI+DHcDXqAu+tg4bSbAEvUB4iXtr1Wr0vo2pOZNoSJUeHlnfwJhHu5/to+Vmr2p0z
         5TevgnlV240nqhxH8sAeVDdmYWXNOtuq4IqOFBu3VN1ytJeUbu/Y0BaDGWuN8lNa1cJe
         6ng9m138DB9hdeQbsHTa0uL7fIneeqZwPIV5ZMY0BTzi5+d4gMvLB8Vo00KcbHyXSKQV
         ctV6cy+Dj/i4FVLt0/uY0S7iS7RRtQRH55eyqSvfz9CBBBEOOcqiq1GA8+tGnbzdeNbH
         HvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo4+QqlKq3rBI4dUhZnosf5TfI2MY6+eR5qfzKyTIIs=;
        b=ZooeMYjJF6MjYXI5UN0jRYTf3tvsSZap34sZhAyOk+0Jk6qjZ2BgAIr3FHPFzD9rV4
         LkX8E119juekOhNFhBz7KaqVIhUx4ZbpuPiVk9OkG/Y1PxMRm9goTlSNc3zodUJRV6Sm
         ZiV7a36XYXXVWvtQo8LU1jZHqwiJMwUWg9EWYt0f7BJyntcJMT6F2RZG2chNyx8/0NDw
         v+MBPRKKT6CbMzklwVa0e2TTM7YhlaymLEGimbXmg9JtXNgyjD6M4RDqt6MN69k1xRv2
         c5W4Gc9PsM8TlNLhMxJcX+vc2v9FN6+XisqOADPiOyQ9ztNbUcPZyjZakP6+2oVgTDBm
         ptTw==
X-Gm-Message-State: AO0yUKUW1yDBOTbcrT+0WURygVYXsv64nyhdG8/07TPaJTxLA1t3DFph
        FWA59EuiUPA8RVuAPTCXIrnZFA==
X-Google-Smtp-Source: AK7set886yHqG45Fh73Vx3xVdDFCgDAyg3YNr3tM3Guk/xGG0lZjX32UoYXVnrFWQ2x2AvCyuqjYtw==
X-Received: by 2002:adf:e585:0:b0:2c5:4c6f:27c6 with SMTP id l5-20020adfe585000000b002c54c6f27c6mr5290432wrm.5.1676218118329;
        Sun, 12 Feb 2023 08:08:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600012c300b002c54911f50bsm6415366wrx.84.2023.02.12.08.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 08:08:38 -0800 (PST)
Message-ID: <c44dbd68-337a-56fb-64f7-bb39abc4f97f@linaro.org>
Date:   Sun, 12 Feb 2023 17:08:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: remoteproc: sti: convert st-rproc into
 dt-schema
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211204751.9149-1-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211204751.9149-1-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 21:47, Alain Volmat wrote:
> Convert the st-rproc.txt binding into dt-schema YAML st,sti-rproc.yaml
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  .../bindings/remoteproc/st,sti-rproc.yaml     | 101 ++++++++++++++++++
>  .../bindings/remoteproc/st-rproc.txt          |  41 -------
>  2 files changed, 101 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/remoteproc/st-rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
> new file mode 100644
> index 000000000000..b9d84dfbcb58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/st,sti-rproc.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/st,sti-rproc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: STMicroelectronics STi remote processor controller
> +
> +description:
> +  This binding provides support for adjunct processors found on ST SoCs.

Drop entire sentence and describe hardware, not binding. This is
binding, so no need to say it is binding.

> +
> +  Co-processors can be controlled from the bootloader or the primary OS. If
> +  the bootloader starts a co-processor, the primary OS must detect its state
> +  and act accordingly.
> +
> +maintainers:
> +  - Patrice Chotard <patrice.chotard@foss.st.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,st231-rproc
> +      - st,st40-rproc
> +
> +  memory-region:
> +    description:
> +      List of phandles to the reserved memory regions associated with the
> +      remoteproc device. This is variable and describes the memories shared with
> +      the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
> +      vrings, ...).

maxItems

> +      (see ../reserved-memory/reserved-memory.txt)

Drop last line.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1

You need to list items.

> +
> +  st,syscfg:
> +    description:
> +      System configuration register which holds the boot vector for the co-processor
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"

Drop quotes.

> +    items:
> +      - items:
> +          - description: Phandle of syscon block
> +          - description: Boot vector register offset
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      Frequency of the processing clock of the remote processor
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop ref, not needed, it comes from dtschema.

> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  mboxes:
> +    maxItems: 4
> +
> +  mbox-names:
> +    items:
> +      - const: vq0_rx
> +      - const: vq0_tx
> +      - const: vq1_rx
> +      - const: vq1_tx
> +
> +required:
> +  - compatible
> +  - memory-region
> +  - resets
> +  - reset-names
> +  - st,syscfg
> +  - clocks
> +  - clock-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stih407-clks.h>
> +    #include <dt-bindings/reset/stih407-resets.h>
> +    audio_reserved: rproc@42000000 {
> +      compatible = "shared-dma-pool";
> +        reg = <0x42000000 0x01000000>;
> +        no-map;
> +    };
> +
> +    st231-audio {

Generic node names, so maybe "remoteproc"

> +      compatible = "st,st231-rproc";
> +      memory-region = <&audio_reserved>;
> +      resets = <&softreset STIH407_ST231_AUD_SOFTRESET>;
> +      reset-names = "sw_reset";
> +      clocks = <&clk_s_c0_flexgen CLK_ST231_AUD_0>;
> +      clock-frequency = <600000000>;
> +      st,syscfg	= <&syscfg_core 0x228>;

Correct indentation issue.

> +    };


Best regards,
Krzysztof

