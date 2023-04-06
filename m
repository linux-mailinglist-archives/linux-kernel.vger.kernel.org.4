Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B6D968A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237763AbjDFL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbjDFL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:56:59 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DDA24F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:54:24 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k37so50518533lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680782052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=NT0z1D54Jz23Qd8QBqW5y4LUgbLtaQiI1TTTYvzoNpqNjsOnHncu4tIm1w0PLSWfus
         FcGnKVh4sD4n20MNNi8iHuadPLgpCDZy3tNxNa+3prJ768N6bKVXy5ptvrYhfmmP153M
         nQT/Rvmq+0VrCWP7UfX/LVCU0QvOlyKPLKiaKC76p+4gyYfBcH048wCc/sJ0dGjmFB12
         SBH7ATZwDZgnf+2p8rbb5dnINgkFDUZxaevgSsqVaCXU8PiAW0dN9GX/a9MPcCZQT9dy
         jsjn0PO7g5uIHM+UuOO0VqtmQ9vqvErlM/XEs0HeE7HRYS2ojiPvPbuUXnSNbBXOHhoI
         tfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vr7hvDh/glr30Yw4qpt5Kbr2lkI/viKC3PQIzjAY6io=;
        b=Q4B6fxMFN3hl910l+/K6vL0D4GE/s83qfBsfiN5Yq8qXf7w4mFSjH1ebGRw7I+rp0G
         nUprgFeL6g6ZorJoceq/H7CTExCZ9g+Mm4SpYWbwT7bfM+xDrR2b5V37hSSWXcahfe30
         DBDqPe812b0ysqgEsUYE5S8p/c40qCHb3+BBmY135S5n4ACpT7vxLDlIYJ0zPWfeLWZ2
         aZ/JJ7eJ8SdmzRbSz7gqZkGUSaXf0FqMlh6N7RhgS3fOLLXeD9p0OS7UgS4lkkw1QdHX
         o2d9uWR8wlmqC4Q+HU/6mGoyyivqNtJ3TI3NTEw5j2MyUUNiXpK3Dt3Eh1jksq5miDpP
         kbPA==
X-Gm-Message-State: AAQBX9fhSOy518HuqlC9Ql/E8RD1Qp5fLIKcyxhWZVN+8Ih+E0fVu6IQ
        bCbVMDVs8bYFsEZSrZQE7LU8lA==
X-Google-Smtp-Source: AKy350YOJBBOhvLdzYhTyarkDYK/pXLiXR2cWg4R6nvYfiOFuIxo3sv/hjwJhsRRoIA0DWwgZVofkQ==
X-Received: by 2002:ac2:596b:0:b0:4e9:609c:e901 with SMTP id h11-20020ac2596b000000b004e9609ce901mr2444588lfp.21.1680782051848;
        Thu, 06 Apr 2023 04:54:11 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id q27-20020ac246fb000000b004eb2cc16342sm237513lfo.21.2023.04.06.04.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:54:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 13:54:05 +0200
Subject: [PATCH v2 2/2] arm64: dts: qcom: sdm845-polaris: Drop inexistent
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-ath10k_bindings-v2-2-557f884a65d1@linaro.org>
References: <20230406-topic-ath10k_bindings-v2-0-557f884a65d1@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v2-0-557f884a65d1@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680782047; l=826;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A+cHJo96LANW/mYlLiz68VJ9kDkIsUWUlAaAZ/obM9g=;
 b=JZKiZ4o7YkofUMsu2AgB8TAPweZ+TM2wSK7+a4qVZ4XupOfbVVCCqYRW+YkwYuRfcRV1vwF/Z5lp
 cZVP38w6DVmxGIdjnblGj2CeL8CJgzyfVanJardNzq2u/QMMqRgn
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

