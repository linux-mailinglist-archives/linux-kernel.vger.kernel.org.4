Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7796DB1E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDGRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjDGRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0DC178;
        Fri,  7 Apr 2023 10:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8BA65330;
        Fri,  7 Apr 2023 17:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34E0C4339C;
        Fri,  7 Apr 2023 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889120;
        bh=i289+hl/QqcGgL1+leVcwWwADguaW9LS68DYAjdH9Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWLeHXHmokaY2r3rykciN0xUhAeEamO9zMzY4WWx/3SkbcE9EcKR2dSIK/j+iZQ//
         OvHAPTbx51/BnOxM6YBN0K3t6FzE6S92HmeiRRCtDYU3yNQIJ2d+GOLrgIQIGEEQoy
         jDdU9P205AqyxhOj15IIIwDbH2hIkjO0V3r8wRk6KFPk4HJQTzffRQmN4UkGRXMGFn
         f2i2xTzEv7gkPrzhjkpC06Kg7vPh5Lmhf5wLIgQKSlg76JohKSkZFWl00IQ8Zx7U5e
         lWFk6lmBSJObibkqbm3zj0O/5U86f0D2JmnBZ5S4RtqNij8WPJtBmTBrQWDVfJY222
         57jr7wThylOpw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     mturquette@baylibre.com, robh+dt@kernel.org,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, will@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        linux-clk@vger.kernel.org, agross@kernel.org,
        linus.walleij@linaro.org, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, Devi Priya <quic_devipriy@quicinc.com>,
        broonie@kernel.org, sboyd@kernel.org, marcel.ziswiler@toradex.com,
        linux-arm-msm@vger.kernel.org
Cc:     quic_poovendh@quicinc.com, quic_kathirav@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_gokulsri@quicinc.com
Subject: Re: (subset) [PATCH V9 0/6] Add minimal boot support for IPQ9574
Date:   Fri,  7 Apr 2023 10:41:16 -0700
Message-Id: <168088927579.2561591.423595679057929869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316072940.29137-1-quic_devipriy@quicinc.com>
References: <20230316072940.29137-1-quic_devipriy@quicinc.com>
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

On Thu, 16 Mar 2023 12:59:34 +0530, Devi Priya wrote:
> The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
> Gateways and Access Points
> 
> This series adds minimal board boot support for ipq9574-al02-c7 board
> 
> V8 can be found at:
> https://lore.kernel.org/linux-arm-kernel/20230214163116.9924-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[6/6] arm64: defconfig: Enable IPQ9574 SoC base configs
      commit: 34d1a90bdb8a2759b9646c8596eea495b4cb02ac

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
