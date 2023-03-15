Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FD6BB8EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjCOQCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjCOQC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:02:26 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BAD96F1C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:02:03 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y189so6899611pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4L0/ohRAJ1raHuU4C5yE5OwktiAIDlaiHLj7apxZis=;
        b=iCIm+CLNElLowiPW8BSJAMT4GTixDbfkn6+Q26QjHY+PqA1JTIZcwxRu8jXplIuMh/
         wK61PzB7F9T1nfyBrkxz0LKohxPlsOuiieYEw4uIcMX+SxNyD4V1hxru4+GQFsFzCNKN
         BE11DaM7+MIkktCeZqUqKDncDkf4Sw+QsGq4foMEewiSF/AN60wRrfMODTtQSP0lr5Ae
         Ja7oPytu8ffwdlMRXc1r/mPHUj8J7V/Wr1c5T9iIXnjqV3cJTjmkDGt25SRDbgOSer1Y
         QNrTY1ALONOqebfq4YxAk5170hIdGqaZ0nLfROBJxNxTn7d6/8Evo023nQdl7R/2h0fD
         Zy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4L0/ohRAJ1raHuU4C5yE5OwktiAIDlaiHLj7apxZis=;
        b=EFEIFQ5WqILgVBD1wqLzrv9EbsSn7xPjjj6Ci00SnUQWnBQGwByeL6OUMrPW+e7PJU
         zh1N8xNZutb7oOmt6HPHXRr+QX+zEtu9DtY2z4mV+hJGw1bfrOlAvInC08fBkuBIUz3U
         NVjlveqosKViyHYIb6FfjWeq3aLRtYNQcHp8bhbCsvX01wPEW/U6b0YUbtv+LAulx6rB
         I6uPSc1rp0CzaG25vMLSkwpfOnwHbLNwIA4SFzlT7MynMJ55EXBDG65vsRhfIx6yN1oa
         btCBot6O2oZaG75OXxrmWONWVl+gbQ8GlhcKHZtDDhf8H9Tstb4CxVOjnPXCSPSyfH1F
         AsWw==
X-Gm-Message-State: AO0yUKXQ72faS8EyMT8T9yJEkXpYb5vMG+IRTQgT8OendNhzJqb0wtMe
        FUfcK2Upg/SU/0nbI3DTieNM2w==
X-Google-Smtp-Source: AK7set9gu0TYUW6m4kJv/UKCBbx75F5ypLi4TuKVs4G3o3XWAxkNUy3arvohuBmDBAXMFwAr5itBiw==
X-Received: by 2002:aa7:8bd5:0:b0:625:75dd:1140 with SMTP id s21-20020aa78bd5000000b0062575dd1140mr54075pfd.8.1678896121556;
        Wed, 15 Mar 2023 09:02:01 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id o1-20020a655bc1000000b00502dc899394sm3457170pgr.66.2023.03.15.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:01 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH 0/2] QRB4210 socinfo
Date:   Wed, 15 Mar 2023 21:31:49 +0530
Message-Id: <20230315160151.2166861-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing IDs for QRB4210.

Bhupesh Sharma (2):
  dt-bindings: arm: qcom,ids: Add IDs for QRB4210
  soc: qcom: socinfo: Add IDs for QRB4210

 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)

-- 
2.38.1

