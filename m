Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E446B018E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCHIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCHIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:33:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D8126CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:32:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f11so14524635wrv.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678264375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3Cg/8jyJAlzuDvpkTj7hvlWgvQci7NxuABE1qCzmpE=;
        b=kCZl7CtVpdR259BAPV+7Tq2q6t3hfPKMOVo3lbOG/Chl77SEpkfszHQR9QvL8SJ+Ei
         AZAbqJ3t/n8+/3wvlHTdtORWPrl6LpK/iAX9WIBhcUt5jiH9wPl3b9lRjkEyxWfWlKNZ
         0fjhv8pDPvSOhfDCKX5XA/g1yaasNeNLxLWptZd+1NFdCv14xTqPB1PyfHQreMhzASO7
         3deKBqNRxDWLFWiu2W0uIDzMILUkuhtboaQv9tfl0WAL0xHt9TxVQ/IirMOI++0YUZ1K
         JqD1WranML1gDYJgZmdAE+8NJgRlUEUIquP26b3b6wYBVbT8G94cW8P45qJmMEM1zDzF
         lxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3Cg/8jyJAlzuDvpkTj7hvlWgvQci7NxuABE1qCzmpE=;
        b=fuE1jW1c3SqS22FfDkeXj2Bdj3oUkHTaJPvCJ5MIFVUuNyit435IxKDarmvQUoI2Gb
         TuJ5hTUA5UqvLai+iAhsBkVro2+Zl9dKg67VumOmuVM69ETiavw47wZdB1bjOZ8vfRXy
         6DFyUR6WDEljaLATNkcNQuFJHmvBwMzEAUm9Cps+AIVuDbzHRak5XHYTqOsJkF+ZHlmN
         mw3GWA40Z+2C5LKtRk9LENPcqfjAjQRLqs1kMJ6ZZUwoyPQ4tqomI0cVcOkwbmhkd9jE
         SHbrdjK/TG3vm6nl5zk7z4hRLur1XY4t5AloHagHg2pki0ATBsLqEju3QA3+dPEL1ldz
         vTHw==
X-Gm-Message-State: AO0yUKUqC2hUFpb73cj7LqxKsDM4C5Lfe3arQ8epymIVD4NGTnNnlqGX
        UsT2WoYdw9S4AsdJh1hrJ5nnHR1I/ppWQOAquvgUmQ==
X-Google-Smtp-Source: AK7set87shpDBIjkHZlUbEU7s36HALfKL7UGI2MhAgm9Qr5Bt7gQs4LkMdpeEq6z0EJFUuds0U382Q==
X-Received: by 2002:adf:e703:0:b0:2c3:dd81:49ad with SMTP id c3-20020adfe703000000b002c3dd8149admr11447996wrm.33.1678264375310;
        Wed, 08 Mar 2023 00:32:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n1-20020adffe01000000b002c4084d3472sm14797907wrr.58.2023.03.08.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:32:54 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sm8550: various DT fixes
Date:   Wed, 08 Mar 2023 09:32:51 +0100
Message-Id: <20230308-topic-sm8550-upstream-dt-fixups-v1-0-595b02067672@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNICGQC/x2NQQqDMBBFryKz7kDUStJepbiIyVgHNIZMLAXx7
 h26fI/P+ycIFSaBZ3NCoQ8L70mhvTUQFp/ehByVoTNdb3rjsO6ZA8rmhsHgkaUW8hvGijN/FdH
 N8W5d+7DBdqCVyQvhVHwKi3bSsa4qcyGd/29f43X9APBX/nOGAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various DT fixes to enhance redability and unify the DT style.

No functionnal changes expected.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      arm64: dts: qcom: sm8550: replace 0x0 to 0
      arm64: dts: qcom: sm8550: fix qup_spi0_cs node
      arm64: dts: qcom: sm8550: misc style fixes

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 80 ++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 39 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230308-topic-sm8550-upstream-dt-fixups-8fd478197c72

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

