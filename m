Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282B6D6382
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjDDNlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235174AbjDDNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:41:38 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B8D468E;
        Tue,  4 Apr 2023 06:41:32 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso34564106fac.4;
        Tue, 04 Apr 2023 06:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3I6cThnoomrgNOtBCTblrlL1is2L6H9KiAc6aOP6ctc=;
        b=xVqeStmZjPHwAEwZCaIKGogun0lfGY4J48d04yaJHsL1Yt2uHUfqvJ5Hk2fsyVYUW3
         p+AXyRL3cxA/wzIUa5faBAXmTeFRHNxwJ5Jnqlg4P6q4WcsbfaED04sYVBnFrv7pS2ZJ
         fVqFCPTXemsxGofpUm3nKMQC5rxNRKw/Ji7GX6dWav1MMD3gpjjmjoBX0Nxh8eAR596u
         ZxZxWmcUAPtyt6ykvAFDsAAQHbE5Hp8FU6/bIdP7BqrdGrP6BjJEP4E46nv846mQZdQP
         NqlanCv2+sJjej1szpuK/FH172R1G0gxxUAjAlz/M3IwuMC428HUzRpq6RQoxx9WPrDi
         8YJw==
X-Gm-Message-State: AAQBX9fvWEGs+Rtmf7zEMqdxYDpsABHzsJXz7UIX9TlGFLDnLO3Ce3R9
        GNN4eSFO1oPxbtyqQeY45A==
X-Google-Smtp-Source: AKy350bKGsx+/Tt/VIIG128S9NPudARV02KnL1yfh2vnqwtnyPDoIkASjDjLF9wtWnumEJBdxTf7Ew==
X-Received: by 2002:a05:6870:309:b0:177:9040:d236 with SMTP id m9-20020a056870030900b001779040d236mr1371463oaf.28.1680615683906;
        Tue, 04 Apr 2023 06:41:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b006a13dd5c8a2sm5554659otq.5.2023.04.04.06.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:41:23 -0700 (PDT)
Received: (nullmailer pid 3782488 invoked by uid 1000);
        Tue, 04 Apr 2023 13:41:22 -0000
Date:   Tue, 4 Apr 2023 08:41:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     rfoss@kernel.org, andersson@kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, bhupesh.linux@gmail.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        neil.armstrong@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/11] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
Message-ID: <168061568226.3782433.11290866098182220844.robh@kernel.org>
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
 <20230402100509.1154220-2-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402100509.1154220-2-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 02 Apr 2023 15:34:59 +0530, Bhupesh Sharma wrote:
> Add new compatible for BAM DMA engine version v1.7.4 which is
> found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
> to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
> accordingly.
> 
> While at it, also update qcom,bam-dma bindings to add comments
> which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
> This provides an easy reference for identifying the actual BAM DMA
> version available on Qualcomm SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

