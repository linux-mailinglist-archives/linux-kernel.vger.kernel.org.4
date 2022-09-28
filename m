Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710565EDDAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiI1NbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiI1NbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:31:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7405A1D73
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:31:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l14so27151982eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=n3qQR+aqK3MBkpPhhE7yG0JzICbbOFyRcGevTT/H8DY=;
        b=MVeVzTtAnaZhe+EoVGaEnkpifnw/hFsnyVLN58MUI492PeZ58ECotTixHYDryoIQys
         22MSjzFXpNbc1k11Kg2gvhhGDfJTw09+oD5vaM+h2mlpSm1vvGTKIKlid4s5jqhKWGQp
         v3miQP7Cbf5oXutuuQBo27dxTIL7HWjlw5KvBMeyt+qsEoS9hICqhvxxR/RBc7VPIFlA
         Igo27gSvRFshssr2bdp0DMbJ1hS8V3R7XLYGvSusgCyH6EVoWi5A+nF8mavYal9YT3SB
         VjlSj/P8u7x45vl4S3k659wLSvFqYg2bSMEW5ne6pT7LHP+wH+RB1aQWh91EsH92B7Oc
         N4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=n3qQR+aqK3MBkpPhhE7yG0JzICbbOFyRcGevTT/H8DY=;
        b=X+r0ZWLR+1cC12YcvEjfRpdHxrFiCPXnTrcZkPbQygFDOtd5BdPv+g8hgSVahY1VuG
         UFzmF0IH24NDXFcKHo3VL59PXXl8sq/fORlLYyf9PUoh8GUHjMDAkm3pOCuvTJhpGLgj
         Tbtn+0R37HdRrwc3agW/A/c4G6YvLDkyAjP/ZYt5QORec/P2WxQn/Sw3PJOntodwhN9n
         58AGaNDhr8oL6FTX8dop6Wes4UPZ0NQazv1GdzMf5HaW2fJnppZuofC5vQwUl0FqOl+Y
         F6ZTv9EpH2Ezbyu3MltEzNpu6w3QRLkev+OIM6G/0HOHnCHGNPfIIfmkndjHy0JaFJW1
         hkEw==
X-Gm-Message-State: ACrzQf1NSQqO+eA5iAGnKcuzYDQGb7evDwaxeQGZy/L7NBGTiD+SqK/7
        pyGVDH2Ldum29VZ/2gl3od3vtWb9+hgKeg==
X-Google-Smtp-Source: AMsMyM6cihZ44FvcUe0BRre7FY4VoB3qwNPZoBjybGrc2Xnj5NprI+bSfV7OA1i9lnIJidtBUAxA9Q==
X-Received: by 2002:a17:907:72c4:b0:783:4fe0:daca with SMTP id du4-20020a17090772c400b007834fe0dacamr14835994ejc.455.1664371878293;
        Wed, 28 Sep 2022 06:31:18 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id q1-20020a50cc81000000b00457618d3409sm3366096edi.68.2022.09.28.06.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:31:17 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm6350: Update the .pwrsts for usb gdscs
Date:   Wed, 28 Sep 2022 15:28:54 +0200
Message-Id: <20220928132853.179425-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.37.3
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

The USB controllers on sm6350 do not retain the state when
the system goes into low power state and the GDSCs are
turned off.

This can be observed by the USB connection not coming back alive after
putting the device into suspend, essentially breaking USB.

Fix this by updating the .pwrsts for the USB GDSCs so they only
transition to retention state in low power.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Similar to sc7180 & sc7280 patches that have been applied recently:
https://lore.kernel.org/linux-arm-msm/20220927170516.zrkzn3xl7oedzi4l@builder.lan/T/

@Rajendra Nayak: Maybe you know a bit more about the internals of
sm6350&sm7225. As described in the commit message USB just stops working
after suspend, with this it comes back after wakeup from suspend and
continues working. If any details in the commit message are somehow
wrong or I can add something, please let me know!
Thanks for fixing this on sc7180&sc7280!

 drivers/clk/qcom/gcc-sm6350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index 69412400efa4..9b4e4bb05963 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2316,7 +2316,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc ufs_phy_gdsc = {
-- 
2.37.3

