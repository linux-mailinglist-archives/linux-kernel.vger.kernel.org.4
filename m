Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD26BD065
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCPNG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCPNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:06:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F46B32AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:06:54 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id h8so1648941plf.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678972013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3jNhyipEJNd1RcWn3fkcuOoTx5a36p3R6zN6vOVqKQ=;
        b=Evo9R0ySjqFSsO0Q1wkSnr5TIDObQf1nYFzYGrG8hfk8Ut9e6+llwzTtyvFb04mlok
         XFv7nZqfqldR1WqAGOtPPg/hwblRHyi0eG+DWps1uut/R7qgpOHGfycS08Thnj/TwgJJ
         F5dwXMAg/SyTCmtL9rFVdleHNyDoqf49VNge1iMsjGbD7RSgZNAXArFe0m1JUkM0Z6Mz
         EUJG6R/CO+L2yuVfVhCcAkUF/t5CyuecTq7q+buBpKGk70EzLlN0jPT2tbXVuqSHO36k
         EB1/+2fRpwxdkXmK8znmbSgve//4xT0Jnd2UqK/Jxpbxh0fCNgA7QQ+Ls+Q4ns+5wYx2
         VxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3jNhyipEJNd1RcWn3fkcuOoTx5a36p3R6zN6vOVqKQ=;
        b=vNOhibjnusu8Efph3vtkrlcTpniz+JYbNOGxQh/6hNIbR/4Utem1YdiGHkLx756ILb
         fwu9Ls+aQJTUUDrvmTe/qkFg2C7i0dI/tFeULUTkhEhnO8KYLkrzrBuPeRXsWVN7cLnA
         McYE+xRULGuvc1xSMDY3ZPRHicXyJRfCtmQ9KPfUUxTOCH00ddk8FR2edY4pjfq8NAXX
         pO/sTEmnw9UeSepjQ/lGqjsIdN38gqYAsEAUpJc5IK0uLzIN2DtlME8WwLwSINvhM9fG
         5cE16kW1OPJDR9f/+RLlAFQP8EX1ENOYUgXFXLqF3/OHwyClXyNruJdf9vicijtSRyxd
         G5Jg==
X-Gm-Message-State: AO0yUKV5cXCi8H9JQT8RIzjz5hVrD2sDcwOMJwu4e/sjJji+G+MxMGma
        qxedaoBtCf7TLKbG1ieKmtg=
X-Google-Smtp-Source: AK7set9ffK4oj3vlyvp+fsYfFTZLfEjsp7v8S2ow5emHdiAPvAlPzOLxxmcwjNzpY84hXqt9t9geyg==
X-Received: by 2002:a17:902:e551:b0:1a0:65d3:bae4 with SMTP id n17-20020a170902e55100b001a065d3bae4mr3658192plf.38.1678972013303;
        Thu, 16 Mar 2023 06:06:53 -0700 (PDT)
Received: from sumitra.com ([117.245.254.247])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903028c00b0019f3cc3fc99sm5580221plr.16.2023.03.16.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 06:06:52 -0700 (PDT)
Date:   Thu, 16 Mar 2023 06:06:47 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH] Staging: octeon: Fix Lines should not end with a '('
Message-ID: <20230316130647.GA81281@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl CHECK: Lines should not end with a '('

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 7a02e59e283f..3e7b92cd2e35 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
 						  int32_t value)
 { }
 
-static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
-	int interface,
-	int port)
+static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
 {
 	union cvmx_gmxx_rxx_rx_inbnd r;
 
-- 
2.25.1

