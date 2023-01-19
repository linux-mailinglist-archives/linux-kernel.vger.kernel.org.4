Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0488672EDD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjASCRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjASCRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:17:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ECE683C7;
        Wed, 18 Jan 2023 18:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE2CDB81FC0;
        Thu, 19 Jan 2023 02:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC77C433F1;
        Thu, 19 Jan 2023 02:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674094627;
        bh=t/eJ/1InYMQqz+byLd819QFU3BgCnnn6IgSijTh/zhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJMol8tBRV48yo1ff+caalJ2EDwQnezoH+puzvye3ICkQboonzVPK6K1cWTRcihh1
         I6sX27o4ZP/4uGla/QUb2v3o3askHpY9h3Q1//Jmq5pdWaMXDPlBtp25feRshKRRaw
         hyh6jrbTOwoAx5G/8YJC6kZjpKnFl7luPhUhThtFbjjzCGfFGWSstIQyDg2U6BWAcL
         hJ3HozTbNA4tRbcfvreoQZoUopRYkLtAB0TLLqFcQ1R0Otub1nfYOtQEgYaKV/56YJ
         Cj8F9iE2E7MwdxYo8KvuhTLWLYVotJgom7WcjwFdxlipwHqtJUacobOG3r865PECe2
         N6WwncieZThsQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan+linaro@kernel.org>, dmitry.baryshkov@linaro.org
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: qcom: align OPP table node name with DT schema
Date:   Wed, 18 Jan 2023 20:16:56 -0600
Message-Id: <167409461442.3017003.3964148432868425769.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
References: <20230109112221.102473-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 9 Jan 2023 12:22:18 +0100, Krzysztof Kozlowski wrote:
> Bindings expect OPP tables to start with "opp-table".
> 
> 

Applied, thanks!

[2/4] arm64: dts: qcom: align OPP table node name with DT schema
      commit: 8a220a62ebe2ade6ee371aa4fcbdb344b32264ad
[3/4] arm64: dts: qcom: sm8250: drop unused clock-frequency from wsa-macro
      commit: a496f7decf4f86bcb34c78041d8db9690cc93aae
[4/4] arm64: dts: qcom: sm8250: drop unused properties from tx-macro
      commit: e5988fd6004bb3ea5a9669933c1a9beaf7637990

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
