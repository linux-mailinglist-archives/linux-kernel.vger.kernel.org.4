Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62E62BD83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiKPMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiKPMTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:19:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466D6339
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:17:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s24so21577260ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzCCokp/dfwOnTXnlOvKedbKZaX4sETIitBC24zNGZc=;
        b=sTSvRoTkg+5w3K/OTAsCLRwhgYyf/p+mRVUSayRqqX/uKJjLAu6z2JmuxgKMt+AhnX
         tjMIZ0Sb0ciLBgWJKgohnvhl4qU1HvHpJ/8JyX/rSEhGNLyIGmUisVnq6pM+2waUMagT
         RLtaCAIq+ddv9Kl7pVm7ivT+WlECDLTWKuv7Z/mYADCrZ0UPFAJtG427lBhwxkglpWu/
         9t2KVvQ3eBLxswjIMXnhBfHnSZwWPQd3qXMHgD9Ggb9rseho5VyJvpdKSarqbaZefbWH
         VGsWW1rc5bIRq7qLGn1nerjEpqufooZ3iuO8gco0rOugOQrNkBW/CH99TFqLOxIqxtMA
         X9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzCCokp/dfwOnTXnlOvKedbKZaX4sETIitBC24zNGZc=;
        b=Ly5+NSe/52ffaxlpFtQGEvW0F/Z7SGRk/xY86rdpZkZyk+zd1LJXJ2gIdLctc38skd
         xLEw/7lE1Q2X2M1A250d7/mVdI+OvfFJ55aKdRL+PvpX7FoWqKBFmFBE3bTp0MRsD5sp
         VuEublfRG490KOVV1/4Gb43wkX0L6OwrXgpUhkgNg2IZhPgn6dhHbYM3C2jilhM5UGxQ
         H/AYa4hbTY+U8h6CdCtDpW4XMMX0TWLKVlwYca7pBWtkHVnoi3SowJoYJwZP8gLINeyr
         eNsd87yNGG9RO//HTmvLyyhIGz3ebqHrswGMCeDtacEyAIyZKTx4aczoYEmqZK+ZOmYa
         XBXA==
X-Gm-Message-State: ANoB5pnglZV3ozcBbJk/Hd0zQMt+rW/OWwPkrYv214nPrJH6twM7on49
        siqirLgHEuPubH0PTuLn+9TP3g==
X-Google-Smtp-Source: AA0mqf55KNBFqnxJBx6kKUY1JIk1NE7g1sYj1zLPCdyz3Omv/8W9OAvWG/XtCHfMerV0WOcMcYqjpA==
X-Received: by 2002:a2e:869a:0:b0:277:f46:617b with SMTP id l26-20020a2e869a000000b002770f46617bmr7177486lji.221.1668601069159;
        Wed, 16 Nov 2022 04:17:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h14-20020a2e530e000000b002790fbb5f89sm913295ljb.44.2022.11.16.04.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:17:48 -0800 (PST)
Message-ID: <38fff21b-3e75-13f9-664e-a115bc527b67@linaro.org>
Date:   Wed, 16 Nov 2022 13:17:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: document Qualcomm MPSS
 DSM memory
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-0-158dc2bb6e96@linaro.org>
 <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-mpss_dsm-v1-1-158dc2bb6e96@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 11:16, Neil Armstrong wrote:
> This documents the Qualcomm Modem Processing SubSystem DSM shared memory.

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../reserved-memory/qcom,mpss-dsm-mem.yaml         | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
> new file mode 100644
> index 000000000000..65f37e1356d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,mpss-dsm-mem.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/reserved-memory/qcom,mpss-dsm-mem.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from above.

I know that this and few further pieces came from existing files...

> +
> +title: Qualcomm Modem Processing SubSystem DSM Memory
> +
> +description: |
> +  This binding describes the Qualcomm Modem Processing SubSystem DSM, which serves the

Drop "This binding describes"

> +  purpose of describing the shared memory region used for MPSS remote processors.

Entire description seems like not wrapped at 80.

> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

Need to update the address.

> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"

Drop quotes.

> +
> +properties:
> +  compatible:
> +    const: qcom,mpss-dsm-mem

Why do we need dedicated binding and compatible for it instead of using
memory-region phandle in the device?

> +
> +unevaluatedProperties: false


Best regards,
Krzysztof

