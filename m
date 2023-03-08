Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAD66AFC5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCHB1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjCHB1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:27:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1E92F1B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:27:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k14so19480017lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1LiRrn/f20aeaTLATrE8Yvqu6MU8FYzo2w111NPDWY=;
        b=u80SPOJKQ5BqBIEJXo0d42CdIKQM2uU4mysTiTzJpvXRgAFxwkuFMnr+PuobykHERb
         bLivjxnAgBxgiTu/Fm+WduhQbsIujAxC4piqI2jUznp8F1TQyaZDLdm9OGc9INdhk+i6
         qQ5eFUMO+9sXewVpZF+qtnOasb114Ib9wWGIhMxTA3odBw+7v73SEeHgwrv5i/tBH2bp
         2N3n4+r/F/VWTA2Q3Nh8IPoXxAfaSkhXqxoL9MqfEQ/kthlVRzL3YzRTanf0vVHf6iyh
         +vl+vTA1u3toVqeMELQ8xH/NkVOikFYU+UWHWoI11KPEE1r8lrNPKnqq5ulz7XOGJ6m4
         6/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1LiRrn/f20aeaTLATrE8Yvqu6MU8FYzo2w111NPDWY=;
        b=A9DpEJg/h4gUtDO6qpl3I/u/l+exICkzgpOflVE2Vu++CD6RJQfkiIOMkYBk6HwcF9
         6uwuduE01T756briq7YBvI18YhL+I3QnSVZpz3a3aIvdlVSASmPKnH120sjzObr8d2ZM
         0hqQt7/O+wPl+5Mw3aVxjXaGK5cgoa/gWfAFwXji2QMlRUUmDNqI6G1bSp4I5dj1j3jh
         t30gHm8U7y09uu0NvWaKdPW6P1Uvn7G2JIGidNT2LRYwhgSVDmyo4R6v1v1eJSrpv55a
         eN6JE0mvy2BJZ+9slUXzlIJ7QpH8PGxhG1CDljyLDH+dGUq0mTpbKtuEwBsIHb/Vb17t
         6rKw==
X-Gm-Message-State: AO0yUKUNBCxGCsE6t6aHtq+/oVKlzBF5HBkGPqw060v9F2dwTF4mPmSZ
        JgY1ZAF9hm6iD3v2ZiTyq/Pl5A==
X-Google-Smtp-Source: AK7set+49coB/F5mtbRumR1Fj9/dcHvr6i94MthLNANUhQpJWO13waJZSJhu9E4HAm94GJtj8qwUSg==
X-Received: by 2002:ac2:546a:0:b0:4cb:449a:31f8 with SMTP id e10-20020ac2546a000000b004cb449a31f8mr4441000lfn.35.1678238843862;
        Tue, 07 Mar 2023 17:27:23 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:27:02 +0100
Subject: [PATCH 5/8] arm64: dts: qcom: sdm845: Add SoC-specific compatible
 to cpufreq_hw
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-5-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=782;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gOO9l9d+O6v5O+DhKkwOdpc/sA5zonlXQAqp2PndSns=;
 b=fJ6lff5PsM/oOT/bMHtcxi20SOGB7ngCB/tF0A0EmFolYVnHbzcJZA7igI+WfQaZZ7XyUooZ8iHl
 jYnGQbetDlr8a2e+BQ/8sNAjb1OtCDib2F2gvcJKgEqkx4G13rQe
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a SoC-specific compatbile to cpufreq_hw for compliancy with bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..5a7cc1ad8094 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5222,7 +5222,7 @@ osm_l3: interconnect@17d41000 {
 		};
 
 		cpufreq_hw: cpufreq@17d43000 {
-			compatible = "qcom,cpufreq-hw";
+			compatible = "qcom,sdm845-cpufreq-hw", "qcom,cpufreq-hw";
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 

-- 
2.39.2

