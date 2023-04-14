Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2726E2818
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDNQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDNQLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:11:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3986BD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 09:11:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM1A-00049R-QH; Fri, 14 Apr 2023 18:11:20 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM19-00BErg-Ni; Fri, 14 Apr 2023 18:11:19 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pnM18-00FQvi-Es; Fri, 14 Apr 2023 18:11:18 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/2] Support non-default LVDS data mapping for simple
Date:   Fri, 14 Apr 2023 18:11:14 +0200
Message-Id: <20230414161116.3673911-1-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some LVDS panels, such as the innolux,g101ice-l01 support multiple LVDS
data mapping modes, which can be configured by strapping a dataformat
pin on the display to a specific voltage.

This can be particularly useful for using the jeida-18 format, which
requires only 3 instead of 4 LVDS lanes.

This series adds an optional data-mapping property, analogously to the
property on lvds-panel, which overrides the default data mapping set in
the panel description in simple-panel.

Best regards
Johannes

Johannes Zink (2):
  dt-bindings: display: simple: support non-default data-mapping
  drm/panel-simple: allow LVDS format override

 .../bindings/display/panel/panel-simple.yaml  | 51 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c          | 37 +++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.39.2

