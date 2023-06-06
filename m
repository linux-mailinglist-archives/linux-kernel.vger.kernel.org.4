Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8D7249CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbjFFRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjFFRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41310CB;
        Tue,  6 Jun 2023 10:07:25 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6a9O-0001ED-JJ; Tue, 06 Jun 2023 19:07:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] arm64: dts: rockchip: rock-5b: add PMIC
Date:   Tue,  6 Jun 2023 19:07:12 +0200
Message-Id: <168607097312.1436521.15824413081309384373.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230529170532.59804-1-sebastian.reichel@collabora.com>
References: <20230529170532.59804-1-sebastian.reichel@collabora.com>
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

On Mon, 29 May 2023 19:05:31 +0200, Sebastian Reichel wrote:
> This adds PMIC support for the Radxa ROCK 5B
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: rock-5b: add PMIC
      commit: db242e8240b5dc8bd3709dceb194bd49cd3aac2e
[2/2] arm64: dts: rockchip: rock-5b: Add SD card support
      commit: 2a6d4af5f157b1540e7a49f7fdbbf517b0d0d5b7

I've adapted the fixed regulator nodes, to add the
"-regulator" suffix.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
