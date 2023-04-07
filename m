Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57C76DAD93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbjDGN24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbjDGN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:28:49 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9DA93F7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a44so24899305ljr.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71AC0ikf0Km0x4plkaVuEck1Cfenbrjm5IUQHvGO24k=;
        b=XkNeRFkyD1Vke1fwILYZ5wCBxBjB8TgpmdJeOin1U9seR/kEM0T6tjuTMuVAyA9+d5
         4MtSRVT0fUyVDZVkKOkdyzhehxSKNDrHjiAf/jiHyXUBDy+BD+MgtqBCzPWTXOohE+o8
         k7s/Gppk3oXJhP9IMVl+qSkmTICuzRQc+UFcmcbODiWjydzuqUd8srR17IABThPYR7dV
         3UEKA7G+AMR/EZQktWMYSubrrxlZFsxVmR4FsYAokMjqed5RvZ+GoVZBe4Kj7Es8arNk
         /AvxIxOyaijm2FtBii86oS6m6fZlsicQaJNHAhxufA6aUwddQP/n78Jb2fSr9chMgOos
         9FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71AC0ikf0Km0x4plkaVuEck1Cfenbrjm5IUQHvGO24k=;
        b=tqQJtf2KJK8HfcwmwBp95N/TYdtN7K6zaD7zA7PKvT4LiQOKr73Nvb5ndpqMzTHciP
         Oh7z/frrvKCbH9ePOJMzMm01WrlMm2t/U/a7kIW2PZoLuHimYtRpwNCpXAw83iu4nT5g
         s4dINRv5qVWjS2zOEEJCDCXstEcyCLvA68z4/2BHnNkhewEc1Lz1UJID/viZFQ4m8DyR
         DD6RxkpZlSrOsB8xVSEg/0cZy0ePt/wbGsTnsERW2WWlfwSjNigjQb8IW3Ui+xF7VaYK
         gacFHyfsp0WZcd3Vk/fgwF9nfDoomAttXMqPzWhwvfiR4kGIdp/R+dG7YAd9BiQC2evK
         XaUQ==
X-Gm-Message-State: AAQBX9cqMZ0qG46uw0iYd24baB1bN7naD/dHjEvy2QjsPAtShuemcgI3
        9ESvBSWy0+v3hOJeKcqJ6FhOxA==
X-Google-Smtp-Source: AKy350ZSruER/WhZaHc54QHBOZ51rAbF7UrQ9i5YxFqdcrNz6ioeFKKdY2ttc1T424CJeSRGUvUDvQ==
X-Received: by 2002:a2e:90d2:0:b0:298:8782:e5f with SMTP id o18-20020a2e90d2000000b0029887820e5fmr562218ljg.43.1680874122036;
        Fri, 07 Apr 2023 06:28:42 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm811031lja.98.2023.04.07.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:28:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 15:28:36 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: sdm845-oneplus: Fix speaker GPIO
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-topic-msm_dtb-v1-6-6efb4196f51f@linaro.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
In-Reply-To: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680874110; l=899;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=2ZlzTx4qZrv5fI0EvpNhiuB/bNP3eTRF8tP8rrGDU64=;
 b=rMGpDmfTtl9My3tCK5KMbjhv6W+DPUi8hya37IvJUg93v3X1hJhA3hhTChLw4Ae5xjo4R9YcfAXP
 LP3v6XHBBcPwajD4MBHv6PdXz7VPM48G/a5f3Yf/53uBOgINd6BK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unnecessary mux{} level to make dtbs check happy.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 0c268c560d37..8c2b9382337c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -814,13 +814,11 @@ panel_esd_pin: panel-esd-state {
 	};
 
 	speaker_default: speaker-default-state {
-		mux {
-			pins = "gpio69";
-			function = "gpio";
-			drive-strength = <16>;
-			bias-pull-up;
-			output-high;
-		};
+		pins = "gpio69";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-high;
 	};
 };
 

-- 
2.40.0

