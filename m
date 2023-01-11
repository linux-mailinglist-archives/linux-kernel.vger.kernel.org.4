Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7676665CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjAKNdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239044AbjAKNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:24 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F581AA35;
        Wed, 11 Jan 2023 05:29:15 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r132so2150314oif.10;
        Wed, 11 Jan 2023 05:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h8C+5qel0vaPITy9VRFkGBy56XK9V3m0cKDXnq516Ks=;
        b=Qu8vCmOqxxn6ziXjixbatRtqTC6XszvqvSBcUDzFOQsJGOvz1Wio057tuQAGYLOUMb
         C3ITKuM07kuw1oYQbtYPlVCixRDbskBvoyD+UNjaSSll5aysuEnYlXn/njr6hg++7koo
         HK01sMxHt4lYpVDPGR2zUXrz5xc147iqrUwKrNdAMuZiigQsJGxqOXpuRtt4f1YO90MV
         sbTS8n8Lm3Y/6fCqLcuRmGJr09RlijVnYM9UrmtDepdI302H3m8xI54QM/GZ3bxryQjl
         s8XGmJ7WMg3xsZxBgjLk00Qm0PMLq1NQSy0a9wI0lhBzCyF+MpeBZnhO+RsYvlBCsyf6
         BMsQ==
X-Gm-Message-State: AFqh2kpdqOHkasut0x0AqUE9gMsQkQFy+h0uW5q2OMRUERuOCysblsTL
        L2ATEr4cOm3IuarCorgghQ==
X-Google-Smtp-Source: AMrXdXvfF9QGekktP4rzGDpDsZz2K/EGEQjcV5LgpQkxLWZS9uLrozigktW/puGJ9oLq6EUAOu4FwA==
X-Received: by 2002:a05:6808:3a85:b0:35e:7e7c:83ed with SMTP id fb5-20020a0568083a8500b0035e7e7c83edmr31374712oib.5.1673443754956;
        Wed, 11 Jan 2023 05:29:14 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a9d744f000000b0066e820696edsm7485021otk.13.2023.01.11.05.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:29:14 -0800 (PST)
Received: (nullmailer pid 408843 invoked by uid 1000);
        Wed, 11 Jan 2023 13:29:11 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, amit.pundir@linaro.org,
        devicetree@vger.kernel.org, sumit.semwal@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will@kernel.org, regressions@leemhuis.info,
        manivannan.sadhasivam@linaro.org, catalin.marinas@arm.com
In-Reply-To: <20230111114337.24782-5-quic_sibis@quicinc.com>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-5-quic_sibis@quicinc.com>
Message-Id: <167344323183.397649.7383594948698294379.robh@kernel.org>
Subject: Re: [PATCH V3 04/10] dt-bindings: remoteproc: qcom,sc7280-mss-pil:
 Update memory-region
Date:   Wed, 11 Jan 2023 07:29:11 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 17:13:31 +0530, Sibi Sankar wrote:
> The dynamic memory region used for metadata authentication would still
> be a part of the kernel mapping and any access to this region by the
> application processor after assigning it to the remote Q6 will result
> in a XPU violation. This is fixed by using a no-map carveout instead.
> Update the bindings to reflect the addition of the new modem metadata
> carveout on SC7280 SoC.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3:
>  * remove double space [Krzysztof]
>  * Pickup R-b
> 
> v2:
>  * Pad commit message to explain bindings break [Krzysztof]
>  * Split dt/bindings per SoC  [Krzysztof]
> 
>  .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230111114337.24782-5-quic_sibis@quicinc.com


remoteproc@4080000: memory-region: [[226], [227]] is too short
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: memory-region: [[231], [232]] is too short
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb

remoteproc@4080000: memory-region: [[234], [235]] is too short
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb

remoteproc@4080000: memory-region: [[240], [241]] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb

remoteproc@4080000: memory-region: [[243], [244]] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb

remoteproc@4080000: memory-region: [[248], [249]] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb

remoteproc@4080000: memory-region: [[251], [252]] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb

remoteproc@4080000: memory-region: [[252], [253]] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [231] is too short
	arch/arm64/boot/dts/qcom/sc7280-idp.dtb

remoteproc@4080000: qcom,halt-regs:0: [236] is too short
	arch/arm64/boot/dts/qcom/sc7280-idp2.dtb

remoteproc@4080000: qcom,halt-regs:0: [239] is too short
	arch/arm64/boot/dts/qcom/sc7280-crd-r3.dtb

remoteproc@4080000: qcom,halt-regs:0: [245] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dtb

remoteproc@4080000: qcom,halt-regs:0: [248] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dtb
	arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [253] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [256] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb

remoteproc@4080000: qcom,halt-regs:0: [257] is too short
	arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-lte.dtb

