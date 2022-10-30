Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F0612CA6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 21:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJ3UaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJ3U3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 16:29:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A36A1A7;
        Sun, 30 Oct 2022 13:29:55 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opEwL-0005lw-Ha; Sun, 30 Oct 2022 21:29:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
Date:   Sun, 30 Oct 2022 21:29:45 +0100
Message-Id: <166716177915.1683006.8839115651590119733.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <7b9c0a6f-626b-07e8-ae74-7e0f08b8d241@gmail.com>
References: <7b9c0a6f-626b-07e8-ae74-7e0f08b8d241@gmail.com>
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

On Thu, 27 Oct 2022 01:31:37 +0200, Johan Jonker wrote:
> The lcdc1-rgb24 node name is out of line with the rest
> of the rk3188 lcdc1 node, so fix it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
      commit: 11871e20bcb23c00966e785a124fb72bc8340af4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
