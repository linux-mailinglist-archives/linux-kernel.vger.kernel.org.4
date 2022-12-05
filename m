Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581E76434BD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiLETtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbiLETs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:48:29 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0825298;
        Mon,  5 Dec 2022 11:45:46 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id o5-20020a4aa805000000b004a020f841cbso1854606oom.3;
        Mon, 05 Dec 2022 11:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+Yii7vntGkbD3PcFzbghkyfEMeEU5KC1swtLk0357A=;
        b=XiVRYBTo7Hc4WFprKDhvcBJRojXK4/IyhLhhn6M5q5fRW7g0FUhmAaY716tdB+MrbW
         S6KvHNqLIwoaF/NwsH+CVyJ99PsZ4QZLv60G2yiCxghhX3o4TnLBOrX8e2laubNMnOyh
         CuX7Mqhdv383X/LGTvX/JemdiZonjIqsjdinMrmSyQLgLHh+QnDxxUggI0qGZoD05/vJ
         hxP7bVe7ky5nDSY/k93yisu2BdvzbRktHj0HJzBQS64+jyDUOsikTkI/rmA8sv69GgvG
         uxdM3vUMvKTQYlrfT101IQJb5NREvOL805rBm8XH0i93eG2Jwj/igLzPwG/+FCFbbcqP
         iy0Q==
X-Gm-Message-State: ANoB5plDjaPOLhcOu3qku+OWhUQCfH/g9T3Fy+OzybU7dnOfjdhbN0lX
        csGMmRvX3Sd1oG602Hk6eSTPwZMeUQ==
X-Google-Smtp-Source: AA0mqf43g0po+ShiChAdiyODu38pR0HpgynMKterVYqAVgZjdxSrlZPF87lw+z+VMmVYS00unGrJ2A==
X-Received: by 2002:a05:6820:1790:b0:49f:b377:3e52 with SMTP id bs16-20020a056820179000b0049fb3773e52mr35494135oob.79.1670269545615;
        Mon, 05 Dec 2022 11:45:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p9-20020a4aa249000000b004a0783d7da6sm7008168ool.16.2022.12.05.11.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:45:45 -0800 (PST)
Received: (nullmailer pid 2476193 invoked by uid 1000);
        Mon, 05 Dec 2022 19:45:44 -0000
Date:   Mon, 5 Dec 2022 13:45:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3 07/15] dt-bindings: remoteproc: qcom,sm8350-pas: split
 into separate file
Message-ID: <167026954349.2476114.11004742399333486090.robh@kernel.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
 <20221124184333.133911-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124184333.133911-8-krzysztof.kozlowski@linaro.org>
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


On Thu, 24 Nov 2022 19:43:25 +0100, Krzysztof Kozlowski wrote:
> Split SM8350 and SM8450 remote processor Peripheral Authentication
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
>  .../bindings/remoteproc/qcom,adsp.yaml        |  48 -----
>  .../bindings/remoteproc/qcom,sm8350-pas.yaml  | 174 ++++++++++++++++++
>  2 files changed, 174 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sm8350-pas.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
