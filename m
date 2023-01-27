Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF2567E2ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjA0LR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjA0LRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84A13DF1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d14so4649851wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=kRNB0YwJHXJDtpUEppM4TcOT6WkwhC+0dsL4O7dUAmrovCDLBx4V0Fc2dK6Um/zuPA
         JhNFgXXqvFRUcq2sZeUU5ajw8F7GtE9vYmwF1QkY2pYOsYLeu3rYwPQp8PyWaopJNTkd
         8NQ7dpabIE6jPCJYVrzNo+GMG7oPq1Mr/Iek0x/rP6hcYrjXseb8cTsjqgR4PRwce5Rr
         aUSKeO73FDVfOGuuKyWVz9qBBX99zDwDpjiD84BEUbTxFUM9nF/BrURfPPjiLypMMFHU
         5bEbZwTUcyeBE3YhPi14WY2VBAs7NLNFOERhWANTXKAhoPZD4G0aC7GQfNxjKi5MYYVj
         Oahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=6oqCQRPz17Aeacxo5BXd/PbpE3MnYx6e5DL+W2iDhxQCYMnwCGQZNEsV+p4R+FMUxQ
         IIaMbNSoUOE50i66Hak4m1VhvR/OxA+ly0q1uTP7NHmiJU39XpsCZ9Hmt0FtmaWT2fsv
         Es5UzdFeLJq6lMSxp2uAkey7gDStOxxQ5//WKlQH2eGyGu0XbLuQcmZotWhowMTqY8cE
         +Ianom1KmS5Yd9J9QHOH5JY9II+Oaj46mjDaBrLuC149sjHdPdKOQZAptifKmR+0M6/v
         FSqZsC76ZMEXJFWFdrEQdHahb9XpIASNHCsLkaF/0xluLGXfEbBMO2X9GFfDv9FxBmh2
         5Vrw==
X-Gm-Message-State: AFqh2ko0NFK9Ii7GRFZ+QeIRR2IU0v/8mlkMCgUq8ne7srWCC5beXXxg
        klA3xUq3cieuskdmJeoDu9+Nrw==
X-Google-Smtp-Source: AMrXdXv1e094Plef2gin4NPeUXiqigrkqTXelplXQ9sqXcu1rrBIgi2dkuotcR9x+BVY86yX6NNqBA==
X-Received: by 2002:adf:b604:0:b0:2bd:f35f:1b5e with SMTP id f4-20020adfb604000000b002bdf35f1b5emr33045137wre.4.1674818265932;
        Fri, 27 Jan 2023 03:17:45 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/37] dt-bindings: nvmem: qfprom: add sdm670 compatible
Date:   Fri, 27 Jan 2023 11:15:32 +0000
Message-Id: <20230127111605.25958-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

From: Richard Acayan <mailingradian@gmail.com>

There is some configuration in SDM670's QFPROM. Add the compatible for
it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 48cfec0c9ece..b7811bbb0e71 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
           - qcom,sdm630-qfprom
+          - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
       - const: qcom,qfprom
-- 
2.25.1

