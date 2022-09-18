Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8285BBCDD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiIRJi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRJiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:38:55 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E2237E6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:38:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s10so29963584ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HEB1dZFh6VkoKbzfje7Er0GM6QVtyW+eiZmJagi107g=;
        b=CzWhBYgYvdFJIunEEBf+SPmuuK9hsQ016YhNMThGUC1fP7UuRwT0WUerzIK+bGwtWn
         rx0EoU3vzqdAk0F6dwu/7wFhmkiL/r/lq5wLOqqhJ+WFgHCrECPjZsZJsQ5DlcWCEsoE
         Mgk4G8KiJVXrrnpDPXSwsa56ydIVmtscGEZrh8cIZS/Aw38jOc8rPyuBZWF7/5nRKMM2
         hfhJTEzy+H2u03ypmvbKay5BzZ8ps3mal6V2TCzMe0up67YNraNZGxMl0j5fW45nEZac
         ESt5v/NVCbSgMmy7UEkfI8BkyWlvPvEFp3iacwh1U8pMzuuzCLZkyNGRWqQldaRSjFfs
         URKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HEB1dZFh6VkoKbzfje7Er0GM6QVtyW+eiZmJagi107g=;
        b=HeMdCvpXSlgmwSc7IcRghTEFXABkuweetk76OgC2SQwwlP6JOqSQV9djdWFGExM5LZ
         OoLqzrTFOHD9//O0MpQtwIR14YTcOu+ufN0JJczuc9iXhwNZ/VPw7UmKmpHcfEs2CI/4
         6FqSEW0nsaF4TYJMqS5mF2pg5j1b5crivvt6vzlhpCd/2ZAagXP2HrEEBk9AkAUDPGm2
         UMIKnkntmTN1JWIT+A5/p//4qID+SICOlQqK6hTq3AV12F+BtTwb7EHz8Ju7klFt59eX
         RDFb2U2z+dMaGiEDckriii1ltJTUp3qD90uUD3GNUzkulnbHp60Nw9NNMy/1qNiup40B
         LT7Q==
X-Gm-Message-State: ACrzQf0koZU75/f00CW9kOF5tHjeWJypGKuUHoAz2a2FZgI8vl0JKQMO
        CMdhrFQcCkfwjKdmxEWYk0qcXg==
X-Google-Smtp-Source: AMsMyM59+gIAACAOz0Pj09IsVP4jC7D3hEx4CoPctx8Y09MgJhm0bBnlHW0nHkX1c/5BtZ5lHJLm3Q==
X-Received: by 2002:a2e:a4b1:0:b0:26c:521:76b5 with SMTP id g17-20020a2ea4b1000000b0026c052176b5mr3629219ljm.258.1663493932400;
        Sun, 18 Sep 2022 02:38:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a2e93ce000000b0026c446918acsm537430ljh.134.2022.09.18.02.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:38:51 -0700 (PDT)
Message-ID: <78a0e713-2691-677b-e749-fde609944a7e@linaro.org>
Date:   Sun, 18 Sep 2022 10:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220914124552.16964-1-johnson.wang@mediatek.com>
 <20220914124552.16964-3-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220914124552.16964-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 13:45, Johnson Wang wrote:
> Add the new binding documentation for MediaTek frequency hopping
> and spread spectrum clocking control.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> new file mode 100644
> index 000000000000..7b0fd0889bb6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml

Name of file matching compatible.

> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek frequency hopping and spread spectrum clocking control
> +
> +maintainers:
> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> +
> +description: |
> +  Frequency hopping control (FHCTL) is a piece of hardware that control
> +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
> +  Spread spectrum clocking (SSC) is another function provided by this hardware.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8186-fhctl
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: Phandles of the PLL with FHCTL hardware capability.

You need constraints here.

> +
> +  mediatek,hopping-ssc-percents:

That's not the correct unit suffix name.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml


> +    description: The percentage of spread spectrum clocking for one PLL.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Best regards,
Krzysztof
