Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F66434F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiLETyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbiLETxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:53:18 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94500BF1;
        Mon,  5 Dec 2022 11:52:25 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1441d7d40c6so14706991fac.8;
        Mon, 05 Dec 2022 11:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRqeIhRPnbhB102J/bLtZm3V3YmXlwZIVcITyw6wscw=;
        b=5C/Or96K2BzfJdZaHxpMkvgWiGYPs6p9a7eIhQqqveq3cGpDleRH7ezzSPgxC7gcd9
         Phi9VLriwqbx9Ydp8Rwlm3VXV7b61D7XcFkVRMW2ctHozexcpJxCrLzAxP9DpbKjIilY
         1tgBI6RE/Q8TWYQNWK/D3+fhufV3FAiPwWyazu7miIqUm2PIHWMhANMfGoHZhPc83hX1
         ntfZS1Z8YGFVIXYFvt1EwqTY1H1QNiG8lXCCFPMbsaRAUTVkWS8kqqq27kcwyRKlfEz6
         RLHtidF4hUTovvhRys2jABwxuifrAQE13hI/SEPB/Rkowv3W2LdsA7terSH9mOqOyLgL
         COfA==
X-Gm-Message-State: ANoB5pnQWKZWPiAUVHOtQvp/GntUpTqdmr3N1M8oMrkobWUqas/RQtvZ
        RJrqI84A7qavUgm9uBsIzg==
X-Google-Smtp-Source: AA0mqf5plAU4ZzrfNY/nDF1R11fgmJCqi640xhEhhlBGgApHOOoyJIXgH5YzRC8SLa7vCJrHZzvj2w==
X-Received: by 2002:a05:6870:6b08:b0:144:8c6d:33ca with SMTP id mt8-20020a0568706b0800b001448c6d33camr4115174oab.217.1670269944778;
        Mon, 05 Dec 2022 11:52:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d9-20020a056870960900b0010d7242b623sm9668989oaq.21.2022.12.05.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:52:24 -0800 (PST)
Received: (nullmailer pid 2485570 invoked by uid 1000);
        Mon, 05 Dec 2022 19:52:23 -0000
Date:   Mon, 5 Dec 2022 13:52:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 13/15] dt-bindings: remoteproc: qcom,qcs404-pas: split
 into separate file
Message-ID: <167026994341.2485510.11528426862252025282.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-14-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-14-krzysztof.kozlowski@linaro.org>
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


On Thu, 24 Nov 2022 19:43:31 +0100, Krzysztof Kozlowski wrote:
> Split QCS404 remote processor Peripheral Authentication Service bindings
> into their own file to reduce complexity and make maintenance easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. New patch.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 12 ---
>  .../bindings/remoteproc/qcom,qcs404-pas.yaml  | 86 +++++++++++++++++++
>  2 files changed, 86 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,qcs404-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
