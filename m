Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED670E5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbjEWTgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjEWTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:36:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DEE54;
        Tue, 23 May 2023 12:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B186E63602;
        Tue, 23 May 2023 19:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47995C433A0;
        Tue, 23 May 2023 19:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870577;
        bh=0/iuXv1Saa3OPZDn3Q0oyLU6WkXtXamRThwmOzxEro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGokeFBqdbRU7EhbqeISJ3tiD2msIqmWt5rF7fI/nBL7uaOc+GyhCCkWhsTZChn4l
         jrAx85dSQIyqfh7sbDlrMvpznsEd/U4iBr5TGZ3+QXXw0Ll2ZforItRuZJOnffaUfh
         n7hEIaNpg+j0yfofMJMxhOgU/ylPnzecFeX3qoLFTJ89QsrqxRLTKXcGT71JUqdvgr
         BF0p1/wnV5z1og4yXeqLqZ5RW29QVTpOqwrIfIXT6vsQ2HSs3Monf1h/Ad7MbCFe9v
         rIAy41b+o4fquhzrSHfsalsKDoiyWFJnBYAKeiwtpu+0qLyhAh9M2cD3yjn8KujLam
         47dISebZ4qSsA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v3 0/6] arm64: qcom: sm8[34]50: enable DP altmode on USB-C Connector
Date:   Tue, 23 May 2023 12:40:06 -0700
Message-Id: <168487080174.3522253.1347485253903162190.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
References: <20230503-topic-sm8450-graphics-dp-next-v3-0-6c43d293995f@linaro.org>
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

On Tue, 23 May 2023 09:15:44 +0200, Neil Armstrong wrote:
> This is the final step to achieve USB-C Altmode on the HDK8350
> and HDK8450 now DP controller support, USB3+DP Combo PHY and
> pmic glink support have been merged for those platforms.
> 
> This patchset depends on the QMP Combo USB3+DP PHY orientation
> support at [1].
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: sm8350: add ports subnodes in usb1 qmpphy node
      commit: d831312557e7308cdb59da5b3a228175e8d7738d
[2/6] arm64: dts: qcom: sm8450: add ports subnodes in usb1 qmpphy node
      commit: e5167da381a71eeeac13d8ec299ac7c597622b23
[3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to SuperSpeed graph
      commit: a3e42da4f712ca7fb3c9b1543f11ad82100e9914
[4/6] arm64: dts: qcom: sm8450-hdk: Add QMP & DP to SuperSpeed graph
      commit: b002bac7b4847aa11a6a56d14b2d75d4118f9591

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
