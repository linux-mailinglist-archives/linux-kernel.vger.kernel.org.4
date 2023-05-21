Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A71970B1D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjEUWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEUWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:48:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C11BA
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Gt7eAaz60O9ddrcN7cZOXzCyhIJbxCHtRLFEQS4tDho=; b=QFKc5N8VaY3M3I13SLeTsnV2Hh
        VrgyXHx/TLXyLRn3Pu4BB3OiCgWaXv6JZXoq8doGw4i7YHTZaipd26MBV6wQf9yf1I+rCqj5EHIjB
        4iqxGEEW110OMSSW6ZgOLJs0f87pzpoOCOJRiV2ea5DsVkCtEZrgp7oUGCk/2PUFwnMmOxLIhVUm+
        Dv+b0fBCHcdxEMh68ytebYTTfpM2Ib5wVOHMfqUTuilydmpVOn8IsHOCK+ggZSZUGxMPbu/gRw6lB
        VVEfzfGDnDvnPV56hqPJahuON2wHs6iYmuJrfEN8Bt/rykcZ5uQ9JOepqhvIDIhD/+L5P9qhneQSi
        MtCYMVAw==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0rr2-004myJ-2D;
        Sun, 21 May 2023 22:48:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RESEND] powerpc: delete empty config entry for PPC_86xx
Date:   Sun, 21 May 2023 15:48:43 -0700
Message-Id: <20230521224843.12720-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an unused and empty "config" entry for PPC_86xx.
It has no keyword entries under it and the following line's
"menuconfig" for the same Kconfig symbol is what kconfig uses.

Fixes: d8267c1a3686 ("powerpc: Add 82xx/83xx/86xx to 6xx Multiplatform")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/86xx/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff -- a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config PPC_86xx
 menuconfig PPC_86xx
 	bool "86xx-based boards"
 	depends on PPC_BOOK3S_32
