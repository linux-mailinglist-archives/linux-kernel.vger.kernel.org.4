Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1866296E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbiKOLMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiKOLKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:48 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902D5FDB;
        Tue, 15 Nov 2022 03:10:33 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1outpe-0007ai-01; Tue, 15 Nov 2022 12:10:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, pgwipeout@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add Rockchip rk3566 box demo board
Date:   Tue, 15 Nov 2022 12:10:15 +0100
Message-Id: <166851058435.863884.6413531629073942416.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221105095935.958144-1-andyshrk@163.com>
References: <20221105095935.958144-1-andyshrk@163.com>
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

On Sat, 5 Nov 2022 17:59:35 +0800, Andy Yan wrote:
> Add device tree binding for Rockchip rk3566 box demo board.
> 
> 

Applied, thanks!

[1/2] dt-bindings: rockchip: Add Rockchip rk3566 box demo board
      commit: 68fc69012b527cb0be2b6b793531c32ab0dd6c29
[2/2] arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board
      commit: 2e0537b16b2557974f81db008a51f41c838dcb81

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
