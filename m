Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C16647807
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHVdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLHVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:33:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681982FA42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:33:34 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id d123so1054954iof.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FSa8Zfu/8xHbnZSuWDC6ttqZXGs49ojzvmsel6my90=;
        b=D9tqPJu7STusgHs8sqgkYqGUsLh2aDAXfT6PVsxVzzi2ANsohxmjekjP6JZcuH3Fb5
         Y0ykqc75MVGoHtSDg0b6c12GzzgzIXo+XU8M0m6wdefQI+yF4Le2aWF5GV1DpegX8zDM
         IavYzYrnIEDTAt3fw6Mj/hDWduI2QSDC/12aGtg+hqtR+aMiJ32lJq259SaAge/bHJ70
         Z+CekEUNtvNsv8r8LDEE/hxus4gDaZ+uftFeEi5J1qGz6T9ujcz65aLcYPFwi0NiiSdZ
         ggxEvrNMCkMxSjCGi+/S89Hvcwyhqkxj15NNYrQqOSCI8vsSAPiUS3WiZGMTzRHFEWoe
         TBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FSa8Zfu/8xHbnZSuWDC6ttqZXGs49ojzvmsel6my90=;
        b=kMFG2vajSXm3C8kb3tmyWnAaVp+vut2vVLuAPvghGoNSDDVDg5UjFTOz5iIgNhM8rv
         c+02hZsngIFZ6MMj473MDUnfBYWtYWC7Ez5S+c5NmEJ5MpqDtKCIL65PdGDc4iHSDi/3
         mfHSCECI0rfGYmFAYM86B1ndr/nEdvO4+qbr4dTFuVuAilqXq7FGjoDulv9Tf9kqF7cH
         gSRsExDckz3WRRQpig+miX0tBVNTFOq2ompDyTfqr2y6Beel0zvESd3GCOmZZebEC8B6
         yZquXwFwKDE2pX8GZlmiyb3KqzMRLvq/OEcb1FnUdkNit+ttEJKazNKHEGZc1+/JCOzN
         8Reg==
X-Gm-Message-State: ANoB5pm61wFCpOeVhN9Oby/0I50LPHC0uvEnTNV9vI8Lg6YCv8TIo/07
        tfRnhI35lEK4ia1KQE0QqUFJXQ==
X-Google-Smtp-Source: AA0mqf7fwtNQxQ3tnxh0ts1pIJeXrIh/KEs6UGxsKxVhtsbvnWlEGc/R0c6pmsYGcUD19CXYniovxA==
X-Received: by 2002:a5d:8351:0:b0:6df:e430:e8af with SMTP id q17-20020a5d8351000000b006dfe430e8afmr2130786ior.18.1670535213618;
        Thu, 08 Dec 2022 13:33:33 -0800 (PST)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a8-20020a021608000000b003755aa71fffsm9237846jaa.105.2022.12.08.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:33:33 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     luca.weiss@fairphone.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: qcom: sm6350: enable IPA
Date:   Thu,  8 Dec 2022 15:33:28 -0600
Message-Id: <20221208213330.937714-1-elder@linaro.org>
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

Enable IPA for the SM6350 SoC, which implements IPA v4.7.  Enable it
on the Fairphone 4, which incorporates IPA definitions used for the
SM6350.

Please delay applying this until after Linux v6.1 is tagged.

					-Alex

Luca Weiss (2):
  arm64: dts: qcom: sm6350: add IPA node
  arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA

 arch/arm64/boot/dts/qcom/sm6350.dtsi          | 47 +++++++++++++++++++
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |  7 +++
 2 files changed, 54 insertions(+)

-- 
2.34.1

