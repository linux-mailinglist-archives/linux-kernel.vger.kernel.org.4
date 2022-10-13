Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12B05FD285
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJMB0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJMB0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:26:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08405F993
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:25:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f23so485427plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ErCDLzxr+lXbZIWazVbprjN/9Z9aiQwpQLeysxfkYg=;
        b=iCLmwpxo/k6bBVXD4Pzl1isfG1D16/7NMJq2ycliUF6/WFidPliBxMRNnwvJDt0iMO
         ZtT9jAC2/b+CM+fr9/XgPlXO+gtUyRI3m91LZnpPBfGeo8Ztya3IKb37gGX1f/vY4zlV
         UcfJaEDYaVZlVZSp+GgNXvUVeE0Ek4q3TmNOniroVeusoU0JtogdyQoOk4z2FrBOIwr8
         5sCZBlN6pHOyA1CjOlnKqAmfexhs46nW68kBhFAnxtZ6DHc9qSq4+Q89rqNqnpSlP3jb
         MFFIeMWSKCeLRRv/u4LV+1WD23ai9aWUv8wYY0kY8qYbfnS0O1JFj8xAPmIWIvdyBcla
         ljcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ErCDLzxr+lXbZIWazVbprjN/9Z9aiQwpQLeysxfkYg=;
        b=ZtI3hQuTYjLnFyY3zqMM4z/9qVYgzJ2hArGyGKN/6X7kmIfS9fF1uEF7kl/2N4eCuM
         rjwKBL/cIvSlMzU4GzuVvNcWx8aICa/UMxIek7o6BSkwG4Udan18IN7OIlvToJSHnG+v
         GAVNVTcCLlOzp0FD+Ocis2LtcFNeBJ/bEiHc+QYvPkl8IpidmKDIu7QqsOR6hpsTIUqB
         d4JLDWk/mWC/5YvvHkBcvA1pkgk3Q3BxAcIE7IN6UAyJUst6gdE4LOxYd8a6K7WYAXeK
         icLQzYGXB+ZCkKj09CENcPbJD34T0/XhYa39rfg61z+5/u4vkDajpBxOI1Y7Hrc4dsEo
         IzJg==
X-Gm-Message-State: ACrzQf2GKRQdl+sSGeX23V08IL2SOKHAH713gku/u55BOmX/e4QSRX4m
        /hiEMbHP+h+QW14DyvXtT8Y=
X-Google-Smtp-Source: AMsMyM4jRjGedIbVoB77le1we5cYAxrSa6YNg3z6OZhfFX5f0BELaZH1I6+Nr84bBtyffVtKyt1HkA==
X-Received: by 2002:a17:902:e790:b0:183:88dd:1d30 with SMTP id cp16-20020a170902e79000b0018388dd1d30mr12583288plb.62.1665624352252;
        Wed, 12 Oct 2022 18:25:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bb2-20020a170902bc8200b001822121c45asm7155246plb.28.2022.10.12.18.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 18:25:51 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     andrew@lunn.ch
Cc:     sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH linux-next v3] soc: dove: Use
Date:   Thu, 13 Oct 2022 01:25:46 +0000
Message-Id: <20221013012546.348932-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace generic_handle_irq(irq_find_mapping()) with
generic_handle_domain_irq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2 -> v3
Add the tag of 'Reviewed-by'.
 drivers/soc/dove/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index ffc5311c0ed8..308fe45231b4 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -243,7 +243,7 @@ static void pmu_irq_handler(struct irq_desc *desc)
 		stat &= ~(1 << hwirq);
 		done &= ~(1 << hwirq);
 
-		generic_handle_irq(irq_find_mapping(domain, hwirq));
+		generic_handle_domain_irq(domain, hwirq);
 	}
 
 	/*
-- 
2.25.1

