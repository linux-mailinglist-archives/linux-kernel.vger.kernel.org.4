Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00D86434FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiLETy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiLETyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:54:22 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338CB7F7;
        Mon,  5 Dec 2022 11:53:15 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12c8312131fso14757642fac.4;
        Mon, 05 Dec 2022 11:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtM2aZf2zZAFjHPoQ/E6ZGb3yRF0xN5gv6sCCUEu8bg=;
        b=zt/omViabR4ftVodxEc5hpggz3c529sCnfFBfk299qf5ZqVaJWc5kho++pipnpRbIL
         1D4sbKL42S8RSqmoVtTD/5le8YUM7xemT0WZ1fp2jvulH1cAJbzsA5LfXBILCliUBy8I
         fDiHCLwtWGaZT6tlmgZBNPnfdltLJV8pW29TWBIAbcb+7fH4SWCzbvGOQrh+xfiHedyJ
         nJpAExyGcP9Wz8bBTLKJDl5iOR1A8kOL4eb+el7ZH6qSnfaAUseVjTnaZGPxrStulIYs
         Zd/ZuFNzIu49n2juxxarYDKwJKK/6jyna1BKHP6BWM8PFgkQs9nxEtVN9CSZ+E0GxnG1
         vqNA==
X-Gm-Message-State: ANoB5plRDaisiMxHveaN6mE12HhLpZqKBYfn8zQO/32mrDIVrNoWkQve
        rEj7oeJgMvajawXML3GqLg==
X-Google-Smtp-Source: AA0mqf5gJMGNDylXQlLJ8q6y60B/bKAPJN3gQeW3BBsHP8siiUGCTtQym0mi+kxygrF2/EDnQ6A7qA==
X-Received: by 2002:a05:6870:c688:b0:13b:e41d:290b with SMTP id cv8-20020a056870c68800b0013be41d290bmr37753929oab.64.1670269994521;
        Mon, 05 Dec 2022 11:53:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a9d7083000000b0066ec7348974sm1863739otj.37.2022.12.05.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:53:14 -0800 (PST)
Received: (nullmailer pid 2486978 invoked by uid 1000);
        Mon, 05 Dec 2022 19:53:13 -0000
Date:   Mon, 5 Dec 2022 13:53:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 15/15] dt-bindings: remoteproc: qcom,adsp: correct
 msm8996-slpi-pil clocks
Message-ID: <167026999306.2486908.12917512847992232424.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-16-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-16-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:33 +0100, Krzysztof Kozlowski wrote:
> According to DTS and Linux driver, the MSM8996 SLPI PIL takes two clocks
> - xo and aggre2:
> 
>   qcom/msm8996-oneplus3t.dtb: remoteproc@1c00000: clocks: [[20], [3, 64]] is too long
>   qcom/msm8996-oneplus3t.dtb: remoteproc@1c00000: clock-names: ['xo', 'aggre2'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. New patch.
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
