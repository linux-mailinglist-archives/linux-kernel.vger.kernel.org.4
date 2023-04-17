Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB476E45C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDQKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjDQKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:51:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005549DD;
        Mon, 17 Apr 2023 03:50:20 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1poLHB-00027c-PJ; Mon, 17 Apr 2023 11:35:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        John Clark <inindev@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [v2] arm64: dts: rockchip: Add pinctrl gpio-ranges for rk356x
Date:   Mon, 17 Apr 2023 11:35:55 +0200
Message-Id: <168172146375.3844162.11356343846845712762.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230413170337.6815-1-inindev@gmail.com>
References: <20230413144316.4247-1-inindev@gmail.com> <20230413170337.6815-1-inindev@gmail.com>
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

On Thu, 13 Apr 2023 13:03:37 -0400, John Clark wrote:
> Add gpio-range properties to the pinctrl gpio nodes in rk356x.dtsi
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add pinctrl gpio-ranges for rk356x
      commit: 6f5ab8fa33238fdf6cb28dac7bc2f650db2caf08

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
