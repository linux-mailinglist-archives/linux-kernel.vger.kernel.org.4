Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2E6BC12F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjCOXdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjCOXcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC629BE13;
        Wed, 15 Mar 2023 16:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C175B81F97;
        Wed, 15 Mar 2023 23:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBD6C433AA;
        Wed, 15 Mar 2023 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923145;
        bh=l5kDFvuxr96g2gXNYSMyfhfzCMHvMCfYfJIdOm1uTwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djm5MwOcmxVQW+8duMGCnlnInqc4hFgXNKmH6bjgacGm7B2CaG8wI1DPvhW76cZPx
         pMfy70o27Zda0Vi0P2uTw63ZtjDZ49cCCrsh2YgU6xQl5tVZ0EUjtW+Ipo8LQ4hk9W
         iKVfWch42N0SHItGcCYD9P95O18UrvmwNuil0/SWWW3Aq/Hi5OICoUMOH7erXZgnT6
         b/Z/QmAkQifKrc+zwTpg7LBRHc/ReZk2nVlhW+GczOhNMQ9PJutvVjpGQprLv8GsyE
         Nkfd1dbWmzLfOL80F+uHV6O2wj+SBbfTRuq7EoMgqXnevo1kyyryB0vdOHciJMPedV
         Y9ul1ExPw3PcA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        krzysztof.kozlowski@linaro.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
Date:   Wed, 15 Mar 2023 16:34:54 -0700
Message-Id: <167892332565.4030021.334263743247962516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230213210331.2106877-1-konrad.dybcio@linaro.org>
References: <20230213210331.2106877-1-konrad.dybcio@linaro.org>
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

On Mon, 13 Feb 2023 22:03:31 +0100, Konrad Dybcio wrote:
> The name stm-data-base comes from ancient (msm-3.10 or older)
> downstream kernels. Upstream uses stm-stimulus-base instead. Fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
      commit: b5d08f08377218b1d2ab4026e427a7788b271c8e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
