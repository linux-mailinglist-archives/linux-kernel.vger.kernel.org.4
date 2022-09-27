Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438915ECE31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiI0UP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiI0UPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:15:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A371EC9A3;
        Tue, 27 Sep 2022 13:14:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id 13so23034980ejn.3;
        Tue, 27 Sep 2022 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BXhbejjCnCNn67i9Vw4bz+4tmw44N/wKgcDC4hccsTQ=;
        b=YSaWOe/sKIGwrhMZuwMsv9vZAe7kXyEerYerGX4v+aduPVgxqp1+T8x/GpgkzB+yx3
         tc2zTqfmaMxXgd9s5qpADzfAY5O3HR9lTR6rOLR4/f5ubXd2EqR/C+ApZfz2pUcXj4i+
         A0FceUh12IoFQe8HaZ5CIT7zc+4hhCA/2n/keVxZnN0BHsrzA9RpBuYXRY8/f8xG+SMP
         kE5JcYwtZK+oS5VmkgIyu/ToRzv/489CbMNfGV5UZaywFHCHw+SrHbp8iu4/nr6r72yH
         XL7U3TLh6AICe2/YV3JyQmiGY88udXPEoEXJ7vq2ePw4NP09RMuV77jtnmu5MTvZvr5B
         8I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BXhbejjCnCNn67i9Vw4bz+4tmw44N/wKgcDC4hccsTQ=;
        b=EncJ1Yg1owlOum8quk4XhCFrGAzVZ0cCA5iVzcI56jqplT/gk3j5xvzNQ945MKYaeg
         FXW40kz1yAg2zv6dc/ydj0LFMtj/y2NlMwhkwcwX/giL9zVC5vRGR7bJYLRjWUHB6LnD
         wI/UiLJoMP2e5VRQ/PP/fMOQuq3xTSbiUzvJIZLDQ8D3pujc603un4lzZumdzsiv+6y9
         eXZspM9i/CviyVTF6HZt9RjPvnnjE2OwD2vXH7/pZo/YICTGBAiJiKR+/HLeMgpMu7q4
         yyG26Yji06REZVdwsUgxYrM2YNOgymuSyq6dnt1dEgT3umQkxDbLB4jFaGAgxMcnyD9m
         63JA==
X-Gm-Message-State: ACrzQf2SJVjMmitVsWdza7VjdWeVeFZN+8kIwWPCNc37FeHzPpzgjSek
        yw2OCKg5F9g3+9kb9S7exAtgJQndLP7ouw==
X-Google-Smtp-Source: AMsMyM6TRlzn5JUio3cdwN4uil8j7uBxKFtzncUhY7HY0xDwY9TmfAE8vLYtqe4xQ31aOkHvPjdM9w==
X-Received: by 2002:a17:906:5a4c:b0:76f:3e98:b453 with SMTP id my12-20020a1709065a4c00b0076f3e98b453mr24360443ejc.509.1664309657696;
        Tue, 27 Sep 2022 13:14:17 -0700 (PDT)
Received: from fedora.. (dh207-96-59.xnet.hr. [88.207.96.59])
        by smtp.googlemail.com with ESMTPSA id i27-20020a170906115b00b0076f0a723f6bsm1250610eja.58.2022.09.27.13.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:14:17 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] arm64: dts: qcom: cp01-c1: remove bootargs-append
Date:   Tue, 27 Sep 2022 22:14:14 +0200
Message-Id: <20220927201415.1265191-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.3
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

bootargs-append is a leftover from the vendor SDK, and does not exist
in the mainline kernel at all, so remove it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index ff4c46645104..eaaaaa72234f 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -20,7 +20,6 @@ aliases {
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-		bootargs-append = " swiotlb=1";
 	};
 };
 
-- 
2.37.3

