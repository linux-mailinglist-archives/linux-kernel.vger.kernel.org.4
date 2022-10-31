Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E39613061
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJaGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:37:15 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7885F5B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 23:37:14 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id ZGQ00011;
        Mon, 31 Oct 2022 14:37:11 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.12; Mon, 31 Oct 2022 14:37:10 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mahesh@linux.ibm.com>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] powerpc/pseries/eeh: Fix some kernel-doc warnings
Date:   Mon, 31 Oct 2022 02:37:06 -0400
Message-ID: <20221031063706.2770-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221031143711017e635c1b38ac4e8b26770add1ab356
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
  arch/powerpc/platforms/pseries/eeh_pseries.c:163: warning: Function parameter or member 'config_addr' not described in 'pseries_eeh_phb_reset'
  arch/powerpc/platforms/pseries/eeh_pseries.c:163: warning: Excess function parameter 'config_adddr' description in 'pseries_eeh_phb_reset'
  arch/powerpc/platforms/pseries/eeh_pseries.c:198: warning: Function parameter or member 'config_addr' not described in 'pseries_eeh_phb_configure_bridge'
  arch/powerpc/platforms/pseries/eeh_pseries.c:198: warning: Excess function parameter 'config_adddr' description in 'pseries_eeh_phb_configure_bridge'

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 8e40ccac0f44..ea890037843c 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -154,7 +154,7 @@ static int pseries_eeh_get_pe_config_addr(struct pci_dn *pdn)
 /**
  * pseries_eeh_phb_reset - Reset the specified PHB
  * @phb: PCI controller
- * @config_adddr: the associated config address
+ * @config_addr: the associated config address
  * @option: reset option
  *
  * Reset the specified PHB/PE
@@ -188,7 +188,7 @@ static int pseries_eeh_phb_reset(struct pci_controller *phb, int config_addr, in
 /**
  * pseries_eeh_phb_configure_bridge - Configure PCI bridges in the indicated PE
  * @phb: PCI controller
- * @config_adddr: the associated config address
+ * @config_addr: the associated config address
  *
  * The function will be called to reconfigure the bridges included
  * in the specified PE so that the mulfunctional PE would be recovered
-- 
2.27.0

