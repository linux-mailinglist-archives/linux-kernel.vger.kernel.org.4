Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA39D62C182
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKPO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiKPO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:56:22 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8F3898;
        Wed, 16 Nov 2022 06:56:21 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so10391692otb.1;
        Wed, 16 Nov 2022 06:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiYE3Mo0zFHleDYSNTS5o0x4eaonhEzzEYL0UrDWPyA=;
        b=mwjTYyBfn6o2RX3DBPDclCq4XuA09eqUg2jdmkKMkNXKunndulQr6E2XSlK8Ntz4ND
         A9sbeLyzOGamgmIefrgzIVEsbxpMuIDUFmIk+nUl177le/o3sR3j/BFDmWHUJuWsr29V
         hF9AMF4dUmqbqLHaX/17CjceR3nR2cbpmm2mOvVUMtG2AoOtI+KYuRqSHdqezlxAkTuS
         WgLwKVFhuE38r/sAycc9uUhOqnVg7mLodRWEKzKxT8Kbe8DSy90gxtpSI+xg9Wp6jcKf
         bgdYSGqi8lBvWn712hGsmfIcoAXY0EF67vHHeDA/L+mddWA8ROCvaGICZHLWjY1lQRKI
         kzvQ==
X-Gm-Message-State: ANoB5pn/cUMxk/vfPYdMQu7jDCzc8X5WS2Hux6Q4e//VS+8SnpplLgTG
        B27qX0LWFmRfHwhOVNDQFg==
X-Google-Smtp-Source: AA0mqf5RT5ifXvwgs+cEfR5EXTxUpg8KtBEflAExFGC+l5ZALD7D9ZYjC+utdFwLwC5MP2euW+cPoA==
X-Received: by 2002:a9d:605:0:b0:66c:9db8:8f7e with SMTP id 5-20020a9d0605000000b0066c9db88f7emr11220476otn.155.1668610580427;
        Wed, 16 Nov 2022 06:56:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d65-20020a9d2947000000b0066c4092ae4csm6646650otb.10.2022.11.16.06.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:56:19 -0800 (PST)
Received: (nullmailer pid 3838368 invoked by uid 1000);
        Wed, 16 Nov 2022 14:56:22 -0000
Date:   Wed, 16 Nov 2022 08:56:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     quic_srivasam@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, quic_plai@quicinc.com,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/11] ASoC: dt-bindings: qcom,q6apm-lpass-dais: Split
 to separate schema
Message-ID: <166861058156.3838310.6244657242742834715.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-11-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:34 +0100, Krzysztof Kozlowski wrote:
> The Qualcomm DSP LPASS Audio DAIs are a bit different than Qualcomm DSP
> Audio FrontEnd (Q6AFE) DAIs - they do not use children nodes for each
> DAI.  None of other properties from qcom,q6dsp-lpass-ports.yaml apply
> here as well, so move the qcom,q6apm-lpass-dais compatible to its own
> binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/sound/qcom,q6apm-lpass-dais.yaml | 32 +++++++++++++++++++
>  .../sound/qcom,q6dsp-lpass-ports.yaml         |  1 -
>  2 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
