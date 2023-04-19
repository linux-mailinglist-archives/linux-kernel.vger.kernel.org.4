Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7F06E7B39
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjDSNrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjDSNrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:47:43 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [104.207.131.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEA469A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:47:40 -0700 (PDT)
Received: from localhost (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DBE0612CB7EB;
        Wed, 19 Apr 2023 15:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1681912055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9UEkT3yosdvnqGEcYdn1VnShnCpVHSTXBAlaZ6LDqZE=;
        b=b1FhMdGJnfN175Q6h5p9gXWC1FxsojBTtmOLXUoXmX8hNF4lyaRs1gELxMZMBjuoENZS8Q
        xhapTjzTkRsTRMN0h65eN4xdh4JJSYzEqkeYOFfNnAJmWgr7gd/AVwEiDwKTaZaGU0BE3x
        RI8yAFFBmfvkVHNTHwsC9z/iQn/zVHE=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH] mailmap: add entry for myself
Date:   Wed, 19 Apr 2023 15:47:34 +0200
Message-Id: <20230419134734.454630-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map my corporate email to my personal one.

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 86d0760c15eb..e9149a81cf43 100644
--- a/.mailmap
+++ b/.mailmap
@@ -358,6 +358,7 @@ Nicolas Pitre <nico@fluxnic.net> <nico@linaro.org>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.com>
 Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
+Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
-- 
2.40.0

