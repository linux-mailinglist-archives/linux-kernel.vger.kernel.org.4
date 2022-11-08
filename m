Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDF620850
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiKHEgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKHEgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:36:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE62183F;
        Mon,  7 Nov 2022 20:36:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1BB6146A;
        Tue,  8 Nov 2022 04:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E38FC43140;
        Tue,  8 Nov 2022 04:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667882194;
        bh=ODwmXCKA67s3XmvfocubOCK6ltn04D/Uq8ybMJLmAXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUC7MRdGc6RdhrtjK15L5s5G0ILbiT825S3I1SjhtS+bVSxJIL2L3MV3wHiaGX6Zo
         sTunhnAdet7TtqOSncn5XhkebucgkyKkD6iYrhAP1mfgbIi3NFLue51ihxtr9wr5Io
         i50vA4gNKABANuAWSleum4301EfoW3IqYN7j0qCCPOelWQsOo497pxVIX1mSLY1K54
         vF9E0tbDS2+Njo37B3OdszSQzhroTzhPts8dwgR13XnJo8/rWdTTmR6xsWLfbqTRJR
         c/cp99cihumtfPjV0kJ70i7YjCthDTmCPc8BdOpdz/TKueu6mxzCloHdqdZrOevxcC
         48YiVQgX+gJbw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        luca@z3ntu.xyz, iskren.chernev@gmail.com,
        stephan.gerhold@kernkonzept.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, treding@nvidia.com, vkoul@kernel.org,
        konrad.dybcio@somainline.org, chanho61.park@samsung.com,
        lpieralisi@kernel.org, patches@linaro.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH RESEND v3 1/4] dt-bindings: arm: cpus: Add Kryo 660 CPUs
Date:   Mon,  7 Nov 2022 22:36:27 -0600
Message-Id: <166788218322.625965.4879146051199489927.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107120920.12593-1-konrad.dybcio@linaro.org>
References: <20221107120920.12593-1-konrad.dybcio@linaro.org>
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

On Mon, 7 Nov 2022 13:09:16 +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> 
> Add a compatible for Kryo 660 CPUs found in at least Qualcomm SM6375.
> 
> 

Applied, thanks!

[1/4] dt-bindings: arm: cpus: Add Kryo 660 CPUs
      commit: 7c1b74e079b983196512769f19812d883d4b87fa
[2/4] dt-bindings: arm: qcom: Document SM6375 & Xperia 10 IV
      commit: 03ed3432a4e457ee08261ff0639ae99ae3dfa909
[3/4] arm64: dts: qcom: Add initial device tree for SM6375
      commit: 59d34ca97f91df08d56d3ac843c7a8c6935bfca8
[4/4] arm64: dts: qcom: Add device tree for Sony Xperia 10 IV
      commit: 4420e60416cb9073fb0d2cb6f10d1830e2a84646

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
