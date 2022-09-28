Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144F5ED8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiI1JP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiI1JPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:15:00 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0E17A95
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:14:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso782831wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=nW4h8IysCeGHSdxKW2hUxsi6ulI+NrijOXZ0X0ypMHo=;
        b=cSVZEx//KYiPk9a5OcsGeg69zXg5u2hnhV8QdG4wQLAUAJ8pc3Y2ixxk0J4yyg9xJL
         AJ9nooK16JS2t5KJks7pMU14zOudKauKknY8dUsM1HrPneE/kz7oGB9l7oCCHv+/w8wR
         CAYkoxctNjA1shQSANzosDUV61P3g2ds7lgjok4UkWKx6t5j9z9fu7GhBrTYgN75SW9f
         uvpMWAyrOEsjuDu/PbPIYguULcDVfm6jbU3SjEofyY+WFh2pnKxwjECBc/NEyERGiPNQ
         BVhI5gNLUMBTkI7J+JnSkJeVSDF6WPkmR6uNSclg2CCj7uaeyICKm3BzN2lOQ+YNprN8
         uqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nW4h8IysCeGHSdxKW2hUxsi6ulI+NrijOXZ0X0ypMHo=;
        b=2DLsu2vm3Q1oFPf91M/vWtWNv70HJa7sTADVIGfTmbsCxXRrbog+93SJ9FJ6KJsZa9
         Kbn1frNFNI6rcXiQFFBKwOMPt0aITpNa1DBfzbTvud9S5yUgS9gYmDKFgb/C7PAilu/y
         agROTiLbl6CfsP4vFwmEESXBs9FHR1hOIxP4B/GwqHBBVkOyVz1o/o97Pa0YqAl/12kh
         nbYAqOwI7D4y1L9xMKM3E7xW/OskYp3csG+lN9qcpUxkI5Z7CHr+3eCtWdt+Dmh+GApD
         u+bz1KeZNQvt6gI+Bv8Fikgzch9CUni2aWVMuR6s/fQ4j5aRT110oN/AC19QtReDNRfm
         IZ6Q==
X-Gm-Message-State: ACrzQf1qy8xFSZ1qUsK2SrZyshI0pFZir4o4KHL2xmUqUw4xic2ICove
        BqA6QPocXq8dUHzQwuhGY1bOLA==
X-Google-Smtp-Source: AMsMyM6I62be+B4NfMham3eMU2SbQ4sQJvp/B10RM814YcRrkShKs9YdwRftB0+Nk2RtPOg3bYYaUg==
X-Received: by 2002:a05:600c:a09:b0:3b5:2f6b:c7c5 with SMTP id z9-20020a05600c0a0900b003b52f6bc7c5mr5855174wmp.141.1664356495565;
        Wed, 28 Sep 2022 02:14:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d6382000000b0022a53fe201fsm2420016wru.68.2022.09.28.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:14:55 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 28 Sep 2022 09:14:53 +0000
Subject: [PATCH v1 3/7] arm: dts: qcom: mdm9615: add missing reg in cpu@0 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v1-3-b6e63a7df1e8@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes cpu@0: 'reg' is a required property from dtbs check.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index b06bbe25fdd4..e547becc9f75 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -28,6 +28,7 @@ cpus {
 		cpu0: cpu@0 {
 			compatible = "arm,cortex-a5";
 			device_type = "cpu";
+			reg = <0>;
 			next-level-cache = <&L2>;
 		};
 	};

-- 
b4 0.10.0
