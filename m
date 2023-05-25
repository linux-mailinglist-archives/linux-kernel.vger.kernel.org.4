Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CE710447
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjEYEvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbjEYEvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1683;
        Wed, 24 May 2023 21:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CB04641E9;
        Thu, 25 May 2023 04:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5EC433A0;
        Thu, 25 May 2023 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990259;
        bh=uhCfD3k7vcFe2Tv+gncTdbMiYtwguC4G62urOHaRIGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaboKHZGCe/jMPG/ldzpiVK150ENBMgpPsa2QSXYPfK+WJZeFbZEjzfGg3i7A/62z
         WYRsn+o3pRTVt/Jv03P2O4OTqd3iM+a5/p/FYkvRA23juXXVvkxkCHWuLuohKRQ1DS
         zuMH3W10ORc7pByXeZpdde6w9iJGAlMn1JS5lN1+l8tf3J2oy2MKg+dwhkmh7x1u1s
         mr7vvuzzKEOsmv0q11EcWcH1qLRDaAAuhOdgiYCChnUMEdXSnSVykn2k3Gjhwd3azc
         lEYfL2VuRrxRH1dBQHyUR5kpyLQoFTcTIxmVC9MxhU6xq7uXr4MRVML4IP6vexFpqW
         wflnnwRkd7vlQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Arnaud Vrac <avrac@freebox.fr>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8998: add blsp spi nodes
Date:   Wed, 24 May 2023 21:53:39 -0700
Message-Id: <168499048183.3998961.2068592218093290218.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417-msm8998-spi-v2-1-b314c6d9ea31@freebox.fr>
References: <20230417-msm8998-spi-v2-1-b314c6d9ea31@freebox.fr>
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

On Mon, 17 Apr 2023 18:49:46 +0200, Arnaud Vrac wrote:
> Add pinctrl and qup nodes in msm8998 device tree to support spi.
> Values were ported from downstream msm-4.4 kernel.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8998: add blsp spi nodes
      commit: 935e538fd6b8e30151ee822313c01005bd2865ad

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
