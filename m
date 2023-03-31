Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42416D1450
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCaAq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjCaAqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:46:24 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEDA12BE4;
        Thu, 30 Mar 2023 17:46:18 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pi2u9-00085a-Vg; Fri, 31 Mar 2023 02:46:10 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Judy Hsiao <judyhsiao@chromium.org>,
        zain wang <wzz@rock-chips.com>,
        linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Enric Balletbo i Serra <eballetbo@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Remove non-existing pwm-delay-us property
Date:   Fri, 31 Mar 2023 02:46:03 +0200
Message-Id: <168022355549.2421590.10536271143101805673.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230330231924.2404747-1-javierm@redhat.com>
References: <20230330231924.2404747-1-javierm@redhat.com>
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

On Fri, 31 Mar 2023 01:19:23 +0200, Javier Martinez Canillas wrote:
> There is neither a driver that parses this nor a DT binding schema that
> documents it, so let's remove from the DTS files that make use of this.
> 
> The properties that exist are post-pwm-on-delay-ms and pwm-off-delay-ms,
> defined in the pwm-backlight DT binding. If the delays are really needed
> then those properties should be used instead.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Remove non-existing pwm-delay-us property
      commit: 3adf89324a2b2a9dbc2c12d8895021e7e34e3346

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
