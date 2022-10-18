Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF7602250
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiJRDMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJRDJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC189AFF0;
        Mon, 17 Oct 2022 20:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B21C61369;
        Tue, 18 Oct 2022 03:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ACFC43147;
        Tue, 18 Oct 2022 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062445;
        bh=RuQ0qyzLyCZ8UbmT38wc6p1T9N+BAk8sE8gaFRQ32Kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jg4K+bucB7CfGN/2s5IRFsjY8sGjKSIrodw1Eu1qMJ4Tj1LG5tdmw4a+jTDexUHyl
         0D7J/eG7EqUlhsSevd/1Tp3KL2S7W7d2D2Xat40z8uPClCsyGOAxn1S6231Yb0lsWM
         CGS3ChCcjqUJbjtH6846pLoVhE1bGKmmR4r+qzwH5cYA7PwBlB/vy0MG7PNZTtgcQX
         DZ3nU5Lf7Go0/IaFJ57VI7zr00kwDFr6AfeOnEgKaAOPoIuJiNItWoVZS5jh3mGIST
         NjKaESoc1INArVF6LrDyNgYCiWOmxfRnkm5B6MxUw54jiIXLzaxvine1lkIfmbvEsy
         ePcF3WsxuXnVg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     robin.murphy@arm.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v4 0/3] MDSS support for MSM8953
Date:   Mon, 17 Oct 2022 22:05:57 -0500
Message-Id: <166606235863.3553294.17596125386082772765.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221016161554.673006-1-luca@z3ntu.xyz>
References: <20221016161554.673006-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Oct 2022 18:15:50 +0200, Luca Weiss wrote:
> This series adds the APPS IOMMU and the MDSS block for display that is
> found on msm8953 SoCs.
> 
> Luca Weiss (1):
>   dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible
> 
> Vladimir Lypak (2):
>   arm64: dts: qcom: msm8953: add APPS IOMMU
>   arm64: dts: qcom: msm8953: add MDSS
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: msm8953: add APPS IOMMU
      commit: c0b9575a36069f52f09fbe9b8f7a9db940cb952c
[3/3] arm64: dts: qcom: msm8953: add MDSS
      commit: cf6c35d1bc89e0942c379f841e1d9095fc66d642

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
