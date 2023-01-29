Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678D67FF67
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjA2NjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 08:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2NjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 08:39:21 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466CE13505;
        Sun, 29 Jan 2023 05:39:19 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pM7tr-0003rM-LA; Sun, 29 Jan 2023 14:39:15 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert rockchip-dp-phy.txt to yaml
Date:   Sun, 29 Jan 2023 14:39:08 +0100
Message-Id: <167499930030.3595793.1225360645667569018.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
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

On Thu, 29 Dec 2022 10:44:28 +0100, Johan Jonker wrote:
> Convert rockchip-dp-phy.txt to yaml.
> 
> Changed:
>   rename file name
> 
> 

Applied, thanks!

[1/2] dt-bindings: phy: rockchip: convert rockchip-dp-phy.txt to yaml
      commit: fc7b83bcaf0334a80d175ab6b280fd838e8a5596
[2/2] dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml
      commit: 51b2089284f3f08ca8971b65d5b2f66f926f7d14

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
