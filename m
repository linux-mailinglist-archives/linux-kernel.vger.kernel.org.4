Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA8600F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiJQMfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJQMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:34:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4771AF1F;
        Mon, 17 Oct 2022 05:34:46 -0700 (PDT)
Received: from p508fc122.dip0.t-ipconnect.de ([80.143.193.34] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1okPKN-00087p-CY; Mon, 17 Oct 2022 14:34:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Drop Scarlet's repeated ec_ap_int_l definition
Date:   Mon, 17 Oct 2022 14:34:35 +0200
Message-Id: <166601006782.173248.10349280767001013645.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013213336.1779917-1-briannorris@chromium.org>
References: <20221013213336.1779917-1-briannorris@chromium.org>
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

On Thu, 13 Oct 2022 14:33:35 -0700, Brian Norris wrote:
> This is repeated a few lines down.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Drop Scarlet's repeated ec_ap_int_l definition
      commit: ef40e88d1be172ca05e6e8cef00284a1cf4f43d8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
