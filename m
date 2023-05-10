Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79016FD7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjEJG6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjEJG6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:58:47 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4511BE1
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=4bqDn7LLqFx/Hn6+UdImm3YIY/5
        xp8ldHuvPZWtfLwc=; b=a3SkHD5vHKKbX5WX4g8JFoUysKwN4dW72rIpjo6hUKk
        LFzuQpUE8Bhf3R+bqfF7qY/wtpv2P7cOVkhd9p9HbhpYJIEi5UCP2hWFSReAOePv
        a7xbMkahgyk7baqBdSuIM1Vg6iq3jxqqyAUS/UcgPXhKQny/HfYcmDYQd8S5b2wI
        =
Received: (qmail 2328158 invoked from network); 10 May 2023 08:58:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 May 2023 08:58:29 +0200
X-UD-Smtp-Session: l3s3148p1@Eek6ZlH7Tr8ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] KingFisher: support regulators for PCIe
Date:   Wed, 10 May 2023 08:58:16 +0200
Message-Id: <20230510065819.3987-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the patches to make PCIe cards work in the slot CN15 on a
KingFisher board. Look at the patches for a changelog, please.

   Wolfram

Wolfram Sang (2):
  dt-bindings: PCI: rcar-pci-host: add optional regulators
  PCI: rcar-host: add support for optional regulators

 .../devicetree/bindings/pci/rcar-pci-host.yaml    | 11 +++++++++++
 drivers/pci/controller/pcie-rcar-host.c           | 15 ++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.30.2

