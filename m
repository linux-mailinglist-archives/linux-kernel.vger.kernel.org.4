Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02E74EF06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjGKMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGKMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:34:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73241717
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:34:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso2863079a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689078791; x=1691670791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9v4ZXfNPn9qlJhxs+gp/ant1A453p1BhRobLNcBnVk=;
        b=Up4HteXzXYxshse/QHhHUUPRI35rS5r2DpZ1dqojER5Nsx9EfvRga46A0W6XK7jJuP
         0E0A7OYk7sGh52rWkSHT/pjzFdGjUmebLkEDHjy7wtyCWw52DNKQxUauW7M+Ee0Pa7QB
         5FkDpnMCEVrb5nQfAmxJ2XArqydsQBRics47K55MGq3A1ne6LGkpsbBVh92dPYd/1Jks
         h5d/a3mFlLiMHGjLkQ6Ye9/cxq9rh6oZJ+1APGwZBMeZzuFTPmAvX9HTjgbM7XCts9Y3
         7eq0IYf+SG9Nn271arN4tSaeiqztkV6vo8dq3NQYYQKe7XRS0BYsqagn5Ggcd41xL4qu
         +N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078791; x=1691670791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9v4ZXfNPn9qlJhxs+gp/ant1A453p1BhRobLNcBnVk=;
        b=iyAOeNxh+VicZLmujcyyIyLpuWCmbSQM30kIezaecwrewalDKV6YuvCCZdU7xjYN0w
         jzdSejExdZTtlIRoePD+ugM4D3VnI+KOgVgBiYLvx3z058lASE7iArNMLA3V76iAIrVh
         I7RpgSW2aoQgmqZmThmVg1zLOaMmNsoZNFyHb0vlQyWjRLWkwBU8hbqHUvOVlJBETbJD
         1ye0mvgHFb8PNSWHjF/qUOr945bbg75VHHU5QqxQ8WGeoQ+LZ9QufG/0w20EONMuRvMT
         5ap0NfuX1uaQ2Ksp0aODLmuRD5ZgqzwIDwVsjfxlExVCKPHlTHIO4ebQDxWHKJRUsahb
         yN4g==
X-Gm-Message-State: ABy/qLZX6HwnCqNYALDdALqtG0Dqy3Mdt5OLEpgt7eZh1TKUksXni7FT
        7eQN4TvLWnMjPYor5DKKM/3mXu6wysJCw1Bku9DhZQ==
X-Google-Smtp-Source: APBJJlGt975r1L3ME9SiPu7XfWBzrD6W9t9yg+ez2+RHTRoOIxDF6/VsWrx6pvoj7Iig1uZMdsOG9g==
X-Received: by 2002:a2e:9c07:0:b0:2b6:e17c:151e with SMTP id s7-20020a2e9c07000000b002b6e17c151emr12101413lji.48.1689077961981;
        Tue, 11 Jul 2023 05:19:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:41 +0200
Subject: [PATCH 42/53] arm64: dts: qcom: sm6350: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-42-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=644;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3BXN4Qsquy4y5qOl9KpHX7nLXTZ8ImSw5T4ipGBkQ1A=;
 b=L4P2R1cTX0Mx5tC2KxNyNlk0tY9lOiawmJDvaVn06l3qHluLU/5INXihMYZKQCkrUV54h+PyO
 evh0Q52kgDYDMKkfN9XL1doUqB6VtMhBVyMInXNS4GKDnYkZ4s3SEBh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index c2b5d56ba242..1f52f63c5a57 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -2563,6 +2563,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 		};
 

-- 
2.41.0

