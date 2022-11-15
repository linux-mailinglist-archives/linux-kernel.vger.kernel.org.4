Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB95629686
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiKOK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiKOK5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:57:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7CC750
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:55:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so23541906wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Os696b+9zkVS6lz3wwEWnLE1KxIJPKzpMEH3bahfyE=;
        b=JiWctmm26IesWn9v52lXd+9stVyKBduqAE3Rig0nnvhzGYTGVluffpEgZmNhNVBSis
         26BbjDcWfsAE+kLpccx9VLSB25WJBkVHSRbfL3Z6l2A/65jVgmHiEMpRClwe93CypaTP
         bUIYzfJ0pU0tUt/lTnGhz/i/OD4VH8Y4qNksN3I+hDJrOEB2BoOQPrzga97s5kzxwMKn
         f24YpA4ib8405CtdjX9WTrmtNCtqgcpFOzpWGCaB9JNt77fw2LjvUDbBtfMBXjFDaSrX
         gzW5rnd2gQWdT8Q1HgLJEltr29mfIS3B35/SJeEGcQsE4jBFE9lSFCwTPwvqTGveqpUb
         dzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Os696b+9zkVS6lz3wwEWnLE1KxIJPKzpMEH3bahfyE=;
        b=dApFbugNTd2+5wbuwDO/y37uSVNoryRNPEBRM0T2DgtCn3g4F54VpsMN4c1Uk4pTEF
         r0OFkvRHieQcKzHzefeZwZpVYhCF2gQR+30mWS/423MsGNZrEuEOfW8Rgd+MuIzVim7X
         jwFq8UPrxLiWux+FajXiwiveRMRLcLHYmcS/JllSazd5CNgNtDkCi1v3DalHs3t+94/Y
         EdgdNdRBASbmLkRPZtWeoBNnl+HqohezyT6ciMVkV32hDJkh5DHsbnTQw41MH9hH2dkq
         NvMUrisOy6jOSZyy7+lX3RDlMoLEfcHs4j+akBSel7Z4/PgnARH4fwkgGSK36vGzsTih
         JlYw==
X-Gm-Message-State: ANoB5pm0AO/Q6JX1aIMJLvqJgV5mJ9QIjQdBZMOQWhSrqrZJgzXKWZ9s
        gvgXOAds05w/3DV+CrvCQXiQug==
X-Google-Smtp-Source: AA0mqf5CKMgNkTiCStyQMUE9zELmueYgW4bfgK1N2t93kQ1edF0KYrFc0oZ/oMvfPzr3cBEMDijUmw==
X-Received: by 2002:a5d:58c3:0:b0:238:8896:7876 with SMTP id o3-20020a5d58c3000000b0023888967876mr10351481wrf.645.1668509755874;
        Tue, 15 Nov 2022 02:55:55 -0800 (PST)
Received: from localhost.localdomain ([185.201.60.217])
        by smtp.gmail.com with ESMTPSA id r18-20020adfe692000000b00238df11940fsm12185046wrm.16.2022.11.15.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:55:55 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: codec: lpass-va: add npl clock support
Date:   Tue, 15 Nov 2022 10:55:39 +0000
Message-Id: <20221115105541.16322-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

New versions of VA Macro has soundwire integrated, so handle the soundwire npl
clock correctly in the codec driver and add related bindings.

Srinivas Kandagatla (2):
  ASoC: dt-bindings: lpass-va: add npl clock for new VA macro
  ASoC: codecs: va-macro: add npl clk

 .../bindings/sound/qcom,lpass-va-macro.yaml   | 72 ++++++++++++++++---
 sound/soc/codecs/lpass-va-macro.c             | 41 +++++++++++
 2 files changed, 105 insertions(+), 8 deletions(-)

-- 
2.25.1

