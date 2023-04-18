Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDE76E6E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDRVrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjDRVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:47:16 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716903C1E;
        Tue, 18 Apr 2023 14:46:52 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-18785c2f39fso597312fac.3;
        Tue, 18 Apr 2023 14:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854412; x=1684446412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGw6D66cZdcr6xGEclYHRxqaFcm+w1g5mT8B0eSxI9c=;
        b=Fy3ZI3HqLE+lMbZf1I0kfovmSWQ9KwepPpfG/jMg38tQUODna5iqGJHKAzw/R9jYbY
         SyhQg8LbnJJ+lJPDUYCHyx6f+83ByhbX8xd/IXwVycahEHcSOZlgbRPFxvZXie14hkrS
         oZNgzd5AzR+G4DpwjJyTV/Dr8j8Z7brKFprE/qQ7/2z4qdepYrdyQ72GjJ4qdNrOFrEe
         23TqyuyITP9nXMgKfxwyncW+meNJ6V5N5FmY6gPMTGyP/bytEqEA3DGz0x3JslGWWpZc
         dT3QzW26Zex+i10ef+L3es1f65x+3JLoDc3H/9GFT6r0g/TfWOI+y7BzUaaJzTSEGsX+
         0B7g==
X-Gm-Message-State: AAQBX9cV65REyMgHMsHNCzP1+ljc3aK4R/v2yd+8uuQ1flGwifveMfgE
        MKYe2RSBYLpzOy+dsxRAIw==
X-Google-Smtp-Source: AKy350bikdghipfMrjoTcerhWJjfmLIKH2C0VvRDP9yN49p+xvxfYy55O4uK11WgsTTyhfmwzOSELA==
X-Received: by 2002:a05:6870:1f95:b0:184:7e77:b107 with SMTP id go21-20020a0568701f9500b001847e77b107mr2215598oac.57.1681854411664;
        Tue, 18 Apr 2023 14:46:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a056870e60400b0016e49af5815sm5971062oag.51.2023.04.18.14.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:46:51 -0700 (PDT)
Received: (nullmailer pid 2385547 invoked by uid 1000);
        Tue, 18 Apr 2023 21:46:50 -0000
Date:   Tue, 18 Apr 2023 16:46:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: document flash LED
 controller
Message-ID: <168185440998.2385492.2952415565992678104.robh@kernel.org>
References: <20230416123203.299740-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416123203.299740-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 16 Apr 2023 14:32:03 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SPMI PMIC come also with a LED controller for flash LEDs,
> already used in DTS:
> 
>   sm8250-hdk.dtb: pmic@5: 'led-controller@d300' does not match any of the regexes: ...
>   From schema: Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

