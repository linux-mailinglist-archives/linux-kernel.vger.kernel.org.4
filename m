Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6195B74EE77
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjGKMV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjGKMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:21:00 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E319A4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5c2433134so70398161fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077952; x=1691669952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfbv/J9UlljbpfQkbJ1RQZoYi8S5NISMbRChDv8nMFA=;
        b=L5HgpV8Udn4sW3t9PDmOv15HQ9F6WlMBljK+t2VMRkrIIiM2b3fuP5PzAGSeJUHrtN
         V4FXNZOp0+hDlyo7mjjcM8J9IG9Kf1U6OocmKy6Vlv8lH5Sbkj5Hilz+TFDw73sTh52o
         z0vEcdtYEvMbXws5ujeCpQIRvECW0GAHBw/M+a/LqoUi1Ae/F+hce/FaJjjo29E6OCkH
         CgOh1bSLW7M3dYUnbOsE8LUFDV9CriIvDMnFprO0B7HFGnhhvotl78xU2M2JE5ZOUn30
         70jKeMHgIl4GvCNpWsJkSzG4slhgZvAzM6PSpdL9Y9Z9zGzNrMVPV4lgipuM642UuhPi
         PdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077952; x=1691669952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfbv/J9UlljbpfQkbJ1RQZoYi8S5NISMbRChDv8nMFA=;
        b=etcKU4p06UgVriDWVBjjUuruoJXHqOsDSmXUFQjNEy3tlkyggb/tbGCO5AvI0wNMBW
         pXaOkG5XaZwNz2t7hWMBZ37NIeC5rlJht2ZYlgT1DXoe8grXI54xe02XWJAik88IfYXQ
         Zo7ji0sV9/Pdz4M0io2lc9OnMUNAJdXXp9St+4MueAbMWp8byEJsE3ZiNZbMfS/Zmmy8
         BSH3Z7okZ2+YgSHXYQ61cCTT5O50XtoDAOJSIDlrw0CTAl1SFYOBxmrdVMovmbcHAxat
         oTbuDbkmXbD4kLhGcpHhJuVvWfGh0H8tl/alesv/MJjlclXXJbNdt4UhkIv9Lu0ws+eW
         3akw==
X-Gm-Message-State: ABy/qLZMn+NDdDAYXZznoZ+X8L7ZWoFfV42OlOnNcJhFXqrWNdyex3ub
        suUjJg7FGBB1s+r8GesQRW92Jg==
X-Google-Smtp-Source: APBJJlHWMJd8XJU3a0oV2Zgz1d7jAlMWXwwV5ij8yhcJB0LV4nihkRh4yfeLMtprJ56gdLV17Zz61A==
X-Received: by 2002:a2e:2417:0:b0:2b6:d47f:2a4 with SMTP id k23-20020a2e2417000000b002b6d47f02a4mr6482909ljk.13.1689077952048;
        Tue, 11 Jul 2023 05:19:12 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:33 +0200
Subject: [PATCH 34/53] arm64: dts: qcom: sa8775p: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-34-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=670;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=J+YzV1ysLrALsNig4GY1Hu1u/TnFl+lfs1ry3Cimg4c=;
 b=RnXcZb42j9gisrdfBq2D0dwqm5OBc1WiW3QgOhaAD3dwMseB7SUn+nM5Ps3f99EzJaYT0vBQ1
 tCFypJ1rmhqAkCv6CuZsCvsUEQh2WU6TvIVwHQcQJq3Dp5uIp1YLfiD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 59eedfc9c2cb..e38cb436ed1f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2243,6 +2243,7 @@ apps_rsc: rsc@18200000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

