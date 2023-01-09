Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57789662891
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjAIObB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjAIOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:30:47 -0500
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9A1B1C9;
        Mon,  9 Jan 2023 06:30:43 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id e22-20020a4a5516000000b004a3d3028bafso2493049oob.3;
        Mon, 09 Jan 2023 06:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZs5nSO5PMtmfvhHOu/9xt+IHBAq4OcNiwoujlYPxtc=;
        b=HjF1P9ekO+RDTyA/mGxBJeWZCttH00BjhCMM/rqDpedfcrgqx34vs+2pWRn1K5pmnn
         3btqDKSf/QsB7N87hHBPU6GJN5/WOLzfXRmCY0EXbCRnrF8MT0ImXNItuZkd3jgn+zCH
         h7m0TDvFswVjREdScBsQMzJHGQ17SYJz91Mte/qiTGVua5TgqYbpoQaRoihvBHlX9b+v
         kdy/XSqKL35CTw7nhhqdVrymOCRw9K8KXghu8/wlgwUR62q1pv074aGrgUI64loy/Abk
         1iW/F6VSv7rmKjOv6sJpJRg+fydX7P2ArVGYjBLWb6vj8e9O7Ee1e+EcEJiT/Y4zk6ul
         W9Ew==
X-Gm-Message-State: AFqh2kpEEniArQNPdu/PWiq6gI5djzRh/zrQhEnKUWLQCJKl78pYzhMs
        XOSQXJDKZzkIycA4/oLHRg==
X-Google-Smtp-Source: AMrXdXtrcAFpyRz33rIvEbgcOBaNXt9gBD46Co33QHUTb8jBNaxSiVfI0ILKOZR0/SNZTHAckYl6cA==
X-Received: by 2002:a4a:a845:0:b0:4a3:bcce:5b56 with SMTP id p5-20020a4aa845000000b004a3bcce5b56mr32467652oom.3.1673274642647;
        Mon, 09 Jan 2023 06:30:42 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e40-20020a056820062800b004f1c4baa96bsm4297809oow.6.2023.01.09.06.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:30:42 -0800 (PST)
Received: (nullmailer pid 237521 invoked by uid 1000);
        Mon, 09 Jan 2023 14:30:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, will@kernel.org,
        robin.murphy@arm.com, sumit.semwal@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
In-Reply-To: <20230109034843.23759-4-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-4-quic_sibis@quicinc.com>
Message-Id: <167327380020.68049.679512287478536329.robh@kernel.org>
Subject: Re: [PATCH V2 03/11] dt-bindings: remoteproc: qcom,sc7180-mss-pil:
 Update memory-region
Date:   Mon, 09 Jan 2023 08:30:36 -0600
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 09 Jan 2023 09:18:35 +0530, Sibi Sankar wrote:
> The dynamic memory region used for metadata authentication would still
> be a part of the kernel mapping and any access to this region  by the
> application processor after assigning it to the remote Q6 will result
> in a XPU violation. This is fixed by using a no-map carveout instead.
> Update the bindings to reflect the addition of the new modem metadata
> carveout on SC7180 SoC.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
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

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230109034843.23759-4-quic_sibis@quicinc.com


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

