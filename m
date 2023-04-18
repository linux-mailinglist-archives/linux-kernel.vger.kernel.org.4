Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38EB6E6BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjDRSCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjDRSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:02:06 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A79A5D1;
        Tue, 18 Apr 2023 11:02:04 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1879fc89e67so490315fac.0;
        Tue, 18 Apr 2023 11:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840924; x=1684432924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52DDXGdLNEShITAc5JOG2UZwH2YBxeM0UslFfpBYM9Y=;
        b=BcDMrrEngYmvIOa1/XDcokFEOqM0q9fwrTI1d6f+b4/uEyEYzcV1FcrZYZgJEOt+ox
         1Uga/89RMsgOAdXYCm9KvTlZ5+k1crNQogBNgd2HBg1BHNA54PPvOl9XrzdzaX+4Z9kU
         n4glYyD6qP6gKIKi5Oj45G27zx/c1ZdYv5j2kAhdd5ISf4tekRaxh1rsmuHzSfXMyTyO
         HKOjg+kwjjXEiHMRQOpZTWqr4RAWtAup7gztDgJQUjckZ7d2/aLWcYUML/tHhOyKvyUz
         9SR5gVPdF70lB+glGIntXC3IWh+TldWOAT6i62bKH1J0RGqBOt/TjO4F6ZTgGGcogY9C
         +qjA==
X-Gm-Message-State: AAQBX9fIlrQtw4Vv03EkGDbZaZQMBEabTUps8ojpu9N6cEQ2plqK5Brm
        drqY5FKKw9Ie2WXfkIvSkQ==
X-Google-Smtp-Source: AKy350Z7akrNTmLW6o5dIL1AQ5/62r2EZXsK8BJOQQOdwSx+gZacCAHiNFH5kkVpdLx9pqKn0vSHGw==
X-Received: by 2002:a05:6870:9a23:b0:183:eb95:7166 with SMTP id fo35-20020a0568709a2300b00183eb957166mr1813376oab.15.1681840923874;
        Tue, 18 Apr 2023 11:02:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a056870b0c500b00172ac40356csm5795710oag.50.2023.04.18.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 11:02:03 -0700 (PDT)
Received: (nullmailer pid 2057312 invoked by uid 1000);
        Tue, 18 Apr 2023 18:02:02 -0000
Date:   Tue, 18 Apr 2023 13:02:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Halasa <khalasa@piap.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Imre Kaloz <kaloz@openwrt.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linusw@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Drop unneeded quotes
Message-ID: <168184087334.2054869.5890313933665475872.robh@kernel.org>
References: <20230327170146.4104556-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327170146.4104556-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Mar 2023 12:01:45 -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml        | 2 +-
>  Documentation/devicetree/bindings/timer/cdns,ttc.yaml         | 2 +-
>  .../devicetree/bindings/timer/intel,ixp4xx-timer.yaml         | 4 ++--
>  .../devicetree/bindings/timer/nvidia,tegra-timer.yaml         | 4 ++--
>  .../devicetree/bindings/timer/nvidia,tegra186-timer.yaml      | 4 ++--
>  Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml   | 4 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 

Applied, thanks!

