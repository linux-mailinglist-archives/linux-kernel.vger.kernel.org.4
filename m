Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DD745FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGCP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGCP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:26:25 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFE4E5C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:26:21 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202307031526188d77f8baf91f644f70
        for <linux-kernel@vger.kernel.org>;
        Mon, 03 Jul 2023 17:26:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=wEnLre4f3ngCv2EBtfa9N2deHlrm/yckl9kFph5IUa4=;
 b=msSXrt/AlsVtRPS6mnfX2g/4PEkStAIQfO8iboVaTO66iogu7vqnLgtkV+ZADTeL0q7dXk
 3hpdmAkgHC+Tp10U1TkR7F4HOc3VacegKccDMvlXJ0P+gmi2Ely7Cf0618rmw790TqBFvYXq
 XIvfZnYbPlD9hN0nbJdCVRKhR/hmY=;
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
Subject: [PATCH 0/3] net: dsa: SERDES support for mv88e632x family
Date:   Mon,  3 Jul 2023 17:26:06 +0200
Message-ID: <20230703152611.420381-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

 drivers/net/dsa/mv88e6xxx/chip.c   |  58 +++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |   4 +
 drivers/net/dsa/mv88e6xxx/serdes.c | 187 ++++++++++++++++++-----------
 drivers/net/dsa/mv88e6xxx/serdes.h |  35 ++++++
 4 files changed, 214 insertions(+), 70 deletions(-)

-- 
2.41.0

