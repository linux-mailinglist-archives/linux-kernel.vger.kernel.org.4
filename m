Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7163C706EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjEQQuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjEQQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:50:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512694ED4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2af12685274so2680891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684342214; x=1686934214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qu3lyWs3Jbx0/jeZXUB6hf2dlkHallCSn46b3AvlYYI=;
        b=YqE6HhdyUGy4W9xtxxoPucGkbifgxv0R6p3g00l33zbm9pWPUToFqZa3RqRKnWmRbD
         1LmqI0SC/n5wP/2HoNMrA0CjBg/DMvBk/XPiUzmB/hvx/GuP7MO7e8IQqtRZ3hY/7vPz
         +JutbUhDxW/3WG/Gbs8PGZqEoNqFrogO2ictnvbC93qbBnvbRP1vD2nKMHSIj6SSUKLk
         1FWumXpW8hi7+2zn5F2EHx+nSsua0rZfYe7rB9Jqrg+gMzHl4CJOsHZcBMJecTjFzqgt
         ++8513xov++McXYwn9Xy8N1XtNwiFgWFyZWFpDygrnqkf9M4gC/ZD5JoazASjVYRQkYu
         8jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684342214; x=1686934214;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qu3lyWs3Jbx0/jeZXUB6hf2dlkHallCSn46b3AvlYYI=;
        b=PesF/V/+g+av45VyQUKGZ1Hq5ixRC4RiE3ZYkwXDGEE3YObOaKuJz0GqAhp6S4w+kf
         GRGyXkT+l/YkxBzIxe5dxnctWq1Du6fbAtjy8Vs/uROBZPNcGvk6Lxo7tHhOC6E5Ahei
         a1/8JpspDbOexTuqOUPX+6g0TEc/HfBIxVwJnxoK4gcmk0wVMwvLe3b9BKvoC5tAxmsG
         KGq3Z70wogFQTzx1goNJY6vfdD1P+65bzPITsdc1kLjAVGBNB3eCr3OCHsY17ZWXF3m6
         wp4nEcoo09pJiqyO1Be4sQVk8No39Geuerc2tqn7bJKMemXjpJSyySQW4THcSuu5dqd/
         XY9A==
X-Gm-Message-State: AC+VfDzz5Eohoy/UqSz1dwLlj+5BdFMLo0A3ahkwB7fqNmlkKay9w7lt
        GS6vq28mhgMnEMAO//Zsm/betQ==
X-Google-Smtp-Source: ACHHUZ7B1OkgdyFqV7dA+bLi8NfyBZ5hPdx4Dm9efcTeqthni/6gYdQdU9dCQt6KhxgZntR/mv09GA==
X-Received: by 2002:a2e:91c5:0:b0:2aa:af16:5c55 with SMTP id u5-20020a2e91c5000000b002aaaf165c55mr10779281ljg.44.1684342214593;
        Wed, 17 May 2023 09:50:14 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id g6-20020a2e9cc6000000b002af0e9abaf6sm159224ljj.131.2023.05.17.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:50:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/6] Adreno QoL changes
Date:   Wed, 17 May 2023 18:50:07 +0200
Message-Id: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL8FZWQC/x2N0QqDMAxFf0XybKA6trj9iowRa6oBqaXdRkH89
 4U9nsM93AOKZJUCj+aALF8tukeDrm3ArxwXQZ2NoXf9xV07wvee1CNTra+UJSENxLe7p9mFAFZ
 NXASnzNGv1sXPtpm0ZdD6vxmf5/kDWs6iCHYAAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684342212; l=971;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+el7PqiUKmuBnYDuD93qCjkLN+POO/QcjFGpgw7amf0=;
 b=I+eTif+5OVxiz5T1jAnY0c3EyKvbZtNVmuIgmiwcS4EQl1tWIrD8wAq3ratR8+88fMXU9M0Q+
 Om6Zb11zNzTDegUIrWEsg6zeuEMq3DoyBQjp0ernsgB6ONfhpHSi0Uc
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

This series brings some niceties in preparation for A7xx introduction.

It should be fully independent of the GMU wrapper series.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      drm/msm/a6xx: Explain CP_PROTECT_CNTL writes in a6xx_set_cp_protect
      drm/msm/a6xx: Skip empty protection ranges entries
      drm/msm/a6xx: Ensure clean GMU state in a6xx_gmu_fw_start
      drm/msm/a6xx: Improve GMU force shutdown sequence
      drm/msm/a6xx: Use GMU_ALWAYS_ON_COUNTER for GMU-equipped GPUs in timestamp
      drm/msm/a6xx: Fix up GMU region reservations

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 21 +++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 23 ++++++++++++-----------
 2 files changed, 29 insertions(+), 15 deletions(-)
---
base-commit: 065efa589871e93b6610c70c1e9de274ef1f1ba2
change-id: 20230517-topic-a7xx_prep-787a69c7d0ff

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

