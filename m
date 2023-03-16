Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9146BC469
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCPDSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCPDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482668B30E;
        Wed, 15 Mar 2023 20:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D174861EF8;
        Thu, 16 Mar 2023 03:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACD1C433A0;
        Thu, 16 Mar 2023 03:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936669;
        bh=hhwbKG9jqdDxpL+7bexzoF9N9Vy7Yc1u5WoxNesixbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpEwlN0zm5Wpdpa5Sx+/ntkh8H2eE7+yH3tegb0nP1DTXXDulvntxNftq3VpYW9Zj
         oEua1KObmx2RUuPRqSh1vVEH+b91aTvV6m/8GW6PO9tIXh1AdsYBKuiJgFNLXyTu+8
         Q5av6DUMTWeQ0r1uP10WF2PRbrYNwMVZk9TOe8JoEK/bzVDW9CMe6Bakt/XQyaSQiz
         npWv69BfVOlFYklEsLVKz4lvfjNEGzI8CC3pSBftGBX/KMqCjKD2Y4Tppw1dAZDUjJ
         gRjhfYQbe4532KXucvbrfiAsaqX2XlD1oe6jj8lgnnVuioe6qZhDuzk7qBuAaxlCLq
         j/PefW0zPy3Dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Iskren Chernev <me@iskren.info>,
        Chanho Park <chanho61.park@samsung.com>,
        devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        marijn.suijten@somainline.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: Add Cortex-A78C and X1C
Date:   Wed, 15 Mar 2023 20:20:53 -0700
Message-Id: <167893686409.303819.5591730164310103078.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224130759.45579-1-konrad.dybcio@linaro.org>
References: <20230224130759.45579-1-konrad.dybcio@linaro.org>
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

On Fri, 24 Feb 2023 14:07:57 +0100, Konrad Dybcio wrote:
> Add compatibles for the Cortex-A78C and X1C cores found in some
> recent flagship designs.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc8280xp: Use correct CPU compatibles
      commit: c2819cab9d2edddcb8395bb74367ba61e581a2c5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
