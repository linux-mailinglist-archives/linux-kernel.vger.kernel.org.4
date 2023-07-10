Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13674D8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjGJOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjGJOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:16:30 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC8106;
        Mon, 10 Jul 2023 07:16:28 -0700 (PDT)
Received: from i53875a50.versanet.de ([83.135.90.80] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qIrge-0001RE-TU; Mon, 10 Jul 2023 16:16:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: Update sound card label on rk3588-rock-5b
Date:   Mon, 10 Jul 2023 16:16:17 +0200
Message-Id: <168899855919.1747213.12679087846139492999.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707162822.676024-1-cristian.ciocaltea@collabora.com>
References: <20230707162822.676024-1-cristian.ciocaltea@collabora.com>
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

On Fri, 7 Jul 2023 19:28:22 +0300, Cristian Ciocaltea wrote:
> The audio-graph-card driver uses the 'label' property to register the
> sound card in the system, but the currently assigned string is too
> generic and cannot be supported by alsa-project/alsa-ucm-conf:
> 
>   card 0: Analog [Analog]
> 
> Use the more specific naming "rk3588-es8316", which is still generic
> enough to be shared with other compatible boards, e.g. Rock 5A. The
> audio card will be listed as:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Update sound card label on rk3588-rock-5b
      commit: 7efcaf997ae624caeccd046b6266fc2b7c0b91dc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
