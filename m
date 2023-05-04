Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172A6F785D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjEDVzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEDVy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:54:59 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631F111B5F;
        Thu,  4 May 2023 14:54:53 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-192a0aab7dfso894495fac.3;
        Thu, 04 May 2023 14:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237292; x=1685829292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybSwMPkAzIFkTGDcSk41rri9acnk9seXpVIY7hgiv10=;
        b=QKjYPs102mSYHtO5ZkRJL452cEUpV+gJ2zx6vyDHfQXV+SpSvSNMzSo5nMi4rF90dK
         ULquihVfLaDJ9eI0n0Iob4lsZmrpZDGu6zraxeppxm8BWwAwREvf+8bLAxh6Vl7Bfwf0
         iBFByJjYkHx/BJLa2mxcBanWTaxL0d29LXmkYMsRjC3YsEPlMeFoynyoRFBhWOmhLODV
         GmEPo6tl0YNI7wQJVQEeP566c/7pn5HjSsdBQpbNbcqCL3dTDDmkkefmaXUYC5TCxpx1
         8I3t7KfEBLY4uyTkU37GpO0pLfvlYHf3kQ4NK+PJfn/qEC6v/zIL9fw5zCHrrJah0ucX
         6ZnQ==
X-Gm-Message-State: AC+VfDy9SFExHvJlLwkD9eOzXZeAyn3D2cvxw1kEjq9PnXfxlKBMCwK1
        hl0+2gAteGkrGGBOXiZDKg==
X-Google-Smtp-Source: ACHHUZ4ZaTUowtigLlqEuT3bSo9DQHKVU+1iTaCKLpma/RA/6Q9tiQgg+V7ZpKqj5zZs8Hz0Vu+3Kg==
X-Received: by 2002:a05:6870:32c1:b0:17e:d34c:8c24 with SMTP id r1-20020a05687032c100b0017ed34c8c24mr1494984oac.47.1683237292595;
        Thu, 04 May 2023 14:54:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y17-20020a056870381100b00187d06465edsm1090897oal.43.2023.05.04.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:54:51 -0700 (PDT)
Received: (nullmailer pid 444306 invoked by uid 1000);
        Thu, 04 May 2023 21:54:50 -0000
Date:   Thu, 4 May 2023 16:54:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v1] dt-bindings: perf: riscv,pmu: fix property
 dependencies
Message-ID: <168323728954.444248.7169255540576935609.robh@kernel.org>
References: <20230404-tractor-confusing-8852e552539a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-tractor-confusing-8852e552539a@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 19:03:22 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Seemingly I mis-implemented the dependencies here. The OpenSBI docs only
> point out that the "riscv,event-to-mhpmcounters property is mandatory if
> riscv,event-to-mhpmevent is present". It never claims that
> riscv,event-to-mhpmcounters requires riscv,event-to-mhpmevent.
> 
> Drop the dependency of riscv,event-to-mhpmcounters on
> riscv,event-to-mhpmevent.
> 
> Fixes: 7e38085d9c59 ("dt-bindings: riscv: add SBI PMU event mappings")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Atish, I'm not 100% on this one but I noticed it while doing dt-validate
> on a dump of the qemu virt machine which doesn't use the
> event-to-mhpmevent property.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Atish Patra <atishp@rivosinc.com>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: devicetree@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/perf/riscv,pmu.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!

