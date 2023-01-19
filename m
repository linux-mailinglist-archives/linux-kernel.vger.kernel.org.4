Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5715674B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjATEuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjATEtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5B3D0DB7;
        Thu, 19 Jan 2023 20:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F18DB82708;
        Thu, 19 Jan 2023 19:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA5AC433F1;
        Thu, 19 Jan 2023 19:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155355;
        bh=B6WQVoKviGDo5Lmu/PR7ZIGyspBOx43F6uoNLJC8g2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLfeub4rKI7vD91AaKS0pn8I21qqkeaKjwX0QRVRS1tbAkHNcFaTtb2xPyU9WAm7X
         BV83IzRxLTsVKX4W9u2UI99FeicOcUFaqzzgjKPTU6Wdlx0BSjgpcY7ZkmdCqFoJml
         OvowNVKJZkep78xI0532l/B4TGGe7NvKVPlet3S0L+hmd1QCu0rqBJP3zGiXhn6cnf
         GEGofDcQyp1iWMdDegAmCxRd8rM96v121ESi4X5REp660nMaqm6DHfP8c7/eF/BNmS
         UgdZcoTICI4sLLsFr7OhenHw/34XXPTQ6mCzavcliEE5hMkgpcQOMrcaAqIx5wFXvf
         d8UzL0oJJgW+A==
From:   Will Deacon <will@kernel.org>
To:     iommu@lists.linux.dev, Luca Weiss <luca@z3ntu.xyz>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v5] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
Date:   Thu, 19 Jan 2023 19:08:39 +0000
Message-Id: <167414938328.2378422.11457059166338062006.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221105142016.93406-1-luca@z3ntu.xyz>
References: <20221105142016.93406-1-luca@z3ntu.xyz>
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

On Sat, 5 Nov 2022 15:20:17 +0100, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: qcom: Add Qualcomm MSM8953 compatible
      https://git.kernel.org/will/c/e3fed6861d86

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
