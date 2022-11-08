Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F837620626
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbiKHBfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiKHBfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:35:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92ABFC2;
        Mon,  7 Nov 2022 17:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46AAD6139D;
        Tue,  8 Nov 2022 01:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CC5C4347C;
        Tue,  8 Nov 2022 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667871303;
        bh=VbHtwiRY9OrRcqTZTxylig5/x3MC+EqH11/EcgSsNa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWBE9yzzMyLiLN6q/6wYb/7IWK9zU71a0tE9xTvGa0JXRDuv3/bSHJqnGZVxtPxuq
         NnCc+OOwcmfl48BnPKFluIV6w/iFbx5ZqsiwM2ad25v5rwfS+QiYpluzrSkVuVGJmD
         5Zbq6y+m+y8RfrCRIuEUPI3MRR5CuBkw8D/0tNHRMTOQFo8MrpOReeCL+Tw4sIs2+D
         0TPAjC3ymldiz1xkEjDUv1GoKfthpyKxmtP3gLAdw45IwF9K+ztmVdShP5uo4tVOHZ
         cWsSa/WzX3IB52OejiLIfnMw1nVh4zPXiEx6hs3ZRsHXw8gCvD1+AbJwSBWlfm43hH
         Z/LkN+Vw0FwoA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org, marijn.suijten@somainline.org
Cc:     agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        jami.kettunen@somainline.org, martin.botka@somainline.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6125: Enable Command Queue Engine (CQE) for SDHCI 1
Date:   Mon,  7 Nov 2022 19:35:00 -0600
Message-Id: <166787129212.608852.6548286601468082055.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221107214702.311271-1-marijn.suijten@somainline.org>
References: <20221107214702.311271-1-marijn.suijten@somainline.org>
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

On Mon, 7 Nov 2022 22:47:01 +0100, Marijn Suijten wrote:
> Downstream sources confirm sm6125 supports CQE, and after fixing the
> reg name for this range [1] this feature probes and enables correctly:
> 
>     [    0.391950] sdhci_msm 4744000.mmc: mmc0: CQE init: success
> 
> [1]: https://lore.kernel.org/all/20221026163646.37433-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6125: Enable Command Queue Engine (CQE) for SDHCI 1
      commit: f53152d1d4e6c711bb9728611bbe0b32deda36b1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
