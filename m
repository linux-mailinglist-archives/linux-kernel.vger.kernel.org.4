Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3011D67425C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjASTLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjASTKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:10:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F09AAA7;
        Thu, 19 Jan 2023 11:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E75760DB4;
        Thu, 19 Jan 2023 19:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752DEC433D2;
        Thu, 19 Jan 2023 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674155330;
        bh=csZcG+ScIVG6UPUV+Hi+YtZInifN2wfE/Ns/56FIT4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTY4p19uzvt/txyeIqvO5f3rXsnARUYeZuOVNsbTZGjimLiucFLAjm6Bu44bA7pzK
         C6ryYikOOCPaaCOC7xCDMS0XLzRYQ3RLdcuu13FoORygLW4uFE4a57LgsM+ZnoJawk
         65t1XP+qngvNyK9zjMbHc5V8KCqBIzRqumjdJjLezpzNyYCfJFu2BcoPWrptXZY9AJ
         QS1P30dkoGYw9f82EEAan+hGz7soox/YAv6GgLhCt2Yfb591BUiBXAR9EC+R7IAtOY
         Li+OzR7adVaZB5uIXrf2sowadJ6tg4jZ6RTNY7xweV2zFjafMKXqLHW8S9ki2CX1U1
         dMckZgSWAL+6g==
From:   Will Deacon <will@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
Date:   Thu, 19 Jan 2023 19:08:31 +0000
Message-Id: <167415018728.2381246.2762108440390961472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230112154554.442808-1-brgl@bgdev.pl>
References: <20230112154554.442808-1-brgl@bgdev.pl>
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

On Thu, 12 Jan 2023 16:45:54 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the qcom,smmu-500 SMMU on SA8775P platforms.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
      https://git.kernel.org/will/c/7caf324fac0b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
