Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649686D8529
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjDERqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDERqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:46:09 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4983C0B;
        Wed,  5 Apr 2023 10:46:06 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk7Cu-0000Me-44; Wed, 05 Apr 2023 19:46:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: correct panel supplies
Date:   Wed,  5 Apr 2023 19:45:59 +0200
Message-Id: <168071663561.3186456.11700069193169074843.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
References: <20230326204520.80859-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 26 Mar 2023 22:45:18 +0200, Krzysztof Kozlowski wrote:
> The Anbernic and Odroid Go have different panels and take differently
> named supplies, so move all the supplies to DTS defining actual panel to
> fix warnings like:
> 
>   rk3326-odroid-go3.dtb: panel@0: 'IOVCC-supply' is a required property
>   rk3326-odroid-go3.dtb: panel@0: 'iovcc-supply', 'vdd-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> [...]

Applied, thanks!

Applied most of the series as fix for 6.3, but split the first patch into
two, as the Odroid Go3 display support only got added for 6.4


[1/3] arm64: dts: rockchip: correct panel supplies
      commit: 60a655debd36e3278a46872accc1a51a54f94f02
      (fixes)

      commit: 07099a551803e05d3ee42fae152bf404f8dc21f9
      (for 6.4)

[2/3] arm64: dts: rockchip: use just "port" in panel on Pinebook Pro
      commit: 5438b349c0512a6fe023976aad8b9f19ca671dd1
[3/3] arm64: dts: rockchip: use just "port" in panel on RockPro64
      commit: 2dd16a23e8c687bde605dbdcfedaed97bb2a0c0e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
