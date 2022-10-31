Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2A613EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJaUB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaUBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:01:20 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3591CDFA9;
        Mon, 31 Oct 2022 13:01:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p184so10659473iof.11;
        Mon, 31 Oct 2022 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQPudoEZCxCWLF7Nl4aD4yznIiAwbdRAmiCvqEJ9SBs=;
        b=i9Cz/5gnWn+sltiL7AUGIqqubDs+t1xDzxamLgFic7tYoHCXoQi3djT8x6EEI/5VXS
         HRWVqono8zeacVjW0b6h0wlOUf69ctfHpuYKLxgeOD5aC/aRSIpyiJ8+us5L6XymkSsb
         wE8NqzrxuTvFAlSLVzKOLiWzamXDfQl239+pD9cRZ6OeX7trx17qW+ct9kkuaB5fjkWk
         NRnSoNmVv3QMETu8Uo7ogSijkERpCYRIHzORWbtc+9007NOfFF6JfmRPkrNRVifSpRyY
         42ID7a64z+uD9JayDGx02MxCYSYT/GAtXjnc5Ys7W+tji1VfkwCbzEmsWYLI+quRjZHO
         xeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQPudoEZCxCWLF7Nl4aD4yznIiAwbdRAmiCvqEJ9SBs=;
        b=gXIlbqEmnK1oDqii86iKn/Ic9b25XdOpWPta0MRqwSN3rEwppDhxBqRy6XVvgcsx/o
         25NNTdLKIoAwHjB7V5C5eD20TxDPEMc3+2a+UdWgS4G9UcVRb/CH4ACTYdAw1flqIoxo
         v7z321gB/yUH62umLH1Js4NAhPCeLRHlhacfdkpgKIXCtWbHy/2SZYnSP902HjDqM5aD
         X7GsTKwnphpgKUuXtDCDlPEbCbDYh6+jQoPy51CIh/mJhZeWoQRW0rqmFoTDvOR0C2NG
         Tx/lQeJrNGe07zOWbpl9e+4PM5B+YvlOpiUxgeDQCd2CH0XBumVQQKjD7tggKDq6vH7H
         sNFg==
X-Gm-Message-State: ACrzQf2eFqIbB8N2dpxXtNZZSEysJd93QLpJ+GEhrTT6sv7huCGWiKuE
        aj05t4hCBY7T6FHFJBaVLDU=
X-Google-Smtp-Source: AMsMyM4NS49mRVZC9egB5ttLomf++rxNSz89Uq8/KebvUqg6XfohhoO6+wH6S+aacbmJfax0HJkBAw==
X-Received: by 2002:a05:6638:478b:b0:375:bbb:f642 with SMTP id cq11-20020a056638478b00b003750bbbf642mr8628366jab.129.1667246478536;
        Mon, 31 Oct 2022 13:01:18 -0700 (PDT)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id 12-20020a056e0211ac00b003007aba03c0sm2827833ilj.66.2022.10.31.13.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:01:17 -0700 (PDT)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v4 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Mon, 31 Oct 2022 15:01:13 -0500
Message-Id: <20221031200114.987024-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This board is based on the ti,j721e

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v3:
 - added Acked-by from Rob Herring
Changes since v2:
 - rebased on next after k3.yaml alphabetical sort
Changes since v1:
 - added documenation links
 - add board in alphabetical order
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 28b8232e1c5b..09e6845ff243 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -61,6 +61,7 @@ properties:
           - const: ti,j721e
           - items:
               - enum:
+                  - beagle,j721e-beagleboneai64
                   - ti,j721e-evm
                   - ti,j721e-sk
               - const: ti,j721e
-- 
2.30.2

