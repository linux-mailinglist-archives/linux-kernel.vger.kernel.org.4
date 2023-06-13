Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174D572EF43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjFMW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFMW1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2FA19B1;
        Tue, 13 Jun 2023 15:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE03463B91;
        Tue, 13 Jun 2023 22:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3AEC433CC;
        Tue, 13 Jun 2023 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695232;
        bh=tRJQBbwZtaJ6NQT1/dC04nb57z6Mm49syrgZQgiFZKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0pHg8OA3PIfY7MEpiGS4CnR5QMTkebIhMLdLJmHcRcpVHwREOR1oYpB7Wggf+kZw
         avODGCtlWEgJ4Y1b5LG31rvjyNps2PmPgKHclDT8EBRJ4K0TWlVvrrfYeAP4bfTuKS
         Wmq8In4o92ccnRshzFA4bCKgC/If8ceFCzCEWzWr7jKG4g025woNc7wDw5ZZUABIho
         awV0MmSL5+NGCve9LrduhLoQDS4DK1uQf19VDD4NIP7xk3uBuw23WSecOHoD+UIkiT
         /ju2/cYcamhhlwUk7qqik25+aRhWlb87XNJgR7in1HU0DUuq+ogDvZWIIMy2qGRbE9
         rrtnTp2wxtdlQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Artur Weber <aweber.kernel@gmail.com>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-leds@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/4] video: backlight: lp855x: modernize bindings
Date:   Tue, 13 Jun 2023 15:30:10 -0700
Message-Id: <168669542896.1315701.6764382551599027707.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
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

On Fri, 19 May 2023 20:07:24 +0200, Artur Weber wrote:
> Convert TI LP855X backlight controller bindings from TXT to YAML and,
> while we're at it, rework some of the code related to PWM handling.
> Also correct existing DTS files to avoid introducing new dtb_check
> errors.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: adapt to LP855X bindings changes
      commit: ebdcfc8c42c2b9d5ca1b27d8ee558eefb3e904d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
