Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53496437C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiLEWLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiLEWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:11:26 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A31AD90;
        Mon,  5 Dec 2022 14:11:25 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so8173201otb.1;
        Mon, 05 Dec 2022 14:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92zrpPL2isoOuIrrH1my3HzkOjBY0w33Uv97jaygHyA=;
        b=XzKS7tDPf0kBvctKaxc0w6UYoT7SDelAGsE28PhNjuMm387doxp3j0+pcKCo1qvl0I
         rXmL4SDfXH6FWu81oO6RxumsWi86T/E6S7fcFO4tHKiK2kz4h60NS7UJ5s8IZTx6iTEY
         z15rYC4kBNw2HgGcYiQmJu+9LQafIS0AquM1T9JNbu4RQh72vJJHpfcztB8i9rVdzhlc
         U4vYHDvoEpk6Q6zyDSYv2nsnyEWEOU08wukSfo8ALHExXvw+EX8v4aTKXEQCW4cOPLBO
         UibNNoZn7s1XB2JJkuoKxWLoqJmm2iCY3gJrcrMiVrtuXqe/GfR00Sr1PVO905zq6EQ8
         Ei1g==
X-Gm-Message-State: ANoB5pkibaU/FobdruAbvD8xZy7FUk0oWuUu8bmZfzjoEEnrHciH35MN
        pCbLYtd1CK3BUw1Xd7GWXxxhEsXu4A==
X-Google-Smtp-Source: AA0mqf46PUZGYgfyzVmCFYfo10rkkbg5CujUG8ZpHy+XzOEZvhateOumUCSz8PB99OAf44ddLA1sSA==
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id x11-20020a9d628b000000b0066c6afa5006mr36135099otk.233.1670278284631;
        Mon, 05 Dec 2022 14:11:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j125-20020acab983000000b0035b451d80afsm7486305oif.58.2022.12.05.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:11:24 -0800 (PST)
Received: (nullmailer pid 2778814 invoked by uid 1000);
        Mon, 05 Dec 2022 22:11:23 -0000
Date:   Mon, 5 Dec 2022 16:11:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-mmc@vger.kernel.org,
        abel.vesa@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/5] dt-bindings: mmc: sdhci-msm: allow dma-coherent
Message-ID: <167027828316.2778752.10639863966103490623.robh@kernel.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
 <20221204094717.74016-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221204094717.74016-5-krzysztof.kozlowski@linaro.org>
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


On Sun, 04 Dec 2022 10:47:17 +0100, Krzysztof Kozlowski wrote:
> SM8350, SM8450 and SM8550 SDHCI controllers for SD card are marked with
> dma-coherent, so allow it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> dma-coherent was first added to SM8450... then to SM8350 (not merged
> yet) and now it appeared in SM8550 patches, but I actually do not know
> if this is copy-paste or real need.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
