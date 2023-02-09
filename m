Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FDC6908C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBIM2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBIM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CE241D8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so1560508wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8QLwX69nf0DJLU5VOw1LrskXEQNPGRhtdKLVFDYpxA=;
        b=FhMGyC3fv8EZy7CQfcEbL8abhhHF2d6D1olU6YTGDONxW1BWVWDySOGT5JQTLl4VPO
         k4QFLpcktqnFDfWeV/0E8wBIjO8ikjxGgsS8kVsyNe6FaxyflzOwNEp314DmjKoaGLLA
         PJcBk50Aho76l7xBATmNxc2CpkvwtfX+TKgk3TbMqy77qwmX+drdurYauOJPRGheYxBe
         2pq9Cg+JnfoFo3s/UDepwhQQJXBSGemdAx80cILx7QJRvHJz7Fsy7gLYT0pg/h4BhSNv
         0YwTsH3m2vkonDW9debhik3uAHVRxPC6Iwe1+Fx/8a5yh7/51vgC8V6p3fEmJ5INGCav
         L/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8QLwX69nf0DJLU5VOw1LrskXEQNPGRhtdKLVFDYpxA=;
        b=m2lkkI09GFvsP1MFCx+wCkaIT8lO341ZXbfenCZubOojz/ORjjK3qed2mT6y9K+tql
         3LIbjj5rITyiTfrd54kXXK+vVxK3HPjFa50gGSh6WcuI3J5NayQS8V5saJq7l1dygind
         OZ0UZSsF6hvRjWIxNKIlpIUd/koHXlrF/NXvn2w3ZPII3lbNBmLUysT5FZNbMGbgKjei
         A5aA7nR2VXD9qT4Flpzs6vYlS3ojTda5feJKWL/3uwL/MR0fGhs1GQkKtL7iqwuHUOpH
         mqKm564mFx+l6h4UQ3Q27cXgJ8AUs4dQQv+QDCzpI+VUicoglcS4y9i44Wwavs+G+Xs8
         xYYw==
X-Gm-Message-State: AO0yUKWsExJ/IzRYPeM0XKzYVpSEEafso6MElKDmyFzAcjFXLn1XOdeb
        I0oiCSx9vMfWYrLKLtxYSrcGMw==
X-Google-Smtp-Source: AK7set9ciyAoHpPjrl4xwcz7REVoH5xOB9ZATOsfGQ2M5+H6rz0ekG5VioaTFIzMDxvyPnVihPgdvA==
X-Received: by 2002:a5d:4fc5:0:b0:2c3:e297:8e4d with SMTP id h5-20020a5d4fc5000000b002c3e2978e4dmr1613733wrw.6.1675945694989;
        Thu, 09 Feb 2023 04:28:14 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/8] ASoC: qcom: q6dsp and lpass codec stablity fixes
Date:   Thu,  9 Feb 2023 12:27:58 +0000
Message-Id: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing X13s audio, we found multiple stablity issues this patchset
fixes these issues.
From q6dsp side issues are around locking of position pointer and handle
multiple prepare cases along with pulse audio timerbased scheduling workaround.

From LPASS codec side most of the staiblity issues were around runtime pm,
hitting various issues as the codec was firstly resetting the soundwire block
for every clk disable/enable which is taking the slaves out of sync and
resulting in re-enumerating. Second issue was around fsgen clk is not
brining up the codec out of suspend as it was not added after
runtime pm enabled. Final issue was with codec mclk rate which should
have been 192KHz same as npl instead of 96KHz. We were getting lucky as
wsa drivers are setting the same clk to 192KHz.

With this patches, x13s audio is pretty stable.

thanks,
Srini


Srinivas Kandagatla (8):
  ASoC: qcom: q6apm-lpass-dai: unprepare stream if its already prepared
  ASoC: qcom: q6apm-dai: fix race condition while updating the position
    pointer
  ASoC: qcom: q6apm-dai: Add SNDRV_PCM_INFO_BATCH flag
  ASoC: qcom: audioreach: fix ADSP ready check
  ASoC: codecs: lpass: register mclk after runtime pm
  ASoC: codecs: lpass: fix incorrect mclk rate
  ASoC: codecs: lpass: do not reset soundwire block on clk enable
  ASoC: codecs: lpass: remove not so useful verbose log

 sound/soc/codecs/lpass-rx-macro.c       | 31 ++++++++++--------
 sound/soc/codecs/lpass-tx-macro.c       | 25 ++++++++------
 sound/soc/codecs/lpass-va-macro.c       | 43 +++++++++++++------------
 sound/soc/codecs/lpass-wsa-macro.c      | 27 ++++++++--------
 sound/soc/qcom/qdsp6/q6apm-dai.c        | 22 +++++++++++--
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c |  5 +++
 sound/soc/qcom/qdsp6/q6apm.c            | 17 +++++-----
 7 files changed, 101 insertions(+), 69 deletions(-)

-- 
2.21.0

