Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3775B69D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIMIs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiIMIsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:48:53 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145DF474DF;
        Tue, 13 Sep 2022 01:48:49 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 13 Sep 2022 16:48:48 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 28D8mkk1017639;
        Tue, 13 Sep 2022 16:48:46 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Tue, 13 Sep 2022 16:48:46 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] *** IT6505 driver read dt properties ***
Date:   Tue, 13 Sep 2022 16:48:33 +0800
Message-ID: <20220913084835.78490-1-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 3614B426C08A09BF188F2DAF5BD90D342D867CB900288FE8BB4244F8061882502002:8
X-MAIL: mse.ite.com.tw 28D8mkk1017639
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allen chen <allen.chen@ite.com.tw>

This series let driver can read properties from dt to restrict dp output
bandwidth.

allen chen (2):
  dt-bindings: it6505: add properties to restrict output bandwidth
  drm/bridge: add it6505 driver to read data-lanes and
    max-pixel-clock-khz from dt

 .../bindings/display/bridge/ite,it6505.yaml   | 10 ++++++
 drivers/gpu/drm/bridge/ite-it6505.c           | 35 +++++++++++++++++--
 2 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.25.1

