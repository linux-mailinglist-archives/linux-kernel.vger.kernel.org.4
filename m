Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C26C6E03
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjCWQpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjCWQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DBCBDD0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so89493444edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679589853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aq8I2aQyBQpQohRa/OmaNRySLUW3o0D8LtVSY1bY2Uk=;
        b=i8j2uvRhu/5srg+g6xmmwsESyfuQnVDMI5KyBWiLslaiqQL7dU9DU84/TdN0Q+eLzw
         6taTI13nhfp2y2YEGn0Hrr4kFVGXb78eIEcExnJVzfYHGz/ZmXYZL020gxxZu8OA7Ocq
         Sv4XUZJ4SOq1DcAZj7aWgqq1kE6aQX8NQJ3mav4r9NEvrgZ/eY5b1OkgT/1Dl+f4QSfM
         f/VmnMVblSBhhO9mU28hArJ6fqDOLiGNGTfyVgy9ZK/jFg/ee3YNTUPwHJUgBWAESz67
         z49b5h51zWrldIzaGa1AuFx+MI1hQWXSo5yu4yjbndx8fmGpJCt4yuwekJkiQowWtGUO
         Mfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aq8I2aQyBQpQohRa/OmaNRySLUW3o0D8LtVSY1bY2Uk=;
        b=lQkKH2EU0ZHPYlg9F6iBN4MTGMN2AXituTVp0ZniPV/AkEX3ZHQ8BP0k3PaEqnMC58
         VJ6oqwUsBfWkDnRidW+zz3wPGbyNkIEQYsUWgoSHWR/AtXuMmt7ezeJPKJpKH+hz6vP7
         4r4pJd13uv9EdEr7X0n7CVHxBOwQ29NdsSvWscA8GiRDzIgsSJqAkc7bhHaCb2oS8YuE
         sC5BR+4DHNzgpkNoQEpm9zq4G7u/jlm5GFr028HH+S3qHu+tUsWa9oFyCZrURK3x/q05
         rTfBjAvDfUAX7/hkFASQVgUh3jKFSVx2hxQOV8Fn1MFFludfCakLcI/52mwZjMleQxS+
         lkjg==
X-Gm-Message-State: AO0yUKV5iJ5ZWeUibAcPwDTjXvI3aHUyqozfKtysABGXMiVdBUTBjodp
        K5z4ZvYfE8/+GSa4yTqFVerJkQ==
X-Google-Smtp-Source: AK7set969B/opsIF2lkPrgqWd55/tFs4Pt60GbdmFaX5Rle7aj7sZbfopjrhzqmZAx1xHx5JbfZGVQ==
X-Received: by 2002:aa7:d34a:0:b0:4fd:2b05:aa2 with SMTP id m10-20020aa7d34a000000b004fd2b050aa2mr10877110edr.42.1679589853009;
        Thu, 23 Mar 2023 09:44:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm9542187edb.72.2023.03.23.09.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:44:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: qcom: fixes for Click/Pop Noise
Date:   Thu, 23 Mar 2023 16:43:59 +0000
Message-Id: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

Click/Pop Noise was a long pending issue with WSA Codecs which are prone
to accumlate DC when ports are active but without any data streams.
There are multiple places in the current setup, where this could happen
in both startup as well as shutdown path.

This patches help fix those issues by making sure the PA is Muted/Unmuted
inline with the stream start/stop events.

Other than this there is a patch to fix DSP graph saturation issue as we never unload
playback graph before loading same graph.

Srinivas Kandagatla (4):
  ASoC: qcom: q6apm-lpass-dai: close graphs before opening a new one
  ASoC: qcom: sdw: do not restart soundwire ports for every prepare
  ASoC: codecs: wsa883x: mute/unmute PA in correct sequence
  ASoC: codecs: wsa881x: mute/unmute PA in correct sequence

 sound/soc/codecs/wsa881x.c              | 30 ++++++++++++++++++++-
 sound/soc/codecs/wsa883x.c              | 36 ++++++++++++++++++++-----
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  3 +++
 sound/soc/qcom/sdw.c                    |  7 ++---
 4 files changed, 63 insertions(+), 13 deletions(-)

-- 
2.21.0

