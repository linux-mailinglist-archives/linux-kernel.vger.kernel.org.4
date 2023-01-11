Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130966595A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjAKKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbjAKKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:48:40 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E913F96;
        Wed, 11 Jan 2023 02:48:36 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFYen-0004Wz-VB; Wed, 11 Jan 2023 11:48:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v1] ARM: dts: rockchip: rk3288: add power-domains property to dp node
Date:   Wed, 11 Jan 2023 11:48:28 +0100
Message-Id: <167343400178.2680857.16763957383621021905.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <dab85bfb-9f55-86a1-5cd5-7388c43e0ec5@gmail.com>
References: <dab85bfb-9f55-86a1-5cd5-7388c43e0ec5@gmail.com>
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

On Wed, 28 Dec 2022 21:17:32 +0100, Johan Jonker wrote:
> The clocks in the Rockchip rk3288 DisplayPort node are
> included in the power-domain@RK3288_PD_VIO logic, but the
> power-domains property in the dp node is missing, so fix it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3288: add power-domains property to dp node
      commit: 80422339a75088322b4d3884bd12fa0fe5d11050

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
