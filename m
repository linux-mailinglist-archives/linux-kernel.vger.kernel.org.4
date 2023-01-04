Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323D365CAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjADAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjADAU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:20:28 -0500
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DE2FD30;
        Tue,  3 Jan 2023 16:20:27 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id q190so17408823iod.10;
        Tue, 03 Jan 2023 16:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V83unu/dgWIOer+77hb9Z8kEGKWwgriIpRWxhsjKe3Y=;
        b=KJV6oyUKFr4fvwiJ6boDWd6Q8ezh0m9VgyDuEmL5e4QYVZ+cxwFjOE+SuWBTVqeqEM
         QT+uxw0XyCA5HnSBzAIucbHG38PPMymhklcvm8UUjmlWmOy+hzCsLaZJbaJnavwP6wm4
         3E395wWx5KNy5yE3eGi6dXBnvm95t6N0ziw51OTa3thtRlNchQ8J98K7cqRuNece4F/4
         NYl5gzXmL8pZAowtnSBDeo41Vhh//Y/bcWXKPXEHWkJwM0XjHhj2jbWB7u6cwKq30zAc
         WzewTAkkw1a4Gpi4wLN1HuHl+28SJzyBBeqQZD10sRhLusvar7S6AAC8VZYRZKBPF7YG
         i8mQ==
X-Gm-Message-State: AFqh2kpWGsxNBUWfokargWfW615IRvskX8yM4kSCmEyeooQlMpL8Ei7d
        VIASLzq2kSoUz5WJEwzqmg==
X-Google-Smtp-Source: AMrXdXuv1hGJk8lfquTpLcS7/biZZcd23B/tCPFIIbvgei2vvOQ7G5YpoHCp2tegO6OVYgRUzIhblA==
X-Received: by 2002:a5e:9204:0:b0:6e0:27a2:1768 with SMTP id y4-20020a5e9204000000b006e027a21768mr30210378iop.18.1672791627051;
        Tue, 03 Jan 2023 16:20:27 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r5-20020a0566022b8500b006e01740c3b6sm12154582iov.2.2023.01.03.16.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:20:26 -0800 (PST)
Received: (nullmailer pid 131563 invoked by uid 1000);
        Wed, 04 Jan 2023 00:20:24 -0000
Date:   Tue, 3 Jan 2023 18:20:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <167279162395.131504.15364556098341067594.robh@kernel.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2022 10:23:55 +0100, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
