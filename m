Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12E96F4043
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjEBJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:37:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA52A4C08;
        Tue,  2 May 2023 02:37:48 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ptmS7-0006ji-PC; Tue, 02 May 2023 11:37:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCHv2 0/7] phy-rockchip-inno-usb2: add RK3588 support
Date:   Tue,  2 May 2023 11:37:42 +0200
Message-Id: <168302024879.773217.112764704871308038.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230403202307.120562-1-sebastian.reichel@collabora.com>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 22:23:00 +0200, Sebastian Reichel wrote:
> This adds RK3588 to the Rockchip Inno USB2 PHY driver. I have tested this
> with USB2_0 and USB2_1.
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20230331163812.6124-1-sebastian.reichel@collabora.com/
>  * Added patch simplifying phyclk handling
>  * Added patch simplifying matchdata handling
>  * Added patches for reset handling and PHY tuning; after doing more
>    testing I noticed my previous patchset does not support hotplug and
>    USB devices need to be plugged in at boot time (more specifically
>    in PATCHv1 it had to be plugged before the PHY is suspended). This
>    fixes the issue.
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: soc: rockchip: add rk3588 usb2phy syscon
      commit: 980cb53be481a6900fc08e6bbb77a6fe2986b211

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
