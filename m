Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBD6E21B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDNLHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDNLG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:06:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E381199
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d4so2413210lfv.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470404; x=1684062404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pbVMYUFkp/wWpVPBgYNzrX3UCSwtdckmQwLwtFjCGg=;
        b=Ecs0U6Fl0zwn2WiDyoyDh684jJKFZ+b9Z9kwZ/Y5S1MyDes1UYONXRjwIZDahTP0Mr
         EY/JvXuPfibFAiKulbDs/AeLzBmh7Ql+T1Tr+bWkVkIvEiLVkNYWPOII7nMWmbKK79DM
         XDmhkmHTaaa7rh9Z2HzVITeWeu7hJ8SXC48KT67Qk09uw2LgAK/cR4LeeRN4zlCaGl5Z
         I+Rg4kTsxmZgISi4dddmFIeJYVipg4tOLON7FfjDhtmZu1B79d1Z79icFLXPrn/tHnTY
         YpSxmg1JY6aPYca28GJZJKODf7n91rEBePiehC93k3zy4q7xEhUJgJENaLtxsQFIXaiW
         ABBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470404; x=1684062404;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pbVMYUFkp/wWpVPBgYNzrX3UCSwtdckmQwLwtFjCGg=;
        b=UuSmLWHWZzq6plBpIIqI7UH/9rJhXqj0YuMenV5Gpt8FXoIcwD9oFSsPkNqaW7cpUn
         DqKESYRtAaRt2T/1LNqL/N2vh5hXIaL0HYADxD6hY+al9G6Crdv9BRJKhH+/5MUOA0AW
         FEQ3VH/di9IrKQuSOnFR4OgYhN5bWjR37GhuNhnzeIT2gQjof+dqIbWIwX/M8TvnyRhN
         iaE8OENuHHUMwto9GU4125CXPtFTSpKrEIGVkHRcis0HHDMguDe5CrnWiCT7w/cfwYfU
         88co/QMeMrsXn9pMM4pSosiHlC38mQxu+CMIhWHP4Q5fkCYrshCgXNrfd3kNYSy/fKkl
         qRTQ==
X-Gm-Message-State: AAQBX9fN4G3h+1RNFXXwgG43Zfps64rVAcvWlMmvXAG96q7/Le/D00tt
        LZPaj8ZQVVcOxws0FGVOQ4FjAQ==
X-Google-Smtp-Source: AKy350YmEO0YJUXjQplRF1p2roVwVla0URGrh5PSaNMg7df5LsTT6qI1HTe2XSbdb+O5u95JFZzKeQ==
X-Received: by 2002:ac2:46ce:0:b0:4d7:807:4eaa with SMTP id p14-20020ac246ce000000b004d708074eaamr1780082lfo.43.1681470403880;
        Fri, 14 Apr 2023 04:06:43 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id j18-20020ac24552000000b004eae672e96bsm751398lfm.255.2023.04.14.04.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:06:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/2] QCM2290 dispcc fixups
Date:   Fri, 14 Apr 2023 13:06:34 +0200
Message-Id: <20230412-topic-qcm_dispcc-v2-0-bce7dd512fe4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALozOWQC/32NWw6CMBAAr0L22zWl4gO+vIchZlsW2ARbbJFoC
 He3cgA/Z5LJLBA5CEeosgUCzxLFuwR6l4HtyXWM0iQGrfRBFbnGyY9i8Wkf90biaC22xcmahol
 NqSBlhiKjCeRsn0L3GoYkx8CtvLfPrU7cS5x8+GzbOf/ZP4c5R4Wm1eWlpPORuLgO4ij4vQ8d1
 Ou6fgFfVVdQxgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681470402; l=851;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=UDEB64Xz5IE9VTGP1A7X45x+eMP2+g5GQeAWrjLQ9yE=;
 b=oq7Xp8Mp5CyZKf2wzpqCcAfJXAw6g+8os24YM0RZ/hVDvtOL+oPBmphIm840NRT3vwjSL73+c1sX
 7bhWrgb4AIStU+kW3Rh0A1O0u+ZVLbLref/InbfTMe9J/6m0bSsx
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

v1 -> v2:
- Drop the merged "remove inexistent dsi1phy clk"
- Reword the commit messages to hopefully make them clearer

Rebased on qcom/for-next (see base-commit) for ease of merging

v1: https://lore.kernel.org/r/20230412-topic-qcm_dispcc-v1-0-bf2989a75ae4@linaro.org

I noticed some very msm-downstream-y bugs in the QCM2290 dispcc..
Let's fix them up..

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
      clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling

 drivers/clk/qcom/dispcc-qcm2290.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
---
base-commit: 8358703a007eacc48b007284f29c0df2b694b513
change-id: 20230412-topic-qcm_dispcc-f46cbdeaeb90

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

