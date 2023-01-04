Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EA565CB0B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238479AbjADAni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjADAne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:43:34 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAD914D1F;
        Tue,  3 Jan 2023 16:43:34 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id u8so18875346ilq.13;
        Tue, 03 Jan 2023 16:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2k4JM3Ism4CtFSfuJ+KhOjo2x1iFKu4VD5n/toK9X4=;
        b=RefDDigRJpyqIPJmWP7QGgYxyGva3V3qHF3lVOnFaPgHA3oO2nbKE/gRzH9dD0cVJZ
         8/iBsNT8Itkllr0Niq7GMNQpjYaZMVaWJ+AuMp1/rszjU3LoPoNzESV51Uo3Ir+eIAnY
         PNJR18iLgfDlcJ3CajSbTojfZA02Dc69VFgJ4X4q9XJCAjw73ex1rkZ2Q6WfsRwV5DAu
         HfaenK1Ixn1ECz31ndp2pQmltc8FPCgI4rB0N1yL/OaBb2xabH2OAsaJ2C2y9v0tfMK3
         lx8x1j2PKi+LqAuXnkF55VaIB0mrmFoqIwHWbgziPOUDefyy0BRuKi5oauIDdrB++ERC
         itdw==
X-Gm-Message-State: AFqh2kry8zpCGXqUqKfpdu5m2I3N/CX/RA2/jZQj3CsmPQux8PWojKLP
        lbPjnxC234NDKZrgX+yrdQ==
X-Google-Smtp-Source: AMrXdXtILk8jSL6XxrjL11edtqTvq8MgBnBVfj9stmJ9CBSU3lgBfbjF8YYJIlpeP21SrJb7+XBvhg==
X-Received: by 2002:a92:ca85:0:b0:30b:cf5f:1275 with SMTP id t5-20020a92ca85000000b0030bcf5f1275mr30677323ilo.8.1672793013304;
        Tue, 03 Jan 2023 16:43:33 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v17-20020a02b091000000b00356738a2aa2sm10234717jah.55.2023.01.03.16.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:43:32 -0800 (PST)
Received: (nullmailer pid 163282 invoked by uid 1000);
        Wed, 04 Jan 2023 00:43:31 -0000
Date:   Tue, 3 Jan 2023 18:43:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,usb-snps-femto-v2: use
 fallback compatibles
Message-ID: <167279301050.163217.7817410182620857350.robh@kernel.org>
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Dec 2022 17:18:32 +0100, Krzysztof Kozlowski wrote:
> Document SoC-specific compatibles with generic fallback (e.g.
> qcom,usb-snps-hs-7nm-phy) already used in DTSI.  Add SoC-specific
> compatibles for PHY on SDX55 and SDX65.
> 
> This disallows usage of the qcom,usb-snps-hs-5nm-phy and
> qcom,usb-snps-hs-7nm-phy generic compatibles alone.  Do not touch
> remaining two compatibles - qcom,usb-snps-femto-v2-phy and
> qcom,sc8180x-usb-hs-phy - because there are no upstream users, so not
> sure what was the intention for them.
> 
> This fixes warnings like:
> 
>   sa8295p-adp.dtb: phy@88e5000: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['qcom,sc8280xp-usb-hs-phy', 'qcom,usb-snps-hs-5nm-phy'] is too long
>     'qcom,sc8280xp-usb-hs-phy' is not one of ['qcom,sm8150-usb-hs-phy', 'qcom,sm8250-usb-hs-phy', 'qcom,sm8350-usb-hs-phy', 'qcom,sm8450-usb-hs-phy']
>     'qcom,usb-snps-hs-7nm-phy' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/qcom,usb-snps-femto-v2.yaml  | 33 +++++++++++--------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
