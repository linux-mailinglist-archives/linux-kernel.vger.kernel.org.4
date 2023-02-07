Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB17268E2AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBGVJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBGVJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:09:26 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865C7EC2;
        Tue,  7 Feb 2023 13:09:25 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id z25-20020a4ad1b9000000b00517affa07c0so1562488oor.7;
        Tue, 07 Feb 2023 13:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9c7XvbZAUdWDf7nNLp27Ktc3CfEaERb1M20H7Mbo8Q=;
        b=giZKjcVaW4M4bnUD9Qhm8ai2uXx+t3wK3CxHHopmBxD5yX/kepcr5b218xffPt5TeM
         IF3BFpxe9GOXe9PFD+BYGg0CZ0kfa+onFYdGo1fMeeSogmvCyB2TixESX2cyGZxRBye3
         DIqoHhHVsJj5tDJWwuc0r5xuxxxY3fxukhoV8QE8+mCpAQ6mrtfvXTCME1nmdLpa4xtu
         usPEKIbnqQULBolScxKsy6uPsUTolLhTgJ1ymZiWPe5/o0yZCCARlY9OuKVHKovRska2
         G4De4icwq+7yTWWPYUnW9N8XCrpmghFHIFrx0bNSNu1d+PRx7T1XtfOQrx8iQ/3kksX/
         LmYg==
X-Gm-Message-State: AO0yUKX43acawRDtFZFgCzEwRIXzB4ZTdMuKpRxwai6SSChdTvXChbxw
        9N9Q38fg9FWoQF1r9H6hBQ==
X-Google-Smtp-Source: AK7set9hYvSsD7ijfMjSHXl0S/b2WUkS1Mzm3qfXTuUrdWltUepRqAPhxD4UYFzRBJlwX8K9W7eZaQ==
X-Received: by 2002:a05:6820:198d:b0:51a:186f:88c4 with SMTP id bp13-20020a056820198d00b0051a186f88c4mr2446005oob.0.1675804164591;
        Tue, 07 Feb 2023 13:09:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 1-20020a4a0901000000b004fb9a65daf1sm6490624ooa.43.2023.02.07.13.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:09:24 -0800 (PST)
Received: (nullmailer pid 4158478 invoked by uid 1000);
        Tue, 07 Feb 2023 21:09:23 -0000
Date:   Tue, 7 Feb 2023 15:09:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: remoteproc: qcom,sm8550-pas: correct power
 domains
Message-ID: <167580416297.4158419.15449374286163338071.robh@kernel.org>
References: <20230206193313.30667-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206193313.30667-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 20:33:13 +0100, Krzysztof Kozlowski wrote:
> Correct CDSP and MPSS power domains to match what is used in DTS and the
> Linux driver:
> 
>   sm8550-mtp.dtb: remoteproc@32300000: power-domain-names: ['cx', 'mxc', 'nsp'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml   | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

