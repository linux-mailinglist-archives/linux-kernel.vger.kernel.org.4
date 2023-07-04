Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0016D746C9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjGDJAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGDJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:00:50 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982AE136;
        Tue,  4 Jul 2023 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=J3jQkbsasLBrhhi99/zoVZyChwuTy4x0uXgdAEkHy5c=; b=WlgHIn0OwOvmOAjxQQcw8qjUUa
        rPP8yaRMkjeCb3AM5ItQfpftx/5kTUdJ+FjU8bMVDJCnDxCJS0UD1gFBR24h280U8kYM2JCpHPhj/
        INggeLmaHNuyxseeR7RvTsmMaPeOPRyGoECRTZw6A0U3lwEj3XPdAV0H0YV1XxOyt8cejKWp1zUuK
        7gCH9ilEr5k2GNqE9knjJ5EqAC4HPmLo6yUNnC+kX8fctiIiig6Mm7bZofhXl3N3oDDXy8KTwhZuA
        gdcqa0AqA36npLCAbZ88dKjaErzwqxAWDEcG2U0fB8sDQactkXX3K3RSNpKNtaO8z5KTqFGf28bbf
        OJF9OgyQ==;
Received: from [89.212.21.243] (port=50488 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qGb19-009KMj-2l;
        Tue, 04 Jul 2023 10:04:11 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, upstream@phytec.de
Subject: [PATCH 0/2] PHYTEC i.MX6 device-tree fixes
Date:   Tue,  4 Jul 2023 10:03:02 +0200
Message-Id: <20230704080304.816942-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

quick evaluation of booting PHYTEC i.MX6 boards with upstream kernel
reveled some obvious problems which are fixed with this two (one-liner)
device-tree patches.

Tested with PHYTEC's phyboard-mira-3 and phyflex-imx6-1 boards.

Best regards,
Andrej

Andrej Picej (2):
  ARM: dts: imx6: phytec: fix RTC interrupt level
  ARM: dts: imx6: pfla02: Fix SD card reboot problem

 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi   | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

