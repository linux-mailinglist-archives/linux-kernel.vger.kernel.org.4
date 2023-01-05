Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70E065F29E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjAER1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjAER0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:26:54 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1443B59FBA;
        Thu,  5 Jan 2023 09:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=dlNwiQpR74Fn2RarO3rtu77WVKud4F1n99IzYmKFdKA=;
        b=o5btCxmc4B/U2EIk6H+cScBBlpe5JEA1m4+Sd+DPEaJ8Ve40R51KaYcWE0XaKZ
        YnXVX/ZVc6ZDzuyODMxfGfswUaEBFdXgMCNsksoPrSNfvCTnCFWg0iGvuLAA0WDA
        tcjqvHOUnu8sezC1qtRPWnf/NoyoJNG7lsvKYwuTY9kSE=
Received: from localhost.localdomain (unknown [36.4.211.162])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wD3JeYnA7djV+t6AA--.2998S4;
        Fri, 06 Jan 2023 01:05:12 +0800 (CST)
From:   =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH v6] serial: linflexuart: Remove redundant uart type assignment
Date:   Thu,  5 Jan 2023 09:04:37 -0800
Message-Id: <20230105170437.4437-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3JeYnA7djV+t6AA--.2998S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw4rZrWxur15KFy8KryxGrg_yoWkKFg_CF
        nrA343Wr1kArW3Kr1xJFyakr9agrWFvFn5tF10vF9agws8Aw4fJryfKrW3ZwnxXw48ZrWU
        Wa13GrnFvrs8XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREzuWtUUUUU==
X-Originating-IP: [36.4.211.162]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiSA-tq1+Fgod7bAAAsJ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in linflex_config_port() the member variable type will be
assigned again. see linflex_connfig_port()

Signed-off-by: 李哲 <sensor1010@163.com>
V4 -> V5: Link: https://lore.kernel.org/all/ddcf396b-7b91-00f3-8c16-7de5dc891aef@kernel.org/
V3 -> V4: Link: https://lore.kernel.org/all/2f726128-29c-b7dd-ad8-f8b536fbe5f@linux.intel.com/
V2 -> V3: Link: https://lore.kernel.org/all/8f433e5-fb46-d3b8-431b-4bddcc938f6b@linux.intel.com/
V1 -> V2: Link: https://lore.kernel.org/all/1c33a2af-cd0d-cdde-5bc7-49b418665784@kernel.org/
---
 drivers/tty/serial/fsl_linflexuart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 6fc21b6684e6..34400cc6ac7f 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -837,7 +837,6 @@ static int linflex_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->membase);
 
 	sport->dev = &pdev->dev;
-	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
 	sport->irq = platform_get_irq(pdev, 0);
 	sport->ops = &linflex_pops;
-- 
2.17.1

