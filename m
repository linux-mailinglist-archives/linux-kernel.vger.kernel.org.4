Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FC6644F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbjAJPeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbjAJPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:33:06 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906732272;
        Tue, 10 Jan 2023 07:33:04 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFGcX-0005bB-UD; Tue, 10 Jan 2023 16:33:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: add brcmf node to rk3066a-mk808.dts
Date:   Tue, 10 Jan 2023 16:32:59 +0100
Message-Id: <167336477675.2640328.14984195063883360325.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <b3c7f1d7-47fd-90e4-badb-e8ceb8901e27@gmail.com>
References: <b3c7f1d7-47fd-90e4-badb-e8ceb8901e27@gmail.com>
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

On Fri, 16 Dec 2022 00:17:44 +0100, Johan Jonker wrote:
> The MK808 board has a wifi chip called RK901.
> Add a somewhat brcmf compatible node to the rk3066a-mk808.dts file.
> That's what's available as driver in the mainline kernel in relation
> to this Rockchip wifi product that is able to load the firmware.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: add brcmf node to rk3066a-mk808.dts
      commit: 75bba4f4faf4f14112377ff6d1b996a7ec4c0fa1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
