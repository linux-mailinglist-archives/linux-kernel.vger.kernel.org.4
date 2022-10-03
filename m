Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467585F35F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJCSz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJCSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:55:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0B1FAC6;
        Mon,  3 Oct 2022 11:55:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a13so15904483edj.0;
        Mon, 03 Oct 2022 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nFbiDq33o+/1OOLfenDeUoeiwYc5KoMc/vKWkTFD+pM=;
        b=EBVMCk6QJiVuUWIK07baLhbBg164s5OYHgjAlV4ZyiX5Z8q4xJfkB1vmQ4BnNJGGMw
         80JF5SPb+oExVo8sbV7gunLszBbw13Qz+mllUb05DxxkfrLHQy/X+N4nQeWJXz9JAYu+
         Y11se9XDcajB0kU7UcPirEboWiOPjZensLcupydK7Hsf7YXYmXkF+ynfH8wu+C4VS4Uq
         lktu3wgObRdiqgsV/cVZ5JAC61zhIkaqwLTT67ZkFwv3xIgHp9t+IBeRsksnMG17v7jX
         BuFPTJBlbbOOV79pTp6IY33CW6A3UXSKiHJHXfVn0Pv8fy1x7NwnpJKDoTQ+vVJr4X2D
         R2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nFbiDq33o+/1OOLfenDeUoeiwYc5KoMc/vKWkTFD+pM=;
        b=TIFh8PV8wkYU33wANCpZ3YzPUcLfrW7yVG0kiZaj8J7Goyw5sdBFAyZ7qY/PisroJk
         TnWeVrtR4hLP259/UNOQKIBsLZkFQzRw1CKWhPh5MFvvvE/g+OZMjNdewyRs9NiuJlZC
         iC+85uDowqz+LxI6ZTI7i6v4SEa2KIn48XRl1eZLy2CUAWouhasNXznQgJX+SyYu2tmm
         lOSreVYZ1AePDjKZqlAK98rLW0LKpvCWtuMscte+PCaeM4dJYwazh0mC8pHNCIybqNuR
         tFIvJu1g0C8mBijrPEvlYXY3J36hCJFcWTzddT5DQJVVW08BBcbtJ/NCzR/kY5RMBQHL
         f1Xg==
X-Gm-Message-State: ACrzQf0mwXIBsd8FWwzCzOo1Wv9ziZMSDmF0X9lTMoqBYDEgYiM7VDZ0
        uKr1BztL/wVg+ygFuIOHqI+oizAxotM=
X-Google-Smtp-Source: AMsMyM6yfe+yOQg0xbDbaIc3a6P789u+jAudGWkZ63arqNET9id/pLaDtOkNKTLnbp2fG1CPB7r61A==
X-Received: by 2002:a05:6402:524d:b0:459:3619:9cfa with SMTP id t13-20020a056402524d00b0045936199cfamr2096577edd.227.1664823315840;
        Mon, 03 Oct 2022 11:55:15 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id a11-20020a05640213cb00b00459091c44b3sm144559edx.3.2022.10.03.11.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:55:15 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v3 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Mon,  3 Oct 2022 21:54:58 +0300
Message-Id: <20221003185500.928608-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  arm64: dts: qcom: sagit: add initial device tree for sagit
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 689 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
 4 files changed, 697 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

