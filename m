Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462E66E6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjAQTNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjAQTK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9BA4F867;
        Tue, 17 Jan 2023 10:24:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93EBDB819A2;
        Tue, 17 Jan 2023 18:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B07EC433EF;
        Tue, 17 Jan 2023 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979872;
        bh=clxRB/jlTPmQ5e3DVafN4xxTKnzEZ2vbVocmLaOKTgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4Fy59dJxkITaWtUTYascbFRP5Dr3yMWTEpf3KwBf+tBy9Pm0/LWBnkfSJptaYfxH
         FAc21jmk3/4z9RZlszT4oIY/NkmxTs3G+9WDn1mdbXDdgtTG3FyfhQNMKgnrXVWMvF
         f+R+WmeyFbi7v50LErlSqEDksuUgBWmgI3Ko/E+Bmr4effsIxzqUlu52nr7xxquxgM
         NVjIV5jSyS6W9D5n26AoZJWpBXjDbFZ+C7wvlGtaYaSlkw9Lr3GRR3HISx5fiAqyNn
         HF44NLVueARpGfZcVcGFoooXC35SXFCT3ZFbqozMREQaxs/OvGgQVfzV6yrE0Z78He
         8dw2lTGw2SFSA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     abel.vesa@linaro.org, robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        johan@kernel.org
Subject: Re: (subset) [PATCH v3 1/2] arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
Date:   Tue, 17 Jan 2023 12:24:17 -0600
Message-Id: <167397986258.2832389.3518995343678702175.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230116141000.1831351-1-abel.vesa@linaro.org>
References: <20230116141000.1831351-1-abel.vesa@linaro.org>
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

On Mon, 16 Jan 2023 16:09:59 +0200, Abel Vesa wrote:
> Add UFS host controller and PHY nodes.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
      commit: 35cf1aaab169e0fd9c0ba5e0c0a5436ecb8081f0
[2/2] arm64: dts: qcom: sm8550-mtp: Add UFS host controller and PHY node
      commit: 6fa1a0f8cbfc3f4197434f63425853ac3bc16f68

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
