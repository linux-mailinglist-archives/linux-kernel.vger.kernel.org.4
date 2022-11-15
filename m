Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C1E6296DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiKOLLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiKOLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:10:43 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B85F6D;
        Tue, 15 Nov 2022 03:10:25 -0800 (PST)
Received: from wf0498.dip.tu-dresden.de ([141.76.181.242] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1outpe-0007ai-MT; Tue, 15 Nov 2022 12:10:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: rockchip: rk3xx: disable arm_global_timer
Date:   Tue, 15 Nov 2022 12:10:17 +0100
Message-Id: <166851058436.863884.13293855526499863813.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <f275ca8d-fd0a-26e5-b978-b7f3df815e0a@gmail.com>
References: <f275ca8d-fd0a-26e5-b978-b7f3df815e0a@gmail.com>
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

On Sun, 30 Oct 2022 21:56:29 +0100, Johan Jonker wrote:
> The clock source and the sched_clock provided by the arm_global_timer
> on Rockchip rk3066a/rk3188 are quite unstable because their rates
> depend on the CPU frequency.
> 
> Recent changes to the arm_global_timer driver makes it impossible to use.
> 
> On the other side, the arm_global_timer has a higher rating than the
> ROCKCHIP_TIMER, it will be selected by default by the time framework
> while we want to use the stable Rockchip clock source.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: rockchip: rk3xx: disable arm_global_timer
      commit: da74858a475782a3f16470907814c8cc5950ad68

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
