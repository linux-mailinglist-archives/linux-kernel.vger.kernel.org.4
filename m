Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86CB6C8D50
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCYLMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCYLMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:12:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B3126EE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:12:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so17343967ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679742766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+Da6p8t1bRmX9X4IXLRnY2DE8przk6Zp2l2Yy3LUzg=;
        b=geb6dszSdPEclC0i9jC/0SdaI754rIyFU2xO6DvpzfKgCLSi+crJ/ha7gvhh4mkKJ/
         RpgSNLq7KKSn/GzBp8VLUBAR+2ZIhvhymqwW8mJDYGVIrWgkNps7uRpPPjtE4ewNxu0Y
         7eqDdNgaBIFoabYq9srYc4gpT12DeaRGWU45faXGSVfjkHKsc3pxgRnhYvs6MqoShDeO
         35kDR18K7Zsn3GNsRPQXmh3wXADALhYL37fUF4LBkC70l+l3bpBLVFsgE+5aZ5aHU1XQ
         Q3+Lu91azxFIeVN+MsAPRA6V+IMmKDyRLJwaan9TVO8Pe0FO37SarJm5xDtDR8HWUqso
         QO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679742766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Da6p8t1bRmX9X4IXLRnY2DE8przk6Zp2l2Yy3LUzg=;
        b=mvNmKkW15aMAGYjLBJh2oPEzcq7EpvgYLnc+mmVv+YebaWn3mj15e/qyHQQeDOqO3R
         tWEVDh/opuvN11gGuAiyeu/lxdUfzETOxXYpXRK+32f0oQkabWd1D+68r8Uw11k4R3/s
         nxEuumG3taxlmpKQv2o6amvIgCU3NRgQA0QAZrWuK3N/8vKg3PXjD4cBlh9RfHupiwXa
         k2rSD5kxCWgPO9r5KKrR70AYSwuYGVbsnojmtOZwcwhXqxXCCRPb8mc5vAdwWkGo3DfI
         rgJAUB22n9CPtOm9sSfv1YuAs7j0Z+GMn9Q9EpqjqLu8xvXHnisv36eoJmDdlfNCR4mX
         eIDg==
X-Gm-Message-State: AAQBX9cRmwopbWvTAWvCLIcjr3j4CyfCocFv1C6pFpZQ8lMQ5E6YJeo0
        wtkv4g+BOBRPabFrpEQxJbgQow==
X-Google-Smtp-Source: AKy350ba6T8ZzFpM6baZosd4rhtYX0c3g3ppufyrcSy2Ttex0o5fyknxa3roehxOistyoBz3X8p/AQ==
X-Received: by 2002:a17:906:b349:b0:931:91a:fa4f with SMTP id cd9-20020a170906b34900b00931091afa4fmr6752833ejb.41.1679742766251;
        Sat, 25 Mar 2023 04:12:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id k24-20020a50ce58000000b004fc9e462743sm11988618edj.91.2023.03.25.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:12:45 -0700 (PDT)
Message-ID: <488a6684-50aa-e78d-d704-7f59ed3f2c13@linaro.org>
Date:   Sat, 25 Mar 2023 12:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 08/18] dt-bindings: gce: Add header for MT6795's GCE
 mailbox
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     qii.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        houlong.wei@mediatek.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230324175456.219954-1-angelogioacchino.delregno@collabora.com>
 <20230324175456.219954-9-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324175456.219954-9-angelogioacchino.delregno@collabora.com>
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

On 24/03/2023 18:54, AngeloGioacchino Del Regno wrote:
> Add the GCE header file to define the GCE subsystem IDs, hardware
> event IDs and thread priority IDs for the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  include/dt-bindings/gce/mediatek,mt6795-gce.h | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 include/dt-bindings/gce/mediatek,mt6795-gce.h
> 
> diff --git a/include/dt-bindings/gce/mediatek,mt6795-gce.h b/include/dt-bindings/gce/mediatek,mt6795-gce.h
> new file mode 100644
> index 000000000000..97d5ba2d2b44
> --- /dev/null
> +++ b/include/dt-bindings/gce/mediatek,mt6795-gce.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

This should be squashed with previous commit adding this compatible. It
is one logical change - bindings for mt6795 mailbox. There is no point
in splitting one change into two.

Best regards,
Krzysztof

