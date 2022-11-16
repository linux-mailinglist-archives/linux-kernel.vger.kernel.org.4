Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453C62CABD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiKPUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiKPUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:22:50 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFC63CF5;
        Wed, 16 Nov 2022 12:22:46 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-13c2cfd1126so21441420fac.10;
        Wed, 16 Nov 2022 12:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgK1rUnmFyPXMa4kFguFgRQCBODLxAzA5c3KNx4CYyA=;
        b=I3LZEcnmFsaXXGIx3ZzzK0T9hDM0BA0B3eUw9KWnxgyr1ba9q3PyA/hAMcH/U9+O8i
         +rQ/HLk0bGgIjGgyAQKYQ0TftRIOF6MOQBoJaHjY4u360eZ3O0SmT9Rft2XQnWvqnDhB
         84gOXP6AYU8YI/8PN82nwUEgKwY/lYI+ajZ0uQcyLGcOsuPOYP/0o98a3yJmlg5uQSc+
         jPCFolT0L03l/k5Xv2z091MVm5YheP5pmMFYQwXTf5W6bnWd+MrU5o8KHZp6YggyczQJ
         jtnCAacBjCbAK4ub8fYnKqZV35Mj4cVpD2/R2c4O8B7QIQJlRb1+dfRlRGxrj0r4041j
         4OZQ==
X-Gm-Message-State: ANoB5pm9eXbGKogCxfOHCoH3DeRkv+yWx7PjVieQaEXD9/ntxkLCNXtH
        fV9+EpfJMAy1JoA49GW0JQ==
X-Google-Smtp-Source: AA0mqf6Zz+aI/iuvrsoTgE0DD8XHfnfXOCIxD7/a202TUht3yY/MjAgq/K+lsqKSP6eH9QbNcQQfOQ==
X-Received: by 2002:a05:6870:6a98:b0:136:66d0:b853 with SMTP id mv24-20020a0568706a9800b0013666d0b853mr2596240oab.161.1668630165974;
        Wed, 16 Nov 2022 12:22:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e11-20020a056870238b00b00136f3e4bc29sm5007128oap.9.2022.11.16.12.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:22:45 -0800 (PST)
Received: (nullmailer pid 826080 invoked by uid 1000);
        Wed, 16 Nov 2022 20:22:47 -0000
Date:   Wed, 16 Nov 2022 14:22:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sven Peter <sven@svenpeter.dev>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        asahi@lists.linux.dev, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop type from 'cpus' property
Message-ID: <166863016450.825960.2284429197449442060.robh@kernel.org>
References: <20221111212857.4104308-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111212857.4104308-1-robh@kernel.org>
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


On Fri, 11 Nov 2022 15:28:56 -0600, Rob Herring wrote:
> 'cpus' is a common property, and it is now defined in dtschema schemas,
> so drop the type references in the tree.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/interrupt-controller/apple,aic.yaml | 1 -
>  Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml     | 3 ---
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml   | 6 ++----
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml     | 2 +-
>  4 files changed, 3 insertions(+), 9 deletions(-)
> 

Applied, thanks!
