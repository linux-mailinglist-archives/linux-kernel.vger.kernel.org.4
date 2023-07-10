Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275F74DF43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGJU3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjGJU3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:29:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026C5198;
        Mon, 10 Jul 2023 13:29:27 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIxVZ-0002mg-Ni; Mon, 10 Jul 2023 22:29:21 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     aric.pzqi@ingenic.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: hwrng: ingenic: simplify the code
Date:   Mon, 10 Jul 2023 22:27:26 +0200
Message-Id: <20230710202733.116133-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the ingenic-trng driver a bit. Switch to devm_clk_get_enabled and
devm_hwrng_register. Remove some unused code.

The changes were compile-tested only (I don't have this hardware).

Martin Kaiser (7):
  hwrng: ingenic - enable compile testing
  hwrng: ingenic - remove two unused defines
  hwrng: ingenic - remove dead assignments
  hwrng: ingenic - use devm_clk_get_enabled
  hwrng: ingenic - use dev_err_probe in error paths
  hwrng: ingenic - don't disable the rng in ingenic_trng_remove
  hwrng: ingenic - switch to device managed registration

 drivers/char/hw_random/Kconfig        |  3 +-
 drivers/char/hw_random/ingenic-trng.c | 57 ++++++---------------------
 2 files changed, 12 insertions(+), 48 deletions(-)

-- 
2.30.2

