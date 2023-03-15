Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055E86BC124
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjCOXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjCOXco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90324484;
        Wed, 15 Mar 2023 16:32:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9923061EB8;
        Wed, 15 Mar 2023 23:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14520C4339B;
        Wed, 15 Mar 2023 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923143;
        bh=twdYEQ0P4kTyElulfalQGVpJPxrIZ7fHl/Cxxq7/zpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHqVOl5jcXwR0ZiZUd2g3gYSaWLXn7HtRlrgwOmaYZtxubC2zCtweGbhoT8rSOZMI
         lwLIsN7nl2obDAf3iI2+ISmsyxx9+GJf0dgvgKiVgq1ON2zZpypzKbdPLE7lEYxBlz
         f4NcL98Wfv4IQsNo71wrGCxu10lRbg7PLnRpC1qmG47aKhaLa51bNrNwWKlWwuXUjP
         G28JgAykux5WCiGFDGmUVSXrIQsPZZbKYX62KOkclM/TClcvimB9Xk+DgfApxYJQc2
         Q82UqwbiZ4llPOMFpm72bur5I1nS4KA/ysdU7PBzwsQa32o17N7fo/90Wdu1dAT3ln
         2sVZo+ghWh/Gw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, Joerg Roedel <joro@8bytes.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: (subset) [PATCH 1/5] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Date:   Wed, 15 Mar 2023 16:34:52 -0700
Message-Id: <167892332566.4030021.5101665756298971397.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
References: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
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

On Thu, 16 Feb 2023 15:56:42 +0100, Konrad Dybcio wrote:
> Document the Adreno SMMU present on SM8350.
> 
> 

Applied, thanks!

[2/5] arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
      commit: c564b69984a78ce7811f22437794c9bb2afc11fd
[3/5] arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
      commit: 3e5c00256881f35b8664e1cf0b9fbf42cd9f24a1
[4/5] arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
      commit: 8347b12e905b99f445067d09326e4a1cc490f9cc
[5/5] arm64: dts: qcom: sm8350: Add qcom,smmu-500 to Adreno SMMU
      commit: 78c61b6b2c33041940f2b22b47b058e83684b3f5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
