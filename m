Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6B87249CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjFFRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjFFRH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:27 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5AA10F0;
        Tue,  6 Jun 2023 10:07:26 -0700 (PDT)
Received: from [91.65.34.120] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q6a9P-0001ED-FW; Tue, 06 Jun 2023 19:07:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, shengfei Xu <xsf@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: add PMIC
Date:   Tue,  6 Jun 2023 19:07:14 +0200
Message-Id: <168607097301.1436521.16891300608030740248.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230526172255.68236-1-sebastian.reichel@collabora.com>
References: <20230526172255.68236-1-sebastian.reichel@collabora.com>
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

On Fri, 26 May 2023 19:22:55 +0200, Sebastian Reichel wrote:
> This adds PMIC support for the RK3588 EVB.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588-evb1: add PMIC
      commit: ec5d218e1e443dd6fea7e77983c3f97b9e09a74a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
