Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514B62EDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiKRGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241280AbiKRGxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:53:02 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36D85A1D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id cl5so7793396wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvvGs4Cz+VQEVpQEOD1WcQQrpkJJ1GD0LCLFR0RC9ck=;
        b=uvM7wQ+YMEkAZCPzrgWrrBz+phm9bImUpK4D2Runa01meJ4mA+VXDmSgL65nsM3q+h
         fMJww79IU9Jpb7iKY6KfMlKr57I65UNd4OhrnlDr7UePsP/FWQD3VR/8Ezso+fmtKbcE
         BNeZA2LjC19PU1y/phEUcVUgmZG9Wn/V5TbDs7lSMbqA5vUZ4+op707WFtAep2O3r9Fi
         UttmpxPOMdZB28e7gkmG1su73RivytsLYU+W+qyof30/QwQmi+U1ekZFK9M2kDS6AC1x
         VN5cHRLGjyyAXESaJ4pKb/1mZRKnEJN8EpgLsPv/JU1E0BlsVD/pRWdRqPmFfyI63xB+
         P9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvvGs4Cz+VQEVpQEOD1WcQQrpkJJ1GD0LCLFR0RC9ck=;
        b=dRqxn5otEeM+v9ROKmQkk6yyjCrSiiFmRrCOEVhmhAz6nM+JbY03erc8J+Ngq19gWl
         leojVRR0dZ1tgE5YSnCxWf9WaEdnlLD/q/iYihcjkyFJD1YGDBHT5YxiEyLCtyxbb/xe
         vMZ2GZMd0OAaJfEQAOYLY2KYK4cxq4uJ93DPnouFhhuP652Q3PoyKV3uer98iaThmZcU
         ngf0w/n5X/WHw/xwJZdvSG0y0ErSLgHYjW8QHzfzD/B1QIa+hMNyJgy2BkWvEK1xpAM8
         c1yOQklU7USgXy4bJES8gOms3tBz0RdyIW3JqShbtbP4K/2FNT15VxDBFvg+u2J5g765
         K7Vg==
X-Gm-Message-State: ANoB5plSzsDPhFLgUwQW/AEZ1mVDmUTG0KYPz40jtjEBNKPwhbkPInK0
        1Iu5Sc8qey84Z35hK6cc22SjHKZQAjn64w==
X-Google-Smtp-Source: AA0mqf5DJYpxPEWo7f8YQvD3HfDttZpO0NrCfGRhmLWQCfNaPtOyyiITKLrp0Cc1SM4AutD5S632kQ==
X-Received: by 2002:a5d:58f8:0:b0:236:f5e5:13ca with SMTP id f24-20020a5d58f8000000b00236f5e513camr3324317wrd.417.1668754374319;
        Thu, 17 Nov 2022 22:52:54 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003cf75213bb9sm7648100wmf.8.2022.11.17.22.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:52:53 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/12] slimbus: patches (set 1) for 6.2
Date:   Fri, 18 Nov 2022 06:52:34 +0000
Message-Id: <20221118065246.6835-1-srinivas.kandagatla@linaro.org>
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

Hi Greg,

Here are some slimbus enhacements patches for 6.2
- converting Dt bindings to schema.
- add support to 44.1 Khz.
- handle unsupported presence rate
- few cleanups around unused compatibles and using correct apis.

Can you please queue them up for 6.2.

thanks for you help,
srini

Krzysztof Kozlowski (12):
  slimbus: qcom-ngd-ctrl: check for device runtime PM status during ISR
  slimbus: qcom-ngd-ctrl: drop PM runtime counter on transfer error
    paths
  slimbus: stream: handle unsupported bitrates for presence rate
  slimbus: qcom-ngd-ctrl: add support for 44.1 Khz frequency
  slimbus: stream: add checks for invalid unprepare/disable usage
  slimbus: qcom-ctrl: drop unneeded qcom,apq8064-slim compatible
  slimbus: qcom-ctrl: use devm_platform_ioremap_resource_byname()
  slimbus: qcom-ngd-ctrl: use devm_platform_get_and_ioremap_resource()
  slimbus: qcom-ngd-ctrl: reinit the reconf completion flag
  dt-bindings: slimbus: convert bus description to DT schema
  dt-bindings: slimbus: qcom,slim: convert to DT schema
  dt-bindings: slimbus: qcom,slim-ngd: convert to DT schema

 .../devicetree/bindings/slimbus/bus.txt       |  60 ---------
 .../bindings/slimbus/qcom,slim-ngd.yaml       | 120 ++++++++++++++++++
 .../bindings/slimbus/qcom,slim.yaml           |  86 +++++++++++++
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt   |  84 ------------
 .../bindings/slimbus/slim-qcom-ctrl.txt       |  39 ------
 .../devicetree/bindings/slimbus/slimbus.yaml  |  95 ++++++++++++++
 drivers/slimbus/qcom-ctrl.c                   |   5 +-
 drivers/slimbus/qcom-ngd-ctrl.c               |  97 ++++++++++++--
 drivers/slimbus/stream.c                      |  17 ++-
 9 files changed, 402 insertions(+), 201 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
 create mode 100644 Documentation/devicetree/bindings/slimbus/qcom,slim.yaml
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 delete mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slimbus.yaml

-- 
2.25.1

