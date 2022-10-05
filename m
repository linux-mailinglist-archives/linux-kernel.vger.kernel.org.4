Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26A5F50F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJEIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiJEIh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:37:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B56733D8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:37:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso648804wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 01:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rclrG9kvjyiwEqNQMIJctVN4MQ1mov4Pr4W0bFer3vY=;
        b=moKmb7HPK9Qk+BTdZ4nrzbQl2dwrdGWJaP1j3hMfIMSCbjAHLlt/HoHM2bnbbLjGqG
         VOoupnOdLjkVoyyby+M9HpCRyr3T+0iY5wX7llxGQJuZjj04WjtwBAzM9nVaAYsafW6t
         MXhf+h+t4J6ZEzzsnYm7xgPzTfh9WOU1dxnqVAZtZ20oBNGRN+50UGMkwRXHPf+QQGT1
         1KtAqIHWDpgSSiFkiqKYyHNirOigyDvvowrpjPpjUfMUy9AcLQeKkLWSP8NN1U72KD/a
         mHwRh9ojh70faKuONfFXZ9ADhlla58k2153WD5+i+XSFcakpHP/QV7W8IzY9ayev5Wfk
         1+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rclrG9kvjyiwEqNQMIJctVN4MQ1mov4Pr4W0bFer3vY=;
        b=fi68F9CD4rrf/SvQoPJ8e4Vu6OHZtTJqiN4ztYhBDD9ns0xychoQ51SnSLeUzFPl6x
         Qu8rnxmcJRzb666ClT/oLKswCidyrySfnv1TH4W13lWMNw8MmPaMPC+GFaRp1W6bp3Jv
         oUufIVUef2K1KXbb3ImBkesFZLjFDkh3KRupC9dF5HCzXbDS55v+N7aXlU3mWDKLn2cw
         x85v8LZb6uS20CaVOsHC1wXIbXPdwtG0+fu5bRbJ0UHt6czyGaEgbNT8FKfL2deS+OZP
         uy5U2GHJMSVdhfuvfArp5q1UA+lTQrgKXBzKkEs5f+UizT/+WA0V58VxbhUPRPGNch/k
         Lcsg==
X-Gm-Message-State: ACrzQf2KoPlxYQCeJNZnyss04aYmNAiKn/ZqaKadKfIhMMytVW5qL6VM
        duObBXe2/ZwpXdBsNije2KnvMlyAZ/ZVbQ==
X-Google-Smtp-Source: AMsMyM73/1tTQofHlN4/cBMxLKa9fwOmXuOj38gXnRo8qFjlUlvp8DBYmGOC37YD5HrgRm9GRCDmtw==
X-Received: by 2002:a05:600c:1e08:b0:3b4:8fef:d63c with SMTP id ay8-20020a05600c1e0800b003b48fefd63cmr2465706wmb.158.1664959075772;
        Wed, 05 Oct 2022 01:37:55 -0700 (PDT)
Received: from localhost.localdomain (hst-221-6.medicom.bg. [84.238.221.6])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b003b47e75b401sm1318171wmo.37.2022.10.05.01.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 01:37:55 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/3] Few corrections in non-tz firmware boot
Date:   Wed,  5 Oct 2022 11:37:27 +0300
Message-Id: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Here are 3 patches which corrects reset bits, non-pix memory region and
use writel/readl with memory barriers included.

Those patches in fact fixes iommu context faults seen on Chromebook
(sc7180) during testing suspend/resume.

Stanimir Varbanov (3):
  venus: firmware: Correct reset bit
  venus: firmware: Correct non-pix start and end addresses
  venus: firmware: Correct assertion of reset bit on remote processor

 drivers/media/platform/qcom/venus/firmware.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.25.1

