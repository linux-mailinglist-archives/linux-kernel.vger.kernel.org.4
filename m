Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80365657225
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 03:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiL1Clp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 21:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1Clm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 21:41:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C34CE30;
        Tue, 27 Dec 2022 18:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F272AB81230;
        Wed, 28 Dec 2022 02:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48D4C433D2;
        Wed, 28 Dec 2022 02:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672195298;
        bh=C3DuWTKdSmlik28u6X8Nhy+o+aaoLNtuw2d3yhjh5Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwYONudidM4bHE56WA3nEDQA7PmUiJSbLuie+MEUt87nV0qKb5rKL5qovELQMdJgN
         VsVlZZzi1NQkQAs+SMLFHtbK+7oGQIi/POhSETviu8yVaPUzc9hMckhDamY7rkE+vE
         +4Y3kXAiIOrQkr6HaGKyOrsH7VHF8+ps4rDZoN5/Ti+4hhyzSY2kBCdJIqlAVdg/2+
         LlmhQ1hJvrOdy/M7g+gLQ/ueUaFENQDD/dXZnQvwx4ajHGpuz2nXvermf4c3pMxHEL
         nLB2S02cgKDHQsO7hdAVB9MzZUKDNvE0BFsM4R0lfQMnguZ5VMPXPvGiNH7DY/mgUg
         psf+T2z3o64pg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     angelogioacchino.delregno@collabora.com, agross@kernel.org
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Qualcomm Ramp Controller and MSM8976 config
Date:   Tue, 27 Dec 2022 20:41:31 -0600
Message-Id: <167219529291.794508.12592366718100436457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
References: <20221117132956.169432-1-angelogioacchino.delregno@collabora.com>
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

On Thu, 17 Nov 2022 14:29:54 +0100, AngeloGioacchino Del Regno wrote:
> This series adds the Qualcomm Ramp Controller driver, necessary on
> various legacy Qualcomm SoCs to enable CPU DVFS by programming said
> controller with the right values, where the bootloader doesn't do
> that before booting the kernel.
> 
> At least MSM8976 and MSM8956 require this initial programming to be
> performed on Linux.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
      commit: 922ef52cea18567bd6a7e083c6acd776b5676bb6
[2/2] soc: qcom: Add Qualcomm Ramp Controller driver
      commit: a723c95fa137f7a1e86dc77a150ef6e2affe977d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
