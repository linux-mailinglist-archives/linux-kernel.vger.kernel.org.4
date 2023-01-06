Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B783066055F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjAFRMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjAFRMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:12:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E0F4A;
        Fri,  6 Jan 2023 09:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30535B81E23;
        Fri,  6 Jan 2023 17:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC70C433F0;
        Fri,  6 Jan 2023 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673025157;
        bh=V5Cjg+awY8Te/ixBSRyQpxLPmfpep+g4G3a1tJRNLok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNfP4/F0dfJRk7reIaprVMzvcoccOdze4nX70LAupzjjKetpCPGRWb2G3qOaCToEa
         woHRS2Hz28fWSc0VZbsztUVLVW2Wb0As9rrVUyHQKCC35JP2v/CTf2X/xmRaIjqCuZ
         QM62NmR2wOsFufxVaVpPh9KIcqEL0RBBZbiB/1JMgdYx17+a9J33VWMVsP3plBaQDB
         BirwwXpX3NQvfQ1ZsXJV3CH35QiGtp995QAmNO0cWdwiHmFfMpoUt+T+d0k/Y1+m9W
         lkQiwiStYCED1iaOixsCiQhGxYPI5aomvLbqjDO3NePEDsJhkuvgZJM3xHV6tNBXIp
         1ExdOB4shDn7A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@linaro.org,
        konrad.dybcio@linaro.org, agross@kernel.org,
        dmitry.baryshkov@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v8 0/4] clk: qcom: Add support for SM8550
Date:   Fri,  6 Jan 2023 11:12:36 -0600
Message-Id: <167302514590.1787824.9356171697272297388.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104093450.3150578-1-abel.vesa@linaro.org>
References: <20230104093450.3150578-1-abel.vesa@linaro.org>
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

On Wed, 4 Jan 2023 11:34:46 +0200, Abel Vesa wrote:
> This patchset adds more clocks support for the Qualcomm SM8550 SoC,
> It adds the TCSR clock controller driver and the rpmh clocks.
> 
> Changes since v7:
>  * Replaced RPMH_CXO_PAD_CLK with RPMH_CXO_CLK in the TCSR CC binding
>    schema example
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: clock: Add SM8550 TCSR CC clocks
      commit: d8aa375bd70681b76c6bd5fe93bab6011e16a0fb
[2/4] dt-bindings: clock: Add RPMHCC for SM8550
      commit: ffcdd6907e9a1fdccd9350147d0f59cafb87e768
[3/4] clk: qcom: rpmh: Add support for SM8550 rpmh clocks
      commit: 478a573be730dd704ab6acee43f40d91fe8c808a
[4/4] clk: qcom: Add TCSR clock driver for SM8550
      commit: e9a7b78b20889d2325bef4a1eb39c1088858ab81

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
