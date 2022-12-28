Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEF6572BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiL1Eht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiL1EhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F4D2D2;
        Tue, 27 Dec 2022 20:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832B1612FC;
        Wed, 28 Dec 2022 04:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F44FC433F0;
        Wed, 28 Dec 2022 04:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202224;
        bh=Ahvfz5CUqMmIz7OZNTaO86E71LoIDtGl48WW36vKisg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7vOAfg5xGDKUsxlc7Lfpukz6LTO14n87xI7/h1niCGf3E0k4dcGJwQMY9UNN20xf
         uv8g3MTIX/Vrnyg9IeCBDcl5ibdA6mryjlrhi4EriO1gm+dPmEbyixVEBywP1j5KR8
         KB/eOp9w9sNwYx5Vo+KtT5jI5dWUKVeRCkN1Lo7842jWs3Sjpfoh0wYBkG9G+8v975
         bozTDyGvhA12XsBsDzFu1cI2824sciZJxM/gFcBKrvhoQzOZ/fN6IFqwO+spvEvlps
         x/btVudfDy9Lkh1ZnmCAYdk8RKsGVNpFJhmC959WM78wEZxiWODoHOMbcpPL7+fpLt
         lYnZIWc5xwwFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     angelogioacchino.delregno@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        jamipkettunen@somainline.org, marijn.suijten@somainline.org,
        agross@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org,
        martin.botka@somainline.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: msm8996-tone: Fix USB taking 6 minutes to wake up
Date:   Tue, 27 Dec 2022 22:36:39 -0600
Message-Id: <167220221219.833009.10099525257701032963.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221124220147.102611-1-konrad.dybcio@linaro.org>
References: <20221124220147.102611-1-konrad.dybcio@linaro.org>
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

On Thu, 24 Nov 2022 23:01:47 +0100, Konrad Dybcio wrote:
> The hardware turns out to be pretty sluggish at assuming it can only
> do USB2 with just a USB2 phy assigned to it - before it needed about
> 6 minutes to acknowledge that.
> 
> Limit it to USB-HS explicitly to make USB come up about 720x faster.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8996-tone: Fix USB taking 6 minutes to wake up
      commit: 43069b9cd358aebc692e654de91ee06ff66e26af

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
