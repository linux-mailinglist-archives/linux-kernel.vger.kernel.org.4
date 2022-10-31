Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59F61401A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJaVpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiJaVpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:45:12 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2814083;
        Mon, 31 Oct 2022 14:45:11 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so14957965fac.1;
        Mon, 31 Oct 2022 14:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foZleSHJS3Wtg9Ww5hakvytOudBWym5CaB+K5swVYfg=;
        b=UDsCS19mbozFdGpyqRfSUKpAOka2okSV7RwIuDTuIobXca9F+9Tke2UUVeGdzB+QVb
         1Ysr9lAPOPfdvYtjOXd0IWTzLlC4qcwmQeILl3te1hzioU5rCkoModABjs2lA9WraZNg
         +7Lb1jc8Dno16+iZWsaPNchAVRysVe5+ZrbkwlRphTnqx/5GzR59S/mu1n20SUsmBgx9
         XE6xKKf6FaT1cXpXAJ05IxPC0WmDqnAK7c7pJH9ucCQTs4gNb4INtIhBoDxyd83l90Wa
         hWybH8WKeMjl2s+6akcy8MbwSKHQovtQYEfKJS/zU3qXz6xK43hofVMw9kKc91jfwYyT
         JR9w==
X-Gm-Message-State: ACrzQf2PjqjaiiS6TRxhbfeSVf5zQutgyzf5XBXgvqvolaamCy8WsjWM
        x66Hn2ih9yI5Shp07sQ4tA==
X-Google-Smtp-Source: AMsMyM6Hh9hh+av/WnARd8ReaocOnqw6068tCkQzgp0z38FOhn0eps2gxYxBYnLes9Jw223nXRz9Sg==
X-Received: by 2002:a05:6870:e3d1:b0:13c:9dbb:7e95 with SMTP id y17-20020a056870e3d100b0013c9dbb7e95mr9024880oad.43.1667252710890;
        Mon, 31 Oct 2022 14:45:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a4acb07000000b00494ed04f500sm2805034ooq.27.2022.10.31.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:45:10 -0700 (PDT)
Received: (nullmailer pid 3622710 invoked by uid 1000);
        Mon, 31 Oct 2022 21:45:12 -0000
Date:   Mon, 31 Oct 2022 16:45:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for
 Qualcomm SM6115
Message-ID: <166725271158.3622671.481660062453926156.robh@kernel.org>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-5-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094258.486428-5-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Oct 2022 11:42:54 +0200, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
