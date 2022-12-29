Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD0658FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbiL2RYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiL2RX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726AD1580D;
        Thu, 29 Dec 2022 09:23:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFFF761867;
        Thu, 29 Dec 2022 17:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3843EC433D2;
        Thu, 29 Dec 2022 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334633;
        bh=vwZado0n/FDUBbdARVUPl7ON0BEEW0ONuWNVT/ToCxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwCURtdhbh2HQdmbcq97JDUzgQ4BrlJYtc3ROTRi0MgsfTICqBhDb9XgeViLDPfhd
         7LHbJ+CHMGFdmyqmgt68co/Ox0KBAZo3XehZY2nxzSbek5RYEBlAeoQMAN8EtGT+Rn
         TSTm7MBhwTynMg/jX58qnSNeIoNWfWBlw2M7wnLRggaDQ8TOlTdkNZl/2+5qAGwPIc
         i33mtPSzg+ae0LvLrb6t/yeRqZzeN2cuXjFFmrdiusa93Ry3eTBJ/AU0fVNWDfPENT
         SCohVsK0EyCeoYUi9LJE+Tajlz5Ao9XmgvR/DF31b/IlGm3EqsG7t3Hl9HGgfMfYvT
         jqq9Cr3lGUoaA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     phone-devel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@somainline.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] arm64: dts: qcom: sm6125-seine: Configure regulators and enable SD Card
Date:   Thu, 29 Dec 2022 11:23:32 -0600
Message-Id: <167233461775.1099840.9313167642077066224.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221222203636.250190-1-marijn.suijten@somainline.org>
References: <20221222203636.250190-1-marijn.suijten@somainline.org>
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

On Thu, 22 Dec 2022 21:36:31 +0100, Marijn Suijten wrote:
> Configure regulators on Sony's SM6125-backed seine platform, and provide
> these regulators to existing (SDHCI 1 / HS USB2 PHY) nodes so that they
> can cast their votes despite being left enabled by the bootloader.
> 
> In addition this allows us to enable the SD Card slot on SDHCI 2, which
> would not function without turning on the necessary regulators (i.e.
> these were /not/ left enabled by the BL, for good reason).
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sm6125-seine: Configure PM6125 regulators
      commit: 7421a8d2f1394ee9f8b5fd87121f055e56ab4e60
[2/5] arm64: dts: qcom: sm6125-seine: Provide regulators to HS USB2 PHY
      commit: 232bb8073b5b3ec043459b34535542ea5ca81694
[3/5] arm64: dts: qcom: sm6125-seine: Provide regulators to SDHCI 1
      commit: 68aadbe7805901b52b18595dcbe36442ebf26d93
[4/5] arm64: dts: qcom: sm6125-seine: Configure SD Card slot on SDHCI 2
      commit: d696b1618bc1a416a4ab72a1176cfdf187ca09bf
[5/5] arm64: dts: qcom: sm6125-seine: Lock eMMC and SD Card IDs via aliases
      commit: fa7ff6e9f14a05f304587ba566a4f445a2a74aa6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
