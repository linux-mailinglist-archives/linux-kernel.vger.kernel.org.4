Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FEB70B7CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjEVIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjEVIg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:36:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1621EBA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:36:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d30ab1ef2so2264694b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684744614; x=1687336614;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcrDpdT0P9HHoECV1vJkLFWVWwbxP8Fr74ykIaaMjzU=;
        b=B1RoD1yqTtItp6r3dhSCZiKiWHVenEw735/3jc4hF+NN0Z9eGPuHCZ9KUjyzCgpynX
         rjbwysUxw7q4InK+r8ctWMTyoFgSy9POLLwQbmznuI2ubUyLSg+sGjS5vpGK13cswrS0
         fGsWuscsmsoRIO6azL9KjPAjvsfkIm/V9wpPH3i0xCat7zxMY7ctJnfmWZ+bkmSoFJXq
         GavttCItjHcBvtxkmnoFOUmXYde2NN1/OdJHNHbPTezjqArcIRURzzXDQ6KCsZKI+wQg
         ETZMKfJxk9im1gQt4SgLYAiZTjbFY7W6RPzuVqutAGu4lWfJ+CV4BcK9JvMPZE/iFiYA
         MkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744614; x=1687336614;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lcrDpdT0P9HHoECV1vJkLFWVWwbxP8Fr74ykIaaMjzU=;
        b=BOVRrPrR++RDGdPnNcTeclkLrirRkmm6eBz4bP3W+ICuqXBc/o7L9681meqFR+40jF
         l/g0x+u/xxWv/hL+9exz4OsqaNx/3Rqy1CK2xHR4Je37CmChfK+/hy2leQDNnF1rBfXN
         r1+gjHHc0RxtcFnwZt1ig7Tobpg84aEmH1psxIwSFlxe3d/TXN9V05KWxGBAjg/SsFAS
         sauacUrBw2nNGmYiBIxNJ1zSF8UYvsUvOpwxtb8ODKqavCuJIlQS/ib7NrDKQH1qyRls
         MqAhFSW0L1OzRe/wDGfXXNLXL02cMUF2fdekbVlacW/quMb+s3u7vOPZ98+IlznonxkF
         kjCQ==
X-Gm-Message-State: AC+VfDxwdGzswlkmdIh3xMorSzNzBX+BKc9ZjL/K9LyGxBnao/s36SPj
        z3miaCBcc8cR7dGpq5uBkGxDbw==
X-Google-Smtp-Source: ACHHUZ7EUFzpEYB4KtHJwQgK1FcjRylaJpeidTl7vlWxTf7raf4yEB4xfF0K/RG8mbA35FrF8UxVjA==
X-Received: by 2002:a05:6a00:234a:b0:64d:123d:cc74 with SMTP id j10-20020a056a00234a00b0064d123dcc74mr11227091pfj.4.1684744614530;
        Mon, 22 May 2023 01:36:54 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id n2-20020aa78a42000000b0064d57ecaa1dsm2738919pfa.28.2023.05.22.01.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:36:54 -0700 (PDT)
Message-ID: <056fa22c-a6be-da19-1352-d771ac61ebdf@linaro.org>
Date:   Mon, 22 May 2023 14:06:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.sharma@linaro.org
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V3 3/4] dt-bindings: qcom-qce: add SoC compatible string
 for ipq9574
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-4-quic_anusha@quicinc.com>
In-Reply-To: <20230518141105.24741-4-quic_anusha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
> Document the compatible string for ipq9574.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   Changes in V3:
> 	- Picked up Acked-by tag.
> 
>   Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> index e375bd981300..0d1deae06e2d 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
> @@ -28,6 +28,7 @@ properties:
>             - enum:
>                 - qcom,ipq6018-qce
>                 - qcom,ipq8074-qce
> +              - qcom,ipq9574-qce
>                 - qcom,msm8996-qce
>                 - qcom,sdm845-qce
>             - const: qcom,ipq4019-qce

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
