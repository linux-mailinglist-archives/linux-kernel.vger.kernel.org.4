Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F309569E3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjBUPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjBUPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:44:45 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA625E29;
        Tue, 21 Feb 2023 07:44:37 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id 26-20020a4ae1ba000000b005200f75cb0cso535866ooy.6;
        Tue, 21 Feb 2023 07:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyjUBDRTJFgSJBaeyt3o+remUUUyICWdxS5ZUjwhQog=;
        b=K+JNWB+Uv/CQGaZ9kiQ98J+P2A9MJnh320aiAKp8m++XZJe+H1K7Y8KkQL2pyd4k9m
         887vC26S/qpFmL7jBh/P32p9bgIj6SfFX13/F3CaDjbwcOCgtXZDU84dmPk/XXWGSWP4
         Ls5YZFYCfGguQI0fncHYcp8hzCftVHUwZQFpyMmwzXzPR/ufMufZw8Bj0+NHEonpCNi6
         KKaxEPlaVqKMuY09Ot0Q3gE2BniE7LAWRLJ4NVuvZLHFiFnvBSOGR4QnTmZ8Ol0NTV3G
         oLy4LoKjDRYxkIEzfkNtGdNOeHBQ37rjnZ/d3VhhA3V5J5jbBQvtjCOY1RE8yeNLm39i
         Q7jg==
X-Gm-Message-State: AO0yUKVjg10DjEW1WcRgLG/TiJ3OWCy1Tr29X65fa/+tCp0wcWKLMbxr
        91rT8UuCtQ3wuDteNMWLdw==
X-Google-Smtp-Source: AK7set92GPefE/7yc/iStug370U3UzOpPZfYPp22CZw5Pdx0yRXD7P3iHKgEzUJ1Uo4CYwmzFkIFXw==
X-Received: by 2002:a4a:33c8:0:b0:51a:ac9:775 with SMTP id q191-20020a4a33c8000000b0051a0ac90775mr2557229ooq.6.1676994276376;
        Tue, 21 Feb 2023 07:44:36 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q185-20020a4a33c2000000b0051a2a5c8ac6sm1303503ooq.36.2023.02.21.07.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:44:36 -0800 (PST)
Received: (nullmailer pid 2591444 invoked by uid 1000);
        Tue, 21 Feb 2023 15:44:35 -0000
Date:   Tue, 21 Feb 2023 09:44:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: qcom,wcd9335: Convert to dtschema
Message-ID: <167699427490.2591405.11732576378747251832.robh@kernel.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
 <20230220095643.64898-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220095643.64898-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2023 10:56:43 +0100, Krzysztof Kozlowski wrote:
> Convert the Qualcomm WCD9335 audio codec binding to DT schema.
> 
> Changes against original binding:
> 1. Drop "mclk2" from clocks as neither Linux driver nor DTS uses it.
> 2. Do not require vdd-micbias-supply as several DTS do not provide it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Few DTS boards have incomplete WCD9335 node causing dtbs_check warnings.
> These are fixed here:
> https://lore.kernel.org/linux-arm-msm/42f7d53b-a922-760a-4be2-7498ea0d560a@linaro.org/T/#t
> ---
>  .../bindings/sound/qcom,wcd9335.txt           | 123 --------------
>  .../bindings/sound/qcom,wcd9335.yaml          | 156 ++++++++++++++++++
>  2 files changed, 156 insertions(+), 123 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

