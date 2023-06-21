Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00244738432
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFUM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjFUM6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:58:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7F19A4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1CA060DF0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC261C433C0;
        Wed, 21 Jun 2023 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687352321;
        bh=0wuMaCipc6KtZD0Xh4BIPnRA9SQTgc4eexJxe2sb/h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnIxgLCUvIzh7oUiE4sXzvtmMB8eohVtfVw3ccGZjd20l8Pfov8YBblQ2I5AieLqO
         8rYxI4a6G/6pPnuG7XNOjo3uWQVoRTyBIyDu8XYVsbRRvFAqz6gQDRBpvQiwBw1vOP
         v1nRx4Hi8TzBJcjaQdtfEJqfWp/eIQkkbhoVJkt8eCHWJaa+wZ0pqgBvmOU61nEQvB
         t8Yo02QHYnakBa22j44k/ai3AMOxTzRzzqLL6HEW4sLOA7xaWRyjrrcPwAruk3tvgu
         LGmQHAdg+wQvuxH935NPBC0OY0BXRK6WbqF6LPllU4Dh5fb2+Jakhu/hm8g/9Q4UcB
         dEKpBDjARxHew==
From:   rfoss@kernel.org
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Robert Foss <rfoss@kernel.org>, andrzej.hajda@intel.com,
        dri-devel@lists.freedesktop.org, airlied@gmail.com,
        jonas@kwiboo.se, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, jernej.skrabec@gmail.com,
        Laurent.pinchart@ideasonboard.com, daniel@ffwll.ch
Subject: Re: [PATCH v2] drm/bridge: lt9611uxc: Add MODULE_FIRMWARE macro
Date:   Wed, 21 Jun 2023 14:58:34 +0200
Message-Id: <168735229147.2587713.1545878591431982417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620061254.1210248-1-juerg.haefliger@canonical.com>
References: <CAN6tsi4jdDD20DY5sKL+ALC_Mk2UHRArOrQnjzKoyF30QZi8jw@mail.gmail.com> <20230620061254.1210248-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <rfoss@kernel.org>

On Tue, 20 Jun 2023 08:12:54 +0200, Juerg Haefliger wrote:
> The module loads firmware so add a MODULE_FIRMWARE macro to provide that
> information via modinfo.
> 
> 

Applied, thanks!

[1/1] drm/bridge: lt9611uxc: Add MODULE_FIRMWARE macro
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=354c0fb61739



Rob

