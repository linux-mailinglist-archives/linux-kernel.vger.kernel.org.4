Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5971A61798F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiKCJOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKCJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:13:30 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F42ADF6D;
        Thu,  3 Nov 2022 02:13:00 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 03 Nov 2022 17:12:59 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 2A39CtA0002280;
        Thu, 3 Nov 2022 17:12:55 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Thu, 3 Nov 2022 17:12:55 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 0/2] *** IT6505 driver read dt properties ***
Date:   Thu, 3 Nov 2022 17:12:41 +0800
Message-ID: <20221103091243.96036-1-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 2838FB2AFEA8CFF14AC738512C4416578E0EBA9D159E75B0586F7E1864BEC8E92002:8
X-MAIL: mse.ite.com.tw 2A39CtA0002280
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series let driver can read properties from dt to restrict dp output
bandwidth.

Changes in v3:
-Rename property name.

Changes in v4:
-Use data-lanes and link-frequencies instead of "ite,dp-output-data-lane-count" and "ite,dp-output-max-pixel-clock-mhz".

Changes in v5:
-Add a port and a endpoint.
-Move data-lanes property to the output endpoint.

Changes in v6:
-Modified data-lanes description by suggestion.

Changes in v7:
-Add commit messages to explain reason for breaking users.

allen chen (2):
  dt-bindings: it6505: add properties to restrict output bandwidth
  drm/bridge: add it6505 driver to read data-lanes and link-frequencies
    from dt

 .../bindings/display/bridge/ite,it6505.yaml   | 68 ++++++++++++++--
 drivers/gpu/drm/bridge/ite-it6505.c           | 80 ++++++++++++++++++-
 2 files changed, 139 insertions(+), 9 deletions(-)

-- 
2.25.1

