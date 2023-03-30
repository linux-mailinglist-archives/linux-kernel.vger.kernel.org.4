Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264026D00F1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjC3KSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC3KSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:18:04 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED09472A7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 03:18:03 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id EC9E120755;
        Thu, 30 Mar 2023 12:18:01 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] drm/bridge: ti-sn65dsi83: Add DSI video mode configuration
Date:   Thu, 30 Mar 2023 12:17:50 +0200
Message-Id: <20230330101752.429804-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

SN65DSI8[34] device supports burst video mode and non-burst video mode with
sync events or with sync pulses packet transmission as described in the DSI
specification.

Enable configuration of the DSI video mode instead of hard-coding
MIPI_DSI_MODE_VIDEO_BURST.

Francesco Dolcini (2):
  dt-bindings: display: bridge: sn65dsi83: Add DSI video mode
  drm/bridge: ti-sn65dsi83: Add DSI video mode configuration

 .../bindings/display/bridge/ti,sn65dsi83.yaml |  8 +++++++
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         | 24 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.25.1

