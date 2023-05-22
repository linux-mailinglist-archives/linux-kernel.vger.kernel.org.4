Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13F70CC48
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEVVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjEVVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:23:53 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6AC2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:23:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso7260866e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684790627; x=1687382627;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgR6hJl4v5W/VNWJbFimymN7T4wI+SFUcIfWJnoBenI=;
        b=C3qykUUv308TdzTBXmivOlJVuKrHI6RtuofmrwxHy2E7E3r0piRlzU3uYZMjOHpq0/
         nbFMtIECGL6ZVq6KigpUxLp2Lo6fhyliggSedkEvwX9qVT1Po4UhZL7jnxX9R2Fy0mLe
         tnjbQ8XRYUwka9Mt9xkjoIMfYLBRE3HKIV3VbZcahdR0cXjf0ehy2L+ZZUD3KIm3Xe36
         Weub8Zncccum9DcWa2UyhXt55dJ/uhhibcv7Jukx25VVp430Qf4Q8sBheIPSwvakd4ly
         Qugdb9UXWvUKFFTXdU7DVTDrRx3e6NrTm2VSelHwdl9NzSkaxlrjZMixRKCAD+0tsWdG
         D5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684790627; x=1687382627;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgR6hJl4v5W/VNWJbFimymN7T4wI+SFUcIfWJnoBenI=;
        b=JsEPZxxr+tqoku7K0MCLcqlACmyFOiL/4hUrEOoVMTTkXwUelM+QmEz1E39IVcs/X1
         RpnWnjg5BU6umTwxHAdKp6ZVbVXPfTJGwBZq2WHNySYCfX+hntmhL8rCFzMKagIovHgw
         AI+DrrhhTp7Ceg1IbAaB5H7d0d2KRlWauRVnGRsI5sdUipKhR7EJKkar+/SRZ4EzO9wU
         dIB/XkYo6mJP0kf8FnEP/lEAm4O7zVSUxGkEclE72P0HDdDebqtbkJKMJznyQYqpZ3VF
         BQNO5Y5o75ApIWYRRSLYz9CqSpiqJwld7mhePDW5P3Gd7v/HrmZU5Eo1QRJqsvocFE+g
         l7JQ==
X-Gm-Message-State: AC+VfDydKfuMsNBHwl+9rVI4EhvZ66myKIyLi7arG+gaZW9EuKavXeXB
        FK6abgbrscapas2w6iwqejvCng==
X-Google-Smtp-Source: ACHHUZ7Bzw5s194y23fjwuuZCzhhqmzfXnSg4bE2VApw3ycGR9+tojHVXKq6PmENI3cIKwUk0nrQRA==
X-Received: by 2002:ac2:5fae:0:b0:4f1:1de7:1aac with SMTP id s14-20020ac25fae000000b004f11de71aacmr3366506lfe.20.1684790627178;
        Mon, 22 May 2023 14:23:47 -0700 (PDT)
Received: from [192.168.1.101] (abyk97.neoplus.adsl.tpnet.pl. [83.9.30.97])
        by smtp.gmail.com with ESMTPSA id q6-20020ac25146000000b004efff420b0asm1102032lfd.108.2023.05.22.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:23:46 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 22 May 2023 23:23:39 +0200
Subject: [PATCH] MAINTAINERS: Add Konrad Dybcio as linux-arm-msm
 co-maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230522-topic-maintainers-v1-1-2b91eb8e4f65@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFrda2QC/x2NQQrCQAxFr1KyNtAZGVu8irhIx9QGalqSKkLp3
 Q0u/uJ9eLwdnE3Y4drsYPwRl0UD0qmBOpE+GeURDLnN57bkjNuySsUXiW4xNsfUX0qivut4LBD
 eQM44GGmdwtT3PMe5Go/y/Ydu9+P4AbGjoIx4AAAA
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684790626; l=891;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sUSfHAwWdvL93XFzBSa385oPJR9eTOiEq7h6nDHiVoM=;
 b=QSfE9E+AOnbudo0Zpi3rmrJr3RMqWRIexzkaUN1qaBRMyV0YhmSKKzgQWgqZTvO47oBGrogvl
 bQzBzt1hZ13Da37H84OZUBm9oTG8uzMNZ3eO3MsPB44h3TuiyB3cUfT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed with Bjorn Andersson in private, step up to
co-maintainership.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 817e96c47be6..2da1e2ce2fae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2568,7 +2568,7 @@ F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
 M:	Bjorn Andersson <andersson@kernel.org>
-R:	Konrad Dybcio <konrad.dybcio@linaro.org>
+M:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git

---
base-commit: 9f258af06b6268be8e960f63c3f66e88bdbbbdb0
change-id: 20230522-topic-maintainers-18651a877ef5

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

