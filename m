Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7773EE86
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFZWMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjFZWLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:11:51 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A20198A;
        Mon, 26 Jun 2023 15:10:05 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77e3267477cso201184839f.2;
        Mon, 26 Jun 2023 15:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817404; x=1690409404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROzIJ+1thxe8s7JVMFhecrcUJDNhOkxxIlboXqUIBDg=;
        b=GGeo4rKhdM2kzlwrUbWdghKtCtSYbaP8DmOnCC4ASGTiC5f2okgV7tJywwqPy4ye15
         dW92EpHeL1siY7f+FL25d4FUUAZT+dYUsXjEBlbK5IWq1sngBrenhIOOG3+9eVbVViNX
         nqX3K26kh3r6I3pDZ00a9+9BMbvmqMXlvc4tO6ODhY06YDW2RkHRRl94C5NfGfwtzu6P
         bTb8v4vYkgULMw0i+2q0+R6xC+xTaryQUyAhrRClKC64XvsMXyhnsrGxbOdpCvwgKoKr
         mdtBec5Juo4pxKnwAhUt2i5w4yrRgk7aVL069hCJhz9LL09pT1W+oDnuVCxReItQWetg
         B/7g==
X-Gm-Message-State: AC+VfDwAxfjfo61A2He1inIMjzbDR6TFUQMDHGo+gLgaU573oMiXsZS0
        eOJ/Loz0/WolLNgNyikjMaPVMXxtgg==
X-Google-Smtp-Source: ACHHUZ4e5M/g1dJ8hzIsA84Iy4TBNFuCsurSlKOujI2ZiY5ZOiiGyX1dhHWIDQ4qrXi7sFxM/xmnZg==
X-Received: by 2002:a5d:9612:0:b0:77e:3e85:34ee with SMTP id w18-20020a5d9612000000b0077e3e8534eemr22241703iol.13.1687817404431;
        Mon, 26 Jun 2023 15:10:04 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a25-20020a029f99000000b0042acc4b0831sm813621jam.82.2023.06.26.15.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:10:03 -0700 (PDT)
Received: (nullmailer pid 3946085 invoked by uid 1000);
        Mon, 26 Jun 2023 22:10:02 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Fix "status" value
Date:   Mon, 26 Jun 2023 16:09:57 -0600
Message-Id: <20230626220957.3945972-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defined value for "status" is "disabled", not "disable".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index cfbc4fc1eba9..c6914db7dc6d 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -779,5 +779,5 @@ &wifi {
 
 &crypto {
 	/* FIXME: qce_start triggers an SError */
-	status = "disable";
+	status = "disabled";
 };
-- 
2.40.1

