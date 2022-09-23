Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8169E5E7876
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiIWKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiIWKeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:34:11 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EC1788A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:34:10 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obg0T-0005sI-4A; Fri, 23 Sep 2022 12:34:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Will Deacon <will@kernel.org>, Anand Moon <linux.amoon@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Synopsys DWC MSHC driver
Date:   Fri, 23 Sep 2022 12:34:01 +0200
Message-Id: <166392923326.537565.6112224812808419083.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220922192050.2031-1-linux.amoon@gmail.com>
References: <20220922192050.2031-1-linux.amoon@gmail.com>
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

On Thu, 22 Sep 2022 19:20:48 +0000, Anand Moon wrote:
> Enable the driver SDHCI support for the Synopsys DWC MSHC
> controller which can be found on Rockchip 356x SoCs.

Applied, thanks!

[1/1] arm64: defconfig: Enable Synopsys DWC MSHC driver
      commit: 489dd8611b64efbd84c12c6c9db470dadc34470f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
