Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE99A7249D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbjFFRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjFFRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C710CB;
        Tue,  6 Jun 2023 10:07:30 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6a9N-0001ED-P3; Tue, 06 Jun 2023 19:07:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
        linux-kernel@vger.kernel.org,
        Andrew Powers-Holmes <aholmes@omnom.net>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
Date:   Tue,  6 Jun 2023 19:07:10 +0200
Message-Id: <168607097307.1436521.10713496866831894596.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
References: <20230601132516.153934-1-frattaroli.nicolas@gmail.com>
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

On Thu, 1 Jun 2023 15:25:16 +0200, Nicolas Frattaroli wrote:
> From: Andrew Powers-Holmes <aholmes@omnom.net>
> 
> The register and range mappings for the PCIe controller in Rockchip's
> RK356x SoCs are incorrect. Replace them with corrected values from the
> vendor BSP sources, updated to match current DT schema.
> 
> These values are also used in u-boot.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rk356x: Fix PCIe register and range mappings
      commit: 568a67e742dfa90b19a23305317164c5c350b71e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
