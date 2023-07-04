Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6783746A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGDHAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGDHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:00:39 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 00:00:37 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8447E1AA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:00:37 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230704065933cd7d8ceb0ce0b19b24
        for <linux-kernel@vger.kernel.org>;
        Tue, 04 Jul 2023 08:59:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=b5rEaasbVD70uV0KaKcnh8XZdEIB4CkUmPMwdCkGMqc=;
 b=R4WwaRH1KkwnOv7MGACIUjBNYBZaKVmitUSalOY4XAQdLHymw70Tk+ctxG8c6RHLMRhC0m
 +kcQLgt3agq+pH+qQCPUvJUbstpisxfmaBdpMFsh5M02r0MIILAvjF/YLLCyv4W3+D0QOdZk
 b4e+sIx5rxnrDxLyiBZ9u7/QzcTKU=;
From:   "M. Haener" <michael.haener@siemens.com>
To:     netdev@vger.kernel.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Date:   Tue,  4 Jul 2023 08:59:03 +0200
Message-ID: <20230704065916.132486-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

This patch series brings SERDES support for the mv88e632x family.

Michael Haener (3):
  net: dsa: mv88e632x: Refactor serdes read
  net: dsa: mv88e632x: Refactor serdes write
  net: dsa: mv88e632x: Add SERDES ops

 drivers/net/dsa/mv88e6xxx/chip.c   | 35 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  5 ++
 drivers/net/dsa/mv88e6xxx/serdes.c | 76 +++++++++++++++++++++++-------
 drivers/net/dsa/mv88e6xxx/serdes.h | 33 +++++++++++++
 4 files changed, 133 insertions(+), 16 deletions(-)

-- 
2.41.0

