Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13AB64116A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiLBXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLBXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:21:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04993F7A29
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:21:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r26so8311833edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 15:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtvKUnumnzVEtCCrGx2jX9RV0tsvIRbyk1vAVgd4Pdw=;
        b=Sbi+S+gPjUHT3arab+0NNvc+l7IToOHQQvdPU6a6+GqAdbg2QiUETyaF/z7tRNYTUS
         j04lTgJHOz0Nj9twV8qFbA/f9IcmTJrnD/IUt8xBcvAnRMp7BIQJ11yGUgltPn42iizc
         KFwvbFvgi/r7AUxtIBavnmJw17Lbcv4ojBgggctwVZQHv+3I0FiNx9+jebwvYKP+0GSm
         Df67eymGA+VyjeyshaJPdja2R96NEaGgQQUjbxSV8UbMAqmjaEyRPn9bWGonA0cnNVSH
         bi2TI0MetEqMssIMtO6e+kjU8XFvJwkaxz4yAIdEPYrInVwOJvETlbf/RDhb2TtKq4l1
         AEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtvKUnumnzVEtCCrGx2jX9RV0tsvIRbyk1vAVgd4Pdw=;
        b=ECLzp/azRBVgCcOUBOAsSyGQSgNZp33q+Y3nFnUhtw2TQnWLVLX8RTy8brWuoRrQvS
         4wk3xHjlxUnf4a1tSzcCu0FdJ/n0ASfoJ5Z+WcugAZ+Tm1zL1y/AHAP7Ug5HCQRY8M1g
         w5bQEqXuKWwaaHzs9H/2u5hkIAWpjZBD2QNqHZ8oDJRO9NPyBtFlcyT6sLmVOw5/pKSi
         TfMd+qBWSS/lbVzFPUA9r47AaARqWR7vqg0ji6tEC9PONQNzKGr1Nri1BQ41z9LmD80B
         4KakTLt5uE4JacaX0scSqJFGADJorq7p2//NUip6tokbn47PfDAUwnE58qo/PYFrzqeC
         QACQ==
X-Gm-Message-State: ANoB5pl8LGaRzsevY9wNlzf2udU+Gw8v8EqJSZCCqV24/FCj54xcqHax
        l65uceSZFy2SjEJBO95O/KC3TA==
X-Google-Smtp-Source: AA0mqf5X6CKep4syQrVvp+4miTb0w9B9WPX/2DEJN2hNrBOeCbq56fmA/M6dGpCSh7vzFv5HUXAFJQ==
X-Received: by 2002:aa7:cad9:0:b0:461:60e8:7ac1 with SMTP id l25-20020aa7cad9000000b0046160e87ac1mr18659661edt.45.1670023266561;
        Fri, 02 Dec 2022 15:21:06 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906304400b007b2a3cad2cfsm3521293ejd.132.2022.12.02.15.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 15:21:06 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 0/2] interconnect: qcom: Add support for SM8550
Date:   Sat,  3 Dec 2022 01:20:52 +0200
Message-Id: <20221202232054.2666830-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This patchset adds interconnect support for SM8550.

The v4 of this patchset is here:
https://lore.kernel.org/all/20221130132059.3145243-1-abel.vesa@linaro.org/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Abel Vesa (2):
  dt-bindings: interconnect: Add Qualcomm SM8550
  interconnect: qcom: Add SM8550 interconnect provider driver

 .../interconnect/qcom,sm8550-rpmh.yaml        |  139 +
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm8550.c            | 2319 +++++++++++++++++
 drivers/interconnect/qcom/sm8550.h            |  178 ++
 .../interconnect/qcom,sm8550-rpmh.h           |  190 ++
 6 files changed, 2837 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm8550.c
 create mode 100644 drivers/interconnect/qcom/sm8550.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h

-- 
2.34.1

