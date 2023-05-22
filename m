Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE27D70B77E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjEVIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjEVIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:21:07 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA251B0;
        Mon, 22 May 2023 01:21:05 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 992D120011;
        Mon, 22 May 2023 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684743663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ka1Fl6OswEMhixEbbi0TzCh7AW+Ii5FCal5DmvLTqf0=;
        b=ZU2Luicl+fq4CWB6b6hl6ciqLNk6pTs/nZ8rxMxAmEw2HL6m9VAR54gwKKTMoqd5TrfpIh
        Hvs8HzalYqJVpl10Y0QTmTMnuXmntSm58H7x3m4QWJJ6XF7XqrMAdQqdJOqp3Wa4TVnMyI
        OSB/8fXPwhDRb6H6SwVdVt2u4sfhpN3TsRKhGFGJM8fOp0iRvtpm+2KRMAOwoZc4ea32Uo
        rIWh1NvuOANtys1leoaXB4lUAVmnoXJH1iaVCeW41+5JGIrmwW4ZUiGUFFSf0J8L3SRF9n
        q4a5vzRljWR+bMlaliCwjhlKyaSdByfx6yIj3mAkaxGch59Zb/RlEjdiw0GauA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/2] Fix COMPILE_TEST dependencies for CPM uart, TSA and QMC
Date:   Mon, 22 May 2023 10:20:46 +0200
Message-Id: <20230522082048.21216-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes issues raised by the kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202305160221.9XgweObz-lkp@intel.com/

In COMPILE_TEST configurations, TSA and QMC need CONFIG_CPM to be set in
order to compile and CPM uart needs CONFIG_CPM2.

Best regards,
Hervé

Herve Codina (2):
  soc: fsl: cpm1: Fix TSA and QMC dependencies in case of COMPILE_TEST
  serial: cpm_uart: Fix a COMPILE_TEST dependency

 drivers/soc/fsl/qe/Kconfig | 4 ++--
 drivers/tty/serial/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.40.1

