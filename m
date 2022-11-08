Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066E6205F7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiKHB2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiKHB2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127B2C67F;
        Mon,  7 Nov 2022 17:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4E46137A;
        Tue,  8 Nov 2022 01:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C985C43149;
        Tue,  8 Nov 2022 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870885;
        bh=IwfGldCNUbJJjSCkSuB4o9XLZwgK37CcEm6Jocq7UbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqNnblCP0EMjcvGul1l/7XqrXuyFetaekzqIpVLf9Ve9Gdi5Uw0fd0/vLycvRAObJ
         GJdwlguw0VagE5eVxxwKqX3DMpeksGg6X9tSuWp+jRqxiYRRW1V9WRRnWDfrMkeBwk
         pvFC4HwsIUODoPZdSKIAbM9v+9+XMRwicOJvA3txQRcc+9bj4V9LJzcoe7ae2KIq4T
         R/07vf1xqWaz8OEJsuPksMQTrE2gIErgUfY1FDu8eGTBvS3Ps+gr1m1T5BXIK6yQoD
         z1IfSQWodp2XVTDwZ/R1m4cNp10SKwncrEfiNj5gy2pDezaJJMx+JzNdJAvRJKpRvA
         2ju6qvPxbsfCA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, quic_molvera@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/4] Add base device tree files for QDU1000/QRU1000
Date:   Mon,  7 Nov 2022 19:27:35 -0600
Message-Id: <166787084680.599230.300024170657831654.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026200429.162212-1-quic_molvera@quicinc.com>
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
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

On Wed, 26 Oct 2022 13:04:25 -0700, Melody Olvera wrote:
> This series adds the base device tree files and DTS support for the
> Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
> regulators, mmc, interconnects, cpufreq, and qup.
> 
> This patchset is based off of [1] which adds support for the PMIC arb used
> on these SoCs. It also requires the dt-bindings from [2], [3], [4], [5],
> and [6].
> 
> [...]

Applied, thanks!

[2/4] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
      commit: cc677f9006c4277bd25881c6713e5ef79bddd79a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
