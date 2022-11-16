Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED162C17A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKPOzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKPOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:55:14 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA31176;
        Wed, 16 Nov 2022 06:55:13 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b103a3e5dso20356785fac.2;
        Wed, 16 Nov 2022 06:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zAenYPukXRa6WH1FuI7zU9MyK95VuVbiFaqQ0TR08s=;
        b=2hUjrJwAhho8mbQtdYiZBjr5RD7oCQFXapkF5d3TUlYP0GKAjP7ajd+sI3jaS0wwv/
         Nn3+BNcNIhK+H88dGjyLQYF+YGiCqONk0cMJSE29vahKBLTcumvrM6oPYCvIGMViOrcN
         /+7ncYOD82VrSDwLB9tRtvG0wCMhApLtsFJeuIbhpUk/1x+KtUEhU1dv3YmMxrIsl4dr
         LZzCedv8QI5fwzpqw5Tm7Sabrb/O/o63GwVIAsAzebvSdeo7PP0xX4VY5NQacbarlyfa
         VZKZrQxSW8+NgaSNmMaxk3wn+0aDrUeUYYdf5yDNPJ/o8oSGax0qRiygQO+fIj53yxtj
         f4kA==
X-Gm-Message-State: ANoB5pmcCH4/F6zVsvdLv1vFQ8HFn4W91Kj4EAsjTDYBwaQSYQQqqNGP
        RY0Gy21FXbZ22H7cwiNOjg==
X-Google-Smtp-Source: AA0mqf7escxT2CNeYstvMXHT5yuoqZ3X8aVm6oVk8h7yhvc/q0jTKxEFAhHiMSNzAvSsDAliZPgxew==
X-Received: by 2002:a05:6870:e412:b0:13c:d709:204 with SMTP id n18-20020a056870e41200b0013cd7090204mr1829034oag.125.1668610512903;
        Wed, 16 Nov 2022 06:55:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a9d749a000000b0066c44b4f2d6sm6763094otk.43.2022.11.16.06.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:55:12 -0800 (PST)
Received: (nullmailer pid 3836759 invoked by uid 1000);
        Wed, 16 Nov 2022 14:55:14 -0000
Date:   Wed, 16 Nov 2022 08:55:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     quic_srivasam@quicinc.com, Banajit Goswami <bgoswami@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>, quic_plai@quicinc.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 08/11] ASoC: dt-bindings: qcom,q6prm: Split to
 separate schema
Message-ID: <166861051295.3836684.17078819887827826854.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-9-krzysztof.kozlowski@linaro.org>
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


On Tue, 15 Nov 2022 13:02:32 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6PRM
> service to its own binding.  Previously the compatible was documented in
> qcom,apr.yaml.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/sound/qcom,q6prm.yaml | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
