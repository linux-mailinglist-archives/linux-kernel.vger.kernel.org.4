Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333EF677F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjAWPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjAWPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:16:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B429177
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h12so7127860wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f0uYFyBWfehvdfPUhzgczyrwyEwalo2faWLflMqRXeM=;
        b=cyJFF5XYn5Er9Wa52DqnrW9zXgNm0OeFTmjt/j/R0ZKS8oivaVfyCGRSYt+E86fg4o
         FFfdQSmdD2/9n5bRpSB+jJJBMa9w6EJIN5PqDLAJGS9LeKlpJWjW3Xv1OmljTNPcvq49
         961HkYs4WR7/0lgRVrCTznfZspJyVCvxkjvwr/dI+If9resaAu5IdR88EYYyMqKlSyx1
         KpJ+MV5UNdzwztRZwtE8w1AQ53TE7xiqIPjOYNPRVp0DfVF9bTeqwRsvnBwVlANDC42Y
         CDjyl46M3XQ5jmg0raSKKti4bstddWvOOHR9RtgBKBX82OHV3NHfmkp1RkBEYUU52ctE
         dS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0uYFyBWfehvdfPUhzgczyrwyEwalo2faWLflMqRXeM=;
        b=IN6UYMz0KfSeeGRFYRboCoXGVDnmicGE7iAh4FBY7wbxZycsxNUpbCRoMxYyKfJIn5
         Zq/rwhAQ+JFnCsxarWmVHjjL40j6MmdvTrqbCaWEGD44jwwe7itZBOBU3I+VIo+PT2ID
         n+BrG6PLcGgCaPa10wrXH2fWtNuB7/gi+8R9GRrVuf216kK40kVft8Demiti5petJTsW
         XmewbbjOq0T0kPl8xrfpsgpGQVJ0laKYf3dMSyvk/Emz7P0KAJy7YL+uZp/Hp7+O4k/7
         2gvDr8z6eTWs3yJ2h17U56/tFQ8JTM3hYCvuvYqgDqpxOSwQ8h41QY+0VPuA/vi8HoXt
         5TgQ==
X-Gm-Message-State: AFqh2kphOOUzErQdUKKru4odwFUnXCmdqwwa7UQZn8UZlOIcWPR1L/ei
        N4+5OGz96Krs1k0fL7aSpVgQxg==
X-Google-Smtp-Source: AMrXdXsbAbk1BkwWOmduOFyhAo84/oZLdTAs6+ake40n4tMRFKzbhjkI16JICGtEE9PlBUsup5HGjA==
X-Received: by 2002:adf:ffc3:0:b0:2bb:ede4:5dd4 with SMTP id x3-20020adfffc3000000b002bbede45dd4mr33278813wrs.34.1674486942871;
        Mon, 23 Jan 2023 07:15:42 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm21726143wrm.66.2023.01.23.07.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:15:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: synaptics: align UART node name with bindings
Date:   Mon, 23 Jan 2023 16:15:40 +0100
Message-Id: <20230123151540.369690-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Bindings expect UART/serial node names to be "serial".

  berlin4ct-dmp.dtb: uart@d000: $nodename:0: 'uart@d000' does not match '^serial(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
index 0949acee4728..dc12350b9fc8 100644
--- a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
@@ -289,7 +289,7 @@ portf: gpio-port@5 {
 				};
 			};
 
-			uart0: uart@d000 {
+			uart0: serial@d000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xd000 0x100>;
 				interrupts = <8>;
-- 
2.34.1

