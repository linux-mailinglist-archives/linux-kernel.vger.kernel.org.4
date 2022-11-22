Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87264633CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiKVMhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiKVMhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:37:39 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C61276D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:37:30 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so23347172lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w0KfeZQDt2kqu3VffioA4jWiWF7VwBC/2sPf+6WgA8Y=;
        b=Ep+CKDHfxbAlJvVm1xz5mlueq8XD8NReNK/nzbSB66TA2xNxLeCPdBaKPDoUXu9OdP
         lEKa8U1nWq4aTEu5Z9l2X+G8zwWB9jTkehn3NHWg7HbHmiulFiF70L8zov59zB0VpwPM
         OLHbP6pfzojwYPq15JscKna1qhDZitmvKzNuo7CDPeUKo426fj98cvqDqLnmSwCdV8Ln
         dJRelueSbxlgxQ3F5XjBTH7WNhTNdBBsOkfYS72WF0oykGbHUByWJH0elHQAKMRPa3TP
         vJWcdIuqkZIq0SSFrDokdMfiffhf/0MsCyY8pitooI0ZUVbpvcFSGa7Anpw4HkBkzJeo
         6gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0KfeZQDt2kqu3VffioA4jWiWF7VwBC/2sPf+6WgA8Y=;
        b=RRBxYzs2VVK3YPj8F1xiVUUNUF1wRvsUrDeD0Lq7WBGpr40jBO4WXekmy6IxVOMn//
         x23uhYXMYT3DxM/3DfPV10a02N/x0AjEYQjPBhvoJf9XOQvy9jU330K/vdErTio55SHA
         QW00iE5RZ0D1uuD7C2W4dZ18eWxG+2jwP7u/6cFyYKRUqmCVDE1B+6g42/NsUDodT8AB
         rt29sEf3EZN5VQxpr+Aq+fO1azOS4gox2LLJUE1Ahs9sL/02adPnIMP0vAZXk2eoSHBr
         f3GPf9Hs/8HDQ9Bod96GeBwiNvq/FbTTsIiuTxMWDoTKa6eymH+ZJUrTm07GmzGKOSsC
         C+Iw==
X-Gm-Message-State: ANoB5pn1Tb1D5UpWVR33aPLq632Dax++EHjk9IEh6Z3lgnGhkRJQ9RVH
        8c2QHaAZA2g3koftfKU2hv5kVg==
X-Google-Smtp-Source: AA0mqf5ksyyVPOsBQE+sl3WYIWeFYnsvODRJ9lWHgaMW2xr2XTY9CKeudMn/yKtpF5uy64vWTFbrtw==
X-Received: by 2002:a05:6512:4011:b0:4a2:8bfe:a03b with SMTP id br17-20020a056512401100b004a28bfea03bmr3681307lfb.210.1669120648462;
        Tue, 22 Nov 2022 04:37:28 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m19-20020a195213000000b004a46f92a15bsm2501844lfb.41.2022.11.22.04.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 04:37:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state"
Date:   Tue, 22 Nov 2022 13:37:13 +0100
Message-Id: <20221122123713.65631-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to recent improvements of the cluster idle state support for Qcom based
platforms, we are now able to support the deepest cluster idle state. Let's
therefore revert the earlier workaround.

This reverts commit cadaa773bcf1 ("arm64: dts: qcom: sm8250: Disable the
not yet supported cluster idle state"), which is available from v6.1-rc6.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note that, the improvements that I am referring to above, comes from the below
series, which Bjorn has queued for v6.2.

https://lore.kernel.org/linux-arm-kernel/20221018152837.619426-1-ulf.hansson@linaro.org/

Kind regards
Ulf Hansson

---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e276eed1f8e2..a5b62cadb129 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -334,7 +334,6 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
 				exit-latency-us = <6562>;
 				min-residency-us = <9987>;
 				local-timer-stop;
-				status = "disabled";
 			};
 		};
 	};
-- 
2.34.1

