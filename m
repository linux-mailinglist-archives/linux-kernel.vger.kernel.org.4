Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587836B5F2A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCKRh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCKRhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:53 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2375822A26
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id j11so33053236edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVGV3sr4u5bJT2FrvZEHa5E7DGB0ljgtzzi50mDOOcE=;
        b=DWBpsxFXI4UyjP3VzprfoyfTwOYRgeeCM86IYd+ShbMLHCi6yj4qU0ISdyaxPSfuw6
         PK1VxWyRjWotSX5+JgcLq8W6Kgi7oaTe/yKMDSK64264SjcvHY+Z3iPiUSJn9EzDb42o
         G8uKdMAqf1RzlK/xEqfyACWCQbYbVVMcRDN3tAWPO1BcPkfjDFLm97eexUzPJh4hPG8z
         IGsTTmz4viyKOtMBEgdT7PJcOxTugSPaoUhAjQG3thR50CJ23gNsDGmIsoIJdvy2wGCs
         8bJLCRG76cmjzJNHegksY8PDI7iaJri+E/GdaBxe2VDgkhSRLcwtbVSEX0x/IVWvf7g0
         zQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVGV3sr4u5bJT2FrvZEHa5E7DGB0ljgtzzi50mDOOcE=;
        b=60EJytsA7hNfy0NC1rcVl3V7gXRya0B3q/Ef1i3f7QydJxuzXU6fgZnAitgydbONnO
         SNQoRXFRpn0MYOjIZ7+pc1Ht6DTxVodnqGx024wesb0HoLF81lc/IpjZ/Oby0Qum7PS6
         6XbG24pf4BwcZKSMSnH2VxP42/8SGe29spZo3W1aLIjef1ly3uNDeXcx+LPRcNel1XXS
         Nq8d6ihuJ9iy9C19JacVyUJPchBfeiCrBLZDXgbfpsWcSbYaXaIrRDa9hiIgTl4g8NAY
         MGL8kp8xM0qRinEfu3woU2P0ZDJ+dsGxykzk+F3yrFFZWU+Mc+z9DIwts4FmP23t0Maz
         AW0w==
X-Gm-Message-State: AO0yUKVviByp3GD/j5szc4sB8EGj2H9e57KjIgxJf9RgZj54Ny/nnIba
        /D66lHnPv+Kqp/26gogy0T++tA==
X-Google-Smtp-Source: AK7set8qJ2FcXrIvKnGT1fAfQe7qW7VdmTnCy8ONH3WuIJjRJQ06o+NwrYbpP4IJdjuk3ZITP70GVw==
X-Received: by 2002:a17:907:1110:b0:91d:dd29:7e73 with SMTP id qu16-20020a170907111000b0091ddd297e73mr3963717ejb.49.1678556191019;
        Sat, 11 Mar 2023 09:36:31 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id jy2-20020a170907762200b008de729c8a03sm1315253ejc.38.2023.03.11.09.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] usb: host: xhci-rcar: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:36:18 +0100
Message-Id: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).

  drivers/usb/host/xhci-rcar.c:269:34: error: ‘usb_xhci_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/host/xhci-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 7f18509a1d39..b12c2c19d107 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -312,7 +312,7 @@ static struct platform_driver usb_xhci_renesas_driver = {
 	.driver	= {
 		.name = "xhci-renesas-hcd",
 		.pm = &xhci_plat_pm_ops,
-		.of_match_table = of_match_ptr(usb_xhci_of_match),
+		.of_match_table = usb_xhci_of_match,
 	},
 };
 module_platform_driver(usb_xhci_renesas_driver);
-- 
2.34.1

