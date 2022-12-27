Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C01656DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiL0SIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 13:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiL0SIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 13:08:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A6F22;
        Tue, 27 Dec 2022 10:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96888B8117A;
        Tue, 27 Dec 2022 18:08:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692BEC433EF;
        Tue, 27 Dec 2022 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672164507;
        bh=Dk53CrhfhfmbIX1qYUefjJ5yOfddXAGZ6MMYK4h0Pl0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=A5d28eAKT2f1nkoZZh4cBix3FJwqkMpFyoyiC396ciF+D/iiGcLERFQRjY/Fpz4dd
         ruTysSEEjHCdd+RAUsfnSVcUpWOGoU5fd7o8CkvmiuD48QWeP6/2PwfbI5POME4iM2
         uwNt/Zytos5Kel4NDu4NP3YFXKM/Z9f9XkyPjsvBwR0CVSIlaXT5p2OXaDnIVf30Vn
         Oc4QMD2nOIlm9vbfTtKxnBk6/Mb5co/BW+NaqD2tuzFBwoNpgrGsE9UAK/nlBnlTbW
         eywu0qHvroThNMbm+osyVL0MlAexqbYEfTTanr57gT37ufeMRsrqmSAwetj7v8dbhL
         lju8nxJk1ZHGA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mani@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, mathieu.poirier@linaro.org
Subject: Re: (subset) [PATCH v3 00/15] dt-bindings: remoteproc: qcom: split and reorganize PAS/PIL
Date:   Tue, 27 Dec 2022 12:08:25 -0600
Message-Id: <167216450118.745591.6304578385014026556.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 24 Nov 2022 19:43:18 +0100, Krzysztof Kozlowski wrote:
> Changes since v2
> ================
> 1. Allow only one or two clocks, after dropping clocks related to PIL binding.
> 2. Drop if:then: for the clock and put it directly under properties
> 3. Merge two if:then: clauses for setting interrupts.
> 4. New patches: DTS fixes, qcom,adsp: drop resets and qcom,halt-regs,
>    qcom,qcs404-pas, qcom,sc7180-pas and last msm8996-slpi-pil fix.
> 
> [...]

Applied, thanks!

[05/15] dt-bindings: remoteproc: qcom,adsp: drop resets and qcom,halt-regs
        commit: c97c4b480fcba2e6ebfacb3990d8b9092916d986
[06/15] dt-bindings: remoteproc: qcom,adsp: split common part
        commit: ea5a10ae295425c9f52577d91b2e45290291d242
[07/15] dt-bindings: remoteproc: qcom,sm8350-pas: split into separate file
        commit: 4e8b39a4d38ebb192ebff977d8a961fd97e7ce5f
[08/15] dt-bindings: remoteproc: qcom,sm8150-pas: split into separate file
        commit: db292776589f1fcbcf2fc6eaebe40a3a2abb4521
[09/15] dt-bindings: remoteproc: qcom,sm6350-pas: split into separate file
        commit: 41729b772c13105ee126ee6fe1bf2cd93c7bd258
[10/15] dt-bindings: remoteproc: qcom,sc8280xp-pas: split into separate file
        commit: 397c619cad8109f5904466ee76d5a1533d2f1590
[11/15] dt-bindings: remoteproc: qcom,sc8180x-pas: split into separate file
        commit: 4b4157518f1ab1276cd08dfab0e51b1409c22e40
[12/15] dt-bindings: remoteproc: qcom,sdx55-pas: split into separate file
        commit: b6f8410eab9270000b8b13b88bc038e9f27c2c45
[13/15] dt-bindings: remoteproc: qcom,qcs404-pas: split into separate file
        commit: 255d7a9581ed4506dddf993aad9dc27bff8296d1
[14/15] dt-bindings: remoteproc: qcom,sc7180-pas: split into separate file
        commit: 8bb92d6fd0b3788b4270eff547cb42cb64db1bff
[15/15] dt-bindings: remoteproc: qcom,adsp: correct msm8996-slpi-pil clocks
        commit: 569d3a7580bcbc463920b0d84ca5caf23e808f90

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
