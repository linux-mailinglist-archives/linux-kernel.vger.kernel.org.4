Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F6A66595E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbjAKKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbjAKKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:48:45 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B323714037;
        Wed, 11 Jan 2023 02:48:40 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pFYem-0004Wz-7p; Wed, 11 Jan 2023 11:48:32 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Andy Yan <andyshrk@163.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, piotr.oniszczuk@gmail.com
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: rk3566-box-demo: add io domain setting
Date:   Wed, 11 Jan 2023 11:48:23 +0100
Message-Id: <167343400177.2680857.32771562121515022.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229115043.3899733-1-andyshrk@163.com>
References: <20221229115043.3899733-1-andyshrk@163.com>
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

On Thu, 29 Dec 2022 19:50:43 +0800, Andy Yan wrote:
> Add the missing pmu_io_domains setting, the gmac can't work well
> without this.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: rk3566-box-demo: add io domain setting
      commit: 9554f023385825be4b1e3557398c82e25be83da4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
