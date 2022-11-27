Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63614639CA7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiK0T4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK0T4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:56:35 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3A9DF4E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ns17so842232pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=juq5/mjC/KKXPH5Eez7pJsfr8RT85fZqcCMfwuxrs/M=;
        b=EJz24sx9HV4+nfAGByt9QAB3IEhPbrtR1EhvxRRae/kWs5PBc3/LGA7Di7A/LsofmL
         Co2eXjPPEh5yzYPRtvsorqprGcrleudUWAa7cNRHsFrXEuHkuT+/zX3r/KvPWdTrNuxF
         je009dBdNh5dJ5q7NCX0nBKbYgNOw+Bg1yhkk/vTjekHgtV2YajnTOwLsh2kt8a3G+gJ
         TlLv5EfwGlJ35MPtzvLDul2O8qyzqVvVrG2ajFNWzEqeX+Bmn6IZFrZMCYByNs69RZWY
         QzikZvw2FOII8kgZi8PELs9ijzJ7cLRWMFPMIf4cSeR6S7lV/rlUIxKWrXbIFXXu4zQz
         W9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juq5/mjC/KKXPH5Eez7pJsfr8RT85fZqcCMfwuxrs/M=;
        b=a2Wrr2ts1h7Q6t8zDUocKTJD8wSTntqtI4kGdPEl0NyNmiSS+sJbmhIuCOOuf/54O/
         dWzpPOGDus1BjjKUjEGaC2MAvWdA37rx0ApFwMVzpqDcdZbI2VYw8qar8l8lkaOvkdzW
         j18Mk68b/jNm2Inf0XahqYG5NwNmEU3G/6cX61c6d0ZFUe1dlqRorl7nDithIVd8Sfo+
         zz9u7UOINhELgCdzuxh6fOhMhGwOmiDjDAmp+O3QNafPSCspUHho/7lkCRctTCRDwsYE
         2eT9fyiuo3tBOz3ISGb/r3uJVOjqYADR6/42PgJpnUqD2XXoiFmgBUS6lgsBJf+xIwsf
         Q6WA==
X-Gm-Message-State: ANoB5pkzQA5mKnWL1K9/J1DxVh/GdYUNj/AP5R/O8YEibUif3oXcW/9X
        k6bMydjUENTH/ZWpqWXwt58dLw==
X-Google-Smtp-Source: AA0mqf5Xy7d1FDxM3SQk8hovsH+Itwl6eIGMuNOyoH4njhj23ei2tlC26P5B6VDHB37sPWpVG5Mtxg==
X-Received: by 2002:a17:902:db09:b0:188:7dca:6f4d with SMTP id m9-20020a170902db0900b001887dca6f4dmr42119770plx.68.1669578994168;
        Sun, 27 Nov 2022 11:56:34 -0800 (PST)
Received: from localhost.localdomain ([223.179.131.184])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902968100b00186616b8fbasm564636plp.10.2022.11.27.11.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 11:56:33 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     jassisinghbrar@gmail.com, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 0/2] mailbox: Add SM4250 APCS IPC support
Date:   Mon, 28 Nov 2022 01:24:16 +0530
Message-Id: <20221127195418.1506876-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the SM4250 APCS IPC support.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>

Bhupesh Sharma (2):
  dt-bindings: mailbox: qcom: Add SM4250 APCS compatible
  mailbox: qcom-apcs-ipc: Add SM4250 APCS IPC support

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                          | 1 +
 2 files changed, 2 insertions(+)

-- 
2.38.1

