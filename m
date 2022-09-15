Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA65B9330
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIODhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIODhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE090188;
        Wed, 14 Sep 2022 20:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2006206E;
        Thu, 15 Sep 2022 03:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8984DC433D6;
        Thu, 15 Sep 2022 03:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213027;
        bh=aD5/tvc2gPQ3YPDDUEU03mu/6ZXtQc2W7QvZYVUpWP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2DJ6qnUp/nZZJESuB071I74ukQMrc0o0csEUy5dnd6HzsUAmIdIxWtkZtFXUZ8us
         JqSfD6eUS4EUuFG1fc3vNsMFq2kmEi51Fu+IUwexJFf77V4mYrvaC6gSiJhOmzKpFX
         iiuGxa8dZNUOXfThRfwEJlipxqRMXvGDL+JPpzjPWkSbdmFqrWQF/ECj1eRwq7xp8O
         4Q34zEAhc0Iesiuvi/8OlIw/G/4F3/wPU/gvWTKQ/URxBQgsoOUjUjJqPaD3i/X0Sw
         lnjbAZ2SKEfZAsGiC2aue8ZXUXVQTwif0wdg2Cq/BbNGgoIq0hEJruvN9slVsYz6Vl
         UsMe3u0vGl+cA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, dianders@chromium.org
Cc:     agross@kernel.org, jinghung.chen3@hotmail.com,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom: Adjust LTE SKUs for sc7280-villager
Date:   Wed, 14 Sep 2022 22:36:50 -0500
Message-Id: <166321302062.788007.3846750146820051620.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
References: <20220829084732.1.I9ef7f8b909a7afbef9ff2251a98c67033f37b516@changeid>
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

On Mon, 29 Aug 2022 08:48:23 -0700, Douglas Anderson wrote:
> There have been a few changes since the patch ("dt-bindings: arm:
> qcom: document sc7280 and villager board").
> * New firmware reports LTE boards as "SKU 512" now. Old firmware will
>   still report "SKU 0", but that's all pre-production and everyone
>   will update.
> * It's been relaized that no "-rev0" boards were ever built that were
>   WiFi-only. Thus we don't two entries for -rev0.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Adjust LTE SKUs for sc7280-villager
      commit: ff0ea86a538e80879243364bcf1a42e2d0eb6254
[2/2] arm64: dts: qcom: sc7280-villager: Adjust LTE SKUs
      commit: 68aa834823e09a540a23374129326a51efe877a3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
