Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BD46434DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiLETx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235155AbiLETxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:53:00 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8BB33A;
        Mon,  5 Dec 2022 11:51:00 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so2389968otp.9;
        Mon, 05 Dec 2022 11:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD28eVmOnHMN4V/EYLh/6HsYiYP7fS1FfA0Dugnv6xk=;
        b=U3L3xph7uDeWnipZlNVDhd/Vcd9KDSWJqJL4ZOfVKdjCY60XkMuUx1wAuSiAkknJNl
         S2lI47NQY0pup9uUig0YvdoIMCVf6zvbFoFNkqu65SM25PiRJOLsCiJ+PZkHJ+TqgHnC
         JsSODVWrF7qP7aMbcMOVREnD7PB+LK2e0r6JGPhbkR+Ed5iT2c38WnuCd2ql1ZyMOQBD
         LZ/SRnXLGSWXYepg4We0TONMSNc8r2ATSKifKFNtLIpy0GCUQThxBwFBTf86FDP2ojhj
         Ox+eY1N/xNPHiOF6W9hv3pgX5YJPNydoHbFODa8sUyGafMEIyW6dPYrlGoY8UFFUZXjO
         HSdg==
X-Gm-Message-State: ANoB5pnp05hg8JVL3xTEt9bwcco32TX3nbdIx8aE8xvJogUj5HnG/KeJ
        fnNy/72xx2L8fbljYPV8neHTgRm2dQ==
X-Google-Smtp-Source: AA0mqf6Wl0XvR2fi0gK8OtRwgluMeFPLr6AxBKOyykxbsdtdg246Bk1+vcrVwoyO+3boOwg7U902TQ==
X-Received: by 2002:a9d:6a19:0:b0:66e:aa89:ddc3 with SMTP id g25-20020a9d6a19000000b0066eaa89ddc3mr4402500otn.352.1670269859843;
        Mon, 05 Dec 2022 11:50:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o25-20020a4ad159000000b0049f8801ed22sm6982563oor.30.2022.12.05.11.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:50:59 -0800 (PST)
Received: (nullmailer pid 2483360 invoked by uid 1000);
        Mon, 05 Dec 2022 19:50:58 -0000
Date:   Mon, 5 Dec 2022 13:50:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 10/15] dt-bindings: remoteproc: qcom,sc8280xp-pas:
 split into separate file
Message-ID: <167026985833.2483296.11985694616851942687.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-11-krzysztof.kozlowski@linaro.org>
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


On Thu, 24 Nov 2022 19:43:28 +0100, Krzysztof Kozlowski wrote:
> Split SC8280XP remote processor Peripheral Authentication Service bindings
> into their own file to reduce complexity and make maintenance easier.
> 
> While moving correctly constrain the number of interrupts per specific
> device.
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
> 3. Correct maxItems: 5 for interrupts.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  26 ----
>  .../remoteproc/qcom,sc8280xp-pas.yaml         | 139 ++++++++++++++++++
>  2 files changed, 139 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc8280xp-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
