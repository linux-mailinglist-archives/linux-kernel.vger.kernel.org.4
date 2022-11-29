Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3699163C0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiK2NN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiK2NNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:13:13 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B6662E84
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e13so19683388edj.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvGYMXBpX4kCTXFb7In42mmUQ0TnJwaY3tVruVQALiM=;
        b=qYzyHHRuHsbiBL4KnYqHuAcMAfaAL6Cryp5vPg0Zjb0XGggP+M1b6b2KiQyenpLQr6
         TZl0yUUe8OSlDVO97gTkjaI3cKSmCrkRPnkgXY5bi/29pGrePfz4Ly/6k25TZZmhGPUp
         KqfVBm7cAiQ4LuPz0NMfBPeO+ScQ4L+Gw065HaMzBznWX6D0fKsZ49WBcwdQ7veW18S8
         I3+kYptVPermoS64iqUo48NfRXMp8HKOHiXbAHIElXRkDRIGCLSQnZpJMhBXMlfnCAqM
         Bme7wERG7/zwLQ63Tl45wAIh98JfoCd2geWVlwOVNNryD8OfEr0H7TLone6ZNHKJ8CVN
         h/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvGYMXBpX4kCTXFb7In42mmUQ0TnJwaY3tVruVQALiM=;
        b=uYgh016rqwfaKfiI7fTSd/USn4/w34QyKAlAJ0ZymVxRIAdTFyp+QQKiIUd3iWSXB9
         MIkROGUYeqIhDwn6gThkfv+/KTTPOQPhurxGCsun+z0x4o86XoJ+Wm4V8/GuWE/kG1Vh
         QRXxob6if3tsX5i5iOwRU9qYaC1q1qvB5xo8ryAqUKiez0Jp+iqpItX0MIBNRNWhWwxp
         qcaageO6NOW34oo2tNRpugn144rJTZOC0Ec3fubdtHTPLE8wYUFrpPkpFNkBWrPxWo7W
         lHvlbjmQGpwyadCT+ETe+9iYsGxFvtJZ9f+6RvaiP2qHS2uNi/rM7hi/kFkpKJxmePvo
         /qjA==
X-Gm-Message-State: ANoB5pnrsj+LjYrgn3iyk8x0mI/X5YTf2NKcYi2hnESjEl1VKF0uOGDQ
        yQajhPYTqCzu2O3Ym5c498/qog==
X-Google-Smtp-Source: AA0mqf4mE6fmy2qJlzqH6rEehX2y9w2oMpqP6Zc2O9ZYfPeOLu+kRcI0MUTEUxfh31doNKzOYGj5BA==
X-Received: by 2002:a05:6402:2949:b0:468:fb6b:3a79 with SMTP id ed9-20020a056402294900b00468fb6b3a79mr50642882edb.63.1669727528092;
        Tue, 29 Nov 2022 05:12:08 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p21-20020a05640210d500b0046b25b93451sm2620541edu.85.2022.11.29.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 05:12:07 -0800 (PST)
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
Subject: [PATCH v3 0/2] interconnect: qcom: Add support for SM8550
Date:   Tue, 29 Nov 2022 15:12:01 +0200
Message-Id: <20221129131203.2197959-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

This patchset adds interconnect support for SM8550.

The v2 of this patchset is here:
https://lore.kernel.org/all/20221124112232.1704144-1-abel.vesa@linaro.org/

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

