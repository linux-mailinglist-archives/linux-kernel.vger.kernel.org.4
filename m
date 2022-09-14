Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDFA5B7E75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiINBjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINBju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:39:50 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BCF1C906;
        Tue, 13 Sep 2022 18:39:49 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id x2so955719ill.10;
        Tue, 13 Sep 2022 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gc4ViA0757Ur6oAHyaazQsLXAPbtcxQzDNaQriprPag=;
        b=bxnpgkqlRUNUZboG7C/f9IIqf963Gpy59Bp1ol6c+u+nPPQxY9UFWQ82Bn0GrykBea
         woQ1tWc3fntjtCEZEgJz3m4H8BpZt5pKsih+y+KJ9sQIRwFMVg3uuByIVNOWnTdmY/IH
         9bDPe+QrJLdy8CVLlsfvrqojBazjZylnI2pQABNJRBS94gPz2kFTB9po3QS0lii7g4No
         YjwkeNYK5ON1wjM4WCbAz6jFlf7NsVA2QOb6j999pO4WSZyLKCbmtm6KTLBWta+TCm3z
         yduMHH++m9ry4YPlKu1Mk64hKatnVj5BjS/YUzgwuCjfeAKV+oEUwrkzBoT2af61qcs3
         iIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gc4ViA0757Ur6oAHyaazQsLXAPbtcxQzDNaQriprPag=;
        b=U+AWmKy75pSgSDovau7RFEevP/unhPvEOT4gNCmliU2ciKNrvBBbyNNHxCLl3zwuzF
         KFl0bc8Aw4xZQv+D8c2k3PJ9nndLa/zB69Hb33+Fa0Knxjk2FHnxeb7m7bX+v9+xaCCg
         y1nRPtdRWUyhcPE2ZLsJvja03JHWGZRv/rYCD39nqqJT3vBYpvCH/0oJ8tXQXTzt8diG
         bfmmQ1cX1Nv0gqD3A0woj1IDyw1xcRD2/RR+zIRSZMyyvpjzdkXVkajbqoJfKW9CBv/P
         bOFddCqmKbE8IY8K8V9HAjiVW8sysRf/jDKKnWQ3OkXwBtn7B5XWL4L0CQAz7OZS9RQ/
         X2UA==
X-Gm-Message-State: ACgBeo17qo01sqRuoUDwa2myJ7dckQ0QD5D2gDX350xApgOeaGue009C
        2TZmrk2GmSjoEShoo/pAWDU2mVUxXbs=
X-Google-Smtp-Source: AA6agR67A2pNBPfMY2V6TB3nF16ohA3kI2P/VgZ+CzkGAvFpXTDErc0W1tp5VrNKLGUSp4nGLqrrlg==
X-Received: by 2002:a05:6e02:544:b0:2eb:1024:3a04 with SMTP id i4-20020a056e02054400b002eb10243a04mr12521139ils.222.1663119588159;
        Tue, 13 Sep 2022 18:39:48 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id w14-20020a02b0ce000000b0035a09ad2d87sm4016002jah.99.2022.09.13.18.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:39:47 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v4 0/3] SDM670 Global Clocks
Date:   Tue, 13 Sep 2022 21:39:19 -0400
Message-Id: <20220914013922.198778-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
 - rebase onto next-20220913
 - accumulate review tags

Changes since v2:
 - drop GCC_SDCC1_BCR reset
 - reorder gcc-sdm845 and gcc-sdm670 if statements in bindings
 - add space
 - accumulate review tags

Changes since v1:
 - regenerate patches to fixed malformed patch
 - fix schema so that the parent clocks are specified correctly
 - remove core_bi_test_pll_se from new parent_data to match array sizes
 - reference correct frequency table for gcc_sdm670_cpuss_rbcpr_clk_src
 - set correct index for sdcc1_ice_core_clk_src

This patch series adds global clocks essential for features of the Qualcomm
Snapdragon 670 (hopefully) cleanly into the SDM845 driver without doing
runtime fixups like in Google's bonito kernel (see patch 3).

This series (mostly patch 2) affects kernels made for Snapdragon 845 and
might need some further testing on SDM845 devices. I do not have a
Snapdragon 845-based device so someone else will have to double check if
necessary.

 .../devicetree/bindings/clock/qcom,gcc-sdm845.yaml |  59 ++-
 drivers/clk/qcom/Kconfig                           |   4 +-
 drivers/clk/qcom/gcc-sdm845.c                      | 400 ++++++++++++++++++++-
 include/dt-bindings/clock/qcom,gcc-sdm845.h        |   1 +
 4 files changed, 447 insertions(+), 17 deletions(-)


