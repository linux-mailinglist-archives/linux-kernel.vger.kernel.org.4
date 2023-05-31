Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE689717D27
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjEaKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjEaKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:22:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B4F121
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:21:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso58019061fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685528509; x=1688120509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+QtbaJIHq75M0HgWzYBYseF2Snm0R8Gn+tXgK+DSAkA=;
        b=iS3aYc29FpYhoJv1+htKhKuR+OEiJ5M27HqkuOSXBATo45rxgd1dBYuAb3nrN4DFsY
         TlBNYQt5NJBcGSwCrrBZcbYIR1ODjq2tpW+WIf/Cv1NwQPJSh47dV7iuDAWhdfjQT5V6
         /P+RWVayWCu3bYE3+A0etwefqD3w3/lEax0EhY1gd3KG4VkdZmgTYvRtUePkeYYfufZZ
         o3QVcM7ecyI/uO2iyWQQuZecVXEgD5bDmRTXZonsy55ldu6MaflxU33P1bj4L0PiJTY+
         ozojLFNVz0fzeo1aCcvsaAGbFDK4SAZHJOm/AjttI6D1blMc7V843QjfVPav6nCgBfUv
         +tXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528509; x=1688120509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QtbaJIHq75M0HgWzYBYseF2Snm0R8Gn+tXgK+DSAkA=;
        b=ltxSHNNzslhiOjy6hVB0tIm19JPzCjmLQu5D2DEYuq7GKZvMiSqzeZAX5eyxaYL2Qb
         x6q3h9UmhNHZJmG8qhTdpgmfzDjtrGYEqZOfI8Lp9v2EdpwvYNHmpK6w1X1sQIKnZUp/
         iBqJ41+vbwI9xrvYZbgLShaMTHyQAgnFG61XeWoMBt+iz9xRhkCDojpt2htjujsQCbY9
         h7Ih36MHNPB92TZBH8kkous3Fq8ONjpluFw3xUkcbNYPxb5hLdxpGDFgrcRDN/vtGNHh
         CTHU3cUIcjgy56O80NysybjF2WfqEcj6WpCkedQJZxbECsZGM9wbgzhsE3ALsHwr0iM+
         wbDg==
X-Gm-Message-State: AC+VfDy1dl00xECwIhTvJsg8ybu3rMeVl5LZDADioDAONRBeHWUfp6Dd
        aguAO714aRxp5zJhbB8ITCPez5jPQR3VoCAKEyg=
X-Google-Smtp-Source: ACHHUZ4dsC2gihLbiJrYPsoPwP2tnrgKYDiLFaoHLYVQrugLZId2o+pDJcbgKO9ghsiU3MBtAc8B9g==
X-Received: by 2002:a2e:7a07:0:b0:2a6:16b5:c658 with SMTP id v7-20020a2e7a07000000b002a616b5c658mr2593063ljc.31.1685528509037;
        Wed, 31 May 2023 03:21:49 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y28-20020a05651c021c00b002adf8d948dasm3229131ljn.35.2023.05.31.03.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 03:21:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PULL] qcom: apq8016: add Dragonboard 410c WiFi and modem firmware
Date:   Wed, 31 May 2023 13:21:47 +0300
Message-Id: <20230531102147.380502-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add firmware for the Qualcomm Dragonboard 410c, an SBC using Qualcomm APQ8016
platform.

The following changes since commit 1f9667ebd8e6aac23bab8e95b0d555181dd432ba:

  Merge branch 'for-upstream' of http://git.chelsio.net/pub/git/linux-firmware (2023-05-30 07:46:20 -0400)

are available in the Git repository at:

  https://github.com/lumag/linux-firmware db410c

for you to fetch changes up to 9d4c9a52c2377c367978ff7b2ec4963b0704613e:

  qcom: apq8016: add Dragonboard 410c WiFi and modem firmware (2023-05-31 06:30:31 +0300)

----------------------------------------------------------------
Dmitry Baryshkov (1):
      qcom: apq8016: add Dragonboard 410c WiFi and modem firmware

 WHENCE                                  |   5 +++++
 qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin | Bin 0 -> 31723 bytes
 qcom/apq8016/mba.mbn                    | Bin 0 -> 230272 bytes
 qcom/apq8016/modem.mbn                  | Bin 0 -> 10678876 bytes
 qcom/apq8016/wcnss.mbn                  | Bin 0 -> 4111376 bytes
 5 files changed, 5 insertions(+)
 create mode 100644 qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin
 create mode 100644 qcom/apq8016/mba.mbn
 create mode 100644 qcom/apq8016/modem.mbn
 create mode 100644 qcom/apq8016/wcnss.mbn
