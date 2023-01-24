Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E0679753
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjAXMKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:10:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727D2330C;
        Tue, 24 Jan 2023 04:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0942CB8117B;
        Tue, 24 Jan 2023 12:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A94C433D2;
        Tue, 24 Jan 2023 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674562225;
        bh=l5P2dcDwl1Ro2L6ilIOJKG9O4Vu68MKthz8L2plR9oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGYpkXcWDatP+rjnX/LmQNuidY4UidrMsxoi89jllbg4Ia5fiAucLHzFPrMZicryh
         enw2AZmOAd2nwcejAz/b0Mq2fkSJACf9HI5QzEeaqfoayK5CArnOVFYxTSzZyDzgu+
         gALXwLVrjMhs0rB3dhpE88Y//9SaOrMVJAABl0zQ33HAM/nrdeOxqtywGLWyRGHJcE
         kxhOy8zbj9n+4P4u6tt/89QaEKXeIMMSSWc33Ng6n+AIyaVkpVVWO0VoAjlEgZPHG4
         +e1C7f/b1NdZV1Gt8OV2iz3Bb8Mc439bnwxO91YkKfppd5yad+mqJWzbbP87gkBJd2
         e70mQNYYfhP0w==
From:   Will Deacon <will@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        joro@8bytes.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        robh+dt@kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date:   Tue, 24 Jan 2023 12:10:19 +0000
Message-Id: <167456063714.294556.5041040061000624802.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
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

On Mon, 23 Jan 2023 18:49:28 +0530, Manivannan Sadhasivam wrote:
> Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
> IP. Even though the SoC specfic compatibles were being used in devicetree,
> the compatibles were not added to the arm-smmu-qcom driver. So they end up
> using the generic ARM SMMU-500 driver instead.
> 
> Spotting this discrepancy, the recent arm,smmu bindings change moved these
> SoCs under the non-qcom implementation of the SMMU.
> 
> [...]

Applied bindings change to will (for-joerg/arm-smmu/bindings), thanks!

[1/3] dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65
      https://git.kernel.org/will/c/eb9181a3ae60

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
