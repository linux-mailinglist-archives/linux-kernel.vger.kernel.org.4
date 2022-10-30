Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347E2612CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ3UaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ3U3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:29:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0770EA1A6;
        Sun, 30 Oct 2022 13:29:53 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opEwJ-0005lw-5m; Sun, 30 Oct 2022 21:29:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 1/2] ARM: dts: rockchip: fix ir-receiver node names
Date:   Sun, 30 Oct 2022 21:29:44 +0100
Message-Id: <166716177914.1683006.17777067125104187141.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ea5af279-f44c-afea-023d-bb37f5a0d58d@gmail.com>
References: <ea5af279-f44c-afea-023d-bb37f5a0d58d@gmail.com>
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

On Thu, 27 Oct 2022 10:58:22 +0200, Johan Jonker wrote:
> Fix ir-receiver node names on Rockchip boards,
> so that they match with regex: '^ir(-receiver)?(@[a-f0-9]+)?$'
> 
> 

Applied, thanks!

[1/2] ARM: dts: rockchip: fix ir-receiver node names
      commit: dd847fe34cdf1e89afed1af24986359f13082bfb
[2/2] arm64: dts: rockchip: fix ir-receiver node names
      commit: de0d04b9780a23eb928aedfb6f981285f78d58e5

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
