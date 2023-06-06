Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CE7249D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbjFFRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbjFFRH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833541735;
        Tue,  6 Jun 2023 10:07:40 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6a9N-0001ED-9t; Tue, 06 Jun 2023 19:07:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Conor Dooley <conor+dt@kernel.org>,
        Zhu Ning <zhuning0077@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        David Yang <yangxiaohua@everest-semi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Daniel Drake <drake@endlessm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] ES8316 audio codec fixes on Rock5B
Date:   Tue,  6 Jun 2023 19:07:09 +0200
Message-Id: <168607097312.1436521.13454183292358558195.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
References: <20230530181140.483936-1-cristian.ciocaltea@collabora.com>
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

On Tue, 30 May 2023 21:11:37 +0300, Cristian Ciocaltea wrote:
> This patch series handles a few issues related to the ES8316 audio
> codec, discovered while doing some testing on the Rock 5B board.
> 
> Changes in v2:
>  - Preserved original dB gain range in PATCH 1
>  - Rewrote PATCH 2 conditional statement, per Mark's review
>  - Rebased series onto next-20230530
>  - v1: https://lore.kernel.org/all/20230524074156.147387-1-cristian.ciocaltea@collabora.com/
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b
      commit: 28ee08cef4f838c343013330a3cd12674c4dd113

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
