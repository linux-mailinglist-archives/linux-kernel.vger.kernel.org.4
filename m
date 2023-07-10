Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099174DD25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjGJSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjGJSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:14:31 -0400
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com [193.143.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8712A;
        Mon, 10 Jul 2023 11:14:29 -0700 (PDT)
Received: from HEL-SMTP.corp.vaisala.com (HEL-SMTP.corp.vaisala.com [172.24.1.225])
        by hel-mailgw-01.vaisala.com (Postfix) with ESMTP id 03E12601F0B8;
        Mon, 10 Jul 2023 20:58:13 +0300 (EEST)
Received: from yocto-vm.localdomain ([172.24.253.44]) by HEL-SMTP.corp.vaisala.com over TLS secured channel with Microsoft SMTPSVC(8.5.9600.16384);
         Mon, 10 Jul 2023 20:58:13 +0300
From:   =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     vesa.jaaskelainen@vaisala.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Davis <afd@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] net: phy: dp83822: Add support for line class driver configuration
Date:   Mon, 10 Jul 2023 20:56:18 +0300
Message-Id: <20230710175621.8612-1-vesa.jaaskelainen@vaisala.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Jul 2023 17:58:13.0867 (UTC) FILETIME=[18CC33B0:01D9B358]
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to specify either class A or class B (default) for line driver.

Class A: full MLT-3 on both Tx+ and Tx–
Class B: reduced MLT-3

By default the PHY is in Class B mode.

Vesa Jääskeläinen (2):
  dt-bindings: net: dp83822: Add line driver class selection
  net: phy: dp83822: Add support for line class driver configuration

 .../devicetree/bindings/net/ti,dp83822.yaml   |  8 +++++++
 drivers/net/phy/dp83822.c                     | 22 +++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.34.1

