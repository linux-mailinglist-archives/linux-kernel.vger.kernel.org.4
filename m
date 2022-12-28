Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5E657511
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiL1KF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiL1KFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:08 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17C1007B;
        Wed, 28 Dec 2022 02:05:08 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d7so15626659pll.9;
        Wed, 28 Dec 2022 02:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u7Uk1luvmnMjmFHjGbs37xOdHZWhJfRtivVYvqsKyM=;
        b=BlOZxQ5+5ju6hXADgDx2hPBqe9r38X9X8SmUUkifVf4KIr45ylB/tSiqMtWEsEbn7Y
         EhQ1f3ozW+hw3PdFi+cM9TRtoRR/hS7auXKnoNSvzVMGKj/sTmd0GydvJ2XPgdpHwk8T
         vpSzFMx9qo8J6p+g4uwaMeU0Oqf0Uc82mJEXehu/zEvQLRFmi7v3O+sEbcLpt60y601y
         r+fHvKFhmSIQ4snrIJRCQ5bRPdlaiNDhA/Q+HdHRbZAlBvflUZndIsQ043Sxxx8UpblI
         c6XFyqDqC/jaRk4F87Zbj+fCA9iSlDitrUMVhyZZ/NLD2qg5LFgP2IqQEAGEyUoS9W1t
         LFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u7Uk1luvmnMjmFHjGbs37xOdHZWhJfRtivVYvqsKyM=;
        b=b6bZRH3/vNGJ+Ap+L5jO202W8k8glKf/r0rYt9EFLzuYENBOILnSorFWJRaXLCHyu7
         z3Zy/CHDwbk3mpZdfAAq3WI4vwaKZ0Kyyg9zIWRxc9vTRlcU+dm9PaOpvz0K08aHv4Qh
         4QVdvZAjjjAByHOPMlUt/mebZIThl1/kK8BXgDYm/hKgiEInH9xr0cj47mWiFvuX2Kto
         0MXtOeiW+2flnw4P9jLufLqggirzxznCCL1om194hYo8BAvSyfIZt5MVKb2mDKsbR0Zu
         40xBF3JQHtnH6SNNGOulbQGe4mMQIVWKI4JfDcoN+QBTyWnEw4uE/SQRHvEqMCj/pi6P
         LHqg==
X-Gm-Message-State: AFqh2koK8Id/obqE4gy2m+1hIyg7KHOAQq9DwL3NA6ki0y55MdV/TBw5
        FgdrTZXwfU7TAj4ToW2ls3E=
X-Google-Smtp-Source: AMrXdXtgp+C1gXCKHzBhlMTiGizZFzt1wSInB/oFAAIr0BnRXXMSGIzeiG4uF2FYYgUW6TOU4+wuGA==
X-Received: by 2002:a17:902:b114:b0:192:64a9:62f3 with SMTP id q20-20020a170902b11400b0019264a962f3mr17041434plr.48.1672221907772;
        Wed, 28 Dec 2022 02:05:07 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:07 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/11] dt-bindings: usb: Add device id for Genesys Logic hub controller
Date:   Wed, 28 Dec 2022 10:03:10 +0000
Message-Id: <20221228100321.15949-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

Add usb hub device id for Genesys Logic, Inc. GL852G-OHG Hub USB 2.0
root hub and Genesys Logic, Inc. GL3523-QFN76 USB 3.1 root hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index a9f831448cca..db009f3ef438 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -16,6 +16,8 @@ properties:
   compatible:
     enum:
       - usb5e3,608
+      - genesys,usb5e3,610
+      - genesys,usb5e3,620
 
   reg: true
 
-- 
2.38.1

