Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D836E74D8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjGJORc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGJOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:17:29 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB7E6F;
        Mon, 10 Jul 2023 07:17:04 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIrge-0001RE-D4; Mon, 10 Jul 2023 16:16:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Riabchenko <d3adme4t@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Furkan Kardame <f.kardame@manjaro.org>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Anand Moon <linux.amoon@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Shengyu Qu <wiagn233@outlook.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dan Johansen <strit@manjaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Yuteng Zhong <zonyitoo@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Wenhao Cui <lasstp5011@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, Lev Popov <leo@nabam.net>,
        Andy Yan <andyshrk@163.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Fabio Estevam <festevam@denx.de>,
        Dongjin Kim <tobetter@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
Date:   Mon, 10 Jul 2023 16:16:16 +0200
Message-Id: <168899855919.1747213.9998138836668928892.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
References: <20230707162217.675390-1-cristian.ciocaltea@collabora.com>
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

On Fri, 7 Jul 2023 19:22:17 +0300, Cristian Ciocaltea wrote:
> The 'regulator-init-microvolt' property is not currently supported by
> any driver, it was simply carried on from downstream kernels.
> 
> The problem is also indicated by the following dtbs_check warning:
> 
>   rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
      commit: 4d08b19629495b29601991d09d07865694c25199

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
