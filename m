Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC5962C105
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKPOhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiKPOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:37:12 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADA82983E;
        Wed, 16 Nov 2022 06:37:11 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id r76so18646832oie.13;
        Wed, 16 Nov 2022 06:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFqEVeiOGdmdH2PP7fid7uM73jsm1VRTwjrkKfa7rbQ=;
        b=cUpTPwFKWkHskXgDPRWwEqANmkQ6miU+ppLvDuNxpCey4dpEVyJdqx6NoxsKF81U9h
         da1P+XLmqxF2itiql++Ota7T4LfygDEjpZgX0I19cgGdTvxmTMCufn6qOPef+3AduZII
         +y1cVRyeJopH6EWAngyvhKo4urheNldyhnGwTGDZQHWQntDG/mzgou4t/Gt5oPi9Xozf
         6HJahfr/vzNen6/tdriWeZiupKmSOluyxS2IypQdUVIIjs7pIKIr1fHr7M/Qnd1Uv0GX
         EcQTwIB39NkeT7kZNp59imxV1saMRgQuT+n2oi7RsY9YP7Jt2Buj7U2cmVsdfpEZvomp
         117w==
X-Gm-Message-State: ANoB5pmDqkDVb5M9+fULrslNK3ZT9sDdyk30VpT96jXGgu3n2xLckk64
        Z7T7VOjlzhrXnIfHB6Q3NQ==
X-Google-Smtp-Source: AA0mqf6xFdK5qLXwDeKCyPu+fMM2QIrZuIBwEkqqZio1DIOYzfGje42p2s8TKZrMX+gIgDSiB4jcCw==
X-Received: by 2002:a05:6808:1486:b0:35a:3662:c693 with SMTP id e6-20020a056808148600b0035a3662c693mr1630798oiw.192.1668609430601;
        Wed, 16 Nov 2022 06:37:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a056830110600b0066d12f2441esm6633468otq.27.2022.11.16.06.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:37:09 -0800 (PST)
Received: (nullmailer pid 3814691 invoked by uid 1000);
        Wed, 16 Nov 2022 14:37:12 -0000
Date:   Wed, 16 Nov 2022 08:37:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        devicetree@vger.kernel.org, quic_srivasam@quicinc.com,
        quic_plai@quicinc.com, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 03/11] ASoC: dt-bindings: qcom,apr: Correct and extend
 example
Message-ID: <166860939523.3813949.14489034056819986470.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Nov 2022 13:02:27 +0100, Krzysztof Kozlowski wrote:
> Correct the APR/GPR example:
> 1. Use consistent 4-space indentation,
> 2. Add required properties to services nodes, so the binding check
>    passes once schema for these services is improved,
> 3. Add few other properties as APR/GPR is part of a GLINK edge:
>    qcom,glink-channels and qcom,intents.
> 4. Drop unnecessary services, to make the example compact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch.
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/soc/qcom/qcom,apr.yaml           | 61 ++++++++++++-------
>  1 file changed, 39 insertions(+), 22 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
