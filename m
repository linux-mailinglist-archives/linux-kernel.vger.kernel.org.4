Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15C66D03BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjC3LqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjC3Lpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:45:49 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E157FBB89;
        Thu, 30 Mar 2023 04:45:28 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phqi2-0003YZ-T6; Thu, 30 Mar 2023 13:44:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        robh+dt@kernel.org, wim@linux-watchdog.org, jamie@jamieiles.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/2] RK3588 watchdog support
Date:   Thu, 30 Mar 2023 13:44:47 +0200
Message-Id: <168017666938.2380317.3546280306376407710.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230328210048.195124-1-shreeya.patel@collabora.com>
References: <20230328210048.195124-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 02:30:46 +0530, Shreeya Patel wrote:
> This patch series enables watchdog support for RK3588 and updates the
> DT bindings for the same.
> 
> Shreeya Patel (2):
>   arm64: dts: rockchip: Enable watchdog support for RK3588
>   dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt string
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rockchip: Enable watchdog support for RK3588
      commit: 932d139e4db18d535dea271df51db5216b8787b3
[2/2] dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt string
      commit: e1a234eb3d1507b942c25e5a5ae0d6fb9036f1ff

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
