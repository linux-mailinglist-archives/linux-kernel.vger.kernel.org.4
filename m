Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95113702264
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjEODcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjEODbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF2C3C10;
        Sun, 14 May 2023 20:29:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94F8C61E53;
        Mon, 15 May 2023 03:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6057AC433EF;
        Mon, 15 May 2023 03:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121365;
        bh=TP9Ur5mJ5Qvq08+4jnFbC5NsEU1s56mQNjEVtxhE8Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mblY0XGBxUPCjbf3v0gyShLxAwbI/pUnjTLYV8OYY0ZSZNMxNRiyxqViLdkazul84
         QQqOYVtbcacD7stIHTxaTZu1hZ1TOU/Crw61zWyslvwCy0ld6qX5UMApCiCSESTieN
         L8CWl/GoaBawrU4GT0O1CLoY24kBDaaqdGWAmEtKSFD3/uFC1P1LL+tmk7dTaLQPMR
         2BA7tz3VK+8w6BhlLJQN9l0f9X099Z364nf1BJcQ5UpUsLyS5jEsOugtIJQXOlgXc+
         lp4ceOkHhaF3ypjPGMnK2q6KeX9VyHF8/mbBnpKFma7NH40DxzDHNTNtjDqhgdG8l1
         lOl1P/V0+diZg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Dang Huynh <danct12@riseup.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add F(x)tec Pro1X (QX1050) DTS
Date:   Sun, 14 May 2023 20:33:03 -0700
Message-Id: <168412158454.1260758.15231030886098180948.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
References: <20230505-fxtec-pro1x-support-v3-0-0c9c7f58b205@riseup.net>
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

On Sat, 13 May 2023 08:05:03 +0700, Dang Huynh wrote:
> The F(x)tec Pro1X is a mobile phone released by FX Technologies Ltd
> in 2022.
> 
> The phone is exactly the same as the Pro1 released in 2019 with some
> changes:
> - MSM8998 -> SM6115
> - Camera button is no longer multistate
> - Only one 48MP back camera
> - A new keyboard layout picked by the community.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Fxtec Pro1X
      commit: 775d08f3954174c030d41bc31a145c027e98b7f7
[2/2] arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS
      commit: 0e59d9e210912e037ec28bd057d06481100f0ba5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
