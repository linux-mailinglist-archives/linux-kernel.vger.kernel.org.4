Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ECA6116C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJ1QDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJ1QD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:03:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C4C219FED
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:00:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y13so5120724pfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxnT79sprMj1qcVVm8Tt8+tmzuujR2ZjMHrctvNUZVI=;
        b=iHfq4sz7PsBNS/x1d5sLnZLVZAADuy1QWqxSDrNge/QOs195ZUBaeJ+Ijx2ur0Bfoa
         /6U3625VxTOqVP46SxbIXsrgsj5RoxisJcQ9YWahhT4/WEpeSlsTZdjysIRL2U2e+HrS
         2/xUEG40xdbo510P2Pgn4V2GmpORNSrLvOjhFT+49b/HUHflCvwTje5ypniQvFR5XjMu
         ChvICuqINajglxouUlnx2fD7f3Y3syvtnba0OUz44/YyT9zcnl9EUnnR4jKOwzBws3+v
         kbptZNREQxg3hk44ffl/s28TV/20/V1TaGfTqTohQwe+vTe9iO3o4Tye0RZRoqpaX2FG
         z7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxnT79sprMj1qcVVm8Tt8+tmzuujR2ZjMHrctvNUZVI=;
        b=n3B+pbMI5es/xmbrQoSUMWFHU+k735B21CpUsPapA6hkm+9TTDvROzJLKDjjSGiEfq
         6v2M8ugdWqNuwrKpqKyg603r/K6m2QLd3S465gC8ebOjkYUdAqhX6sB/zRnXZDEpM6Y/
         rD4AH2IA05s8njqhe0l1MA+dGFeeDZL3ACTsdg3KQFl2fX1eUlRan1bY4hOCGR9OCAWh
         ngnj7ru0oWPa8oMmskrPvkpenkNvS1vgqFQ1FAAh77SLCUdEX4d7zlICneY4hs7CZzdd
         NVedhxGEmp8sPHVIga0KGt7SB5kOrcmhbf6U86zdWOgxNmYY1UA0PXlfAP4GQ3pQOIZH
         ay2Q==
X-Gm-Message-State: ACrzQf3ATNwYR29ONwTXjN6029O8C2lPWxL27lKK+DDc034yUa1hwSmh
        Xw4MZMZuQwHnoVnqLKBLAqRN
X-Google-Smtp-Source: AMsMyM5RZegx1F/jDKjl0LqHKaFoo4B9bakBP7rjENvEjRkXOBnVqIITfE/gbiuQvchjLpBBG40WIg==
X-Received: by 2002:a05:6a00:a96:b0:558:8915:2f0e with SMTP id b22-20020a056a000a9600b0055889152f0emr55055453pfl.38.1666972837757;
        Fri, 28 Oct 2022 09:00:37 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id d190-20020a6236c7000000b005627ddbc7a4sm2992265pfa.191.2022.10.28.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:00:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org
Cc:     stanimir.varbanov@linaro.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH] MAINTAINERS: Add Manivannan Sadhasivam as the Qcom PCIe RC maintainer
Date:   Fri, 28 Oct 2022 21:30:29 +0530
Message-Id: <20221028160029.44483-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stan is moving out of mm-sol and decided not to carry on the maintainership
duties of the Qcom PCIe RC driver. Since I'm already maintaining the Qcom
PCIe EP driver, I'm volunteering myself to maintain the RC driver also.

Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..05ca3a7f6967 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16036,7 +16036,7 @@ F:	Documentation/devicetree/bindings/pci/microchip*
 F:	drivers/pci/controller/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
-M:	Stanimir Varbanov <svarbanov@mm-sol.com>
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.25.1

