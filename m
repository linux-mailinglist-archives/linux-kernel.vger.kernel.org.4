Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB736434D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLETxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLETw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:52:57 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47CBB2;
        Mon,  5 Dec 2022 11:50:40 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id q83so786110oif.7;
        Mon, 05 Dec 2022 11:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Faja+CA1qqpktVRzHV8b+4BSFiXMnlNP9AqBY0hBfq0=;
        b=7zqAPL6mNm3p49WnbuxgKH3hAsYAwwszrzQZr9ZD6LNwd3JLykZkYBN61TNTyyMbFC
         PUAyiBEJyV/39kF4Oa0STjqH7uGODnIa14vuAchIxXYRX/2Xf5Q6VAgc7kYz+zyRF2Yz
         O05Co00sPDpweD0pBRnsPSE/1VBRyCJFT1Dx/mq5uJoGpn560LRKk1Q67mdS+S1dNilw
         5zED9xYDzRHT6Za9ZDIBhazQwn+169e3EDsWyab17X4Sc2bGzhxc6duf27jh0NRtRcCU
         nqLMKjxJkGJ1IqC2q4/eP6zZP0kTDZodtfMFtR5+pbFIADh3qo5/gEu2aMBi7ilt2+kE
         1JuQ==
X-Gm-Message-State: ANoB5pnSSyq6zBzlib1Qz+O+G611bD766xelUJoxAugrstP8CHzhcfMx
        f8yH4CH1ZnB5oFuOtNfa1bsVKZJ/vQ==
X-Google-Smtp-Source: AA0mqf6IVC94fItJEZ6bBQIsKwej634/8PW14pd35nqA0hF2NEKer7CYdLowNLs9neDqmpAZf85+cA==
X-Received: by 2002:a05:6808:2216:b0:35b:aacb:988c with SMTP id bd22-20020a056808221600b0035baacb988cmr19952703oib.189.1670269839651;
        Mon, 05 Dec 2022 11:50:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fp43-20020a05687065ab00b00140d421445bsm9585016oab.11.2022.12.05.11.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:50:39 -0800 (PST)
Received: (nullmailer pid 2482807 invoked by uid 1000);
        Mon, 05 Dec 2022 19:50:38 -0000
Date:   Mon, 5 Dec 2022 13:50:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v3 09/15] dt-bindings: remoteproc: qcom,sm6350-pas: split
 into separate file
Message-ID: <167026983773.2482747.5205889553808461964.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Nov 2022 19:43:27 +0100, Krzysztof Kozlowski wrote:
> Split SM6350 remote processor Peripheral Authentication Service bindings
> into their own file to reduce complexity and make maintenance easier.
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
> ---
>  .../bindings/remoteproc/qcom,adsp.yaml        |  28 ---
>  .../bindings/remoteproc/qcom,sm6350-pas.yaml  | 159 ++++++++++++++++++
>  2 files changed, 159 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm6350-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
