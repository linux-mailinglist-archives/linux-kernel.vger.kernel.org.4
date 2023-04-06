Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDE76D8C3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjDFA75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjDFA7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:59:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706426EAF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 17:59:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x17so48974091lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680742781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyt8W3zTm8mLAuocsZEse9H9Wjv92dhj3v8YnLOroKY=;
        b=t7X/Za4IJMuxfnHTFyLConWxB5AywCFd2qxosbiWBC5GRmaCKIYfRr7egqzVJTTg8N
         wMFbDyZu/hHkJLnmQnMGLglPe8hWrFPJ5vNSDzLLusqD9gi1PXfJ9Stejstg+H/Ud4Gv
         E1+ta9m4intURNO7QCH/HWiE9Vtx7thGr5LNhP+q+cRhPxHFg73zFy6kwBqs3Tz/1Qdq
         0yNg+PzJ0yLLN+oM2awMlSVtsg5g1MFC98pMOFe57DGa06FNoWlQEuZQf01dDrHMhSIu
         P28E9raIwGheBgSq2YT7ivFoB0eY3tv+TvrqW5ibihUfbl0/GvON9YZoHIEFQIhywO9r
         tdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680742781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyt8W3zTm8mLAuocsZEse9H9Wjv92dhj3v8YnLOroKY=;
        b=rdk0a4Vzg13pyiVxRc7smRsbrhy5JTRJmP8KDYnk9PI5CpWgioYfuNzkkBiVP5IZ44
         gZayCY5qwChtGgeXoyiDe9YiOmkLeqT81tOqvQKllWYFI87Wy8ab4wjTj8h9jttmLFkP
         I67mziD4GHtbKYVSJ/B+TSrH8tkJT5qZes75k7+LKwzw1lut/bx9CxrR50XsbJ2SO4d6
         E++PVJ2cUo3Lqv1W2kk8vYxrdAQCoJdlZ2KSlLlTx/+Pedg8mfDveMG9z8l56H5BqcID
         BhTryzLmBoK6DzRCIdY9q3Qt6hWYDSGRZcJkCTpL2YPV89LwbbpJdlea5fkW4EPVZRgK
         Qzlg==
X-Gm-Message-State: AAQBX9faCF72o0vPhMRyyJs7vVO3HgeYmzt7WO1LyFDWlkP9ud/dHRDT
        wbq+DxYBdsWpupphsXTAGKGeQPf47csEoJA9u1o=
X-Google-Smtp-Source: AKy350b6b79dA9VgLSyOrjVxET0SPehmL6ImBkvScOgiR16iexi0wp3aZDwU8WR1aquDEhltWlqnXA==
X-Received: by 2002:a05:6512:3885:b0:4cb:13d7:77e2 with SMTP id n5-20020a056512388500b004cb13d777e2mr2177317lft.26.1680742780676;
        Wed, 05 Apr 2023 17:59:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v7-20020a197407000000b004b550c26949sm48280lfe.290.2023.04.05.17.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 17:59:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 02:59:36 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845-polaris: Drop inexistent
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-ath10k_bindings-v1-2-1ef181c50236@linaro.org>
References: <20230406-topic-ath10k_bindings-v1-0-1ef181c50236@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v1-0-1ef181c50236@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680742775; l=759;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yzgqDSTZJ+UbMalehZ3yMdPUd3D/DDvUo/JFlgMs+5U=;
 b=sHPf/FrohXz7C9fLj2wWw9ZruWAGCYizyuzeuM9hidn5HR7plSHgPqw68u4/AQQt0bfoI/3/oBQF
 A0aZwIuGCJi7efvDfp7+sLcTU0v+aRrdzceZDkVr1R+uE84UOfRd
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

