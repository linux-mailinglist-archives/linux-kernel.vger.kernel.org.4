Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C25F3373
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJCQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJCQYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:24:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4C1CB3E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:24:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b7so9905984wrq.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7dQXLQGjmAcl/xcPVLsk1EjIAQGW9LYFw0dKgGXUj4M=;
        b=dzlZCs0pQ6N4c92Jl1CeRSAvWesd/CPvFfP6FhzMgKbg2SyCBdpwkK2pH08JpQNZPr
         cJZYDt+zmpGjm2tCv8jmyd3yEcYBIppw/Kqo6sAzIp6rthuwar2Hd0G55KoPkk4KeqdP
         18gZ8CZFfEI/nMGG213fpoRmmc58CeA5UgE2YonCB7rDTSNQDoDVQiFWvPlO9/2KROwF
         3/+e3mirgUnRE7/uCcpow+mSC9SlIXDHiT0WJ2A+cG2OycUJSh0AOk9Vcr3PHPDsLF6c
         4jEaDMDygXwWI2hdfR1yaknbT/d3+we0U4SYgqNHtvm4w4plc9rKxKhv0vSGCcQXbaKT
         I6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7dQXLQGjmAcl/xcPVLsk1EjIAQGW9LYFw0dKgGXUj4M=;
        b=fFTUoIV1htKc7C0kXVsWBUqGa2yA6ECIGvYn1bnLek3gkRekUJoPrh0gH1nlkpNymS
         Z9uM0Hg24eQ5kfYrx1tzWg1jRALDIimg/NVhHsdgTUb34bBzjfK/IwpPMZCU9AYETzAn
         t+tybX6B8Aig1+6T/9j7CV8a2844BUavkNv/JGv+8yi+1H0TNo9KT68JmdJ2xeJtoT/z
         GaN36TctTxjUNuC5HsLnxzmfMDBdq0XJ+uTersDvQNIBKs5fKBdeemfKWn80be62jZsX
         Ctj7Zdr+e+jz948l1SE31g+l17JaHimE2CE+iltjQnCCcIRvNT3Kv92gLekpRFTPI7S8
         fpcw==
X-Gm-Message-State: ACrzQf3/Lbhi/eeMyvk6CfPHtT+I8hrRsiIe5Yx/y2MclRbBH2t4l6nL
        lpZnJXXSAJP7kTGTNOnQRqV5nQ==
X-Google-Smtp-Source: AMsMyM4vVbkffrJ3E3PU2m2Z6a7VMuakpcJncHhkNtpAb19dzY6JHHYpCwkcV+z2A0QgAo4UT6vKDw==
X-Received: by 2002:adf:fec9:0:b0:22e:431f:b6df with SMTP id q9-20020adffec9000000b0022e431fb6dfmr2247655wrs.705.1664814255098;
        Mon, 03 Oct 2022 09:24:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b003b95ed78275sm4989013wms.20.2022.10.03.09.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 09:24:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     corbet@lwn.net, linux@leemhuis.info,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org, joe@perches.com, akiyks@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH RESEND v4 1/2] get_maintainer: Print maintainer for S: Supported
Date:   Mon,  3 Oct 2022 17:24:10 +0100
Message-Id: <20221003162411.431774-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221003162411.431774-1-bryan.odonoghue@linaro.org>
References: <20221003162411.431774-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Throughout the documentation we make reference to maintainers as the people
who ought to be mailed when sending patches.

Right now get_maintainer.pl returns "supporter" for maintained files which
are denoted "S: Supported".

Update get_maintainer to output "maintainer" for "S: Supported" the
differentiation between paid (v) non-paid maintainers doesn't impact who
needs to be mailed for patch submissions.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ab123b498fd9b..7a8d2961d948d 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1283,7 +1283,7 @@ sub get_maintainer_role {
 
     $role = lc($role);
     if      ($role eq "supported") {
-	$role = "supporter";
+	$role = "maintainer";
     } elsif ($role eq "maintained") {
 	$role = "maintainer";
     } elsif ($role eq "odd fixes") {
-- 
2.37.3

