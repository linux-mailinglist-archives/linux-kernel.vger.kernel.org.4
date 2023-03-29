Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773836CDB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjC2OGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjC2OGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:06:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA55440F8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:04:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bi9so20338752lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680098688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHJ0WvwFhiwkNTXEVFAcPy6OADOzAA2uvcs+k52iD3M=;
        b=BVWxz02BP62xHNvQqVawNsr8/34+J8NWKHuzN6MPcgZdTfCDdxWgtB/bRHjQHDLYpa
         8y4U3Ktra2AcImTgh7g9x+808EFuitW3L2kKfw8kqmdWNc58ySzVoa83d6wEY8VHio6E
         AqxwvtzXiD9jvDp4f59y8HlrK2tnynYGSvhH0TfOndIdBF4oX1yloBovV8Ml5qk4tyNm
         Juq82SBIFpKv0zlGiuT5fCdOiA8689mtzuGQOrFi+gzImO6l0ZJA8c4IoQQyUb72dPG0
         M97dP58+YmQcnKNItNAho3iXUafJ6//KvH0pFgRgFa0nxfPM/ysTmv9Y2HZ05jm2RsoN
         C+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHJ0WvwFhiwkNTXEVFAcPy6OADOzAA2uvcs+k52iD3M=;
        b=uDd/Wq+y5nIYOox8SMaw0uKvf89lU3+pmnwWKkefF8fT6s3wwxwRFhHvuxvGpVLGTn
         8HpkmgFb6kwQotnR0QutTUg/J8nDAaHY1gXBYR8fTcCP630HNolqn/zJMrZASHA0oZJi
         NAjALbCv4ILI1Fsu5vseGDShcMpHXkgyMTMmFJtOp0tD89BDZe3pI/97gOl6nTaOtReE
         kMXeT7muc4JxnUZlrI2rU/Z7+2iABVty6FuND6l1ukSlNaQqUUbtwGAhV0P7LUxi2iaZ
         h3iCLAURmG9ZtopzSgcUjURz9SscJkQcWU0twz2C0B+SP3EnE+oVUmBOkcDSo/MO0GjT
         N/2w==
X-Gm-Message-State: AAQBX9ciCGp6S8hjwfZQl/hAMmQsYpUtQzseKkAQQVXjSq9lg/Q8BupX
        KLt7xXCiGD+z66mDaFbXDkbx8A==
X-Google-Smtp-Source: AKy350bZjIkvOV30egQBp76DByMuaZbSmTJ1/6zX+9+rZEZvIkolNPlHLICPA3fsY5DWKnVOqEqpzg==
X-Received: by 2002:ac2:4889:0:b0:4e0:61a6:c158 with SMTP id x9-20020ac24889000000b004e061a6c158mr5775860lfc.36.1680098688469;
        Wed, 29 Mar 2023 07:04:48 -0700 (PDT)
Received: from localhost.localdomain (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f21-20020ac251b5000000b004eaf2207a33sm3501083lfk.223.2023.03.29.07.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:04:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of idle() on load error
Date:   Wed, 29 Mar 2023 16:04:44 +0200
Message-Id: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to initialize the GPU for whatever reason (say we don't
embed the GPU firmware files in the initrd), the error path involves
pm_runtime_put_sync() which then calls idle() instead of suspend().

This is suboptimal, as it means that we're not going through the
clean shutdown sequence. With at least A619_holi, this makes the GPU
not wake up until it goes through at least one more start-fail-stop
cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
shutdown.

Test cases:
1. firmware baked into kernel
2. error loading fw in initrd -> load from rootfs at DE start

Both succeed on A619_holi (SM6375) and A630 (SDM845).

Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu load")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index f61896629be6..59f3302e8167 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	return gpu;
 
 err_put_rpm:
-	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
 err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.40.0

