Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99634750645
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLLid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGLLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:38:29 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3B1982
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=WWq50IXc7DT3nr
        DcWZF3oif51BO0pBy6J8A61kjH14k=; b=L3v07Z1W6+gGNCijdvjpl3z962fDSl
        dRcKWEVlvEkkCUk48697JyPAqZH+ePfDp4rFwza8NLpZGGS2EnUTTCDLZrzsJ7hf
        g19VV7F6qs/WkLY4qK6RY4bCGdZ+dlY2qCIqSpxSyn420xqF7rEDFMefeMjiUt/L
        0zE0UOuxEpH/U4hB7GK9b5Kvg264fqa3P9BddChngmUsV2dXv9j2qBAiKE1pksBe
        ao2asZjinz4l37GkqoPQlkCnMOZflaH6qxx01S+LnjfMweH2rn0VG/0E1bS3qAws
        2PQwsUlIpWdbwdvgm5Qj8CTGV6vw8IHwOh8aFs9nSYvJ4keySd9W0XsQ==
Received: (qmail 1596742 invoked from network); 12 Jul 2023 13:37:43 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 13:37:43 +0200
X-UD-Smtp-Session: l3s3148p1@WjrbpEgATKUujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] gnss: ubx: updates to support the Renesas KingFisher board
Date:   Wed, 12 Jul 2023 13:37:28 +0200
Message-Id: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For that, we need "reset-gpio" support (patches 2+3). But first,
simplify regulator handling with a new helper (patch 1).

Changes since RFC v2:
* dropped DTS patch because the binding is clear now and we can upstream
  it separately
* added binding documentation
* rebased to 6.5-rc1


Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  dt-bindings: gnss: u-blox: add "reset-gpios" binding
  gnss: ubx: add support for the reset gpio

 .../bindings/gnss/u-blox,neo-6m.yaml          |  7 ++++
 drivers/gnss/ubx.c                            | 35 ++++++++-----------
 2 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.30.2

