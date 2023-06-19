Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C73735C54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFSQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjFSQo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:44:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD000E61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f7deee339dso4405558e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687193063; x=1689785063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hk3+XLzwvUhnac+YdwTL34Deb6BoH9HZb6xFXJBKUGM=;
        b=TBZG7v7If7o/5pSou59M0mIZP5qeoKj+Nh+mbYavYalVGusJMKNk7Tc4+mD14X24Rl
         gB144EyGtNJUDAbx2Dsov95atHXw81pvbEShQTNGjnhskR2lKGiuqaeviwqtAJPxFxGi
         6TKUdnGIRwDL3EvyiH+nKoOZF6HOKPUD7UBcqhZZwCYoEbNaXQpF2F3L5kNEIy07hvmT
         Bf+Yg6MqCVGqiv4GzptJG4WS51vdxd7vEkjMKfcH8M3tVFUY9UcLWx8ITARFmsGVYGI3
         PyjSn1jqOfeTL1hel2r5maJzPRuz2fUJO6S0O4I9IjQYrQJuddFvVaOnwf51mPVSYooa
         9srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193063; x=1689785063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hk3+XLzwvUhnac+YdwTL34Deb6BoH9HZb6xFXJBKUGM=;
        b=C83p9FrFiagrInSllBK4WG3i+j8cxpNoSGxeZMmUnDGoxoI5KV4fxHPCLUPPY6tclb
         96fVbpBqfJb1Jh59pfeETPyFq3rIxAFLIeNsz9n14Xwf7B20NZe4cIeY28OJoSnIT05v
         S8i8xzTq2q4xzBi7zfr79UWWf0EFeAyQ/jJ4/fH5CjWs0L+Kp2Ytsy9a2EIHgP3M60AF
         /iboBDBiWBhmhnhHAUiZMP6ukXRs2en1U7krEiQAPELySci+873/+1Cf8PazPEuXOJ4W
         +lQ7qVl6XUHetPdJZOR3/YkN0xJQxn5Ix65CsnwtfTGuu3a27UYsso67EV6XpHVH0roA
         7zMw==
X-Gm-Message-State: AC+VfDxw2pYP710KbBxjCi1xH/UxzAhbI0Fo84XSPSVAAKCY96gDJVfC
        UpUNS+iWx3scy7bqpWNF53FShg==
X-Google-Smtp-Source: ACHHUZ43YVyyMvpV79hwaPfXJTAxmlC/6e/OWjQ1pc/ydVIDwICbEz1/Yu+VrbtJj+Npcj/Fmg5R2Q==
X-Received: by 2002:a19:e016:0:b0:4f8:5886:1868 with SMTP id x22-20020a19e016000000b004f858861868mr4674410lfg.24.1687193063082;
        Mon, 19 Jun 2023 09:44:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id d9-20020ac24c89000000b004f849605be7sm1774293lfl.292.2023.06.19.09.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:44:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/6] Adreno QoL changes
Date:   Mon, 19 Jun 2023 18:44:20 +0200
Message-Id: <20230517-topic-a7xx_prep-v3-0-a3ce3725385b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOWFkGQC/4WNQQ6CMBREr2K6tqZ8hFpX3sMY81taaEJa0iLBE
 O7uh50L43ImM+8tLNvkbWbXw8KSnXz2MVAojwdmOgyt5b6hzEBAKapC8jEO3nCU8/wckh24vEi
 slZGNcI7RS2O2XCcMpqNfePU9lbR0ft419wflzucxpvdunYqt/S2YCi64RFWfHVilDNx6HzDFU
 0wt22AT/AEAASqtGkTQYJz4Aqzr+gGkors4BQEAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687193061; l=1497;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fU7IOvGFZT+jtDrFsHSlPtEO+e2x+lA6EVgMfmK5BgE=;
 b=UBAMGsIGb0WZMAKEbrHuoXl8s1shs2X+HNxHtR5cntD9grU6aO3tDG/rzyE3s2Ad67Wy68QFc
 nhLhLOplWgZDaveJw0ANYhBIme+xR984zvUcx/LroWMxZSBcJ3WxeZu
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series brings some niceties in preparation for A7xx introduction.

It should be fully independent of the GMU wrapper series.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v3:
- Pull more definitions from mesa
- Decode CP_PROTECT_CNTL bitfields
- Rebase on next-20230619
- Link to v2: https://lore.kernel.org/r/20230517-topic-a7xx_prep-v2-0-5b9daa2b2cf0@linaro.org

Changes in v2:
- Drop switching to using the GMU_AO counter in timestamp
- Add a definition for REG_A6XX_GMU_AHB_FENCE_STATUS_CLR, may be subbed
  with a register sync after mesa MR22901
- Link to v1: https://lore.kernel.org/r/20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org

---
Konrad Dybcio (6):
      drm/msm/a6xx: Add some missing header definitions
      drm/msm/a6xx: Use descriptive bitfield names for CP_PROTECT_CNTL
      drm/msm/a6xx: Skip empty protection ranges entries
      drm/msm/a6xx: Ensure clean GMU state in a6xx_gmu_fw_start
      drm/msm/a6xx: Improve GMU force shutdown sequence
      drm/msm/a6xx: Fix up GMU region reservations

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     | 21 +++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 14 ++++++++++----
 3 files changed, 29 insertions(+), 8 deletions(-)
---
base-commit: 47045630bc409ce6606d97b790895210dd1d517d
change-id: 20230517-topic-a7xx_prep-787a69c7d0ff

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

