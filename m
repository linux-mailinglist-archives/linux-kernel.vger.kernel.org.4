Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D5656AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiL0MXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiL0MWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:22:37 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0959C76B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:19:15 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id c20so2837051ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lWSHAKtiPsDtgkX2rcEcG1df3ve/T2GKoX3O6Tm7Vig=;
        b=uIR065Dp7wPHoUh7TZLntTjJaAtOgm9k4wuBfxtEj7w3PwW4OxAqnyYF2saAEiwusj
         vU2OIdxtHgfDj63nrA0v4hgncrtk5qAAuiXOJVyfs2FE18KJ/AISocxxzR+IHGgEDat7
         9CGChEa76dAsMRnkGPsO4gaMjjpSgB6N/dWURNX1v10Zb4OqOuGJPNtjHR4i4+HCCJcC
         lUwGGgVaa6QY/VCGX8m0ZXnJXoDNXX94TejxHQQBeRZEzjJzgaKmwWCz3+NcMFeSAAX+
         7/nqQbxDkJuf08trR+gTL3PpFWj3wJG3QVhekFQToxIeUV17uO3HPS9kqxtGgH6BJgVV
         jHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWSHAKtiPsDtgkX2rcEcG1df3ve/T2GKoX3O6Tm7Vig=;
        b=dMU98ZooVfkDKQyyRJhOafth/u1oQ2iCpm4/XvivFeZ0hB2Jw69+IZM8520Tsx2zn8
         stD0qNb9kK6xEcoYFKsDqfEeyMkBzSzeMKZIELzIAr6tTmEf7iyflRVmfZMQc9btGlwq
         MkBOygRRD23PQ9AG6zVNk+WvZkEZSfiXyFx74aqQdghYx7EC+Mk61HwKxEExUPefRTCW
         ajbYdnSs9fsMGBtGx4jjBMFtLFLzSHQXo2JICwwdUPyozEiVMYj7m9B3M//reTStK96H
         5o9xeD4IFIecaq4euRw6hC3bRagkzwtRNn+3WOl+iMQ7vOca/BpJyK/wGit87WvWrVJL
         oUjw==
X-Gm-Message-State: AFqh2kr3X5biNKZ/u/Gwt0E2UQ0sbjxGr+KrUlw7enmuhkzjkG4qHFPi
        48t+p4PnXwleIAqp38n2NS/WyXVatg4VvwJts/VaBQ==
X-Google-Smtp-Source: AMrXdXsYz2lGrPY0q7M0+455zRuRNV5KPHADZ0Rc78pYQGBa7M2eaCMK/tEjA+XUREZbiaMa1wFmAmnUSWxhkFvUj0k=
X-Received: by 2002:a92:ab0f:0:b0:2ff:daa8:dbbe with SMTP id
 v15-20020a92ab0f000000b002ffdaa8dbbemr1938423ilh.14.1672143536694; Tue, 27
 Dec 2022 04:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
In-Reply-To: <20221213140724.8612-1-quic_sibis@quicinc.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 27 Dec 2022 17:48:20 +0530
Message-ID: <CAMi1Hd08aVZE4Hg_tnVd0-hb5QfUydEQjGhQyPdBTpE5O9Os4g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix XPU violation during modem metadata authentication
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2022 at 19:37, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
> The memory region allocated using dma_alloc_attr with no kernel mapping
> attribute set would still be a part of the linear kernel map. Any access
> to this region by the application processor after assigning it to the
> remote Q6 will result in a XPU violation. Fix this by replacing the
> dynamically allocated memory region with a no-map carveout and unmap the
> modem metadata memory region before passing control to the remote Q6.
> The addition of the carveout and memunmap is required only on SoCs that
> mandate memory protection before transferring control to Q6, hence the
> driver falls back to dynamic memory allocation in the absence of the
> modem metadata carveout.
>
> Relevant discussions on the mailing list:
> https://lore.kernel.org/lkml/20221114110329.68413-1-manivannan.sadhasivam@linaro.org/
>
> Depends on:
> https://patchwork.kernel.org/project/linux-arm-msm/cover/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/
>
> Reported-by: Amit Pundir <amit.pundir@linaro.org>

Smoke tested this series on db845c (SDM845) running v6.2-rc1, with the
upstream workaround (b7d9aae40484 Revert "arm64: dma: Drop cache
invalidation from arch_dma_prep_coherent()") reverted and I can no
longer reproduce the above crash in my limited (10+) test runs so far.
So for the entire series:

Tested-by: Amit Pundir <amit.pundir@linaro.org>

Regards,
Amit Pundir

> https://people.linaro.org/~amit.pundir/linaro-sid-developer-dragonboard-845c-569/6.1-rc4_defconfig
> Reproduced with ^^ defconfig SDM845 SoCs
>
> Sibi Sankar (4):
>   arm64: dts: qcom: Introduce a carveout for modem metadata
>   dt-bindings: remoteproc: qcom: sc7180: Update memory-region
>     requirements
>   dt-bindings: remoteproc: qcom: q6v5: Update memory region requirements
>   remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
>     headers
>
>  .../bindings/remoteproc/qcom,q6v5.txt         | 29 ++++++-
>  .../remoteproc/qcom,sc7180-mss-pil.yaml       |  3 +-
>  .../remoteproc/qcom,sc7280-mss-pil.yaml       |  3 +-
>  .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  6 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |  9 ++
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  9 ++
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  7 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  7 +-
>  .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  7 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          |  9 ++
>  drivers/remoteproc/qcom_q6v5_mss.c            | 85 +++++++++++++------
>  11 files changed, 142 insertions(+), 32 deletions(-)
>
> --
> 2.17.1
>
