Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A56F8BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjEEV65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjEEV6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:58:52 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616575244;
        Fri,  5 May 2023 14:58:44 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-192cd5579faso1972067fac.1;
        Fri, 05 May 2023 14:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323923; x=1685915923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbgIOnkpYCYYpEoxomNQGFoUuvsXx9duXQwywtiwyZ4=;
        b=EWQeF/a4c8L0Ifk5Oow3iEB50abgoJcYPi8bjHKPjCQO2G3rphvvbDId9825s8yOSc
         +siXkNgCjmvpu6SKHOc9raDtwEMPYqumrFnl7R28s7V/bDxGo0ywbkfS3OmrfKfAoCjQ
         CscOnjGhC9tbIiH31d8B3JQghWODocALBVO/eUe9En6W3GIK0aIlLFDjsw9opup4EsHF
         Jhmdew+FXOLvKZ8q6zGRSna09EOQcL1xweOdcKbPLuNQTJmXvzc71JTBg1mC9ww22mBV
         WStmUfNoTaWqpurCHWhyLhBHWbts29umnVqmVIzXdgVx1sJ+HrBV//ZpQmPh2paU6zdX
         S7iA==
X-Gm-Message-State: AC+VfDyQE73R+WnXD5M5kxf4UEW0m67doV5598/I0fz6T5yyHy8HJ+c/
        ol4Mq2ViUuxsMnDj1nou+w==
X-Google-Smtp-Source: ACHHUZ5OymvDRj77K/L2WzILHBdu6s//tHlq/nfzZShylPCvd7YmeQDLnFN7vYge8apcmW2hecM1mQ==
X-Received: by 2002:a05:6808:4394:b0:38e:25f1:ddcd with SMTP id dz20-20020a056808439400b0038e25f1ddcdmr1269717oib.20.1683323923587;
        Fri, 05 May 2023 14:58:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a4ae60b000000b00547372059afsm1487720oot.4.2023.05.05.14.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:58:42 -0700 (PDT)
Received: (nullmailer pid 3633776 invoked by uid 1000);
        Fri, 05 May 2023 21:58:41 -0000
Date:   Fri, 5 May 2023 16:58:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        thara.gopinath@gmail.com, devicetree@vger.kernel.org,
        amitk@kernel.org, andersson@kernel.org, daniel.lezcano@linaro.org,
        agross@kernel.org, rui.zhang@intel.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1 1/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <168332392113.3633716.4128640191394678480.robh@kernel.org>
References: <cover.1683027347.git.quic_varada@quicinc.com>
 <cbf916e31b00e0e0599a3012a84a4740df89f4e0.1683027347.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf916e31b00e0e0599a3012a84a4740df89f4e0.1683027347.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 03 May 2023 10:15:59 +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

