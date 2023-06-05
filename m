Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0485722CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjFEQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjFEQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:35:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B224CD;
        Mon,  5 Jun 2023 09:35:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279FE62822;
        Mon,  5 Jun 2023 16:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792CFC433D2;
        Mon,  5 Jun 2023 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685982915;
        bh=zDePudP0DIR1Wb1O58bInOt74h9pSblZwyhXOT/M3Hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRLcSUDjdioCI3RhbR5gPH62O+NlFoutQE/GVqFrkM8GfbZSRJHtR+8PqwyQvHs85
         QLa+14K5UIVgmig6BroBG1m00K7UwoH2tLzrKzLsWTFc+yDW5MZ/SzbvOo5imJyDN3
         tr5Vdz4Sy42wxrXVf4FjYd7njW5kzAtRbeBxyej4uMZ1VV06MQ4k5Bqy7Xl0ra389h
         VvEa1yf8mwxKHW0iJbjLhdZFHp6g79UMROiiVMcBaNJ5qXRs/00622zuejcFzRZKWf
         k+A1Vbzzq8YsaJv44tLRm2EJQ9VopXBmtbnaRdht9Q5admb/YUvkQ1zjVWbeb08Jz8
         561RqQviWbv1Q==
From:   Will Deacon <will@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] arm64: dts: qcom: sa8775p: add more IOMMUs
Date:   Mon,  5 Jun 2023 17:35:01 +0100
Message-Id: <168597911073.23229.8836975612213411980.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230417125844.400782-1-brgl@bgdev.pl>
References: <20230417125844.400782-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 14:58:39 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
> GPU clock controller driver.
> 
> NOTE: I didn't pick up Krzysztof's tag for patch 4/5 as the patch changed
> significantly.
> 
> [...]

Applied bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[4/5] dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
      https://git.kernel.org/will/c/387a80a74125

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
