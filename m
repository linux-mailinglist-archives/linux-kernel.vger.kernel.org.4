Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A046D9773
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjDFM4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbjDFM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:56:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFACE86AB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:55:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y15so50677291lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680785754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=uKnjq7nO2hBgKSpX5Y9YkKQayH2KWplyH5jDhXRz+8bLdUOD23xPePP6fjFYIMylj4
         j5fBWQ8C9JIRixBqrvKCoVo3R5XVvAy1X8sdM1U48uqcaTJdSrBXjR6S3TJhnGTZali9
         Cup80wzwtjO/b6DqxM8TG7xvLlt50ecIkv5Biv4o09lLdGotkL7eD/0mNq5Cju884r0G
         gi+mp2iB+lh6wj0BQfMmflLc5pFIGhjhe2kBYy3Via3N7LqoDcGJBGRfkAczPcIVFbYh
         ljZxDiN1B5wN+ab6k/qo5RQ+6TnWW8LrFVt1bJ/jXWhY1a6E3Vk4Z+DR2ho/e7rrqcOG
         hJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=ESlTqT1s6krDGjOMrd366XjWiDRUu/cGsHbVPqv3+yo8l6TIkTFUP3BWTQC7kUt85v
         Bm6B7P6urVeA8RHjklASyoe1aR4IeNjbU+0T4jPAw9KQs9QLSzl7IuAYx8GDmDrmeSwV
         kJ5TrmbfzUIhbG0CAa4tOsQ4HrskUd3AfJeU33E7D4m24oiRpmb+iQRE3W+himBGx8CO
         mR3aFxIP3siq0aQ+diS7kvriRPHSW9orREwczsSFzj3H9kknJWg0GnYU1CvJQn3cEsp2
         7Rq01dIVG3SWOw/mQ3TOMP+8/EnkW9FU0RACl1bZ8h+j+FyK+RVP784R7PsSSlHqsrdJ
         +w9A==
X-Gm-Message-State: AAQBX9eP269zSJzQdx2ZiEBzUf8Zg5VLOSHdzvRmHWS8/xo388snJM+v
        TUiCk2RndCBC/+UvoAZ1OhjTWw==
X-Google-Smtp-Source: AKy350bft/u4kYYCqIkqe8piY32mlGiSvRknbxsY+1B9JBEeVwyfVgN1xVSi86A6HZmAakyRWhmIKg==
X-Received: by 2002:a19:750b:0:b0:4dc:4fe2:2aad with SMTP id y11-20020a19750b000000b004dc4fe22aadmr2283288lfe.41.1680785753992;
        Thu, 06 Apr 2023 05:55:53 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id i13-20020a2e864d000000b00295765966d9sm276513ljj.86.2023.04.06.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:55:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 14:55:45 +0200
Subject: [PATCH v3 2/2] arm64: dts: qcom: sdm845-polaris: Drop inexistent
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-ath10k_bindings-v3-2-00895afc7764@linaro.org>
References: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v3-0-00895afc7764@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680785748; l=826;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A+cHJo96LANW/mYlLiz68VJ9kDkIsUWUlAaAZ/obM9g=;
 b=Dn5+ES2v+YAAgWafpzt+vz8m0ORlFjVLwi8YEXZDaB29+Q/YoyRu13AvSdzIDc7SZOeaG5v799hP
 oJjyfvzFA9JLz2Pd5IhvJX51acjGRuE09PGriA9TL+RaCaAoJaIP
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

Drop the qcom,snoc-host-cap-skip-quirk that was never introduced to
solve schema warnings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 1b7fdbae6a2b..56f2d855df78 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -712,7 +712,5 @@ &wifi {
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
-
-	qcom,snoc-host-cap-skip-quirk;
 	status = "okay";
 };

-- 
2.40.0

