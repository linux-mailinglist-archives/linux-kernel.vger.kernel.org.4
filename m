Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74A966BABE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAPJn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjAPJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:43:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AC14EB2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:42:20 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn22so29748646plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5rnNsL4lEChI1TD5S3DOvfNRk0icdBAPi2/vjJi8W8=;
        b=XltKaVPJPio78dn9fWXrVElyvU7s3UkQS3HseSd7T7iW/oXsc1fQLKL4xFCd2k1Y1V
         xtm8gANYx/TlpQUJpPuKeQhlHFxXrqEN4rPIPqlvJEXF+VduauJyymi378eLZIP0vQGr
         vVIsiuef5gh/ce2gDR8vWmEwIkSJ88Nk1bbu0bhYinlch1O3RTAshPafKmuYwND0b4ZK
         PDpGu6pnnt9QhdHNU+SE+Cl75JfEIk1882jEoB2C2xISz+gSbgXZ+Lle4Kh30K79WxPL
         ejQdHOHj0+U7BpCfBmCwXkZ2cuNbDpvzz6BoY2OvEvRnQglz9LBHiEFdgh5IoSECRh/v
         YuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5rnNsL4lEChI1TD5S3DOvfNRk0icdBAPi2/vjJi8W8=;
        b=Lv0tDFHWfQ4mMYjx67ofPiTKr8dOalu7jKiL3hACc/IXxbTz+v5r058hHu5ayRJ06d
         VRZL2XWmWt/aOWC67uFDoJJp8tbo1D8u3VU9dramt2czdO7qMtRgFt3WcUxEShAf4DZP
         YLaMnkyHg7xkyRj2Yo5pBUvjNgvv9JMEFfrfx3BTgmzSXs61iWpFrB5w4+9zDiXsLuR/
         LswSonVAvSIUD7l+amHM1hil/yJq2CX0a6/xPEgfzR48Ov3wyLUuAcLu/EmXw4MvDvyL
         89hsTYIDXYyWkgDEbmCKoFZe2lb/HEKaU0ewxpCQ3fbfPp8X5TnvTmDyUj2983VllkYK
         5jNQ==
X-Gm-Message-State: AFqh2kplo+k8vA1azGUTLm9gR6J+62m+9sQPu7fTnGPOBl6/Vctu2AKT
        xZNJ7VUQZKUJu2yM2CmWU8fLMw==
X-Google-Smtp-Source: AMrXdXsDIb3h1O/6Tz2h9O66iZtsKZs2KTs69PMWNdtDV8aQkHBc21pklhDRIECg4t7uzG5IyiH8mw==
X-Received: by 2002:a17:903:442:b0:194:828e:ec5c with SMTP id iw2-20020a170903044200b00194828eec5cmr7035610plb.51.1673862139608;
        Mon, 16 Jan 2023 01:42:19 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902c94c00b00189a50d2a3esm6051998pla.241.2023.01.16.01.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 01:42:19 -0800 (PST)
Date:   Mon, 16 Jan 2023 15:12:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/6] dt-bindings: opp: v2-qcom-level: Let
 qcom,opp-fuse-level be a 2-long array
Message-ID: <20230116094217.3ekwt7yosfkxst4a@vireshk-i7>
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
 <20230116093845.72621-4-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116093845.72621-4-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-23, 10:38, Konrad Dybcio wrote:
> In some instances (particularly with CPRh) we might want to specifiy
> more than one qcom,opp-fuse-level, as the same OPP subnodes may be
> used by different "CPR threads". We need to make sure that
> n = num_threads entries is legal and so far nobody seems to use more
> than two, so let's allow that.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> index b9ce2e099ce9..a30ef93213c0 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
> @@ -30,7 +30,9 @@ patternProperties:
>            this OPP node. Sometimes several corners/levels shares a certain fuse
>            corner/level. A fuse corner/level contains e.g. ref uV, min uV,
>            and max uV.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 2
>  
>      required:
>        - opp-level

Applied. Thanks.

-- 
viresh
