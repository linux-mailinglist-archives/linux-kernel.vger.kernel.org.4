Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D665BF77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjACL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjACL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:58:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701FFDFE0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:58:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso22915423wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riuB621SAvRb1u+xy63QHjUE1rwJNvyT5glJGdZN9mw=;
        b=BrvkzBh+9tQ870R8RXVgmfdRSgUWvkX8myruFn1qJQ5UOeRFc09yefnFgmJHlWuvdw
         JAm0Rxsrdk6NCcm1L7GGvbRWax0aR0AlSDXfCgkmzd+4Yczjc4Ameu1fdQuf+S1ybzE8
         d8fmvP6lvwG/jja1dTC5jX3ENd/qWpT9m4W8FMpTwZ0l/rS0Kk/dVgtgSrtYJTFj7GA9
         ukqZGtpihiqiGYrr4Mb8JvLVB1QxR2FeDXiyc4B73aFVOCv/777TS5FI14snPeBodvsl
         YLqzYcMViOLrcChdjUfaca2JfFU/bBss8dzxYHU2t49Je3OLOsR7l1U7DJfM+dDOOvcs
         buVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riuB621SAvRb1u+xy63QHjUE1rwJNvyT5glJGdZN9mw=;
        b=hlPHN2SsA1XBCnNwa1YzSARuRLeBgcXtdj58yilhseIujbWyueVwmpDTaFE3/O+bYg
         Gv8svX4Ibde+kkk/aLGESTulWU5OsjPVGKthF/EttlOwM8y1DInT6PpQw0wysjw48o0M
         33mMIm0C6ivalZvPZv1LcUNR2LJ8a8p1f4cJcrn2whHp1Jkd93e7I3jQYKCoUqzH6Oxb
         wnYC1L9A4HaMQsQcucEl6yhIxRIwBb8vPJbxlZlTJMOVoYyns82cxyTWxBuTItY30tH1
         wXTj2QiC+gUMCtFDnOT4u5h2rw1fJj8i7E4Yl943lmOCzR+qNi8ad1C4MeldGLhA6cMB
         UPEw==
X-Gm-Message-State: AFqh2krVxIOBcAOMC4sALtkJZ2R7WGJG3RIe6gQxGcOKs/X/oI/4vcu7
        eGtpM7UbmwXqhzwUnbACzl3dGQ==
X-Google-Smtp-Source: AMrXdXvM2GCi6P68d2DLmesx7lUf8rCnEwp/jl+nTjy/3bSafdJE7PTv06jftjnaNvz2XDo41FwNDg==
X-Received: by 2002:a05:600c:3ba4:b0:3cf:d428:21d6 with SMTP id n36-20020a05600c3ba400b003cfd42821d6mr30008705wms.3.1672747082040;
        Tue, 03 Jan 2023 03:58:02 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id p34-20020a05600c1da200b003d99fad7511sm17934292wms.22.2023.01.03.03.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:58:01 -0800 (PST)
Message-ID: <0ae643ac-c07e-fe04-ad7c-e853d4db6909@linaro.org>
Date:   Tue, 3 Jan 2023 11:57:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/11] dt-bindings: nvmem: Add compatible for MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        jic23@kernel.org, lars@metafoo.de, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, evgreen@chromium.org,
        gregkh@linuxfoundation.org, a39.skl@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-4-angelogioacchino.delregno@collabora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221111120156.48040-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2022 12:01, AngeloGioacchino Del Regno wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> Document generic QFPROM compatibility on MSM8976.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
Applied thanks,

--srini
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 474abdbb1ee7..336cc05c3e32 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -21,6 +21,7 @@ properties:
>             - qcom,ipq8064-qfprom
>             - qcom,msm8916-qfprom
>             - qcom,msm8974-qfprom
> +          - qcom,msm8976-qfprom
>             - qcom,msm8996-qfprom
>             - qcom,msm8998-qfprom
>             - qcom,qcs404-qfprom
