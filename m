Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA35B850B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiINJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiINJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:33:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB675FC3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:27:30 -0700 (PDT)
Received: from [89.101.193.68] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oYOg3-0004qR-32; Wed, 14 Sep 2022 11:27:27 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, David Airlie <airlied@linux.ie>,
        Dan Carpenter <error27@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/rockchip: Fix return type of cdn_dp_connector_mode_valid
Date:   Wed, 14 Sep 2022 11:27:24 +0200
Message-Id: <166314762584.32089.13970704876797531888.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913205555.155149-1-nhuck@google.com>
References: <20220913205555.155149-1-nhuck@google.com>
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

On Tue, 13 Sep 2022 13:55:55 -0700, Nathan Huckleberry wrote:
> The mode_valid field in drm_connector_helper_funcs is expected to be of
> type:
> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
> 				     struct drm_display_mode *mode);
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: Fix return type of cdn_dp_connector_mode_valid
      commit: b0b9408f132623dc88e78adb5282f74e4b64bb57

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
