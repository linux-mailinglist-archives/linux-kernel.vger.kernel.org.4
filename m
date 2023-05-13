Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF59701840
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjEMQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjEMQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 12:49:35 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063EA2D68;
        Sat, 13 May 2023 09:49:33 -0700 (PDT)
Received: from p508fce4f.dip0.t-ipconnect.de ([80.143.206.79] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pxsR0-0000Vh-Cn; Sat, 13 May 2023 18:49:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix button reset pin for nanopi r5c
Date:   Sat, 13 May 2023 18:49:24 +0200
Message-Id: <168399655509.610817.9447804188799510954.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230510161850.4866-1-cnsztl@gmail.com>
References: <20230510161850.4866-1-cnsztl@gmail.com>
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

On Thu, 11 May 2023 00:18:50 +0800, Tianling Shen wrote:
> The reset pin was wrongly assigned due to a copy/paste error,
> fix it to match actual gpio pin.
> 
> While at it, remove a blank line from nanopi r5s dts.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: fix button reset pin for nanopi r5c
      commit: 5325593377f07de31f7e473a9677a28a04c891f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
