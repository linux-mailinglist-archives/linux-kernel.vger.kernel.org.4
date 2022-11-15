Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7B6295E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbiKOKcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiKOKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:32:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147E22BFA;
        Tue, 15 Nov 2022 02:32:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z14so23321805wrn.7;
        Tue, 15 Nov 2022 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3hleG+JBlWKiyuOBiHTr/k3gF4VUiw+qWAWvRBF4c8=;
        b=kREM6saglq8HeIc5QRINVA75AkeornAxvkaWg3odA22W+AWraA655sTtPT9UsniIW9
         ouZ5W/R5HwMQ0atdoXyB8gfGPLrUEzoYicEDe0ELWbfdm4gVMjiRZjqFgo605z+tDNB9
         sO2TyDHWfRmxYQuZmqkEQp5ZZf0+4Uys2QFeShUc8UIsjzvu3SZd/yvVPqJNuqj+d72m
         Be2j8n7/yBRMPZluYE5/tndN96jWhoeafOEiZnxVtx6v1BPshmAy6SCrLz5+Q8jLDnvu
         URZr/YhxWNVGvmg49akb0179406dsnQlagbBLFAFfs9Hs3A0gRxsgKg3WGoH40G2fL94
         94wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3hleG+JBlWKiyuOBiHTr/k3gF4VUiw+qWAWvRBF4c8=;
        b=pmbOUPFmYud2uCW3qd0IjrfOhwsdUxwioM6vLAulSLigblPPNfN4/qN/qSTnouambk
         cza86KmlO/Hs82jj6/ySOnSdezrK4jqM9POaWik5u5V+h8eul4PlMVaq8C45VeXBTiwk
         ki6dJlk3wFJVq3EgwDWWxwMcqqIfZDCWch5NCUTzEH7rFeJ0gi3IK2yqSYKdQXHnHr19
         LvPGOSB4BnpH1zUJvVqbcK/2/TOks/+6HSN8fL6fpPAtvPVC6GW7InynC34IeW0cUSI1
         QzqivWhY/pxJWAHS78kzkupWhfEQ1igQciUuYNwemdNqWFrca59Swlq4J2Kn8gYusTz6
         w/Hg==
X-Gm-Message-State: ANoB5pnNVLSc5L61A4g7C8wAhyBSolP+RivgMCwjYjeIUtvnEEFO8ho/
        smrAwh6a+8Hslscs4bIpwB8=
X-Google-Smtp-Source: AA0mqf7SuuYyRKlOJch4Qlmd4Yoooeu9BbQHtWGy3R/vQjMgsmeMAOIHLFk0ze0X5QTotT0AkHMZqg==
X-Received: by 2002:a5d:6407:0:b0:238:238:cae3 with SMTP id z7-20020a5d6407000000b002380238cae3mr10355518wru.685.1668508327067;
        Tue, 15 Nov 2022 02:32:07 -0800 (PST)
Received: from felia.fritz.box (200116b826a73f00a9cec1b8eddc8521.dip.versatel-1u1.de. [2001:16b8:26a7:3f00:a9ce:c1b8:eddc:8521])
        by smtp.gmail.com with ESMTPSA id t5-20020adfe445000000b00236740c6e6fsm11940207wrm.100.2022.11.15.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:32:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@skidata.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: rectify entry for MICROCHIP USB251XB DRIVER
Date:   Tue, 15 Nov 2022 11:31:53 +0100
Message-Id: <20221115103153.28502-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fff61d4ccf3d ("dt-bindings: usb: usb251xb: Convert to YAML schema")
converts usb251xb.txt to usb251xb.yaml, but misses to adjust its reference
in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file reference in MICROCHIP USB251XB DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Marek, please ack.

Greg, please pick this minor non-urgent patch on top of the commit above.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdcf1e020a5a..43f9e2abe893 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13726,7 +13726,7 @@ MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/usb/usb251xb.txt
+F:	Documentation/devicetree/bindings/usb/usb251xb.yaml
 F:	drivers/usb/misc/usb251xb.c
 
 MICROCHIP USBA UDC DRIVER
-- 
2.17.1

