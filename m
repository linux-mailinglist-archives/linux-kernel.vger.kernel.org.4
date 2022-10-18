Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6D6021D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJRDHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiJRDGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE66172B58;
        Mon, 17 Oct 2022 20:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B1866CE076D;
        Tue, 18 Oct 2022 03:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AD5C43141;
        Tue, 18 Oct 2022 03:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062396;
        bh=oCXr3dbM5LjEvH17WGOa9blmcsR9MAlQIezoyVamM9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0ErFZqPiM1lXUIbMwYsYQhjyGtFCn2l8aQ5zKn94aWZRnymFKRvblv5qRCiT63ff
         v0jSF0kDGHIoUMhiqfdN3pXj5QpyqQ16T6to52xngg7SEtXA0hy/qYDspyk2jZvonq
         D4ORLuxrebYBMKnv5ynWaxWWwSFWpVGN4Nnxn8T1ySRGsqPFkSymINwEgPHDEbNnpW
         ZddrKZSRYS4zXjJoz20uTBzm0Yzhw3yD1FBdG1GoxuGUDpZzdco327PZuTxKWTTDI9
         6MptDjB2xxfishji0pidmFitcC6tEgOKSnRALjY30Ms7ZFs7DKwxWxbOIbByrh1BRI
         +ALV7EjL8RODg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: sc8280xp: fix USB/DP PHYs
Date:   Mon, 17 Oct 2022 22:05:18 -0500
Message-Id: <166606235847.3553294.15074071965403871212.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919094454.1574-1-johan+linaro@kernel.org>
References: <20220919094454.1574-1-johan+linaro@kernel.org>
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

On Mon, 19 Sep 2022 11:44:50 +0200, Johan Hovold wrote:
> When adding a check for overlapping register regions to the QMP PHY
> drivers I noticed that the USB4/USB3/DP PHY nodes are currently broken
> in multiple ways.
> 
> This series fixes the SS PHY nodes and drops the DP PHY nodes which can
> be added back after the binding and driver has been updated.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc8280xp: fix USB0 PHY PCS_MISC registers
      commit: 31b3b3059791be536e2ec0c6830767b596af340f
[2/4] arm64: dts: qcom: sc8280xp: fix USB1 PHY RX1 registers
      commit: 81cad26c6c3984d01b0612069c70ffd820f62dfa
[3/4] arm64: dts: qcom: sc8280xp: fix USB PHY PCS registers
      commit: 8723c3f290c7b798c0cbd89998576e6b365bda3a
[4/4] arm64: dts: qcom: sc8280xp: drop broken DP PHY nodes
      commit: 7cdfb7a54ac88f7cb6d830ebb78bdbcbcb44bb4c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
