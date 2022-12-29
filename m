Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346A7658FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiL2RYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbiL2RYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:24:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CE15F07;
        Thu, 29 Dec 2022 09:23:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FF8F61867;
        Thu, 29 Dec 2022 17:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F2AC433F0;
        Thu, 29 Dec 2022 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334637;
        bh=hRL4ycc+lQsp2wGlAkvHZUjePfOXrZqQc7K2S8PUFYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JryPBA4OOv8iVouPEj60PGkvqwNNW86VUOf8ZrIMGztM84idqHpTGT+Jeq/K3tlJD
         2SDFlYA7MM19wC0xRgTvbjRMIOWWY3ZTsNrQVaPH/Fd4bmYqBiGHE1ls8KjszqKOtc
         prjcz9qWEO0Aq/i8lu9wMoDIkfyhNRPHslkx64Wr9ZjK8KxHHKIc2fEiA2e54UaQNX
         C86C9+OplwzmauPUejgrLAEcPodmTMzAniwSZO0hoj4OBLUJaU/o2BGd7rqX2MrqAe
         vDX346wHsj5AVDN1YIXPIZ8pVpHajEkQB8hNsFll378z4qXYtr61dlBm+Ki0zr4a4N
         09ouovvF8kViw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, jami.kettunen@somainline.org,
        martin.botka@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys (volume down)
Date:   Thu, 29 Dec 2022 11:23:36 -0600
Message-Id: <167233461774.1099840.11525870770738189217.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221222192443.119103-1-marijn.suijten@somainline.org>
References: <20221222192443.119103-1-marijn.suijten@somainline.org>
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

On Thu, 22 Dec 2022 20:24:43 +0100, Marijn Suijten wrote:
> - Remove autorepeat (leave key repetition to userspace);
> - Remove unneeded status = "okay" (this is the default);
> - Remove unneeded linux,input-type <EV_KEY> (this is the default for
>   gpio-keys);
> - Allow the interrupt line for this button to be disabled;
> - Use a full, descriptive node name;
> - Set proper bias on the GPIO via pinctrl;
> - Sort properties;
> - Replace deprecated gpio-key,wakeup property with wakeup-source.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys (volume down)
      commit: a9f6a13da473bb6c7406d2784d9e3792f6763cba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
