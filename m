Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683C0719830
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjFAKDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjFAKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:01:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4117F18B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso674639f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613659; x=1688205659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaTNCraedRCnPAddnekC6NMX5SCDR9ZdFC83tjFkdCc=;
        b=qsOOihu7c4aNHc/x/lmoifhhwfhkVBsK+gejRtYMDgGbXAA/XLuIRn1wiwFCjRNMlu
         ZhpmSkHw3OVTeig31IIxJCn2NaiDVI31yXb2bx+YGQ5RaOJwN3cqSCPYLP284ksxEQSx
         RIIu7kJ2tFvvysOkZcvXiRHlo00HxT4gU7o689xkzQyy20b4iND4de6TT5L/BD3NB04q
         mXMztVB2FlkKNBvRIEV3cQa0pdhbzCh92adO9Q57+9H8ItSUvXwf8iozXNUjEwy4l/fC
         STgjqj1pmb810dR7qI3NKuXX8QB2js8iKtrYS6haTy4pL+yhTq684ee1Cj2KxlPHMYzl
         nvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613659; x=1688205659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaTNCraedRCnPAddnekC6NMX5SCDR9ZdFC83tjFkdCc=;
        b=FikpEcTgkKSAORTH+NVRJPzBYlaj5dhbmquVvEsk16ESsxSwEHFLLroI0NBkTcfIQY
         8DU1Df0PmgPd/SAkSgQYCVqPIxH5TaTgeMkOs6jDlOevSGsRRIjICN+3EP+nS2fFia96
         o71Rb3JPLoGEHnquLhGcVMupdwwTDUffc96LRIYtnVpBrGj7Bc9xsaeCU2vR6+w6B3hb
         UhSRg1/Zd1O7bLReuioft+SNQeQo/dC/wwSoFlmIyh60RAk2NCQ9AdYvAixmJ+nuMtXs
         1/0kusXi0mEO0QR0DeblP+Sh05aCAXeqBpZRNogU9BVMKcX2frVYRrChYdNo6y8NkqJu
         To1A==
X-Gm-Message-State: AC+VfDy2W3bAtPKXunWXS9UwEkDkov2IXdR7+joOpo/gZinOpLck8RxK
        5CYgtTDCJG3itKFGKDpXS8nwmQ==
X-Google-Smtp-Source: ACHHUZ7eyyg0X/78dOkGbIO23r6CYz4t3T17uj7N5SCkgGLLdxmHmMS/13ZqBfEh9fhLYaXbvNYmpg==
X-Received: by 2002:a5d:4a51:0:b0:309:49e3:efb4 with SMTP id v17-20020a5d4a51000000b0030949e3efb4mr1377883wrs.63.1685613659631;
        Thu, 01 Jun 2023 03:00:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b003064088a94fsm9708543wro.16.2023.06.01.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:00:59 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 12:00:54 +0200
Subject: [PATCH v3 3/4] arm64: dts: qcom: pmk8550: always enable RTC PMIC
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-3-8823ee43f3fc@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=787;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9trx9Tp4WXjEe0208eDY+ogw4Uj5lKhGWDzUscoQQxw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGxXTBXgctmv1Oig2koc2dVmbsey/79DJMdEFHmw
 ipcZENaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhsVwAKCRB33NvayMhJ0c2REA
 CNSbsH1CKfL12NWLChYVfOrxOCCC1DEvYXpNJGOn1vB2DehkXeo36pIzeaFuSHjuvWIJC12nxUeFDs
 A0oTGZMxh8EKr0zFyMKiTzBGI6DV3WYYECqDMFBFJr8dqLj2309C85apvYJD6K3YNNXVigplU0JF46
 AJIyhq/p5PkHa6SfUzLaQWlP4jbFC184Vdo5OEjzOcWjzS3QpEp+/PtAzTl1na7eHBpAsKU5AXw0je
 0LGWw1p6hfrTi910pLeqlDh20WJNv07uk/lI3I/NFkcC4OIaUpdBawZjCVwZwzXYCIpEj2aRsbHhA5
 QOgJLTAHzlJHQVFCttffpe+Pir1sZwQZWnE/6rQt6gAuaDEOKf/kADKf4TZ9fZVvTelSns1ZWM/rw8
 JuZkQW84mKj2SHVlpPwzyXiS1TCF72mPo3HLtpvXsokj4hLyYw1tJGbwnEU5U/vSfm5SClt1IyZ3ma
 2usO24/ImrN++RApWhEEG8DX0pqGaMmHFCfE4NzfhsWj0FV0lk7WBjMkAJB6Dbqh33K8HOqndBCaHW
 wT+UcNeC6Mss/A8XyuBmlnl6bQLwmJapS44axKGmJSTegeCdtzsyxX3xh2+P6a1js9/YPLR7/pEuC7
 5ACgr5TByFNX1fLLRIRRPyKoZFPdVKqIxbMMabrA/KlQ8VAt31WQE2kkU5rw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to keep the RTC disabled, it has been tested
and is functional on the SM8550 QRD and MTP boards.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
index 8c897d4fee29..c7ac9b2eaacf 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -49,7 +49,6 @@ pmk8550_rtc: rtc@6100 {
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			status = "disabled";
 		};
 
 		pmk8550_sdam_2: nvram@7100 {

-- 
2.34.1

