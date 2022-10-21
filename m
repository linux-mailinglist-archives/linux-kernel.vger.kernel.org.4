Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62286607CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiJUQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJUQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:53:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E293A28B1E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w18so5879169wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9OiCeTYd5uwtgxnfokq334VISJqPFOEG4jCoBXmUcQ=;
        b=H6yqD+bCUnAKFwa4WuP5unnQpoopWMDnHs8K1A07/c9lDLBtLdzHe8NWGiO5lstJlb
         nVBZrpavBodHSeQL9ZniCsWcLYadN6wDTqM9MR9TTksZNNC4WgEwAEDaTfnUuBj8A9Qd
         3XA2l8Js5uUI3r8emrqWttrx62/rCSAkM21InLKAeWafOAlFEleo24qBCKWVMszeDxmU
         hTEGvQC7BrQR69IVt6TWtlKCtRWY6kMTtaFJcgn4uawgYisv+2vkJRpGt3rI8irSdoVq
         Coq2dNYrP1sv+jwnaJtrl39a8YCuxqgKvUBJ7TfDW9ZTJrMAsIEzv7VhQmwGZ3Zyvkqr
         J/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9OiCeTYd5uwtgxnfokq334VISJqPFOEG4jCoBXmUcQ=;
        b=kK6Fvc5tuijmJjucKJzSRQZl1DiqmY82yJUF7zPlNAatj5PkA4+4++MXMn3Cjm7IT6
         wVRgiErj0qZBZmZdr7LnzdCk1AToAMC0UefKkZ/LH0kZS8mltavtXpQllzhzzwBPUVOt
         aOg0rJSqddqoJ5zBpvvBAusvBNMkvGqfRqkS/eHe7CqIHg2sZ1r68GXfhMNAGd5Tmy//
         ZQEMfxglo2zHJ9um2zH0Ti06yiGELxJKgFku8D7I+oZy2XqBZf0P0EJ5y7iSC2hkAy57
         NdRN7HKArqAvW6vKkvqLBUZCAi7DaDQx/xYqYJMWInX+eF8SrL8yWbFY3nDZzafxurpE
         bA6Q==
X-Gm-Message-State: ACrzQf3zeB2mzsSmvgWcsFnSVE0zs4otZAyj9YBC8H6QhNFil8VbNgDP
        QZlNxertLONX8PdxFFxa1f+CeA==
X-Google-Smtp-Source: AMsMyM5FcvSGOMyUgALVBEmrf1/MUzL3CxMm1g5sP2aXKScMYiHdIUV1O8xZ3U1kX8oVSXHmIO9aqg==
X-Received: by 2002:a5d:6d89:0:b0:22e:4af7:84a5 with SMTP id l9-20020a5d6d89000000b0022e4af784a5mr13232081wrs.4.1666371182045;
        Fri, 21 Oct 2022 09:53:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm19541773wrp.78.2022.10.21.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:53:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/9] ASoC: qdsp6: audioreach: add multi-port, SAL and MFC support
Date:   Fri, 21 Oct 2022 17:51:58 +0100
Message-Id: <20221021165207.13220-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to multi-port connections between AudioReach Modules
which is required for sophisticated graphs like ECNS or Speaker Protection.
Also as part of ECNS testing new module support for SAL and MFC are added.


Tested on SM8450 with ECNS.

Thanks,
Srini

Changes since v1:
	Fixed two warnings on unused and unintialized variable.

Srinivas Kandagatla (9):
  ASoC: qdsp6: audioreach: topology use idr_alloc_u32
  ASoC: qdsp6: audioreach: remove unused connection_list
  ASoC: qdsp6: audioreach: update dapm kcontrol private data
  ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections
  ASoC: qdsp6: audioreach: simplify module_list sz calculation
  ASoC: qdsp6: audioreach: add support for more port connections
  ASoC: qdsp6: audioreach: add support to enable SAL Module
  ASoC: qdsp6: audioreach: add support for MFC Module
  ASoC: qdsp6: audioreach: add support to enable module command

 include/uapi/sound/snd_ar_tokens.h |  27 +++
 sound/soc/qcom/qdsp6/audioreach.c  | 310 ++++++++++++++++++++---------
 sound/soc/qcom/qdsp6/audioreach.h  |  47 +++--
 sound/soc/qcom/qdsp6/q6apm.c       |  84 +-------
 sound/soc/qcom/qdsp6/q6apm.h       |   6 +-
 sound/soc/qcom/qdsp6/topology.c    | 243 +++++++++++++++++++---
 6 files changed, 489 insertions(+), 228 deletions(-)

-- 
2.21.0

