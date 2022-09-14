Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1725B7E88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiINBoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiINBoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:44:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A45D0D2;
        Tue, 13 Sep 2022 18:44:13 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id l6so7205705ilk.13;
        Tue, 13 Sep 2022 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Q7Lh7FH8w4M3kKacFLOBmbMxs4WHQSRRgQYPFFxxkjk=;
        b=goRRtm5dNrBfOpMB6JOWpttLpThCqxKmtTaQH5/ViW63KLGNIE0gI7qG6DbWIcTltv
         vWr2zwhaVqLcPPqbEsiEPxzcGyT1QmUiasD+XzF66EMMun+AGaylHRZAXWsVNTj2HyAc
         YUkJoCKUjIkWZNYMbI6EqJSAnU7pDm8cjr9ivFvZUtxi4Bh7e/2Ks941OXavl4Pk0wxW
         fhRRuBxP3J/I8G0TKQQqeHj3rj3JhQ56z6YIq6WxBFuqbonHjJ1UrPFX+KAWMlaIVqO4
         eHVgmO0caLZulMJ+O9kVw9Sk7wPXv0e9M6viSrFhCfFa1ca+0AGesRM45HfzswmcpsqO
         cTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Q7Lh7FH8w4M3kKacFLOBmbMxs4WHQSRRgQYPFFxxkjk=;
        b=BKZ/m4Ng36gFzpsiM4dzJFNfAqeiwi8aRWWRaR6OvJrVGaucPbRG+Hak/l5C/I6CIl
         kXg1Ex8iiP+WHp83C3qfsKCz90WYyUug/tSRzxgv/mZrdhhiYeJbiDtDx6dgZ3tYRDVc
         GViDkh5jtZyTipVi6rHs1KX1udM8MyATqQffT3IV/uOZd8FKO+0Bi685DUNbwoO2iVoG
         RODHnz/3hnDTdK/LRrJXFseTfiRoEnScxx3F9WvetE7y/md/1kcv3+P3Nuyr7TDr3nP+
         awbm3jh/8rmvzUI/VRsdDXYjxbNDlWoSf6ZSEE6FaOJ61gzh9sPZ0mbc0mKKwpgbK7W/
         2/Kw==
X-Gm-Message-State: ACgBeo1PzX0iTYVXkGwmn/GpaWQb87ZiQfAP9aG4o3N1Zsz8PgTjhm3o
        PmuLztZmBi/00Eo9E5EE2Tjz9fjE9QY=
X-Google-Smtp-Source: AA6agR7Ef7aN4Dc9NsPfULyTpw1ic/3b5vIONFmNWJ4orMcOo8tfvYewi1gU1LNaZbULqs7Fp+YHIQ==
X-Received: by 2002:a92:ca0f:0:b0:2ee:5577:e447 with SMTP id j15-20020a92ca0f000000b002ee5577e447mr12876105ils.215.1663119853097;
        Tue, 13 Sep 2022 18:44:13 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id x3-20020a026f03000000b0035a205ab110sm5291730jab.123.2022.09.13.18.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:44:12 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/2] SDM670 Pin Control Driver
Date:   Tue, 13 Sep 2022 21:44:02 -0400
Message-Id: <20220914014404.199505-1-mailingradian@gmail.com>
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

This patch series adds the driver for the Qualcomm Snapdragon 670 TLMM
(Top-Level Mode Multiplexer).

This is not ready yet because the dummy pingroups cause debugfs to
misbehave. I might be able to find tile values that are safe enough but
it would be easier if there was already a way to declare a dummy pingroup.

 .../bindings/pinctrl/qcom,sdm670-pinctrl.yaml      |  128 ++
 drivers/pinctrl/qcom/Kconfig                       |    9 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c              | 1368 ++++++++++++++++++++
 4 files changed, 1506 insertions(+)


