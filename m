Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414762EDCA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbiKRGk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241259AbiKRGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F449BA2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bs21so7764579wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbyn9XotI1LBu4cxCTVd2A4l7ms8/uWb+iIfpo5nB4k=;
        b=j2QcmURTm9xDvarO8ysEt2K7V003qQV+6Ko50z8adb2DIqJ6Rq0q3XQ2EcqIEcmg/+
         NJCu3ES35QIlhHRel0cveGglSqRYnqSUIaosUZfeRpsjNnDSl2bQ2iwq3NbuTFP2YyvM
         l2OmnLVzqENXgiYdkjwq0MURj7QdRcWAbdQLvAa74WbWhFcFFgxbH1Lpp1mwB4Z+OJvw
         le5XCTl0b17ICG6HAHHjS4snBMk8rOICoGsXSJfxTMfeNVPEow2nMBUtgw9GiWLKM+/t
         2xhTYd3rf+wtIBUBzbsIjtgxHxMEnDWwVLj5DQOg+heY37/mTgRQNrZVhjdutn98AES4
         xErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbyn9XotI1LBu4cxCTVd2A4l7ms8/uWb+iIfpo5nB4k=;
        b=xv4PsKLJrtI+/oOFAkdk4E2N8etmJ9xbzfYM/vhU9XnoLPeYEjgwKl2KUnwVap/0VF
         dCnw954XQ94IAMnluZUhw3vO6g5sv2PuW0P8Gxv4pMgqUGOG4zU2xF8JMyyU+06ysNoO
         qg4mNVWwVvEYFmnBRmLpyIxQAenyruwSGAKroVHD6x6u+cW8nZ3bL500eVQ1dSf2Ukg/
         1pWCy7Y2dE72EPHmazUFstOgNg74fBgrZPBlH7CU6AwqeMKDJgpgY/n+PoibFEWcqYcr
         25niRGvoT1w6KY79C2r6SjGCOOi5W4wwkOWuRM8+iPxTYOG70H+OClduI6uqhaZcZ2rb
         wsqQ==
X-Gm-Message-State: ANoB5pl/DBiIvs+0Gilr9LdlrX5AvS0+YOhO+tULUI7hYbRDiGMJemLX
        H9B+jIZ0vP0+NQtWKcbTjQpK+uoycroxkQ==
X-Google-Smtp-Source: AA0mqf7h7qfilPcfoJud5cjb+7maW5NobRZ+gYTb2KutOZK2vWm5aq5a4yQCo8FLQbDL5MRLFhs8sw==
X-Received: by 2002:a5d:58f8:0:b0:236:f5e5:13ca with SMTP id f24-20020a5d58f8000000b00236f5e513camr3302762wrd.417.1668753599637;
        Thu, 17 Nov 2022 22:39:59 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/13] dt-bindings: nvmem: Fix example
Date:   Fri, 18 Nov 2022 06:39:25 +0000
Message-Id: <20221118063932.6418-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

Despite not being listed nor required within the top level nvmem yaml
file, the "compatible" property is mandatory and is actually enforced by
all the nvmem provider bindings.

Unfortunately, the lack of compatible in the nvmem.yaml to level
description file lead to the example not matching anything and thus not
being checked at all.

Let's pick a compatible almost randomly (one which is already used with
the qfprom label) to make the example at least valid on a semantic
point of view and getting it checked.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
index 1eb22dba364c..0455506fc30f 100644
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -67,6 +67,7 @@ examples:
       #include <dt-bindings/gpio/gpio.h>
 
       qfprom: eeprom@700000 {
+          compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
           #address-cells = <1>;
           #size-cells = <1>;
           reg = <0x00700000 0x100000>;
-- 
2.25.1

