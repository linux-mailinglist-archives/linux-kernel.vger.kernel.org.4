Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF386DB1E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDGRjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDGRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBB1B47A;
        Fri,  7 Apr 2023 10:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC7965338;
        Fri,  7 Apr 2023 17:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A74C433D2;
        Fri,  7 Apr 2023 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889121;
        bh=OQSosJYSuZVbDTMHCZ0H3HYidHURX5xdpy3yEE+Eb9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qY+CAeSJgIHvMupF+KC04cNMhlT6Dj2TYQ6XSPaZu3rXWA0qkLudxoxmsuCeXR4KC
         hwUOR1pznjXxvPwqVh2izqJAIcL9SUT1a6heLH0YlhYHZyT4M3M+8gh7jSqbp8Agbz
         dZTigZfJsB38f7MZ+ebSHT0QQwudM+OefzX2yaGVZnEDL5ZEKCYY959JEftGXLtDGv
         TIhS2pI1sDsDAtuIFj7OfTh0+xaGMTqOBzi7JL5n04bteeMeBtFW+dxow+5UvbIBtw
         b3A2k335AtIlImv0rxbajLQ1OhZdFnxzhyJtTsbZHsngnCchxq8h89M32wK9jU1YOg
         nl4XDdcVuRBpQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        wim@linux-watchdog.org, robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan T <quic_kathirav@quicinc.com>,
        konrad.dybcio@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH V2 0/2] Add few device nodes for IPQ5332 SoC
Date:   Fri,  7 Apr 2023 10:41:17 -0700
Message-Id: <168088927578.2561591.12316304033286537024.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230320104530.30411-1-quic_kathirav@quicinc.com>
References: <20230320104530.30411-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 16:15:28 +0530, Kathiravan T wrote:
> This series adds the support for QUP peripherals, PRNG, WDT for IPQ5332
> SoC.
> 
> This series depends on the below patch, due to the node ordering
> https://lore.kernel.org/linux-arm-msm/20230217083308.12017-6-quic_kathirav@quicinc.com/#t
> 
> Kathiravan T (2):
>   dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq5332 compatible
>   arm64: dts: qcom: ipq5332: add few device nodes
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: ipq5332: add few device nodes
      commit: d0367098dc1e925d22a6706e358636d12371116c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
