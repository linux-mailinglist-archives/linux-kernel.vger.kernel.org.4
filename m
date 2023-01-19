Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DB672F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjASCnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjASCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:42:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CC4B47E;
        Wed, 18 Jan 2023 18:42:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0945B81FBA;
        Thu, 19 Jan 2023 02:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ABDC4339B;
        Thu, 19 Jan 2023 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096176;
        bh=XiJBo+Rb6OfHZD1AubVx/LNMabwU6aDM9SbmNqLeqhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ErRaTj/aXXv5NF/K3DC2vRjXJBMKY8qC/1oGNtKrpPoWpsUGlBPbIAsgOUqGLDvTo
         ey/WiZnuUm1ceZs1JqXj2jgQJbgyfTKY8ArZ5CXhW0sI6oMdhoMXApEd4eVpFazrEd
         P6OVL9GKGyb5IVQuvTb1ZE5bwaTQlQO9T8FUeCyinj1IBwwl1F5QNFb584A2bmb1wZ
         n0tQSGkqlm4tF23hhMpXr7R/xUmZSGdordvxI5Gts/vVIaIL2cq1i5Vp4SIxYs7DJp
         HuBWZg+3YP1wmijbx4ot+tvYsu70rcyTcB91wEEQgHGYHwOs+fxfkQaSVnRtsl7PG9
         B0d0SlZSsTTcA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, quic_molvera@quicinc.com, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_tdas@quicinc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] clk: qcom: Add clocks for the QDU1000 and QRU1000 SoCs
Date:   Wed, 18 Jan 2023 20:42:51 -0600
Message-Id: <167409616956.3024582.17239635574684353077.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230112204446.30236-1-quic_molvera@quicinc.com>
References: <20230112204446.30236-1-quic_molvera@quicinc.com>
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

On Thu, 12 Jan 2023 12:44:44 -0800, Melody Olvera wrote:
> This series adds the GCC, RPMh, and PDC clock support required for the
> QDU1000 and QRU1000 SoCs along with the devicetree bindings for them.
> 
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks
      commit: f636dee9b60dd1cc4d8dcac98cf975991bc12d58
[2/2] clk: qcom: Add QDU1000 and QRU1000 GCC support
      commit: 475b330cca2acbf19a00e80a12c66919209b0183

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
