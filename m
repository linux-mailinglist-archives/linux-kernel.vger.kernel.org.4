Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78EA6F48DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjEBRGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjEBRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:06:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7510D9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=teoykMSKWvNuelz3FlN5iS0dm7a
        vkJXg9LbNugRtXA4=; b=j9gBx/Ufl1oedtl9C+qOyy8vUXxGHlKbIkvWLQWc8uy
        xJTKzM+iK/nIsGKLLXNaEsQNX5SAZUkleQbWpeLZ7Vk69SD7pkaUod6DQtLbgCKd
        956AH6J7PcEgrH3eg90jMPU66EC3x+t9Mceqqw2WhWRRwp5oi0W1LWp8oQ8MY5qg
        =
Received: (qmail 3809168 invoked from network); 2 May 2023 19:06:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2023 19:06:29 +0200
X-UD-Smtp-Session: l3s3148p1@s9PV9bj6OOEujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] r8a779a0: enable PWM
Date:   Tue,  2 May 2023 19:06:16 +0200
Message-Id: <20230502170618.55967-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having another look at the specs, I finally discovered a testpoint (CP2)
which we could use to test PWM4 on a Falcon board. Thanks go to Kieran
for setting up the scope and do the actual testing. This was the last
missing V3U bit from my side, hooray!

Phong Hoang (1):
  arm64: dts: renesas: r8a779a0: Add PWM nodes

Wolfram Sang (1):
  clk: renesas: r8a779a0: Add PWM clock

 arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 50 +++++++++++++++++++++++
 drivers/clk/renesas/r8a779a0-cpg-mssr.c   |  1 +
 2 files changed, 51 insertions(+)

-- 
2.30.2

