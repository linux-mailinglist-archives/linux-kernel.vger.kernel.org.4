Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109F55BDD49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiITGcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiITGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:31:15 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D9357FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:31:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bh13so1587263pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QOQs5Hm3j51CfiHsd049SOzfOXJ88T7ZPIrn00Ifr3s=;
        b=jsyUy35QANuiTDbaGsXM4v85cZmvVoAfejAlonfSrzxfZ4SzG/uamECONgldKE/n29
         m0bmZezM9CbphtqMpnFQe88aXokLIzUc9yBYE2ysIDwXu8Z0q96Tz9GMA//a3NBg3fHG
         YglKqE2x1HJLO9kiQ/6MMqWIEjFrXcHvtI0iwWiaUmpLUadJx1HV2zzgO5jbpWj4i9Qs
         hSK/vE9f+auVwWg2xLFglgUYROZJKO6V2A3UZuC1+F3ViAV29Rueuf50UuCT23jniAVd
         dl6Ky+tM+nYo/1IkhFzutvu6ozkZxh6a28Mv/cTLL2SNE2kfl5JE38mjwcTPjj+2x/a7
         OenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QOQs5Hm3j51CfiHsd049SOzfOXJ88T7ZPIrn00Ifr3s=;
        b=mSiQt6xdoUTyD14W7t+oH2cB0aGSjaapiRP0VGFT8P3VUln6y1vfKPPg6GG8RaTnNC
         YmrFnUgFZgaUUm//saWyZU/ZRdF6XPjFuADe2HopVSALz/1mZGaicninAgFqvQ582l+y
         VTMS/NJykEucvoFd5Mr7zXopDGP3C1Sn5zfC8bUOoLzmLJW979KaasTrp3oZzIGayGwx
         nz5EQwDN2eF2hUQuqvWf2kSYl2WNNOUnDoGVnCMd8I/NSkWhrfsvcVtUFlOmMrKBpBlI
         PEFUEG93G1i34k9SCq6bfvsVsx2Ky6H8ZBTxWlufdbZZ2i4+19WEuu9tou9pMgNgqB7v
         FgCQ==
X-Gm-Message-State: ACrzQf1BxYJtM6QwizB7SVJcedxxFQj9pxx5lxgmGb276KccYQjjjXxy
        P1ejN48iyH2Hp/9wGUZ+rDA=
X-Google-Smtp-Source: AMsMyM6vf8MMMYzqHA/wJ44pnk9xmS4Hu0QQ48NAuw2YtkCvs1gfgAXeAekOCrsTMtBqEm21zT4I4w==
X-Received: by 2002:a63:e516:0:b0:434:9462:69cd with SMTP id r22-20020a63e516000000b00434946269cdmr17897287pgh.503.1663655460369;
        Mon, 19 Sep 2022 23:31:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709027c0900b00176a579fae8sm529910pll.210.2022.09.19.23.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:30:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     richard@nod.at
Cc:     anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] um: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:30:53 +0000
Message-Id: <20220920063053.215033-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value epoll_ctl() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/um/os-Linux/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index 98ea910ef87c..cf7e49c08b21 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -127,12 +127,10 @@ int os_mod_epoll_fd(int events, int fd, void *data)
 int os_del_epoll_fd(int fd)
 {
 	struct epoll_event event;
-	int result;
 	/* This is quiet as we use this as IO ON/OFF - so it is often
 	 * invoked on a non-existent fd
 	 */
-	result = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
-	return result;
+	return epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
 }
 
 void os_set_ioignore(void)
-- 
2.25.1
