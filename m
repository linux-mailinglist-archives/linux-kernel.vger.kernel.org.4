Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E01E7104FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbjEYE5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbjEYEzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85DE48;
        Wed, 24 May 2023 21:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD78642B3;
        Thu, 25 May 2023 04:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08192C433A4;
        Thu, 25 May 2023 04:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990322;
        bh=wbuqSr/dpQZAWNfRhRWhjk92q+VPd7IY9nI6I0haJc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hiuDBew7VBo2HHdEmQ55CNhozIfR4j7iDQjfwkU4miS1db86JvKZ+VNXb/3xz0K8m
         E08J7bukhI8hTtLI65/NR3Y9uKdkxvDIvWuTbpF3/pzsWMq7XJX0/SkFScxSS0yy2v
         mckEp+vuLMm5t2VWiq8Bb7xe4+IR8ms+rIyQNxJSSxe3bJhI2rILwtXLKXdh8PuFFF
         QwRMr4TpsUNf7BLCgHk8CfrhdKiRfHIQSEUNjasKqgi8L49G7Y+Ik+8TE9Ozj2PvU5
         AGykGkUhCw38vB1iU9L5T0/boiWgfaIvVctEUvrPwz6OTfOoMEaqSKCrGIq9LICtnz
         TDjmgCs1L1Q/A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jkona@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Imran Shaik <quic_imrashai@quicinc.com>,
        linux-clk@vger.kernel.org, quic_rohiagar@quicinc.com,
        netdev@vger.kernel.org
Subject: Re: (subset) [PATCH V2 0/5] Add GCC and RPMHCC support for sdx75
Date:   Wed, 24 May 2023 21:54:39 -0700
Message-Id: <168499048185.3998961.8118041081683162755.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512122347.1219-1-quic_tdas@quicinc.com>
References: <20230512122347.1219-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 17:53:42 +0530, Taniya Das wrote:
> This series of patches extends the invert logic for branch2 clocks and adds
> GCC, RPMH clocks devicetree bindings and driver support for SDX75 platform.
> 
> Imran Shaik (5):
>   clk: qcom: branch: Extend the invert logic for branch2 clocks
>   dt-bindings: clock: qcom: Add GCC clocks for SDX75
>   dt-bindings: clock: qcom: Add RPMHCC for SDX75
>   clk: qcom: rpmh: Add RPMH clocks support for SDX75
>   clk: qcom: Add GCC driver support for SDX75
> 
> [...]

Applied, thanks!

[1/5] clk: qcom: branch: Extend the invert logic for branch2 clocks
      commit: 9092d1083a6253757c7f9449340173443c81768c
[3/5] dt-bindings: clock: qcom: Add RPMHCC for SDX75
      commit: 379d72721bc4308fbc038e9858b7d2e9191725b5
[4/5] clk: qcom: rpmh: Add RPMH clocks support for SDX75
      commit: 1c2360ff58162ab3a91c619ab8172c0061174151
[5/5] clk: qcom: Add GCC driver support for SDX75
      commit: 108cdc09b2dea5110533bba495b6953ca9c7c2a9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
