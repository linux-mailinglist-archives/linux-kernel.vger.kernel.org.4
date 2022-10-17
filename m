Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4E600F47
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJQMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJQMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:35:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F323BF3;
        Mon, 17 Oct 2022 05:34:50 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okPKO-00087p-G0; Mon, 17 Oct 2022 14:34:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Lev Popov <leo@nabam.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Dan Johansen <strit@manjaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4] arm64: dts: rockchip: fix quartz64-a bluetooth configuration
Date:   Mon, 17 Oct 2022 14:34:39 +0200
Message-Id: <166601006787.173248.7939745921519650115.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926125350.64783-1-leo@nabam.net>
References: <CAMdYzYpdhJ-wWN9UAppQvaNqK8Y_RadYv2v67gD5S_u=1ZXw0Q@mail.gmail.com> <20220926125350.64783-1-leo@nabam.net>
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

On Mon, 26 Sep 2022 14:53:48 +0200, Lev Popov wrote:
> For "Quartz64 Model A" add missing RTS line to the UART interface used by
> bluetooth and swap bluetooth host-wakeup and device-wakeup gpio pins to
> match the boards physical layout. This changes are necessary to make
> bluetooth provided by the wireless module work.
> 
> Also set max-speed on the bluetooth device as it's not automatically
> detected.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix quartz64-a bluetooth configuration
      commit: 2dcd7e0c821fe9b663f7d3382b6d2faa8edf2129

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
