Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B7672575
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjARRsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjARRry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:47:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A63CE0D;
        Wed, 18 Jan 2023 09:47:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E973161944;
        Wed, 18 Jan 2023 17:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C15EC433EF;
        Wed, 18 Jan 2023 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674064069;
        bh=dTOao7OTnDD2Bljll1cIh3aZadqaefZ1UzKEm/3O13s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iT9y7TEGJZWJK/D9ZgOxj5SpFsBm9v0WjU7S38iXzcBR1FgigHN9MHeM0yaPntq7Q
         g1H1dET0MsaTIHxWIZiLxvpDbso5Hso6mUsUylgH2M6wc0GosV82ee/BNvhviIt/KI
         ILtW5yYOB4RrF4BumnY2jK7vq4YmY6sPooHzsjWRgJNI/v/dm+9AN9XdfSVmmPypO1
         ijyf7ScoBCof2ZN0IcsF+AYAMV7vtvAkrRnWoQalqhAy0ge60BVoM5MwjJkngjZq6z
         mJrtEYCtVP79xafZcEdcbxtHbilFsH4+D+90tkE/vsRx6HyyOLsIQLSKVnppepinWc
         5EgLJv1JXFbqQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, robh+dt@kernel.org, neil.armstrong@linaro.org,
        mani@kernel.org, srinivas.kandagatla@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, amahesh@qti.qualcomm.com,
        mathieu.poirier@linaro.org, konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        elder@linaro.org, abel.vesa@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v4 0/5] remoteproc: qcom_q6v5_pas: add support for SM8550 adsp, cdsp & mpss
Date:   Wed, 18 Jan 2023 11:47:47 -0600
Message-Id: <167406406337.2924867.12230424280288709048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v4-0-54154c08c0b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 17:22:39 +0100, Neil Armstrong wrote:
> This patchsets adds support for the aDSP, cDSP and MPSS found in the
> SM8550 SoC.
> 
> The aDSP, cDSP and MPSS boot process on SM8550 now requires a secondary
> "Devicetree" firmware to be passed along the main Firmware, and the cDSP
> a new power domain named "NSP".
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: remoteproc: qcom: adsp: move memory-region and firmware-name out of pas-common
      commit: cee616c6884616aea3be72a9debafd0614332682
[2/5] dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible
      commit: 084258d607128a7486311daf5e67ca414ee07cc9
[3/5] remoteproc: qcom_q6v5_pas: add support for dtb co-firmware loading
      commit: 29814986b82e820ae9d3eb7474cdcf66605bd114
[4/5] remoteproc: qcom_q6v5_pas: add support for assigning memory to firmware
      commit: c63c0a7cab91b930a6ee78c28b481b84bfa98b7f
[5/5] remoteproc: qcom_q6v5_pas: add sm8550 adsp, cdsp & mpss compatible & data
      commit: 7eddedc975638f9bf427e7964c74276450a3021d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
