Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B360EE46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiJ0DCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiJ0DCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 23:02:15 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436AB1285CC;
        Wed, 26 Oct 2022 20:02:10 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 27 Oct 2022 11:02:09 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 29R327Kg066790;
        Thu, 27 Oct 2022 11:02:07 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Thu, 27 Oct 2022 11:02:06 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/2] *** IT6505 driver read dt properties ***
Date:   Thu, 27 Oct 2022 11:01:52 +0800
Message-ID: <20221027030155.59238-1-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: C994312C4D7C7AD7551E368439E1BAC17A40D5B6306B4FC6D09D1749855C95E02002:8
X-MAIL: mse.ite.com.tw 29R327Kg066790
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

allen chen (2):
  dt-bindings: it6505: add properties to restrict output bandwidth
  drm/bridge: add it6505 driver to read data-lanes and link-frequencies
    from dt

 .../bindings/display/bridge/ite,it6505.yaml   | 68 ++++++++++++++--
 drivers/gpu/drm/bridge/ite-it6505.c           | 80 ++++++++++++++++++-
 2 files changed, 139 insertions(+), 9 deletions(-)

-- 
2.25.1

