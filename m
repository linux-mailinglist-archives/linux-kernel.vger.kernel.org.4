Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C1665CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjAKNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjAKNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:24 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FF01C41F;
        Wed, 11 Jan 2023 05:29:14 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-142b72a728fso15478953fac.9;
        Wed, 11 Jan 2023 05:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qd3Z8VO+VAf5/4p9366p9ZX04oJTF2Yoje1PaBs94g=;
        b=7u6VVfTek8n9UAFEmAv1KtecqzwzyHgYVPQF4L2Rjtknpd1Ix+H4wdrl/NjNd1V+AH
         AXUo912WdEe5iSbUleNAGmFRDFenWrflAtsZdxXM/iM8oLfCa1GqkNopjO18mtx3nlg3
         g3xQZFfodEeWO2/twcUitXKdgsXAA77ODfkHLLMnQz3C1YTt8gYbJIZcekQ73lUCSgNx
         p6YvrpYqZevWTiOGe0FBRnrdxdlOA7noonbX0o3hn86leZWIP71+xCGJA48dNmeV/pM5
         1fyn6/CYNkOi+Zu8GtRKCeOcwamctFmiTQ08ckAY707azUbEV46/XzZ92tASbva28oEK
         h6wg==
X-Gm-Message-State: AFqh2kqH5SDwP95rqyxiVl5T1bLNm/XPDrJfZRWrJG76xAS0cavQWLru
        qGx1BxIdC7OUcN/IX6IuTQ==
X-Google-Smtp-Source: AMrXdXu7ZxeBxERi6OVApYuwABQAkEHsnE8o1WlZHuu+mQl811oTHuSfkavMAFa4XbDNzzqlkgkxuA==
X-Received: by 2002:a05:6870:8294:b0:157:ded4:d8f6 with SMTP id q20-20020a056870829400b00157ded4d8f6mr8967053oae.40.1673443753687;
        Wed, 11 Jan 2023 05:29:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bb9-20020a056820160900b0049be9c3c15dsm7021093oob.33.2023.01.11.05.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:29:13 -0800 (PST)
Received: (nullmailer pid 408841 invoked by uid 1000);
        Wed, 11 Jan 2023 13:29:11 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     amit.pundir@linaro.org, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        regressions@leemhuis.info, manivannan.sadhasivam@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        will@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, sumit.semwal@linaro.org,
        robin.murphy@arm.com
In-Reply-To: <20230111114337.24782-4-quic_sibis@quicinc.com>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-4-quic_sibis@quicinc.com>
Message-Id: <167344323074.397198.6257468619548226699.robh@kernel.org>
Subject: Re: [PATCH V3 03/10] dt-bindings: remoteproc: qcom,sc7180-mss-pil:
 Update memory-region
Date:   Wed, 11 Jan 2023 07:29:11 -0600
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 17:13:30 +0530, Sibi Sankar wrote:
> The dynamic memory region used for metadata authentication would still
> be a part of the kernel mapping and any access to this region by the
> application processor after assigning it to the remote Q6 will result
> in a XPU violation. This is fixed by using a no-map carveout instead.
> Update the bindings to reflect the addition of the new modem metadata
> carveout on SC7180 SoC.
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
>  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230111114337.24782-4-quic_sibis@quicinc.com


remoteproc@4080000: memory-region: [[105], [106]] is too short
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb

remoteproc@4080000: memory-region: [[122], [123]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb

remoteproc@4080000: memory-region: [[123], [124]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb

remoteproc@4080000: memory-region: [[128], [129]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb

remoteproc@4080000: memory-region: [[129], [130]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb

remoteproc@4080000: memory-region: [[130], [131]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb

remoteproc@4080000: memory-region: [[131], [132]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb

remoteproc@4080000: memory-region: [[132], [133]] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [110] is too short
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb

remoteproc@4080000: qcom,halt-regs:0: [127] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [128] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-auo.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-mrbland-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb

remoteproc@4080000: qcom,halt-regs:0: [133] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360-wifi.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-parade.dtb

remoteproc@4080000: qcom,halt-regs:0: [134] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-ti.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-ti.dtb

remoteproc@4080000: qcom,halt-regs:0: [135] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb

remoteproc@4080000: qcom,halt-regs:0: [136] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb

remoteproc@4080000: qcom,halt-regs:0: [137] is too short
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb

