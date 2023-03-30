Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A645D6D03B9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjC3Lp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjC3Lpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:45:43 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D4A5D8;
        Thu, 30 Mar 2023 04:45:20 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1phqi2-0003YZ-6H; Thu, 30 Mar 2023 13:44:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Robert Mader <robert.mader@collabora.com>,
        Jarrah Gosbell <kernel@undef.tools>,
        linux-rockchip@lists.infradead.org, Tom <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Martijn Braam <martijn@brixit.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Ondrej Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>
Subject: Re: [PATCH v3 0/2] arm64: dts: rk3399-pinephone-pro: Add display and touchscreen support
Date:   Thu, 30 Mar 2023 13:44:45 +0200
Message-Id: <168017666941.2380317.10565826137192421162.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230328073309.1743112-1-javierm@redhat.com>
References: <20230328073309.1743112-1-javierm@redhat.com>
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

On Tue, 28 Mar 2023 09:33:07 +0200, Javier Martinez Canillas wrote:
> This series adds support for the display and touchscreen found in the
> PinePhone Pro. It's a third version that addresses issues pointed out
> by Ondrej Jirman in v2:
> 
> http://lists.infradead.org/pipermail/linux-rockchip/2023-March/037889.html
> 
> Best regards,
> Javier
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: rk3399-pinephone-pro: Add internal display support
      commit: 3e987e1f22b9b9fdb652a5f3f4aff24265c9af05
[2/2] arm64: dts: rk3399-pinephone-pro: Add touchscreen support
      commit: 17a23ce930e35d5a84889441efd9208d0445bf18

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
