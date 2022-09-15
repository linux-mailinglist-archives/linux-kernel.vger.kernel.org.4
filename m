Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1795B933B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIODhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIODhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20D93201;
        Wed, 14 Sep 2022 20:37:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EE86207E;
        Thu, 15 Sep 2022 03:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E2C433D7;
        Thu, 15 Sep 2022 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213034;
        bh=6UXU2nblH9ignjAwPxhipidK1bqOkBo0Kl4re5fATNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCDFYBX0h4wyPbqjXYH2cbQBP7Ew+d+GaeBOjp+PDuRNLimlTbvpShfodZ21SdQWs
         exCtEiB7A/1ylxRmPZSvFy6NkBPJ7wzC2BlT/IgSxDo6V3EguTjY6+0vDAWr1uXsJW
         IlD6Y9Uzor7ucf3VG6GVTXrP+JhV0Z1KRHUKuQ/TIDt65+Z3sdEyU6qB3tsc+vaaDs
         9FVKdmNJAjXFQZFnvIE6JKbyxQICl/DORsAgAF7frixFxvRWdEjpuB0yfBj6JeMMkD
         aG+IqINVEbeHZFHPTHab4LnUI6yreyDGQfe3w87RB4A3EzA/H21un7uHyKKZzocPSI
         ME85bExRDoEgA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] arm64: defconfig: enable newer Qualcomm SoC sound drivers
Date:   Wed, 14 Sep 2022 22:36:56 -0500
Message-Id: <166321302063.788007.16801894871633601282.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220909105136.421877-1-krzysztof.kozlowski@linaro.org>
References: <20220909105136.421877-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 9 Sep 2022 12:51:36 +0200, Krzysztof Kozlowski wrote:
> Enable sound support:
> 1. machine drivers for Qualcomm SC7180 and SC7280 SoCs,
> 2. Qualcomm ADSP Peripheral Image Loader used already on SC7280.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable newer Qualcomm SoC sound drivers
      commit: 9385eb46e319ecb7632acba59dac3458a544bd98

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
