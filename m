Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFC6746B68
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGDIDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGDICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:02:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08226E4F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 01:02:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9370978a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688457757; x=1691049757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBZPI8glJqIUeXhqVRAMT4N4I6Vuww3+N8Gf1+RF6eg=;
        b=A2IEtShJbjKpwGTdVrHcrDd4B6aTMvHQ2LMjreMTZS6SAURNgYuypXFUZHxb/taqUR
         2HW+6514DjeJsL+S43lF/gccbk655IkQ/PIc3wc7yOu3uHrSSwrj5w+3n57yyyg5tIkG
         EZvOdJV55bzGa2IRL+1vFYVXuB3CNbFmMEn2hQjFY+FK8PNQf6EzgXvXRpFiR6nKYNfB
         zbQeb/Rcez+EMySJxtuGNB6v52GLemDYdsbQdcg8YbQsbYNGvxhGrMRbHiV+suU7LhTf
         H0NRXYD5ibwRKn5wwWfuyBLmuYh2OkbcXQUbjEuQY8nxvAB2nw3RdPGgoJgBjJDgUWxA
         erHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457757; x=1691049757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBZPI8glJqIUeXhqVRAMT4N4I6Vuww3+N8Gf1+RF6eg=;
        b=FnS10ni+FsqD5hYWOeDinEvSxi03Ft9Jg9sn3hSc98jX4uu2maKVeYmqolOC2HA0Bg
         bcPaL22yIfQrQYvktJTkjwmgkC8JEv0QfSFT+N8RzD+fWrZdeUjoADNpW7IGVlmRg60v
         I8A0B2UF2vo07PtkOgmWGYWeo+9fwQpQ6tIhZkvB+Lnupm4hM8F68GR1t4xuo+JDoigF
         bX+pMcwfyIJnPl0Ayl4lB+QbTybOUKQWrWUzTIZ16VVk5hw9zpIJ6wboOAIJXhKYQImA
         SPPmtexxRqCkTxhN6ll+cwKy7yitQRyo68ndQhSWbVf9GUlcXQ4n8n6bZmWjLZZHfj5G
         4aAA==
X-Gm-Message-State: ABy/qLatzkaFRitaAYjUmXJYY49NDAi5NUpcmXJYLIrNlfk2mZluYedz
        FtsMFOveFBQUEyTtQu7PKjbfnw==
X-Google-Smtp-Source: APBJJlH717oPGFv+MjoFn80oa7HNgr/u6Yrl7/XZuLT5Lhy/wGRwAFSGpyBAiRmiDQc7Muh+xJqIcQ==
X-Received: by 2002:a05:6402:b1a:b0:51d:914a:9f3d with SMTP id bm26-20020a0564020b1a00b0051d914a9f3dmr12953207edb.10.1688457757473;
        Tue, 04 Jul 2023 01:02:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402165300b0051d9df5dd2fsm9370643edx.72.2023.07.04.01.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:02:37 -0700 (PDT)
Message-ID: <85771493-a06a-b92d-51c5-c7771443b563@linaro.org>
Date:   Tue, 4 Jul 2023 10:02:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8-acm: Add audio clock mux
 support
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org,
        peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1688449175-1677-1-git-send-email-shengjiu.wang@nxp.com>
 <1688449175-1677-2-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1688449175-1677-2-git-send-email-shengjiu.wang@nxp.com>
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

On 04/07/2023 07:39, Shengjiu Wang wrote:
> Add the clock dt-binding file for audio clock mux. which
> is the IP for i.MX8QM, i.MX8QXP, i.MX8DXL.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Except what the bot already pointed out:

> ---
>  .../devicetree/bindings/clock/imx8-acm.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8-acm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8-acm.yaml b/Documentation/devicetree/bindings/clock/imx8-acm.yaml
> new file mode 100644
> index 000000000000..820c06b81aa6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx8-acm.yaml

Filename matching compatible. At least vendor prefix is missing.


> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx8-acm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8 Audio Clock Mux Binding
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +description: |
> +  NXP i.MX8 Audio Clock Mux is dedicated clock muxing IP
> +  used to control Audio related clock on the SoC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,imx8qm-acm
> +      - nxp,imx8qxp-acm
> +      - nxp,imx8dxl-acm
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-domains:
> +    minItems: 13
> +    maxItems: 21


21 power domains? What's this? Why clock device make entire SoC awake?

Anyway, you need to list them.

> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8-clock.h
> +      for the full list of i.MX8 ACM clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - power-domains
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +
> +    acm@59e00000 {


Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "nxp,imx8qxp-acm";
> +        reg = <0x59e00000 0x1D0000>;

Don't mix hexes. Only lower-case.

Please perform some basic review in NXP before sending it.

Best regards,
Krzysztof

