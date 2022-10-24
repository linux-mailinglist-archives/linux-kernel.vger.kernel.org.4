Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F2609FED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJXLNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJXLND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:13:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7F52FEB;
        Mon, 24 Oct 2022 04:12:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k8so6874928wrh.1;
        Mon, 24 Oct 2022 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nM1eROY2hqOAD8ZSvyDw9Yar9WGgqxzJ+6QCeBCS/mI=;
        b=LLE2Yz7OEonPF7D0+0abGw2AQ3B93CdA35s8Uj7DGIvYZ3ijuFseCeEMTN5dimPron
         saJAjcRy/VQp7h7qF7XT8FrjL7kYp9uU6FisfH2VjfUv9J7knOPELMIW8WdyusX2AHq9
         rrjFQX04Sd3JucEIyl9Ln0/uHynkzEufVqavnRf139U9w9y2Z8QXrdTa/BALOBowxw8l
         /jWFYC8QNPZDOquw8KbKMuClQOkUnnX0Uign4+5ovifV5mcqWI7plq5sGSs5ojnY///E
         FV53R+BDOBr4IIfqsvRYnsEE8QTWA22Y8aTAj3jc7lPHivbZ2IHb4B80u0Wayczn+MaZ
         9dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nM1eROY2hqOAD8ZSvyDw9Yar9WGgqxzJ+6QCeBCS/mI=;
        b=VMr+zGSak5SVbwku1rI5fVi3yuVINvYlCSw/QQ9pvxrDBQlKZbGy93gi0CrQLT6kf9
         wSScOhiqU0TkUExgRbLhogX3ZJDgZllXg+ZNS0YBVFnN/sPdI/BC2UXiQ+HrCRrY+hha
         nZXTrHtDLFw+H/n2bt7HYgj1tvFIjC/3hLM8YvGQUAKL9Kx4UJq4hj2mPANb4zYkO7c6
         ynaD+wDTxtxVf1K2cCl91DyxxrrwbMIsF7hAqLGFsqstpuwgo5BVEbGDhzizQgjmJq/f
         PZ9COXJq+o/CEdw8VcJSlPfjA+ORzfUt//jH5CjvKgZ0hDIcYDVuI3SjH2CEooXS+TPE
         UlDA==
X-Gm-Message-State: ACrzQf1pX/y5l2NZ2Yhh9XVIWunDWcDwXbml/AS/JnOci+ZovrybvZ4f
        orZP3vw+xC7seGiBu9u+Z3gNZMQZmco=
X-Google-Smtp-Source: AMsMyM7erXDlwc7JTKT7OdNomoEgHf0YYZIj8RVVOJBkjVDgpB9tfkweVLtmSfOU30d6WFXOj/ZMkA==
X-Received: by 2002:a5d:522f:0:b0:235:c877:5cdc with SMTP id i15-20020a5d522f000000b00235c8775cdcmr14848004wra.352.1666609966590;
        Mon, 24 Oct 2022 04:12:46 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id d1-20020adffbc1000000b00236695ff94fsm4501309wrs.34.2022.10.24.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:12:45 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH] arm64: dts: imx8mq-kontron-pitx-imx8m: remove off-on-delay-us for regulator-usdhc2-vmmc
Date:   Mon, 24 Oct 2022 13:12:31 +0200
Message-Id: <20221024111230.1335233-1-heiko.thiery@gmail.com>
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

The delay is not required and can be remove.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index a91c136797f6..21442e04a632 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 };
-- 
2.30.2

