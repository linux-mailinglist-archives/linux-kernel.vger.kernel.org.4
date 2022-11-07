Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A445661E8F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKGDMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGDMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F32DF8B;
        Sun,  6 Nov 2022 19:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6CB960E86;
        Mon,  7 Nov 2022 03:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D6C433D6;
        Mon,  7 Nov 2022 03:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790760;
        bh=BJhJtY0HZvBQOHMDEoddp405SPkv4K9k17KO6kVmZ+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyZJijt4VJ1mO4dS2qzSyXBZrlx0DkDL7LH7Toyh9idVY7kuOqs3BjJZ4fK3Ti9zb
         j2wHX9A0sPIBUHVYNTitljBbSvR8DqMBa74P7VYXbYWMBjmcjEa3cnQ8GdzRHiPp1F
         fAh9Ydx43MY1rsHk6BHqr5INBYHtT1xl6UuFKh/q2b5yphEvCtQmh3znT8Ege02hil
         +kOFgQ0vD/CDhD/1ulgFFBbebT+XPVXlo3xHxhWXBsAwdbnK9/FYMcXDUmJ6ClQ2w4
         GH1oGlrySpmXaGr0UkRfvh3wEcZaT/a9J9KkH+YBdC82KV4FTyD47MHhGnNEakkl7W
         VJkucMdkg98oQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     bhupesh.sharma@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Cc:     robh@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, jorcrous@amazon.com,
        catalin.marinas@arm.com, agross@kernel.org, will@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, thara.gopinath@gmail.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v7 0/4] ARM: dts + defconfig: Add support for Qualcomm QCE block on new SoCs and in defconfig
Date:   Sun,  6 Nov 2022 21:11:58 -0600
Message-Id: <166779074249.500303.18099197547906258152.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
References: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
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

On Wed, 21 Sep 2022 10:25:58 +0530, Bhupesh Sharma wrote:
> Changes since v6:
> =================
> - v6 can be seen here: https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/
> - No code changes since v6.
> - As per Krzysztof's suggestion on v6, clubbed the crypto driver and
>   dt-bindings changes together. Now the overall v5 patchset into 3
>   separate patchsets, one each for the following areas to allow easier
>   review and handling from the maintainer:
>         arm-msm, crypto and dma
> - This patch targets the arm/arm-msm tree specifically.
> - This patchset is dependent on the crypto + dt-binding patchset, which
>   can be seen here:  https://lore.kernel.org/linux-arm-msm/20220920114051.1116441-1-bhupesh.sharma@linaro.org/
> 
> [...]

Applied, thanks!

[4/4] arm64: defconfig: Enable Qualcomm QCE crypto
      commit: e19d0bf25c8119eaf401041c55af4edb5beab90c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
