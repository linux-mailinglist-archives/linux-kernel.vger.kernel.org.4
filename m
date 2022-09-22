Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2A25E65F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiIVOkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiIVOjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:39:36 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 020F4F8593;
        Thu, 22 Sep 2022 07:38:33 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 2661B1C8116E;
        Thu, 22 Sep 2022 22:22:32 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 22
 Sep 2022 22:22:31 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 22 Sep
 2022 22:22:19 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 22 Sep 2022 22:22:19 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id A394E637C4; Thu, 22 Sep 2022 17:22:18 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <olivia@selenic.com>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] rng: npcm: add Arbel NPCM8XX support
Date:   Thu, 22 Sep 2022 17:22:14 +0300
Message-ID: <20220922142216.17581-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Arbel NPCM8XX Random Number Generator(RNG) support 
to RNG NPCM driver.

The NPCM8XX RNG uses different prescalar clock value.

The NPCM RNG driver was tested on the NPCM845 evaluation board.

Tomer Maimon (2):
  dt-bindings: rng: nuvoton,npcm-rng: Add npcm845 compatible string
  hwrng: npcm: Add NPCM8XX support

 .../bindings/rng/nuvoton,npcm-rng.yaml        |  4 +++-
 drivers/char/hw_random/npcm-rng.c             | 21 ++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.33.0

