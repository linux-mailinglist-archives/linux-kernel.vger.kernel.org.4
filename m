Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA41710FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241339AbjEYPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjEYPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:47:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB50410B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso4331755e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685029662; x=1687621662;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsprdRjm9I2tkvweLJm8m5dib1j+Ex3v712oZU007dg=;
        b=Tl1L67jWinXK1SRvVzYn2UxjwBvK/l7bl5CREJO1S7plZS2cF6Iikfz1esl/0IWWiz
         eJnTVh0Bz8gJF3B7hjZvknsvOjy1jzj8Hl0+/x2rfIt3asSioECgTIxbe+DMce90dFe4
         Ztzsb3OjIrUdIBXsPP33kPi39yRDtEjLy+NzBdevA/KhJq/QvSeWBoSMskMVpXofXie5
         fLox33mFVR0oQX057T3FbqCxk5B3qkXo064jcb/f4odGVNzD/1iWCKvCjdlp4/dfy5rF
         3wUDBA88TdTnGjphYcqI2Us7LcS0fcF+s4envxJspsn9YJHedm2I34vKLonBTA4Vulem
         o4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029662; x=1687621662;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsprdRjm9I2tkvweLJm8m5dib1j+Ex3v712oZU007dg=;
        b=GWoOcck+D0xIgJgaBLakJp62R7sVdfrg0Z4CTYV+F2+rbu6PBT1pXywGYJ5JGQfDFm
         cKw3bHMS/TuwyWc7LYYZDQHxK2n5hq1dz04IPTIln4FvGpUXlIc0VcwRSkQTtppZY8Ot
         zHsKJ5DT3/1l2dmyXG31a6XumhAqwb40VTq4Tw5JaO+EmwyHc0HasIZ8ym/bYZAnCjdC
         nykdlBl13LqV2PjbF0kldEj/qxs5cxthwFE6kVonvLQMgtxXGMoSxCzFJUx39sr0692K
         MMXENI/RT+8IY56QmmUrgSwBuyX8bo6KwZS+Fp2iKTqVYY5swWqSTOT+rWnLlliOJM1t
         l4AA==
X-Gm-Message-State: AC+VfDyZpoSFmDczrdT4cHgE/y3NYNdIFS4dqmF694/Yz7EyXJArgyGI
        6Q9lH8E05Anf0g/qrHFttlXlRw==
X-Google-Smtp-Source: ACHHUZ5t6pREG4ll22UenPbeFrX5UEUPZDY1lxRULlm037wgVtVZWbBxV5PgoeioUdy54m4PHC4cDg==
X-Received: by 2002:a05:600c:ad8:b0:3f6:cfc7:8bc7 with SMTP id c24-20020a05600c0ad800b003f6cfc78bc7mr1863419wmr.17.1685029662082;
        Thu, 25 May 2023 08:47:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b002ca864b807csm2275873wrv.0.2023.05.25.08.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:47:41 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] arm64: qcom: sm8550: enable PMIC devices
Date:   Thu, 25 May 2023 17:47:34 +0200
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABeDb2QC/5WOQQ6DIBQFr2JY9zcIfmu66j0aFwioJAgE0LQx3
 r3UnqDLmcWbt5Oko9GJ3KudRL2ZZLwrUF8qImfhJg1GFSaMMk6RIWQfjIS0dIgU1pBy1GKB8GM
 bJlAZJK8bRMXYyFpSlgaRNAxRODmXLbdaW2SIejSvM/3sC88mZR/f55Ot/tr/olsNFAbsGq5uK
 FrGH9Y4Ef3Vx4n0x3F8AJ10d0fsAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4tYqV/GEkHVwDABrr+uf0cpSsJR6GuD2I924uiTs4kg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkb4MbgypG5Llc8Ufb0M+A7mIWcy8Tkg64X1L0OMO7
 +vzE78CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZG+DGwAKCRB33NvayMhJ0ZtYD/
 4swIcl1CWzwligWPpoAVk1R7jaTxYYnDVYF8GkNDTEPXDXan5h2dh5r7rRu63kyA1yFIkNpIve1PSS
 GgzsvL/ElTJE4uvdONzdRmcG43dzU2CKRVE2+DPkFTzFM2KuzM0rd27iiRrB+LypHUJ3MBCBzQct1R
 2KIYGAeQfkPo6sKxq0AC/nynfS4N5w7xiipxzSWrci0/3mLUXon0CqxGaft/jcBgphB2XVLhGAgtQb
 g70AUIZiQfyPjcjhnYpXKkJuulMowQMr4Qed9k/pUEmkVi19OKwFYe9EdR+fPmIEn48C+m3XmDqSbW
 aqPHDbrw3Xqvpbg0Ube3mzJCZphInWE6/7/97iqDhuC7ZUurCpbNugNfCJ49lOGdPzr+8+8VtmLS4W
 kXJxRpnHGSl47I9ul9tSEqS5853qXjmJB5BlPz5H5SpGDW2ErYyO33K2D0vWVh4kv11z3OvuNUiZ0s
 nbQzD6ORk5VgWrfNFCknp6hEf8OIp97juSV5J6JmZ/jMc7FYCdy0NxY/9soeFOJR7kBrGHtyV+P99+
 LV+iMTt/uKyycHUZDKsHA+ZFLyR4Ttq9rQoRw8Ha0+BAEhwPjeADtrQYfRAh/7VhAJ/c0ymfIBRL0h
 OxmaOuMtjIV/lYlr33YftNpfBrxNYynQyxJGIGwoh62dgIypIV4x3MvtYMHQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables the following PMIC devices:
- PWM RGB LED
- RTC
- Volume and Power buttons

on the SM8550 boards.

Depends on:
- [1] PWM bindings, merged by Lee
- [2] functional fix
- [3] & [4] QRD flash DT changes

[1] https://lore.kernel.org/all/20230522-topic-sm8550-upstream-pm8550-lpg-v2-1-c5117f1d41f9@linaro.org/
[2] https://lore.kernel.org/r/20230515162604.649203-1-quic_bjorande@quicinc.com
[3] https://lore.kernel.org/r/20230516150202.188655-3-krzysztof.kozlowski@linaro.org
[4] https://lore.kernel.org/r/20230516150202.188655-2-krzysztof.kozlowski@linaro.org

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      arm64: dts: qcom: pm8550: add PWM controller
      arm64: dts: qcom: sm8550-qrd: add notification RGB LED
      arm64: dts: qcom: sm8550: enable PMIC RTC on MTP & QRD boards
      arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and Power buttons

 arch/arm64/boot/dts/qcom/pm8550.dtsi    | 10 +++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts |  4 ++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 67 +++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
---
base-commit: a04eb9aad608ac77e5212edbd46ad3002ea6265f
change-id: 20230525-topic-sm8550-upstream-pm8550-lpg-dt-c31455d22f26

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

