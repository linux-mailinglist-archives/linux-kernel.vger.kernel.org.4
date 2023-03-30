Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA926D0066
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjC3J7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC3J7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:59:49 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CCAB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:59:49 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 5445B20B49;
        Thu, 30 Mar 2023 11:59:47 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/6] drm/bridge: tc358768: Improve parallel RGB input configuration
Date:   Thu, 30 Mar 2023 11:59:35 +0200
Message-Id: <20230330095941.428122-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add support for different parallel RGB input format and mapping, this enables
using the TC358768 when the parallel input width is less than 24-bit or the
input mapping is not the default one.

In addition to that this series add support for the TC9594, that is the
automotive version of the TC358768 (100% identical from the SW point of view).

Francesco Dolcini (6):
  dt-bindings: display: bridge: toshiba,tc358768: Fix typo
  dt-bindings: display: bridge: toshiba,tc358768: Add TC9594
  dt-bindings: display: bridge: toshiba,tc358768: add parallel input
    mode
  drm/bridge: tc358768: Add TC9594
  drm/bridge: tc358768: Add parallel data format cfg
  drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation

 .../display/bridge/toshiba,tc358768.yaml      | 20 +++++++-
 drivers/gpu/drm/bridge/tc358768.c             | 51 +++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.25.1

