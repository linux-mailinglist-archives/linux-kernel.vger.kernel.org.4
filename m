Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAC7104C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbjEYE4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbjEYEyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DF3173C;
        Wed, 24 May 2023 21:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92A9A641D3;
        Thu, 25 May 2023 04:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59141C433D2;
        Thu, 25 May 2023 04:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990299;
        bh=mqywyp55t3zt0pDnj/vf2I4qIDtfPhn2nPyF55RY1LA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uZj418iKUgYNygP6iMlTgHYO57LS4h31v0vQ678w6s1L+nQ3PYwGxJrHSQD/CX9NI
         yGv/SgFBLiwXCwFbpFk+yiGvWz1WEGC8ICWzkFLpHTyfh98GseTc4cAJ7nyd0EK99e
         ourwekrm4MvqF2Xua/ct9x6qrLr6yR+jZhj0bVCD2+MaGdSmCvTJdTAS2lFmvCncxm
         YA+Kx+Y28ZutQiRbOSCJqINjczeRu3DEm78IgV1Cs61bGd2p2aVoOrzDU2rjOB37pR
         CIiT74tSDAkjrZZPkOAxwlFu2h+fVl3gAQC9e4pufRGDbXc+/1zsygWGz7chVUIILy
         dw/59u8kJAJhA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2] clk: qcom: restrict drivers per ARM/ARM64
Date:   Wed, 24 May 2023 21:54:18 -0700
Message-Id: <168499048185.3998961.5762782047515714184.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514114711.18258-1-krzysztof.kozlowski@linaro.org>
References: <20230514114711.18258-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 14 May 2023 13:47:11 +0200, Krzysztof Kozlowski wrote:
> There is no point to allow selecting clock controller drivers for
> Qualcomm ARMv7 SoCs when building ARM64 kernel, and vice versa.  This
> makes kernel configuration more difficult as many do not remember the
> Qualcomm SoCs model names/numbers.  No features should be lost because:
> 1. There won't be a single image for ARMv7 and ARMv8/9 SoCs.
> 2. Newer ARMv8/9 SoCs won't be running in arm32 emulation mode.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: restrict drivers per ARM/ARM64
      commit: ab7f00379fe90506e5e9af4e03e6935fb8deb9fd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
