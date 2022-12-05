Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0B6434BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiLETtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiLETs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:48:56 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE3E264AC;
        Mon,  5 Dec 2022 11:46:10 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so7927111otl.10;
        Mon, 05 Dec 2022 11:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oQD2RkFUqEg2em9xEYcSEtRxlY9CVzz7vYONYiUx9s=;
        b=i6N+87fozP45x5KRGgmanFmTKB33qlYVTnLWwghFK1JZLx86J1vSattJQpc3fbPTv6
         jMzLt2MWINDtTaeWQro/Zm4dXuaYMWw+g11vy1BnTSMNki0HhV/k11eFdNHthKo+SXZn
         1cSde+Uc3ju3Uor68LHUbwEbPzLDPDT6w637Of42Ku2Z17FJo4lmXgal0BP6lYQGuUxm
         JFvx9yAkVRayAUzvc4BZtIoqIUTIvA+ZWk7fFk+FNUzPDNEFqrIgQUpWb9mDenfsdtrN
         FkpvxNSvI6QJIH/t+zwvR2mgr0bQqPOSI6nWbaisAuKfrV+ZB0ahEEnrrTGbTqwgPpvV
         JNTQ==
X-Gm-Message-State: ANoB5pk1akwThMWHy45EcyY3La8BUqXh1MD+4+1BM9a9of+liZMvTqoi
        +P6mB5AaADVUzPiOMS+dXjit/Z/d4g==
X-Google-Smtp-Source: AA0mqf5iwBCXWpQMZUnlFU4Dw5gh6BLWT90uuCTAQ9uxeK32l2fBQY7R92L0Q4I8qPUv6M5Mmz/fEQ==
X-Received: by 2002:a05:6830:1e76:b0:66d:3137:20b7 with SMTP id m22-20020a0568301e7600b0066d313720b7mr42385153otr.228.1670269569566;
        Mon, 05 Dec 2022 11:46:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 123-20020aca0781000000b0035028730c90sm7507663oih.1.2022.12.05.11.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:46:09 -0800 (PST)
Received: (nullmailer pid 2476815 invoked by uid 1000);
        Mon, 05 Dec 2022 19:46:08 -0000
Date:   Mon, 5 Dec 2022 13:46:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 08/15] dt-bindings: remoteproc: qcom,sm8150-pas: split
 into separate file
Message-ID: <167026956809.2476755.5763624089022586393.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-9-krzysztof.kozlowski@linaro.org>
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


On Thu, 24 Nov 2022 19:43:26 +0100, Krzysztof Kozlowski wrote:
> Split SM8150 and SM8250 remote processor Peripheral Authentication
> Service bindings into their own file to reduce complexity and make
> maintenance easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Drop if:then: for the clock and put it directly under properties.
> 2. Merge two if:then: clauses for setting interrupts.
> 
> Changes since v1:
> 1. Add qcom,qmp (not part of qcom,pas-common.yaml# anymore).
> 2. Add firmware-name to example.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  27 ---
>  .../bindings/remoteproc/qcom,sm8150-pas.yaml  | 166 ++++++++++++++++++
>  2 files changed, 166 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8150-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
