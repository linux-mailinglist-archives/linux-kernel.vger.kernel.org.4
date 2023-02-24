Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663406A229A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBXT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBXT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:58:16 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207E0682B1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c8bcae3bso6252877b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677268688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ozTt3+xQs6+7ogbKaGsgcnydK5zFBxlpY+OKLh75k=;
        b=YcHnei0sgU7WOBbwBcC7bYeBQfgTTWPvFHN1cEwg309Bo29+1Jx1Q0KA0jAAG9dXfC
         BW/r+PmCY9a1ZuL6cO8dLH8xvNEqVek3VWt/wDEh39fqa4+sEFP66cyAwTSwl4SpiIx0
         QinhZSelVJ60nB+HoFFY66n5Km/2O15ZLohjdU31tx7+FPEJRd2bgYwoXd4SmHapSCHA
         APm579m23p3/j/nSqcOqjB/z5LbkfPkxCzAEJYTFsvHrOgrBbuPKrB/EbR0zdWqxSD7u
         eKEldJWXt+tWjZuGz9MQzY/kMURuHmutEmkQRt1mNB2l8Y41YUP5yKz3OGTm2ehIrcq0
         QTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677268688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ozTt3+xQs6+7ogbKaGsgcnydK5zFBxlpY+OKLh75k=;
        b=IhY2744nweXGvzMt1v8wlYwrhbsA4XsXQ+W7DpAxkKSNoFC3Z1+N8w3oWqjjTSOi6n
         urKaImClJnFglSyZ9tjWjkXPoFqEKauWy8AUcXYovkikL9o72zwe6EyUqqsi2gIgolZ+
         81p2yrKV2Mz0TqB0iq2EvVUn48aau+VrXGDIJaiSE2Mumf0hjPn1hE1TsGr3+g1sx7Ib
         i5IBtv7n0qoX9/1cuixBI2GVdTYnddPRHiyAgL9mSZCMFtYPQBFfHrBoOMCJF4sy+IeZ
         jQdRVZYlnD4rXGD4KmmfyTVMyScm/FH4HrAsKUnv0K9JADRcYlioDqpfk9b0ZxTRI7VM
         g3Sg==
X-Gm-Message-State: AO0yUKW6PRJ18SfAJVDTjUjqYC7Iy1B2FbO1yKWVef+JSbt0hYCndUqb
        zEL9dsWDA4q7e2mw5WuM1qMn8ggsdWk=
X-Google-Smtp-Source: AK7set+btwFgubuHZ/Rb4MNnccdpV/hP9fK6leiIOl8RXG+/oNxNWwAZcOBowLTFIYv5GMhm2C+RP7jXmRM=
X-Received: from sdalvi-android.chi.corp.google.com ([2620:15c:2:a:1808:5921:faf8:7a68])
 (user=sdalvi job=sendgmr) by 2002:a05:690c:583:b0:538:49a4:b1e0 with SMTP id
 bo3-20020a05690c058300b0053849a4b1e0mr720665ywb.2.1677268687916; Fri, 24 Feb
 2023 11:58:07 -0800 (PST)
Date:   Fri, 24 Feb 2023 13:57:46 -0600
In-Reply-To: <20230224195749.818282-1-sdalvi@google.com>
Mime-Version: 1.0
References: <20230224195749.818282-1-sdalvi@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224195749.818282-2-sdalvi@google.com>
Subject: [PATCH v1 1/2] dt-bindings: PCI: dwc: Add snps,skip-wait-link-up
From:   Sajid Dalvi <sdalvi@google.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sajid Dalvi <sdalvi@google.com>, kernel-team@android.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Root Complex is probed, the default behavior is to spin in a loop
waiting for the link to come up. In some systems the link is not brought up
during probe, but later in the context of an end-point turning on.
This property will allow the loop to be skipped.

Signed-off-by: Sajid Dalvi <sdalvi@google.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 1a83f0f65f19..0b8950a73b7e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -197,6 +197,14 @@ properties:
       - contains:
           const: msi
 
+  snps,skip-wait-link-up:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When the Root Complex is probed, the default behavior is to spin in a
+      loop waiting for the link to come up. In some systems the link is not
+      brought up during probe, but later in the context of an end-point turning
+      on. This property will allow the loop to be skipped.
+
 additionalProperties: true
 
 required:
-- 
2.39.2.637.g21b0678d19-goog

