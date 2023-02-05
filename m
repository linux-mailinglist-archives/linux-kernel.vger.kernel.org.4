Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4276D68B034
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBEOKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBEOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:10:02 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010D1F919;
        Sun,  5 Feb 2023 06:10:00 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pOfi4-00075Q-6S; Sun, 05 Feb 2023 15:09:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Robert Foss <rfoss@kernel.org>,
        dri-devel@lists.freedesktop.org, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com,
        hjc@rock-chips.com, philippe.cornu@foss.st.com, jonas@kwiboo.se,
        krzysztof.kozlowski+dt@linaro.org,
        Laurent.pinchart@ideasonboard.com, alim.akhtar@samsung.com,
        neil.armstrong@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        linux-rockchip@lists.infradead.org, inki.dae@samsung.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, devicetree@vger.kernel.org,
        andrzej.hajda@intel.com, linux-usb@vger.kernel.org,
        sw0312.kim@samsung.com
Subject: Re: (subset) [PATCH v6 01/17] dt-bindings: display: rockchip: convert rockchip-lvds.txt to YAML
Date:   Sun,  5 Feb 2023 15:09:34 +0100
Message-Id: <167560616167.854266.15581661831063028156.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 15:22:14 +0100, Johan Jonker wrote:
> Convert rockchip-lvds.txt to YAML.
> 
> Changed:
>   Add power-domains property.
>   Requirements between PX30 and RK3288
> 
> 
> [...]

Applied, thanks!

[01/17] dt-bindings: display: rockchip: convert rockchip-lvds.txt to YAML
        commit: d567ca6ed9fd5fe594bca5e29717ff9e9631efba
[02/17] dt-bindings: soc: rockchip: grf: add rockchip,lvds.yaml
        commit: cbfc73a3febdf14395ecdd738decd53835166662
[03/17] dt-bindings: display: dsi-controller: move clock-master property
        commit: a1b7455dc4a399a565353ceb7cce605b4b9db41a
[04/17] dt-bindings: display: bridge: snps,dw-mipi-dsi: fix clock properties
        commit: a90fa0adbeb07f11c08635364d206678d9e1b938
[05/17] dt-bindings: display: rockchip: convert dw_mipi_dsi_rockchip.txt to yaml
        commit: 0dac2102cf6baacba0d9d7804b0c163337f69839
[06/17] dt-bindings: display: bridge: convert analogix_dp.txt to yaml
        commit: 440112adadd3e273d2a2ff6e5d4b969ee03fda47
[07/17] dt-bindings: display: rockchip: convert analogix_dp-rockchip.txt to yaml
        commit: 9bb35d4c3230803345d5218676a7325b26823209

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
