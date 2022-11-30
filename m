Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9FC63E078
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiK3TMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiK3TL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:11:57 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021754462;
        Wed, 30 Nov 2022 11:11:55 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 94-20020a9d0067000000b0066c8d13a33dso11836852ota.12;
        Wed, 30 Nov 2022 11:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWJ50zA5TVYr+bV59/c/vvQvcBXcydROn5Y49QwA5is=;
        b=l2aSdiY3I5W88WwSexypTyCM+QCwk48M8KSoMKdvmjXKZlVNL9mZZdAUCuDxMG/FlR
         8vXt54msnD1q4VBc9Sn8xdEeVd0rcETtmBNJBQpob92fB05unNyXJ+MiIGhFZHY6nJw8
         rwAL3IXWLzSWWmeYXuYRGr7s/tuecEYAGmmQDglSLIHzybmRJ2mfex66XJTnQdSvi4MX
         Xc/Hg924pF4XM6MCZM4C4veJVAiTIZ//aSnWyAR+Q9n5I9g2RbEgYho0nKuDwLfrVh00
         Q3Q1ewa3omSCq+L/oNX5C4SgI+bRWx3CDJ9v10slBViM1KmctlJaJEXThhEaI2L5+Qh0
         6EpQ==
X-Gm-Message-State: ANoB5pk1Ubhhr5BNwcBPBAqh6WQqkmCbz3sGV+3CrcZDtTyTc0If88cB
        vIqN6PiVLbC7Gr7wiTx79w==
X-Google-Smtp-Source: AA0mqf5BtN9/ALLfGJN4UbzKMXsCiP2XClCzcpivRvcaCR/jMsik2BTmOaxD4C/v6WKGMnF6B3ANJQ==
X-Received: by 2002:a9d:7656:0:b0:663:c86f:7573 with SMTP id o22-20020a9d7656000000b00663c86f7573mr22375282otl.187.1669835515050;
        Wed, 30 Nov 2022 11:11:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h17-20020a056870171100b00136c20b1c59sm1558055oae.43.2022.11.30.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:11:54 -0800 (PST)
Received: (nullmailer pid 2630250 invoked by uid 1000);
        Wed, 30 Nov 2022 19:11:53 -0000
Date:   Wed, 30 Nov 2022 13:11:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH 2/2] dt-bindings: firmware: qcom,scm: narrow clocks and
 interconnects
Message-ID: <166983551315.2630191.3710173249882859069.robh@kernel.org>
References: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
 <20221122092345.44369-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122092345.44369-2-krzysztof.kozlowski@linaro.org>
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


On Tue, 22 Nov 2022 10:23:45 +0100, Krzysztof Kozlowski wrote:
> SCM has clock inputs and interconnects only on some of the SoCs, so
> disallow them inb other cases, which makes the binding stricter.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Cc: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/firmware/qcom,scm.yaml           | 44 ++++++++++++++++---
>  1 file changed, 37 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
