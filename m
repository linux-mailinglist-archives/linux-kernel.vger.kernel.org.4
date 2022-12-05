Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097AE64349D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiLETsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiLETrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:47:46 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616C72D4;
        Mon,  5 Dec 2022 11:44:21 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id h132so14275328oif.2;
        Mon, 05 Dec 2022 11:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RmATd2q1+x2EW0v+mUv7xDaYHexVioaWjz3s4HKhtY=;
        b=GSI8N6CGA6brb311vU8NvZ4KkZk5P1uFGQgiy5SAvb3+FFd88dWCXIdILNPz1EjWBK
         1XfxHrTqneYZtWo8+FjFdh37xCa4wvVRy1nfbisMCfajtivUpATkpVAyMymFI4psQSgP
         Zxg8e8C/QCBN/BBVoyP0vWx3ixnnHfzO2qXHyw+TunK86nyx0+nsSo3DKguuwXkq/2o9
         CIfGMHmJBGf/DphNSJQY4pI7ppul1/z7bESZLrgSoznWTjhG2lhYeeHl+dy/jb7tk2TL
         LNRrtWTYsbzPP3SQbb6iVgKwi30eXl+fpWi1uJ1Gyd3oOSJa9s4TXGgtwHtaWqWXA8ix
         D4/g==
X-Gm-Message-State: ANoB5pmf4k6b5QS3Cdksk0BDsash65rcufC62HdUFjdf7mJd+ARyS72m
        XVOlSGe/Mof03+efpmruCQ==
X-Google-Smtp-Source: AA0mqf62ytDm52jAEXZXM+QYeT9eMz0HtIK5GS5evNrv4EF2JucWuHvro8011jueT/HVsG7CfQMnCA==
X-Received: by 2002:a05:6808:30a0:b0:359:f059:ed05 with SMTP id bl32-20020a05680830a000b00359f059ed05mr41564463oib.148.1670269460530;
        Mon, 05 Dec 2022 11:44:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a05687041c600b001442fada152sm6975896oac.46.2022.12.05.11.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:44:20 -0800 (PST)
Received: (nullmailer pid 2474209 invoked by uid 1000);
        Mon, 05 Dec 2022 19:44:19 -0000
Date:   Mon, 5 Dec 2022 13:44:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 06/15] dt-bindings: remoteproc: qcom,adsp: split
 common part
Message-ID: <167026945884.2474151.16819271414676448843.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:24 +0100, Krzysztof Kozlowski wrote:
> Split common part of Qualcomm SoC Peripheral Authentication Service
> bindings into a re-usable schema file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v2:
> 1. Allow only one or two clocks, after dropping clocks related to PIL binding.
> 
> Changes since v1:
> 1. Keep resets, reset-names, qcom,qmp and qcom,halt-regs in qcom,adsp,
>    because they are not shared with most of PAS bindings.
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        | 81 +---------------
>  .../bindings/remoteproc/qcom,pas-common.yaml  | 97 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
