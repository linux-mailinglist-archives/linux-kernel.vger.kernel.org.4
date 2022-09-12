Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C915B596E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiILLkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiILLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:39:58 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F613E24
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:39:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e17so12314555edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=VvhgnJkgzWm1+CY+cryCC9lz3BC2Xljvm+CFhD5zskw=;
        b=WE7aLkAP/qhfgY9MILUdI4NsGOW4ov+PHmQj4Q5RJBIF+3UYBW9zYeSnhF3qa8Vgxb
         YfVICL6Y2NO4JsSgYysXRG/AjQQHnBhwhXV9FeoFJRKFDkQG0caOyKL0yrljZNRDh+lh
         3aBPskdPECHjiNs8jmFN/XaDSiWHZiuYkR2SJAl0Lln873Q2VHsvrNnFB9JWyeyuTsfC
         E5WAtA6bqwyd4OjLKUv5tK19kpCfuQHOYp5L1WV5252FDU+KqDwdUF5EdaUeJncGe7w+
         JhKqvy+shmX6/gsblsv4hamRdZt1Jo5zRUVMrp7JIE/QWQzwedMF9yqqdn8gk+kePyKo
         m3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=VvhgnJkgzWm1+CY+cryCC9lz3BC2Xljvm+CFhD5zskw=;
        b=59SHQgzumcUkgmma4QL3lx44VDGjWmAlpervuxmGuWDt7ynHsG7RqmaCjBtbe+xSb6
         gIxOuoRs2pyKDXCGZKsboLOcEBpTaOI2Zx1iDubtq78Unz4AryJwWIYpcQmK2O8WERJu
         B45IhOm5o7i6busAyz41KdDEHY4AJhAFO01+sZHlUo1xe991naaKq4j4oRWhGG7Jni7E
         Ez7tlm288S0o0Yw89zIpHHQdcVEI38h7syTsOb1Gt5c8KdDWJ+oHpBwzUA9AhL4oWtVy
         KAjtfqeehxNLcfrGAwIGFFXzu3KgPnGS5nJHJMI+9QKR8B7HLBVE4uR9FJNjQCzCJR6a
         LjWQ==
X-Gm-Message-State: ACgBeo0vrKwM0B00NqK+AWz2N/4HKh7qlCf+0y7xh2Ium1/PphDgiqXj
        PFLNQLZAoDFqL+O7mER01/roYA==
X-Google-Smtp-Source: AA6agR7giM5UqzmcT6ZjCeKgXdWXuOfW0ePVyeY/7ceWkZ0Luv1B4yPnOR2C1URKlLGmLwCfzq5zlg==
X-Received: by 2002:a05:6402:27ca:b0:451:7b58:1b01 with SMTP id c10-20020a05640227ca00b004517b581b01mr6365040ede.61.1662982792208;
        Mon, 12 Sep 2022 04:39:52 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906310900b00779cde476e4sm4314368ejx.62.2022.09.12.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 04:39:50 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dianders@chromium.org,
        lkundrak@v3.sk, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, tzimmermann@suse.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Subject: [PATCH v1 0/2] Revert chrontel-ch7033 byteswap order series
Date:   Mon, 12 Sep 2022 13:38:54 +0200
Message-Id: <20220912113856.817188-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After applying the "chrontel-ch7033: Add byteswap order option" series,
Laurent reported an issues with the approach. Since no fix has been submitted
for the issues outlined in time for the next kernel release, I'd like to
revert this series for now.

Just to be clear I would very much like to see a v3 of this[1] series, where the
issues outlined have been fixed.

[1] https://lore.kernel.org/all/20220902153906.31000-1-macroalpha82@gmail.com/

Robert Foss (2):
  Revert "dt-bindings: Add byteswap order to chrontel ch7033"
  Revert "drm/bridge: ti-sn65dsi86: Implement bridge connector
    operations for DP"

 .../display/bridge/chrontel,ch7033.yaml       | 13 ---------
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         | 28 -------------------
 2 files changed, 41 deletions(-)

-- 
2.34.1

