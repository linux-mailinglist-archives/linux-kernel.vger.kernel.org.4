Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104861E8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiKGDMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKGDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9343DF8A;
        Sun,  6 Nov 2022 19:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3420EB80D8F;
        Mon,  7 Nov 2022 03:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED97C433D7;
        Mon,  7 Nov 2022 03:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790757;
        bh=xSarG0tAU/SBUZo/l5uciGdCVm+EuqT0ZUYkek4PDVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCTett2Sg4rPGOHKU3NSjCJFYGqluETa0eDj4GUPemrsKUXK+rbBDCpbwegLEzGwP
         A7P0m7HzCOJItso1XF5V4E80HmdN9QiiQ/PxJAWU6iXH5V1kkMfR3S/ocZHUmYFUks
         lF8RLH7bFmptoOiPP6Hf9yMNrD7hVnHRifi02OovBHZYjXk1SpCBCD2vbhEJtmEIlQ
         ov0Vx9DXBGer8VeMlQbvpMxDWST7VCHT9NjIeJdg7vX6QoUAUAhLocsN7m1L2OYzVN
         KLVVbMR0VyW0ZibfjBbukAkZamnGDyBu5NIAnWXSjX9mKxoA0xq8kZlF6WDUYPA88O
         aQqvsf4wXM9EA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     angelogioacchino.delregno@collabora.com, agross@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, kernel@collabora.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Support MSM8976 SAW2 for both clusters
Date:   Sun,  6 Nov 2022 21:11:56 -0600
Message-Id: <166779074270.500303.16911926659610369577.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
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

On Fri, 4 Nov 2022 14:34:50 +0100, AngeloGioacchino Del Regno wrote:
> This series adds support for the L2 cache SAW2 on MSM8976,
> required to configure sleep modes and managing part of DVFS.
> 
> AngeloGioacchino Del Regno (2):
>   dt-bindings: soc: qcom: spm: Add compatibles for MSM8976 L2
>   soc: qcom: spm: Implement support for SAWv2.3, MSM8976 L2 PM
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: soc: qcom: spm: Add compatibles for MSM8976 L2
      commit: 7a21fddb355a01c5655d43e4723c6fe99f2a4146
[2/2] soc: qcom: spm: Implement support for SAWv2.3, MSM8976 L2 PM
      commit: 33268bb9fdb64f57c08d400709bae7b9cda3120a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
