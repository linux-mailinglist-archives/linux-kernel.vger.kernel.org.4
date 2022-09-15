Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5515B9C20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIONk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIONkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:40:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148DE4A804
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:40:20 -0700 (PDT)
Received: from [89.101.193.72] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYp6E-0004w0-5I; Thu, 15 Sep 2022 15:40:14 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tom Rix <trix@redhat.com>, airlied@linux.ie, hjc@rock-chips.com,
        daniel@ffwll.ch
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: remove vop_writel
Date:   Thu, 15 Sep 2022 15:40:12 +0200
Message-Id: <166324919922.172360.17550156520771628477.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220521190716.1936193-1-trix@redhat.com>
References: <20220521190716.1936193-1-trix@redhat.com>
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

On Sat, 21 May 2022 15:07:16 -0400, Tom Rix wrote:
> cppcheck reports
> [drivers/gpu/drm/rockchip/rockchip_drm_vop.c:186]: (style) The function 'vop_writel' is never used.
> 
> vop_writel is static function that is not used, so remove it.

Applied, thanks!

[1/1] drm/rockchip: remove vop_writel
      commit: 98a65e6d498c46b0beec7a40aac4b3e404642993

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
