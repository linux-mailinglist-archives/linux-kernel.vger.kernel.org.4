Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55906665956
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjAKKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjAKKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:48:38 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E513E85;
        Wed, 11 Jan 2023 02:48:34 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFYem-0004Wz-VS; Wed, 11 Jan 2023 11:48:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Caleb Connolly <kc@postmarketos.org>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: fix input enable pinconf on rk3399
Date:   Wed, 11 Jan 2023 11:48:25 +0100
Message-Id: <167343400179.2680857.5225762201628008377.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221215101947.254896-1-arnaud.ferraris@collabora.com>
References: <20221215101947.254896-1-arnaud.ferraris@collabora.com>
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

On Thu, 15 Dec 2022 11:19:47 +0100, Arnaud Ferraris wrote:
> When the input enable pinconf was introduced, a default drive-strength
> value of 2 was set for the pull up/down configs. However, this parameter
> is unneeded when configuring the pin as input, and having a single
> hardcoded value here is actually harmful: GPIOs on the RK3399 have
> various same drive-strength capabilities depending on the bank and port
> they belong to.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: fix input enable pinconf on rk3399
      commit: 6f515b663d49a14fb63f8c5d0a2a4ae53d44790a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
