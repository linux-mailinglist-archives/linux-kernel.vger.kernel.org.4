Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ABB61FF55
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiKGUOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiKGUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:14:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602332BB20
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:13:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i3so11657774pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=DLbUXpx5BGpG1DMQLOiBzekr6LKIQl3xNK69EzWu9cBTt0IhkdmZEwISLEFENb2XyY
         F6/uOEAYvPy0pCsiKqNfvo+OIfm6SIX23KDx3yvMgH3sgSWchQIKDJE3GlzipiOCntXn
         /clhW8ucjAP0zT0zof+RkYMmEXv6b4ZGsStnqT8oNHT2Ijc8ADMZhCAzlI2lH+fr1/YO
         x8c4BelTxgBcJGxLGvn23wE5GsMamdtb7aMOLH1Yng9pUzNmTj0K1sanTKJko582ilbk
         F/TgKqkz4ALp59zsfD87HDFQgUw9Nn7h4v9gTInuzb4aaEecdA3lo3c7rkliEi2oPP/4
         KM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xwUUkKpDcIPfyqgEqqK+GlgxLC+bvP4zY8tMROFslo=;
        b=bRVTIAE+KVssNZWLO5K6RaXusgc9j7xEfrUe/I/4DR5EOXngiX0wZS/sbGIylamDjf
         z8P9/GAiNmU3+KMapQ3UO5eFFT+XZcKfuQMtecwzqlyj9JkB4OaDzw6QBYPjWMX9aOub
         sEOGi+LEB3gW5KxNq3t/ZCkT5DaisBjvMQiRqaKfflG+iumBUxHHUziKDxZJsp3D7pjx
         WyoBoTEmYf2mjweprVdVAmSDjvlmJySmvcVOmHdv7bcpjbsIfbLz128LjoJInyqkNYaY
         1UAXNtP//h9K5JQNwDnWTMbB+uWSxbTk7pwuxmoWbn7lAgzX5hczNJlKUmKIp+as7DRF
         UMUw==
X-Gm-Message-State: ACrzQf3Rw8D8Tk1IP0+DVxHzKuW1kyxx8XCtdF2cwgKPSG0eEQMp4mDx
        oTdUgKtRds+ww8d/07AgUMS+NXqInNwNvsmPgc9utQ==
X-Google-Smtp-Source: AMsMyM74vaf7W54OL8zd+LH6la1LzG3+QlIhG7MtdJ/FbfqblOiiJopqiebGx/275JBCdBk/+joGXH2EXp7Nnh5kKbs=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr46115918pgk.595.1667852038821; Mon, 07
 Nov 2022 12:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com> <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221104172122.252761-6-angelogioacchino.delregno@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Nov 2022 21:13:22 +0100
Message-ID: <CAPDyKFramrp3gvOCCULC6anTh9ZfFbdtSgrmE_iGCJgbT0vYLQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-msm: Document compatible for MSM8976
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 18:22, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Document the compatible for the SDHCI controller(s) found on MSM8976.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index a96f143479c7..fc8a6b345d97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -26,6 +26,7 @@ properties:
>                - qcom,msm8226-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
> +              - qcom,msm8976-sdhci
>                - qcom,msm8916-sdhci
>                - qcom,msm8992-sdhci
>                - qcom,msm8994-sdhci
> --
> 2.37.2
>
