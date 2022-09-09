Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B75B3BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiIIPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiIIPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:48 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E44B86FDC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:31:08 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oWfxD-0006GD-HL; Fri, 09 Sep 2022 17:30:03 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, wangjianli <wangjianli@cdjrlc.com>,
        daniel@ffwll.ch, airlied@linux.ie
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/rockchip: fix repeated words in comments
Date:   Fri,  9 Sep 2022 17:30:01 +0200
Message-Id: <166273738605.3499664.4120092619093859297.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908123616.19195-1-wangjianli@cdjrlc.com>
References: <20220908123616.19195-1-wangjianli@cdjrlc.com>
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

On Thu, 8 Sep 2022 20:36:16 +0800, wangjianli wrote:
> Delete the redundant word 'in'.

Applied, thanks!

[1/1] drm/rockchip: fix repeated words in comments
      commit: fe53d167129e19ce01c056d85262427146cacf88

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
