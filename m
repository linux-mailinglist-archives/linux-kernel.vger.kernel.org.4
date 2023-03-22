Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2793B6C4E57
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjCVOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCVOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ADB3A867;
        Wed, 22 Mar 2023 07:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31868B81D19;
        Wed, 22 Mar 2023 14:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341C4C433A8;
        Wed, 22 Mar 2023 14:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496136;
        bh=8DxEaJ30cqDPKcgyQB59S++Qld4UlbF+9S+zcpwtV68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYTy43ZQgsL1j3qV75CHRHJrMKuYXvuyXiznmbt2pfBY9Nnd05lYS44zQrAj/ZXnQ
         hKqMFBpYuqEhS/7Q1cl8waG+eaev2Z6z57TJfkeGh/U6KQdc3A2cmniTyjmVYvcl07
         ayutgqegNsU8Y4oScWPouyEcReZoEBRjH2XeZMBZY76YHublWRgXGpxoWeICzTe7Xm
         f+o9hDJr6SMDwOPeIZKA/QPPiG3pOFPmBNtcr0vfjujLqAgF4GvPxBSmZlPTNeGtFL
         Py/631yNz4xhee9L8OoxLHvcObxG1juNEJUc7sSW3vx6yuEhY+rE0qLlYnLQYgvy+a
         M/YYoJ6lQVWsA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 0/6] arm64: dts: qcom: sc8280xp-x13s: regulator fixes
Date:   Wed, 22 Mar 2023 07:45:07 -0700
Message-Id: <167949631654.1081726.7739109504366769251.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322113318.17908-1-johan+linaro@kernel.org>
References: <20230322113318.17908-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 12:33:12 +0100, Johan Hovold wrote:
> This series marks four of the regulators which have consumers not yet
> (fully) described in the devicetree as always-on to avoid the supply
> going away while the device is still in use.
> 
> The last two patches adds the missing description of the pmic regulator
> and hid supplies, which is needed to eventually be able to disable the
> regulators in question.
> 
> [...]

Applied, thanks!

[5/6] arm64: dts: qcom: sc8280xp-x13s: add pmic regulator supplies
      commit: ed066df385cb1a7286123a246337636f8debd18d
[6/6] arm64: dts: qcom: sc8280xp-x13s: add hid 1.8V supplies
      commit: b01899cb18659c9911cc790cd66784623e5e5a0e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
