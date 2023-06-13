Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279372F09A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFMXsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjFMXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFA72D54;
        Tue, 13 Jun 2023 16:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C0562EF7;
        Tue, 13 Jun 2023 23:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514A5C433D9;
        Tue, 13 Jun 2023 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699955;
        bh=o4AIqGTNBOdVmrdJEKcPDcLQEjkhm6E0B/4K9xnHkXs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eosRzgDdP+haRL72z9fUoaHVfLIx1OH1dJk8pCA0eP+OBH/rP17wWMgfCDk3nkAUw
         M8rFIC0cjhQ0xecllgjAXq7LdU4hQ/G1rkuyYDTXEcXsshVAgr+vStSx0UfqF+9WrY
         lvLRi/aqEBscRrkX3+o01/EPW0XyI/Mo1wn5nMcYmPAXMaT0z4iWKCvfbxYGWXbI07
         fiATR/EriokFHQPZXaNQI2SLWbzUe/lueyOYIfetHlKYTwbIoKlnHADc/8+80w4hN1
         dZcdfOyrq6JLL2rBBT1a6tirR+3B0eN8K3T81erFT7csNeblYWo0gZ75RgtCCArDKs
         mBuB/jrQ0GaBQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, rafael@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        thara.gopinath@gmail.com, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, rui.zhang@intel.com,
        amitk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org
Subject: Re: (subset) [PATCH v6 0/3] Enable IPQ9574 TSENS support
Date:   Tue, 13 Jun 2023 16:48:57 -0700
Message-Id: <168670013501.1400697.3289506817774430976.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686125196.git.quic_varada@quicinc.com>
References: <cover.1686125196.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 14:23:07 +0530, Varadarajan Narayanan wrote:
> This patch set enables tsens in IPQ9574
> 
> Depends on
> 	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
> [v6]:
> 	Remove comments from tsens node in dtsi
> [v5]:
> 	Fix make DT_CHECKER_FLAGS=-m dt_binding_check and make dtbs_check errors without removing existing entries
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: ipq9574: add tsens node
      commit: 2e0580e10e919b544d7be1b2b8fc48fc7dff1322
[3/3] arm64: dts: qcom: ipq9574: add thermal zone nodes
      commit: 581dcbe60b6390c633f318a29db41d1df642e6d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
