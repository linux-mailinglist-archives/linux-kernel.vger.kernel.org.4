Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF33074EA30
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGKJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGKJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:20:47 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9E171E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:17:37 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230711091734882e41a6eec986961d
        for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 11:17:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=YngbMRZ+I71xx4c0Kbc0TTwPMq+UjMpwaQWK/OE0Vi0=;
 b=bEGzPCEPXtDnDjTv9DCE1gCxAJD8SW7Pm763yj8b+3ajZkwxtTVzuwq6hlEhyyz8Ljk20p
 15tn1DsL3kibmjtLFuY3XFfgs9A/fUQ8jn5IurPXQaiRrR7jxl7CtD1Y/oQNGR3YeAGOEOa/
 xibJXbXzw2s0aGo9D/Dizh5HC4a9M=;
From:   huaqian.li@siemens.com
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com, Li Hua Qian <huaqian.li@siemens.com>
Subject: [PATCH v2 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Date:   Tue, 11 Jul 2023 17:17:10 +0800
Message-Id: <20230711091713.1113010-1-huaqian.li@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Hua Qian <huaqian.li@siemens.com>

The watchdog hardware of TI AM65X platform does not support
WDIOF_CARDRESET feature, add a reserved memory to save the watchdog
reset cause, to know if the board reboot is due to a watchdog reset.

Li Hua Qian (3):
  dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
  arm64: dts: ti: Add reserved memory for watchdog
  watchdog:rit_wdt: Add support for WDIOF_CARDRESET

 .../bindings/watchdog/ti,rti-wdt.yaml         | 13 ++++-
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 11 +++++
 drivers/watchdog/rti_wdt.c                    | 48 +++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.34.1

